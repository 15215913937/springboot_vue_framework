package com.sqn.library.service.impl;

import cn.hutool.core.util.RandomUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sqn.library.common.Constants;
import com.sqn.library.controller.dto.UserPasswordDTO;
import com.sqn.library.controller.dto.UserResetPwdDTO;
import com.sqn.library.entity.User;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.UserMapper;
import com.sqn.library.service.IUserService;
import com.sqn.library.utils.RedisUtils;
import com.sqn.library.utils.RegexUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.Date;
import java.util.concurrent.TimeUnit;


/**
 * <p>
 * 用户信息表 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-08
 */
@Slf4j
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {
    @Resource
    UserMapper userMapper;
    @Resource
    IUserService iUserService;
    @Resource
    RedisUtils redisUtils;

    @Override
    public void updatePassword(UserPasswordDTO userPasswordDTO) {
        int update = userMapper.updatePassword(userPasswordDTO);
        if (update < 1) {
            throw new CustomException(Constants.CODE_INTERNAL_ERR, "系统异常");
        }
    }

    @Override
    public void resetPwd(UserResetPwdDTO userResetPwdDTO) {
        int update = userMapper.resetPwd(userResetPwdDTO);
        if (update < 1) {
            throw new CustomException(Constants.CODE_INTERNAL_ERR, "系统异常");
        }
    }

    @Override
    public Boolean sendCode(String phone) {
        // 验证手机号格式是否正确
        if (!RegexUtils.isMobileExact(phone)) {
            return false;
        } else {
            // 格式正确，则生成6位随机数（即验证码）
            String code = RandomUtil.randomNumbers(Constants.LOGIN_CODE_KEY_LENGTH);
            // 保存验证码到redis
            redisUtils.setEx(Constants.LOGIN_CODE_KEY, code,Constants.LOGIN_CODE_KEY_TTL, TimeUnit.MINUTES);
            // 发送验证码
            log.info("发送验证码成功，验证码是：{}", code);
        }
        return true;
    }

    @Override
    public void updateRecentLoginTime(Long id) {
        final Date date = new Date();
        User user = userMapper.selectById(id);
        user.setRecentLogin(new Timestamp(date.getTime()));
        userMapper.updateById(user);
    }

    @Override
    public void isDeleteById(Long id) {
        final User user = userMapper.selectById(id);
        user.setIsDelete(1);
        userMapper.updateById(user);
    }

    @Override
    public Boolean setStatusOnline(Long userId) {
        final User user = userMapper.selectById(userId);
        user.setStatus(1);
        userMapper.updateById(user);
        return true;
    }

    @Override
    public Boolean setStatusOffline(Long userId) {
        User user = userMapper.selectById(userId);
        if (user == null) {
            return false;
        }
        user.setStatus(0);
        userMapper.updateById(user);
        return true;
    }
}
