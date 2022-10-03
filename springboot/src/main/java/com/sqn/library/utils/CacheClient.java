package com.sqn.library.utils;

import cn.hutool.core.util.BooleanUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.sqn.library.common.Constants;
import lombok.extern.slf4j.Slf4j;
import net.sf.jsqlparser.statement.select.FunctionItem;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.concurrent.*;
import java.util.function.Function;

/**
 * @Author shenqn
 * @Date 2022/9/28  23:33
 */
@Slf4j
@Component
public class CacheClient {

    @Resource
    StringRedisTemplate stringRedisTemplate;

    /**
     * 将任意Java对象序列化为json并存储在string类型的key中，并且可以设置TTL过期时间
     *
     * @param key   键
     * @param value 值
     * @param time  有效期
     * @param unit  有效期单位
     */
    public void setObject(String key, Object value, Long time, TimeUnit unit) {
        stringRedisTemplate.opsForValue().set(key, JSONUtil.toJsonStr(value), time, unit);
    }

    /**
     * 将任意Java对象序列化为json并存储在string类型的key中，并且可以设置逻辑过期时间，用于处理缓存击穿问题
     *
     * @param key   键
     * @param value 值
     * @param time  有效期
     * @param unit  有效期单位
     */
    public void setWithLogicalExpire(String key, Object value, Long time, TimeUnit unit) {
        // 设置逻辑过期
        RedisData data = new RedisData();
        data.setData(value);
        // 设置过期时间：当前时间追加秒（利用unit的方法将传入的时间转换成秒）
        data.setExpireTime(LocalDateTime.now().plusSeconds(unit.toSeconds(time)));
        stringRedisTemplate.opsForValue().set(key, JSONUtil.toJsonStr(data));
    }


    /**
     * 根据指定的key查询缓存，并反序列化为指定类型，利用缓存空值的方式解决缓存穿透问题方法
     *
     * @param keyPrefix  键名前缀
     * @param id         传值id
     * @param type       传入的实体类类型
     * @param dbFallback 有参数ID，有返回值R的函数  使用方式 this::函数名(id)  等价于 id->函数名(id) 此id不等于传值id（可用其他值代替，例如id2）
     * @param time       有效期
     * @param unit       有效期单位
     * @param <R>        返回值类型
     * @param <ID>       id的类型
     * @return
     */
    public <R, ID> R queryWithPassThrough(String keyPrefix, ID id, Class<R> type, Function<ID, R> dbFallback,
                                          Long time, TimeUnit unit) {
        // 定义键名：业务前缀+查询id
        String key = keyPrefix + id;
        // 从redis查询缓存
        String json = stringRedisTemplate.opsForValue().get(key);
        // 判断是否存在
        if (StrUtil.isNotBlank(json)) {
            //若存在，直接返回；把string值反序列化
            return JSONUtil.toBean(json, type);
        }
        // 判断命中的是否是空值
        if (json != null) {
            return null;
        }
        // 执行函数（例如根据id查询数据库）
        R r = dbFallback.apply(id);
        // 不存在，返回错误
        if (r == null) {
            // 将空值写入redis
            stringRedisTemplate.opsForValue().set(key, "", Constants.CACHE_NULL_TTL, TimeUnit.SECONDS);
            // 返回错误信息
            return null;
        }
        // 存在，写入redis
        this.setObject(key, r, time, unit);
        return r;
    }

    private static final ExecutorService CACHE_REBUILD_EXECUTOR = Executors.newFixedThreadPool(10);

    /**
     * 根据指定的key查询缓存，并反序列化为指定类型，需要利用逻辑过期解决缓存击穿问题
     */

    public <R, ID> R queryWithLogicalExpire(String keyPrefix, ID id, Class<R> type, Function<ID, R> dbFallback,
                                            Long time, TimeUnit unit) {
        String key = keyPrefix + id;
        // 从redis查询缓存
        String json = stringRedisTemplate.opsForValue().get(key);
        // 判断是否存在
        if (StrUtil.isBlank(json)) {
            // 存在 直接返回
            return null;
        }
        // 命中 需要先把json反序列化为对象
        RedisData redisData = JSONUtil.toBean(json, RedisData.class);
        R r = JSONUtil.toBean((JSONObject) redisData.getData(), type);
        LocalDateTime expire = redisData.getExpireTime();
        // 判断是否过期
        if (expire.isAfter(LocalDateTime.now())) {
            // 未过期，直接返回信息
            return r;
        }
        // 已过期，需要缓存重建
        // 缓存重建
        // 获取互斥锁
        String lockKey = Constants.LOCK_KEY + id;
        boolean isLock = tryLock(lockKey);
        // 判断是否获取锁成功
        if (isLock) {
            // 成功 开启独立线程 实现缓存重建
            CACHE_REBUILD_EXECUTOR.submit(() -> {
                try {
                    // 查询数据库
                    R r1 = dbFallback.apply(id);
                    // 写入redis
                    this.setWithLogicalExpire(key, r1, time, unit);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                } finally {
                    // 释放锁
                    unlock(lockKey);
                }
            });
        }
        // 返回过期的信息
        return r;
    }

    /**
     * 设置锁
     *
     * @param key
     * @return
     */
    private boolean tryLock(String key) {
        Boolean aBoolean = stringRedisTemplate.opsForValue().setIfAbsent(key, "1", 10, TimeUnit.SECONDS);
        return BooleanUtil.isTrue(aBoolean);
    }

    /**
     * 释放锁
     *
     * @param id
     */
    private void unlock(String id) {
        stringRedisTemplate.delete(id);
    }
}
