package com.sqn.library.common;

/**
 * @Author shenqn
 * @Date 2022/7/17  22:49
 */
public final class Constants {
    //dict表type
    public static final String DICT_TYPE_ICON = "icon";

    //错误异常code
    public static final String CODE_SUCCESS = "0"; //操作成功
    public static final String CODE_COMMON_ERR = "400"; //操作失败
    public static final String CODE_INTERNAL_ERR = "600"; //内部错误
    public static final String CODE_TOKEN_UNAUTHORIZED = "401";//token未授权
    public static final String CODE_TOKEN_ILLEGAL = "402";//token不合法

    //    系统常量
    public static final String PREFIX_USERNAME = "sqn_"; //自动注册用户名前缀
    public static final String PREFIX_NAME = "游客_";//自动注册姓名前缀
    public static final String DEFAULT_PASSWORD = "123456"; //默认密码

    //    redis常量
    public static final String USER_KEY = "info:user:"; //用户信息
    public static final String MENUS_KEY = "info:menus:";//菜单信息
    public static final String LOGIN_CODE_KEY = "login:code:"; //验证码
    public static final Long LOGIN_CODE_KEY_TTL = 3L;//验证码缓存有效期
}
