package com.sqn.library.service.impl;

import com.sqn.library.entity.UserInfo;
import com.sqn.library.mapper.UserInfoMapper;
import com.sqn.library.service.IUserInfoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2023-12-30
 */
@Service
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo>implements IUserInfoService {

}
