package com.sqn.library.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Target;
import com.sqn.library.mapper.TargetMapper;
import com.sqn.library.service.ITargetService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

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
        Integer flag = targetService.add(target);
        if (flag == 0) {
            return Result.error(Constants.CODE_DATA_ERR, "请勿与历史任务代号重复");
        } else if (flag == 1) {
            return Result.error(Constants.CODE_DATA_ERR, "未设置具体运动目标");
        }
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        targetService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Long> ids) {
        targetService.removeByIds(ids);
        return Result.success();
    }

    @PostMapping("/queryTargets/{uid}")
    public Result<?> queryLatestTarget(@PathVariable Long uid) {
        targetService.refreshAllTargetSchedule(uid);
        targetService.refreshStatus(uid);
        List<Target> list = targetMapper.selectList(Wrappers.<Target>lambdaQuery().eq(Target::getUid, uid).orderByDesc(Target::getCreateTime));
        return Result.success(list);
    }

    @GetMapping
    public Result<?> findAll() {
        return Result.success(targetService.list());
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Long id) {
        return Result.success(targetService.queryById(id));
    }

    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize) {
        QueryWrapper<Target> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return Result.success(targetService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    @PostMapping("/terminate")
    public Result<?> terminate(@RequestBody Long id) {
        targetService.terminateTarget(id);
        return Result.success();
    }

}
