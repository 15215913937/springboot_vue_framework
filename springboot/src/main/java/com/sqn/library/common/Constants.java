package com.sqn.library.common;

/**
 * @Author shenqn
 * @Date 2022/7/17  22:49
 */
public interface Constants {
    //dict表type
    String DICT_TYPE_ICON = "icon";

    //定义缓存键名
    String USER_KEY = "USER_FIND_ID";
    String MENUS_KEY = "MENUS_FIND_ALL";

    //错误异常code
    String CODE_SUCCESS = "0"; //操作成功
    String CODE_COMMON_ERR = "400"; //操作失败
    String CODE_INTERNAL_ERR = "600"; //内部错误
    String CODE_TOKEN_UNAUTHORIZED="401";//token未授权
    String CODE_TOKEN_ILLEGAL="402";//token不合法

    //    系统常量
    String PREFIX_USERNAME = "sqn_"; //自动注册用户名前缀
    String PREFIX_NAME = "游客_";//自动注册姓名前缀
    String DEFAULT_PASSWORD = "123456"; //默认密码

}
