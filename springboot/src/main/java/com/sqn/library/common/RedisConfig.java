package com.sqn.library.common;

import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 配置Redisson客户端
 *
 * @author shenqn
 * @Date 2022/10/15  21:47
 */
@Configuration
public class RedisConfig {
    @Value("${redis.host}")
    private String host;

    @Value("${redis.port}")
    private String port;

    @Bean
    public RedissonClient redissonClient() {
        // 配置类
        Config config = new Config();
        // 添加redis地址，这里添加了单点的地址，如果设置了密码可使用setPassword();也可以使用config.useClusterServers()添加集群地址
        config.useSingleServer().setAddress("redis://" + host + ":" + port);
        // 创建客户端
        return Redisson.create(config);
    }
}
