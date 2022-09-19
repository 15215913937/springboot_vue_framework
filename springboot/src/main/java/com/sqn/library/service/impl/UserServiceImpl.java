package com.sqn.library.service.impl;

import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.log.Log;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.controller.ConsumerDetailsController;
import com.sqn.library.controller.UserController;
import com.sqn.library.controller.dto.UserPasswordDTO;
import com.sqn.library.controller.dto.UserResetPwdDTO;
import com.sqn.library.controller.dto.UserSearchDTO;
import com.sqn.library.entity.ConsumerDetails;
import com.sqn.library.entity.User;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.UserMapper;
import com.sqn.library.service.IConsumerDetailsService;
import com.sqn.library.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sqn.library.utils.RegexUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;


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

    @Override
    public Result<?> sendCode(String phone, HttpSession session) {
//        验证手机号格式是否正确
        if (!RegexUtils.isMobileExact(phone)) {
            return Result.error(Constants.CODE_COMMON_ERR, "手机号格式错误");
        } else {
//            格式正确，则生成6位随机数（即验证码）
            String code = RandomUtil.randomNumbers(6);
//            保存验证码到session
            session.setAttribute("code", code);
//            发送验证码
            log.debug("发送验证码成功，验证码是：{}", code);
        }
        return Result.success();
    }
}
