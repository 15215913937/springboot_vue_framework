package com.sqn.library.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sqn.library.common.Result;


import com.sqn.library.service.IConsumptionCategoryService;
import com.sqn.library.entity.ConsumptionCategory;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author shenqn
 * @since 2022-08-30
 */
@RestController
@RequestMapping("/consumption-category")
public class ConsumptionCategoryController {

    @Resource
    private IConsumptionCategoryService consumptionCategoryService;

    // 新增或者更新
    @PostMapping
    public Result<?> save(@RequestBody ConsumptionCategory consumptionCategory) {
        consumptionCategoryService.saveOrUpdate(consumptionCategory);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Integer id) {
        consumptionCategoryService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        consumptionCategoryService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result<?> findAll() {
        return Result.success(consumptionCategoryService.list());
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Integer id) {
        return Result.success(consumptionCategoryService.getById(id));
    }

    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize) {
        QueryWrapper<ConsumptionCategory> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return Result.success(consumptionCategoryService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

}

