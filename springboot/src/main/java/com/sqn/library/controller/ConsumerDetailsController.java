package com.sqn.library.controller;


import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sqn.library.common.Result;


import com.sqn.library.service.IConsumerDetailsService;
import com.sqn.library.entity.ConsumerDetails;

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
@RequestMapping("/consumer-details")
public class ConsumerDetailsController {

    @Resource
    private IConsumerDetailsService consumerDetailsService;

    // 新增或者更新
    @PostMapping
    public Result<?> save(@RequestBody ConsumerDetails consumerDetails) {
        consumerDetailsService.saveOrUpdate(consumerDetails);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Integer id) {
        consumerDetailsService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        consumerDetailsService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result<?> findAll() {
        return Result.success(consumerDetailsService.list());
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Integer id) {
        return Result.success(consumerDetailsService.getById(id));
    }

    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String type,
                              @RequestParam(defaultValue = "") Integer uid,
                              @RequestParam(defaultValue = "") String category) {
        LambdaQueryWrapper<ConsumerDetails> wrapper = Wrappers.<ConsumerDetails>lambdaQuery();
        wrapper.eq(ConsumerDetails::getUid, uid).orderByDesc(ConsumerDetails::getId);
        if (StrUtil.isNotBlank(type) || StrUtil.isNotBlank(category)) {
            wrapper.like(ConsumerDetails::getType, type)
                    .like(ConsumerDetails::getCategory, category);
        }
        return Result.success(consumerDetailsService.page(new Page<>(pageNum, pageSize), wrapper));
    }

}

