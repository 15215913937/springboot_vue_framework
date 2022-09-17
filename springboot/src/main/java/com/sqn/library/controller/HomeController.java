package com.sqn.library.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Book;
import com.sqn.library.mapper.ConsumerDetailsMapper;
import com.sqn.library.service.IBookService;
import com.sqn.library.service.IEventsService;
import com.sqn.library.utils.ConsumeCalculate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/home")
public class HomeController {
    @Resource
    ConsumerDetailsMapper consumerDetailsMapper;

    @Resource
    ConsumeCalculate consumeCalculate;

    @Resource
    IBookService iBookService;

    @Resource
    IEventsService eventsService;

    //    查询当月账单
    @GetMapping("/getHomeOneInfo/{id}")
    public Result<?> getHomeOneInfo(@PathVariable Integer id) {
        HashMap<String, HashMap<String, String>> homeInfo = new HashMap<>();
//        我的账单
        HashMap<String, String> billInfo = new HashMap<>();
//        我的账单-支出和收入
        List<String> list1 = consumerDetailsMapper.getCurrentMonthExpense(id);
        List<String> list2 = consumerDetailsMapper.getLastMonthExpense(id);
        billInfo.put("currentExpense", (list1.size() != 0 ? list1.get(0) : "0.00") + "元");
        billInfo.put("currentIncome", (list1.size() == 2 ? list1.get(1) : "0.00") + "元");
        billInfo.put("lastExpense", (list2.size() != 0 ? list2.get(0) : "0.00") + "元");
        billInfo.put("lastIncome", (list2.size() == 2 ? list2.get(1) : "0.00") + "元");
//        我的账单-同比增长率
        final String s1 = consumeCalculate.ratioYearOnYear(list1.size() != 0 ? Double.parseDouble(list1.get(0)) : 0d, list2.size() != 0 ? Double.parseDouble(list2.get(0)) : 0d);
        final String s2 = consumeCalculate.ratioYearOnYear(list1.size() == 2 ? Double.parseDouble(list1.get(1)) : 0d, list2.size() == 2 ? Double.parseDouble(list2.get(1)) : 0d);
        billInfo.put("expenseRatioYearOnYear", s1);
        billInfo.put("incomeRatioYearOnYear", s2);
        homeInfo.put("billInfo", billInfo);
//          我的书籍
        HashMap<String, String> commonInfo = new HashMap<>();
//        我的书籍-个数
        final List<Book> bookList = iBookService.getByUid(id);
        commonInfo.put("myBookCount", String.valueOf(bookList.size()));
        homeInfo.put("MyBookInfo", commonInfo);

        return Result.success(homeInfo);
    }
}
