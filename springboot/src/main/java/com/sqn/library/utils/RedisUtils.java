package com.sqn.library.utils;

import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
@Component
public class RedisUtils {
    @Resource
    StringRedisTemplate stringRedisTemplate;


}
