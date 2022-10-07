package com.sqn.library.utils;

import io.swagger.models.properties.StringProperty;
import org.springframework.data.redis.core.StringRedisTemplate;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * @Author shenqn
 * @Date 2022/10/4  0:40
 */
public class RedisIdWorker {
    @Resource
    StringRedisTemplate stringRedisTemplate;
    /**
     * 开始时间戳 2022-01-01T00:00
     */
    private static final long BEGIN_TIMESTAMP = 1640995200L;

    public long nextId(String keyPreFix) {
        // 生成时间戳
        LocalDateTime now = LocalDateTime.now();
        long nowSecond = now.toEpochSecond(ZoneOffset.UTC);
        long timestamp = nowSecond - BEGIN_TIMESTAMP;

        // 生成序列号
        // 获取当天日期，精确到天
        String date = now.format(DateTimeFormatter.ofPattern("yyyy:MM:dd"));
        // 自增长
        long count = stringRedisTemplate.opsForValue().increment("icr" + keyPreFix + ":" + date);

        // 拼接返回
        // <<左移32位 和count做或运算
        return timestamp << 32 | count;


    }


    public static void main(String[] args) {
        LocalDateTime dateTime = LocalDateTime.of(2022, 1, 1, 0, 0);
        System.out.println(dateTime);
        long toEpochSecond = dateTime.toEpochSecond(ZoneOffset.UTC);
        System.out.println(toEpochSecond);
    }

}
