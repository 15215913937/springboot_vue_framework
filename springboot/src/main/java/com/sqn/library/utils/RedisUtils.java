package com.sqn.library.utils;

import cn.hutool.core.lang.TypeReference;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import io.micrometer.core.instrument.util.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * Redis工具类，使用之前请确保RedisTemplate成功注入
 *
 * @author qnShen
 * @since 2022-09-17
 */
@Component
public class RedisUtils {
    @Autowired
    StringRedisTemplate stringRedisTemplate;


    /**
     * 清空缓存
     *
     * @param key
     */
    public void flushRedis(String key) {
        stringRedisTemplate.delete(key);
    }

//    设置缓存

    /**
     * 存入普通对象，该键值对存在有效期
     *
     * @param key
     * @param value
     * @param timeout 有效期 ttl单位：分钟
     */
    public Boolean setStringToRedis(String key, String value, long timeout) {
        stringRedisTemplate.opsForValue().set(key, value, timeout, TimeUnit.MINUTES);
        return true;
    }

    public Boolean setObjectToRedis(String key, Object value, long timeout) {
        final String s = JSONUtil.toJsonStr(value);
        stringRedisTemplate.opsForValue().set(key, s, timeout, TimeUnit.MINUTES);
        return true;
    }

    public String getRedis(String key) {
        return stringRedisTemplate.opsForValue().get(key);
    }

    public void removeRedis(String key) {
        stringRedisTemplate.delete(key);
    }


}