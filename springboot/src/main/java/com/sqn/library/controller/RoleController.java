package com.sqn.library.controller;


import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.RoleMapper;
import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sqn.library.common.Result;


import com.sqn.library.service.IRoleService;
import com.sqn.library.entity.Role;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author shenqn
 * @since 2022-07-17
 */
@RestController
@RequestMapping("/role")
@Api(tags = {"角色管理"})
public class RoleController {

    @Resource
    private IRoleService roleService;
    @Resource
    RoleMapper roleMapper;
    // 新增或者更新
    @PostMapping
    public Result<?> save(@RequestBody Role role) {
        final Role role1 = roleMapper.selectOne(Wrappers.<Role>lambdaQuery().eq(Role::getRole, role.getRole()));
        if(role1!=null && !role1.getId().equals(role.getId())){
            throw new CustomException(Constants.CODE_COMMON_ERR,"角色已存在");
        }
        if (StrUtil.isBlank(role.getRole()) || StrUtil.isBlank(role.getFlag())) {
            throw new CustomException(Constants.CODE_COMMON_ERR, "参数错误");
        }
        roleService.saveOrUpdate(role);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Integer id) {
        roleService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        roleService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result<?> findAll() {
        return Result.success(roleService.list());
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Integer id) {
        return Result.success(roleService.getById(id));
    }

    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(defaultValue = "") String role,
                              @RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize) {
        QueryWrapper<Role> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("role", role);
        return Result.success(roleService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    /**
     * 绑定角色和菜单的关系
     */
    @PostMapping("/roleMenu/{roleId}")
    public Result<?> roleMenu(@PathVariable Integer roleId, @RequestBody List<Integer> menuIds) {
        roleService.setRoleMenu(roleId, menuIds);
        return Result.success();
    }

    @GetMapping("/roleMenu/{roleId}")
    public Result<?> getRoleMenu(@PathVariable Integer roleId) {
        return Result.success(roleService.getRoleMenu(roleId));
    }

}

