package com.sqn.library.controller;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.Month;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Book;
import com.sqn.library.entity.User;
import com.sqn.library.service.IBookService;
import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

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

    @GetMapping("/example")
    public Result<?> get() {
        HashMap<String, Object> map = new HashMap<>();
        map.put("x", CollUtil.newArrayList("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"));
        map.put("y", CollUtil.newArrayList(150, 230, 224, 218, 135, 147, 260));
        return Result.success(map);
    }
//新冠数据
    @GetMapping("/COVID-19_pandemic")
    public void getC19() {
//        final HttpRequest request = new HttpRequest();
//        request.getUrl("https://c.m.163.com/ug/api/wuhan/app/data/list-total?t="+);
    }

    @GetMapping("/booksNumber")
    public Result<?> booksNumber() {
        List<Book> list = bookService.list();
        int m1 = 0; //1月
        int m2 = 0; //2月
        int m3 = 0; //3月
        int m4 = 0; //4月
        int m5 = 0; //5月
        int m6 = 0; //6月
        int m7 = 0; //7月
        int m8 = 0; //8月
        int m9 = 0; //9月
        int m10 = 0; //10月
        int m11 = 0; //11月
        int m12 = 0; //12月
        for (Book book : list) {
            Date buyDate = book.getBuyDate();
            Month month = DateTime.of(buyDate).monthEnum();
            switch (month) {
                case JANUARY:
                    m1 += 1;
                    break;
                case FEBRUARY:
                    m2 += 1;
                    break;
                case MARCH:
                    m3 += 1;
                    break;
                case APRIL:
                    m4 += 1;
                    break;
                case MAY:
                    m5 += 1;
                    break;
                case JUNE:
                    m6 += 1;
                    break;
                case JULY:
                    m7 += 1;
                    break;
                case AUGUST:
                    m8 += 1;
                    break;
                case SEPTEMBER:
                    m9 += 1;
                    break;
                case OCTOBER:
                    m10 += 1;
                    break;
                case NOVEMBER:
                    m11 += 1;
                    break;
                case DECEMBER:
                    m12 += 1;
                    break;
                default:
                    break;
            }
        }
        return Result.success(CollUtil.newArrayList(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12));
    }

    @PostMapping("/booksNumberOne")
    public Result<?> booksNumberOne(@RequestBody User user) {
        List<Book> list = bookService.OneList(user.getId());
        int m1 = 0; //1月
        int m2 = 0; //2月
        int m3 = 0; //3月
        int m4 = 0; //4月
        int m5 = 0; //5月
        int m6 = 0; //6月
        int m7 = 0; //7月
        int m8 = 0; //8月
        int m9 = 0; //9月
        int m10 = 0; //10月
        int m11 = 0; //11月
        int m12 = 0; //12月
        for (Book book : list) {
            Date buyDate = book.getBuyDate();
            Month month = DateTime.of(buyDate).monthEnum();
            switch (month) {
                case JANUARY:
                    m1 += 1;
                    break;
                case FEBRUARY:
                    m2 += 1;
                    break;
                case MARCH:
                    m3 += 1;
                    break;
                case APRIL:
                    m4 += 1;
                    break;
                case MAY:
                    m5 += 1;
                    break;
                case JUNE:
                    m6 += 1;
                    break;
                case JULY:
                    m7 += 1;
                    break;
                case AUGUST:
                    m8 += 1;
                    break;
                case SEPTEMBER:
                    m9 += 1;
                    break;
                case OCTOBER:
                    m10 += 1;
                    break;
                case NOVEMBER:
                    m11 += 1;
                    break;
                case DECEMBER:
                    m12 += 1;
                    break;
                default:
                    break;
            }
        }
        return Result.success(CollUtil.newArrayList(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12));
    }
}
