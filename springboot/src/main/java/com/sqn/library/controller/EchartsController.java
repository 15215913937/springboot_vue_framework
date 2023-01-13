package com.sqn.library.controller;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.Month;
import cn.hutool.http.HttpUtil;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Book;
import com.sqn.library.entity.User;
import com.sqn.library.service.IBookService;
import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.*;

/**
 * @Author shenqn
 * @Date 2022/7/16  1:47
 */
@RestController
@RequestMapping("/echarts")
@Api(tags = {"图表管理"})
public class EchartsController {
    @Resource
    IBookService bookService;

//    @GetMapping("/example")
//    public Result<?> get() {
//        HashMap<String, Object> map = new HashMap<>();
//        map.put("x", CollUtil.newArrayList("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"));
//        map.put("y", CollUtil.newArrayList(150, 230, 224, 218, 135, 147, 260));
//        return Result.success(map);
//    }

    /**
     * 新冠数据
     *
     * @return
     */
    @GetMapping("/epidemic")
    public String getC19() {
        return HttpUtil.get("https://c.m.163.com/ug/api/wuhan/app/data/list-total?t=" + System.currentTimeMillis());
    }

    /**
     * 按年获取每月购书数量
     *
     * @param year 获取年份
     * @param id
     * @return
     */

    @GetMapping("/booksPurchaseStatistics")
    public Result<?> booksPurchaseStatistics(@RequestParam String year, @RequestParam Integer id) {
        return Result.success(bookService.booksPurchaseStatistics(year, id));
    }
}
