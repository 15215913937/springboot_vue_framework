package com.sqn.library.utils;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.sqn.library.entity.Activity;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * Redis工具类，使用之前请确保RedisTemplate成功注入
 *
 * @author qnShen
 * @since 2022-09-17
 */
@Component
public class RedisUtils {
    @Resource
    StringRedisTemplate stringRedisTemplate;

    @Resource
    RedisTemplate redisTemplate;


    /**
     * 清空缓存
     *
     * @param key
     */
    public void flushRedis(String key) {
        stringRedisTemplate.delete(key);
    }

    /**
     * 存入普通对象，该键值对存在有效期
     *
     * @param key
     * @param value
     * @param timeout 有效期 ttl单位：分钟
     */
    public void setStringToRedis(String key, String value, Long timeout) {
        stringRedisTemplate.opsForValue().set(key, value, timeout, TimeUnit.MINUTES);
    }

    public void setObjectToRedis(String key, Object value, Long timeout) {
        stringRedisTemplate.opsForValue().set(key, JSONUtil.toJsonStr(value), timeout, TimeUnit.MINUTES);

    }

    public String getRedis(String key) {
        return stringRedisTemplate.opsForValue().get(key);
    }

    public void removeRedis(String key) {
        stringRedisTemplate.delete(key);
    }

    public void saveMapObject(String key, Map<String, Object> map, Long timeout) {
        stringRedisTemplate.opsForHash().putAll(key, map);
        stringRedisTemplate.expire(key, timeout, TimeUnit.MINUTES);
    }

    /**
     * 获取list缓存的内容
     *
     * @param key   键
     * @param start 开始
     * @param end   结束 0 到 -1代表所有值
     * @return
     */

    public List<String> lGet(String key, Integer start, Integer end) {
        List<Object> list = redisTemplate.opsForList().range(key, start, end);
//        可以直接转换成string
        if (StrUtil.isNotEmpty((CharSequence) list)) {
            assert list != null;
            List<String> listStrs = list.stream().map(String::valueOf).collect(Collectors.toList());
            System.out.println("遍历输出到表中！");
            listStrs.forEach(System.out::println);
            return listStrs;
        }
        return Collections.emptyList();
    }

    /**
     * 将list放入缓存
     *  @param key   键
     * @param value 值
     */
    public void lSet(String key, List<Activity> value) {
        redisTemplate.opsForList().leftPushAll(key, value);
    }


    public void hSet(String key, Long field, String value) {
        stringRedisTemplate.opsForHash().put(key, field, value);
    }

    public List<Object> hGet(String key) {
        return stringRedisTemplate.opsForHash().values(key);
    }

}