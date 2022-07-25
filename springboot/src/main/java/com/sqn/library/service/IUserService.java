package com.sqn.library.service;

import com.sqn.library.controller.dto.UserPasswordDTO;
import com.sqn.library.controller.dto.UserResetPwdDTO;
import com.sqn.library.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

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
}