package com.sqn.library.controller;

import cn.hutool.core.collection.CollUtil;
import com.sqn.library.common.Result;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

/**
 * @Author shenqn
 * @Date 2022/7/16  1:47
 */
@RestController
@RequestMapping("/echarts")
public class EchartsController {

    @GetMapping("/example")
    public Result<?> get() {
        HashMap<String, Object> map = new HashMap<>();
        map.put("x", CollUtil.newArrayList("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"));
        map.put("y", CollUtil.newArrayList(150, 230, 224, 218, 135, 147, 260));
        return Result.success(map);
    }
}
