package com.sqn.library.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Result;
import com.sqn.library.entity.UserInfo;
import com.sqn.library.mapper.UserInfoMapper;
import com.sqn.library.service.IUserInfoService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author shenqn
 * @since 2023-12-30
 */
@RestController
@RequestMapping("/user-info")
public class UserInfoController {

    @Resource
    private IUserInfoService userInfoService;

    @Resource
    UserInfoMapper userInfoMapper;

    /**
     * 新增或者更新
     */
    @PostMapping
    public Result<?> save(@RequestBody UserInfo userInfo) {
        userInfoService.saveOrUpdate(userInfo);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        userInfoService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        userInfoService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping("/all")
    public Result<?> findAll() {
        return Result.success(userInfoService.list());
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Long id) {
        return Result.success(userInfoService.getById(id));
    }

    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String name) {
        Page<UserInfo> userPage = userInfoMapper.findPage(new Page<>(pageNum, pageSize), name);
        return Result.success(userPage);
    }
}
