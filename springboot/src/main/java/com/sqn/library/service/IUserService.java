package com.sqn.library.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.sqn.library.controller.dto.UserPasswordDTO;
import com.sqn.library.controller.dto.UserResetPwdDTO;
import com.sqn.library.entity.User;

/**
 * <p>
 * 用户信息表 服务类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-08
 */

public interface IUserService extends IService<User> {

    void updatePassword(UserPasswordDTO userPasswordDTO);

    void resetPwd(UserResetPwdDTO userResetPwdDTO);

    Boolean sendCode(String phone);

    /**
     * 更新最近登录时间
     *
     * @param id
     */
    void updateRecentLoginTime(Long id);

    /**
     * 用户假删除
     *
     * @param id
     */
    void isDeleteById(Long id);

    Boolean setStatusOnline(Long userId);

    Boolean setStatusOffline(Long userId);
}