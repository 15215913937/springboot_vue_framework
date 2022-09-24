package com.sqn.library.common.Interceptor;

import cn.hutool.core.util.StrUtil;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;

import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.entity.User;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.UserMapper;
import com.sqn.library.utils.TokenUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 登录拦截器
 */
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {

        String token = request.getHeader("token");
        if (StrUtil.isBlank(token)) {
            throw new CustomException(Constants.CODE_TOKEN_UNAUTHORIZED, "未获取到token, 请登录");
        }
        User user = TokenUtils.getUser();
        if (user == null) {
            throw new CustomException(Constants.CODE_TOKEN_ILLEGAL, "token不合法");
        }
        // 验证 token
        JWTVerifier jwtVerifier = JWT.require(Algorithm.HMAC256(user.getPassword())).build();
        try {
            jwtVerifier.verify(token);
        } catch (Exception e) {
            throw new CustomException(Constants.CODE_TOKEN_ILLEGAL, "token不合法");
        }
        return true;
    }
}
