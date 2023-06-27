package com.sqn.library.utils;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * @Author shenqn
 * @Date 2022/9/28  23:40
 */
@Data
public class RedisData {
    /**逻辑过期
     *
     */
    private LocalDateTime expireTime;
    private Object data;
}
