package com.sqn.library.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
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

    /** 新增或者更新
     *
     * @param role
     * @return
     */
    @PostMapping
    public Result<?> save(@RequestBody Role role) {
        if (StrUtil.isBlank(role.getRole()) || StrUtil.isBlank(role.getFlag())) {
            throw new CustomException(Constants.CODE_COMMON_ERR, "必填项不能为空！");
        }
        Role res =
                roleMapper.selectOne(Wrappers.<Role>lambdaQuery()
                        .eq(Role::getRole, role.getRole())
                        .or()
                        .eq(Role::getFlag, role.getFlag()));
        if ((res != null && role.getId() == null) || (res != null && !res.getId().equals(role.getId()))) {
            throw new CustomException(Constants.CODE_COMMON_ERR, "该角色或标记已存在");
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

    @GetMapping("/allRole")
    public Result<?> findAllRole() {
        final QueryWrapper<Role> wrapper = new QueryWrapper<>();
        final List<Role> roles = roleMapper.selectList(wrapper);
        return Result.success(roles);
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

