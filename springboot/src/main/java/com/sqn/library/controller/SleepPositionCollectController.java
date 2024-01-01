package com.sqn.library.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Result;
import com.sqn.library.entity.SleepPositionCollect;
import com.sqn.library.service.ISleepPositionCollectService;
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
@RequestMapping("/sleep-position-collect")
public class SleepPositionCollectController {

    @Resource
    private ISleepPositionCollectService sleepPositionCollectService;

    /**
     * 新增或者更新
     */
    @PostMapping
    public Result<?> save(@RequestBody SleepPositionCollect sleepPositionCollect) {
        sleepPositionCollectService.saveOrUpdate(sleepPositionCollect);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        sleepPositionCollectService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        sleepPositionCollectService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result<?> findAll() {
        return Result.success(sleepPositionCollectService.list());
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Long id) {
        return Result.success(sleepPositionCollectService.getById(id));
    }

    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize) {
        QueryWrapper<SleepPositionCollect> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return Result.success(sleepPositionCollectService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }
}
