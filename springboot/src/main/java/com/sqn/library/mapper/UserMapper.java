package com.sqn.library.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sqn.library.entity.User;
import org.apache.ibatis.annotations.Select;

public interface UserMapper extends BaseMapper<User> {
    //查询用户名
    @Select("select password from user where username = #{username}")
    User selectByName(String username);
}
