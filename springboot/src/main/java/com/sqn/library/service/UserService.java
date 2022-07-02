package com.sqn.library.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sqn.library.entity.User;
import com.sqn.library.mapper.UserMapper;
import org.springframework.stereotype.Service;

@Service
public class UserService extends ServiceImpl<UserMapper, User> {
}
