package com.sqn.library.service.impl;

import com.sqn.library.entity.Menu;
import com.sqn.library.entity.User;
import com.sqn.library.mapper.RoleMapper;
import com.sqn.library.mapper.RoleMenuMapper;
import com.sqn.library.mapper.UserMapper;
import com.sqn.library.service.IMenuService;
import com.sqn.library.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;


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
}
