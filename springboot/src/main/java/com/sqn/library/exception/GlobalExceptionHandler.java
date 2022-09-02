package com.sqn.library.exception;

import cn.hutool.log.Log;
import cn.hutool.log.LogFactory;

import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestControllerAdvice
//@ControllerAdvice(basePackages = "com.sqn.library.controller")
public class GlobalExceptionHandler {
    //打印错误日志
    private static final Log log = LogFactory.get();

    //统一异常处理@ExceptionHandler,主要用于Exception
    @ExceptionHandler(CustomException.class)
    public Result<?> customer(HttpServletRequest request, CustomException e) {
        log.error("异常信息vv----------vv----------vv", e);
        return Result.error(e.getCode(), e.getMsg());
    }

    //统一异常处理@ExceptionHandler,主要用于Exception
    @ExceptionHandler(Exception.class)
    public Result<?> error(HttpServletRequest request, Exception e) {
        log.error("异常信息vv----------vv----------vv", e);
        return Result.error(Constants.CODE_INTERNAL_ERR, "系统异常");
    }

}
