package com.sqn.library.service.impl;

import cn.hutool.log.Log;
import com.sqn.library.controller.dto.UserPasswordDTO;
import com.sqn.library.controller.dto.UserResetPwdDTO;
import com.sqn.library.entity.User;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.UserMapper;
import com.sqn.library.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


/**
 * <p>
 * 用户信息表 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-08
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {
    @Resource
    UserMapper userMapper;

    @Override
    public void updatePassword(UserPasswordDTO userPasswordDTO) {
        int update = userMapper.updatePassword(userPasswordDTO);
        if (update < 1) {
            throw new CustomException("-1", "系统异常");
        }
    }

    @Override
    public void resetPwd(UserResetPwdDTO userResetPwdDTO) {
        int update = userMapper.resetPwd(userResetPwdDTO);
        if (update < 1) {
            throw new CustomException("-1", "系统异常");
        }
    }
}
