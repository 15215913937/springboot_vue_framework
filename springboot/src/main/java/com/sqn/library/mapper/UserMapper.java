package com.sqn.library.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.entity.Menu;
import com.sqn.library.entity.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface UserMapper extends BaseMapper<User> {

    //查询用户名
    @Select("select password from user where username = #{username}")
    User selectByName(String username);

    // 一对多查询
    Page<User> findPage(Page<User> page, @Param("name") String name);
}
