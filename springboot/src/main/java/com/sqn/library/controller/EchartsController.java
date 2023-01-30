package com.sqn.library.controller;

import cn.hutool.http.HttpUtil;
import com.sqn.library.common.Result;
import com.sqn.library.service.IBookService;
import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;

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

    /**
     * 指定年份每月购书数量统计
     *
     * @param year 获取年份
     * @param id   用户id
     * @return
     */

    @GetMapping("/booksPurchaseStatistics")
    public Result<?> booksPurchaseStatistics(@RequestParam String year, @RequestParam Integer id) {
        return Result.success(bookService.booksPurchaseStatistics(year, id));
    }
}
