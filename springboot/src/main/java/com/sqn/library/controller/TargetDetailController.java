package com.sqn.library.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Result;
import com.sqn.library.entity.TargetDetail;
import com.sqn.library.service.ITargetDetailService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author shenqn
 * @since 2023-03-08
 */
@RestController
@RequestMapping("/target-detail")
public class TargetDetailController {

    @Resource
    private ITargetDetailService targetDetailService;

    /**
     * 新增或者更新
     */
    @PostMapping
    public Result<?> save(@RequestBody TargetDetail targetDetail) {
        targetDetailService.saveOrUpdate(targetDetail);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Integer id) {
        targetDetailService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        targetDetailService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result<?> findAll() {
        return Result.success(targetDetailService.list());
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Integer id) {
        return Result.success(targetDetailService.getById(id));
    }

    @GetMapping("/getTargetDetail/{tId}")
    public Result<?> getTargetDetail(@PathVariable Integer tId) {
        return Result.success(targetDetailService.getTargetDetailByTId(tId));
    }

    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize) {
        QueryWrapper<TargetDetail> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return Result.success(targetDetailService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }
}
