package com.sqn.library.exception;

import lombok.Getter;

/**
 * 自定义异常
 */
@Getter
public class CustomException extends RuntimeException {
    private String code;
    private String msg;

    public CustomException(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }
}
