package com.sqn.library.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sqn.library.common.Result;


import com.sqn.library.service.IConsumptionTypeService;
import com.sqn.library.entity.ConsumptionType;

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
@RequestMapping("/consumption-type")
public class ConsumptionTypeController {

    @Resource
    private IConsumptionTypeService consumptionTypeService;

    /**
     * 新增或者更新
     */
    @PostMapping
    public Result<?> save(@RequestBody ConsumptionType consumptionType) {
        consumptionTypeService.saveOrUpdate(consumptionType);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Integer id) {
        consumptionTypeService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        consumptionTypeService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result<?> findAll() {
        return Result.success(consumptionTypeService.list());
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Integer id) {
        return Result.success(consumptionTypeService.getById(id));
    }

    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize) {
        QueryWrapper<ConsumptionType> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return Result.success(consumptionTypeService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

}

