package com.sqn.library.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Result;
import com.sqn.library.entity.User;
import com.sqn.library.mapper.UserMapper;
import com.sqn.library.service.UserService;
import com.sqn.library.utils.TokenUtils;
import io.swagger.annotations.Api;
import lombok.val;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/user")
@Api(tags = {"成员管理"})
public class UserController {
    @Resource
    UserMapper userMapper;
    @Autowired
    UserService userService;

    //登录接口
    //@RequestBody ：把前端传过来的json对象转换为java对象
    @PostMapping("/login")
    public Result<?> login(@RequestBody User user) {
//        User userPwd = userMapper.selectByName(user.getUsername());
//        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
//        queryWrapper.eq("username", user.getUsername());
//        queryWrapper.eq("password", userPwd.getPassword());
//        User res = userMapper.selectOne(queryWrapper);
        User res =
                userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, user.getUsername()).eq(User::getPassword, user.getPassword()));
        if (res == null) {
            return Result.error("-1", "用户名或密码错误！");
        }
        // 生成token
        String token = TokenUtils.genToken(res);
        res.setToken(token);
        return Result.success(res);
    }

    //注册接口
    @PostMapping("/register")
    public Result<?> register(@RequestBody User user) {
        User res = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, user.getUsername()));
        if (res != null) {
            return Result.error("-1", "用户名已存在");
        }
        if (user.getPassword() == null) {
            user.setPassword("123456");
        }
        userMapper.insert(user);
        return Result.success();
    }

    //新增接口
    @PostMapping
    public Result<?> save(@RequestBody User user) {
        if (user.getPassword() == null) {
            user.setPassword("123456");
        }
        userMapper.insert(user);
        return Result.success();
    }

    //修改接口
    @PutMapping
    public Result<?> update(@RequestBody User user) {
        userMapper.updateById(user);
        return Result.success();
    }

    //删除接口
    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
//        userMapper.deleteById(id);
//        return Result.success();
        userService.removeById(id);
        return Result.success();
    }

    //分页查询接口
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String name) {
        LambdaQueryWrapper<User> wrapper = Wrappers.<User>lambdaQuery().orderByAsc(User::getId);
        if (StrUtil.isNotBlank(name)) {
            wrapper.like(User::getName, name);
        }
        Page<User> userPage = userMapper.findPage(new Page<>(pageNum, pageSize), name);
        return Result.success(userPage);
    }

    @GetMapping("/{id}")
    private Result<?> getById(@PathVariable Long id){
        User user = userMapper.selectById(id);
        return Result.success(user);

    }
}
