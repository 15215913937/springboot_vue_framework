package com.sqn.library.common;

/**
 * @Author shenqn
 * @Date 2022/7/17  22:49
 */
public class Constants {
    /**
     * dict表type
     */

    public static final String DICT_TYPE_ICON = "icon";

    /**
     * 响应code
     */

    public static final String CODE_SUCCESS = "0"; // 操作成功
    public static final String CODE_COMMON_ERR = "400"; // 操作失败
    public static final String CODE_INTERNAL_ERR = "600"; // 内部错误
    public static final String CODE_DATA_ERR = "601"; // 数据不存在
    public static final String CODE_TOKEN_UNAUTHORIZED = "401";// token未授权
    public static final String CODE_TOKEN_ILLEGAL = "402";// token不合法
    public static final String CODE_SUCCESS_MESSAGE = "操作成功";// 操作成功
    public static final String CODE_ERROR_MESSAGE = "操作失败";// 操作失败

    /**
     * 系统常量
     */

    public static final String PREFIX_USERNAME = "sqn_"; // 自动注册用户名前缀
    public static final String PREFIX_NAME = "游客_";// 自动注册姓名前缀
    public static final String DEFAULT_PASSWORD = "123456"; // 默认密码

    /**
     * 信息常量
     */

    public static final String USER_KEY = "info:user:"; // 用户信息
    public static final String ALL_USER_KEY = "info:users:"; // 所有用户信息
    public static final String MENUS_KEY = "info:menus:";// 菜单信息
    public static final String EVENT_KEY = "info:events:";// 单个事件信息
    public static final String BOOKS_KEY = "info:books:";// 书籍信息
    public static final String LOGIN_CODE_KEY = "login:code:"; // 验证码
    public static final Long LOGIN_CODE_KEY_TTL = 3L;// 验证码缓存有效期
    public static final Integer LOGIN_CODE_KEY_LENGTH = 6;// 验证码长度
    public static final Long LOGIN_INFO_TTL = 2L;// 登录后相关信息缓存有效期
    public static final Long CACHE_NULL_TTL = 5L;// 空值缓存过期时间
    public static final String LOCK_KEY = "lock:key:"; //互斥锁前缀名
    public static final String ALL_ACTIVITY_KEY = "info:activities:"; // 运动集
    public static final String HEALTH_DATA_KEY = "info:healths:"; // 健康信息

    /**
     * 角色常量
     */

    public static final String ROLE_ADMIN = "ROLE_ADMIN"; // 管理员
}
