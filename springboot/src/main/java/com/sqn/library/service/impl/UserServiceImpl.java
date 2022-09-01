package com.sqn.library.service.impl;

import cn.hutool.log.Log;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.sqn.library.common.Result;
import com.sqn.library.controller.ConsumerDetailsController;
import com.sqn.library.controller.UserController;
import com.sqn.library.controller.dto.UserPasswordDTO;
import com.sqn.library.controller.dto.UserResetPwdDTO;
import com.sqn.library.entity.ConsumerDetails;
import com.sqn.library.entity.User;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.UserMapper;
import com.sqn.library.service.IConsumerDetailsService;
import com.sqn.library.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


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
    @Resource
    IConsumerDetailsService iConsumerDetailsService;

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
    public Double updateBalance(Integer id, Double new_bill) {
        User one = userMapper.selectById(id);
        Double balance = one.getBalance();
        balance += new_bill;
//        LambdaQueryWrapper<ConsumerDetails> wrapper = Wrappers.lambdaQuery();
//        wrapper.eq(ConsumerDetails::getUid, id);
//        List<ConsumerDetails> list = iConsumerDetailsService.list(wrapper);
////        System.out.println(balance);
//        for (ConsumerDetails consumerDetails : list) {
////            System.out.println("类型：" + consumerDetails.getType() + ",金额：" + consumerDetails.getCost());
//            if (consumerDetails.getType().equals("支出")) {
//                balance -= consumerDetails.getCost();
//            } else if (consumerDetails.getType().equals("收入")) {
//                balance += consumerDetails.getCost();
//            }
//        }
        one.setBalance(balance);
        System.out.println("------------------------------------这里------------------" + one);
        User user = new User();
        user.setId(id);
        user.setBalance(balance);
        userMapper.updateById(user);
        return balance;
    }
}
