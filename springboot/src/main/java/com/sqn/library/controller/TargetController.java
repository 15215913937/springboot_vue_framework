package com.sqn.library.controller;


import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.entity.Health;
import com.sqn.library.mapper.TargetMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sqn.library.common.Result;


import com.sqn.library.service.ITargetService;
import com.sqn.library.entity.Target;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author shenqn
 * @since 2023-02-23
 */
@RestController
@RequestMapping("/target")
public class TargetController {

    @Resource
    private ITargetService targetService;

    @Resource
    TargetMapper targetMapper;

    /**
     * 新增或者更新
     */
    @PostMapping
    public Result<?> save(@RequestBody Target target) {
        targetService.saveOrUpdate(target);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Integer id) {
        targetService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        targetService.removeByIds(ids);
        return Result.success();
    }

    @PostMapping("/queryTargets/{uid}")
    public Result<?> queryLatestTarget(@PathVariable Integer uid) {
        targetService.refreshStatus(uid);
        List<Target> list = targetMapper.selectList(Wrappers.<Target>lambdaQuery().eq(Target::getUid, uid).orderByDesc(Target::getStartTime));
        return Result.success(list);
    }

    @GetMapping
    public Result<?> findAll() {
        return Result.success(targetService.list());
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Integer id) {
        return Result.success(targetService.getById(id));
    }

    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize) {
        QueryWrapper<Target> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return Result.success(targetService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

}
