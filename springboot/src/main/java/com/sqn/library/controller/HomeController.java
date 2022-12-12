package com.sqn.library.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Book;
import com.sqn.library.entity.Events;
import com.sqn.library.entity.Files;
import com.sqn.library.entity.User;
import com.sqn.library.mapper.ConsumerDetailsMapper;
import com.sqn.library.service.IBookService;
import com.sqn.library.service.IEventsService;
import com.sqn.library.service.IFileService;
import com.sqn.library.service.IUserService;
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

    @Resource
    IFileService iFileService;
    @Resource
    IUserService userService;

    //    查询当月账单
    @GetMapping("/getHomeOneInfo/{id}")
    public Result<?> getHomeOneInfo(@PathVariable Integer id) {
        HashMap<String, HashMap<String, String>> homeInfo = new HashMap<>();
//        我的账单
        HashMap<String, String> billInfo = new HashMap<>();
//        我的账单-支出和收入
        List<String> list1 = consumerDetailsMapper.getCurrentMonthExpense(id);
        List<String> list2 = consumerDetailsMapper.getLastMonthExpense(id);
        billInfo.put("currentExpense", (!list1.isEmpty() ? list1.get(0) : "0.00") + "元");
        billInfo.put("currentIncome", (list1.size() == 2 ? list1.get(1) : "0.00") + "元");
        billInfo.put("lastExpense", (!list2.isEmpty() ? list2.get(0) : "0.00") + "元");
        billInfo.put("lastIncome", (list2.size() == 2 ? list2.get(1) : "0.00") + "元");
//        我的账单-同比增长率
        final String s1 = consumeCalculate.ratioYearOnYear(!list1.isEmpty() ? Double.parseDouble(list1.get(0)) : 0d, !list2.isEmpty() ? Double.parseDouble(list2.get(0)) : 0d);
        final String s2 = consumeCalculate.ratioYearOnYear(list1.size() == 2 ? Double.parseDouble(list1.get(1)) : 0d, list2.size() == 2 ? Double.parseDouble(list2.get(1)) : 0d);
        billInfo.put("expenseRatioYearOnYear", s1);
        billInfo.put("incomeRatioYearOnYear", s2);
        homeInfo.put("billInfo", billInfo);
//          数量统计
        HashMap<String, String> commonInfo = new HashMap<>();
//        总书籍个数
        final List<Book> booksList = iBookService.list();
        commonInfo.put("booksCount", String.valueOf(booksList.size()));
//        我的书籍个数
        final List<Book> bookList = iBookService.getByUid(id);
        commonInfo.put("myBookCount", String.valueOf(bookList.size()));
//        事件统计
        final List<Events> eventsList = eventsService.list();
        commonInfo.put("eventsCount", String.valueOf(eventsList.size()));
//我的事件统计
        final Integer byAuthor = eventsService.getByAuthor(id);
        commonInfo.put("myEventCount", String.valueOf(byAuthor));
//        文件总数
        final List<Files> filesList = iFileService.list();
        commonInfo.put("filesCount", String.valueOf(filesList.size()));
//注册总人数
        final List<User> usersList = userService.list();
        commonInfo.put("usersCount", String.valueOf(usersList.size()));

        homeInfo.put("commonInfo", commonInfo);
        return Result.success(homeInfo);
    }
}
