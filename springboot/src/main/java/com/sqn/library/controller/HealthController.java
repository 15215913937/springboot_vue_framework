package com.sqn.library.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sqn.library.common.Result;


import com.sqn.library.service.IHealthService;
import com.sqn.library.entity.Health;

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
@RequestMapping("/health")
public class HealthController {

    @Resource
    private IHealthService healthService;

    /**
     * 新增或者更新
     */
    @PostMapping
    public Result<?> save(@RequestBody Health health) {
        if (health.getHeight() == 0 || health.getWeight() == 0) {
            return Result.error(Constants.CODE_COMMON_ERR, "身高或体重输入错误");
        }
        healthService.saveOrUpdate(health);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Integer id) {
        healthService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        healthService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result<?> findAll() {
        return Result.success(healthService.list());
    }

    @PostMapping("/queryLatestInfo/{uid}")
    public Result<?> queryLatestInfo(@PathVariable Integer uid) {
        List<Health> list = healthService.getByUid(uid);
        return Result.success(list);
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Integer id) {
        return Result.success(healthService.getById(id));
    }

    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize) {
        QueryWrapper<Health> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return Result.success(healthService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

}
