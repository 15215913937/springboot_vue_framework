package com.sqn.library.controller;


import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Result;
import com.sqn.library.entity.ConsumerDetails;
import com.sqn.library.mapper.ConsumerDetailsMapper;
import com.sqn.library.service.IConsumerDetailsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author shenqn
 * @since 2022-08-30
 */
@Slf4j
@RestController
@RequestMapping("/consumer-details")
public class ConsumerDetailsController {

    @Resource
    IConsumerDetailsService consumerDetailsService;
    @Resource
    ConsumerDetailsMapper consumerDetailsMapper;

    /**
     * 新增消费记录
     *
     * @param consumerDetails
     * @return
     */
    @PostMapping
    public Result<?> save(@RequestBody ConsumerDetails consumerDetails) {
//        List<ConsumerDetails> oldList =
//                consumerDetailsMapper.selectList(Wrappers.<ConsumerDetails>lambdaQuery().eq(ConsumerDetails::getUid,
//                        consumerDetails.getUid()));
        consumerDetailsService.save(consumerDetails);
        return Result.success();
    }


    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
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

    @GetMapping("/findById")
    public Result<?> statisticsByIdAndYear(@RequestParam Long id, @RequestParam String year) {
        return Result.success(consumerDetailsService.statisticsByIdAndYear(id, year));
    }


    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String type,
                              @RequestParam(defaultValue = "") Long uid,
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