package com.sqn.library.controller;


import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.ConsumerDetailsMapper;
import com.sqn.library.utils.ConsumeCalculate;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
@Slf4j
@RestController
@RequestMapping("/consumer-details")
public class ConsumerDetailsController {

    @Resource
    IConsumerDetailsService consumerDetailsService;
    @Resource
    ConsumerDetailsMapper consumerDetailsMapper;
    @Autowired
    ConsumeCalculate consumeCalculate;

    // 新增消费记录
    @PostMapping
    public Result<?> save(@RequestBody ConsumerDetails consumerDetails) {
        List<ConsumerDetails> old_list =
                consumerDetailsMapper.selectList(Wrappers.<ConsumerDetails>lambdaQuery().eq(ConsumerDetails::getUid,
                        consumerDetails.getUid()));
        consumerDetailsService.save(consumerDetails);
        List<ConsumerDetails> new_list =
                consumerDetailsMapper.selectList(Wrappers.<ConsumerDetails>lambdaQuery().eq(ConsumerDetails::getUid,
                        consumerDetails.getUid()).orderByDesc(ConsumerDetails::getCreatetime));
        if (old_list.size() < new_list.size()) {
            ConsumerDetails new_detail = new_list.get(0);
            return Result.success(new_detail.getCost());
        }
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

    //    查询当月账单
    @GetMapping("/getCurrentBill/{id}")
    public Result<?> findCurrentBillById(@PathVariable Integer id) {
        HashMap<String, String> map = new HashMap<>();
        List<String> list1 = consumerDetailsMapper.getCurrentMonthExpense(id);
        List<String> list2 = consumerDetailsMapper.getLastMonthExpense(id);
        map.put("currentExpense", (list1.size() != 0 ? list1.get(0) : "0.00") + "元");
        map.put("currentIncome", (list1.size() == 2 ? list1.get(1) : "0.00") + "元");
        map.put("lastExpense", (list2.size() != 0 ? list2.get(0) : "0.00") + "元");
        map.put("lastIncome", (list2.size() == 2 ? list2.get(1) : "0.00") + "元");
        final String s1 = consumeCalculate.ratioYearOnYear(list1.size() != 0 ? Double.parseDouble(list1.get(0)) : 0d, list2.size() != 0 ? Double.parseDouble(list2.get(0)) : 0d);
        final String s2 = consumeCalculate.ratioYearOnYear(list1.size() == 2 ? Double.parseDouble(list1.get(1)) : 0d, list2.size() == 2 ? Double.parseDouble(list2.get(1)) : 0d);
        map.put("expenseRatioYearOnYear", s1);
        map.put("incomeRatioYearOnYear", s2);
        return Result.success(map);
    }

}

