package com.sqn.library.controller;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.sqn.library.entity.Book;
import com.sqn.library.mapper.BookMapper;
import com.sqn.library.service.IBookService;
import com.sun.org.apache.xpath.internal.operations.Bool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/test")
public class TestController {
    @Autowired
    StringRedisTemplate stringRedisTemplate;
    @Autowired
    IBookService bookService;
    @Autowired
    BookMapper bookMapper;

    @GetMapping("/{id}")
    public Boolean get(@PathVariable Integer id) {
        final List<Book> list = bookMapper.selectList(Wrappers.emptyWrapper());
        stringRedisTemplate.opsForValue().set("book", JSONUtil.toJsonStr(list), 10, TimeUnit.SECONDS);
        return true;
    }

}
