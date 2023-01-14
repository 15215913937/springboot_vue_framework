package com.sqn.library.controller;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.sqn.library.entity.Book;
import com.sqn.library.mapper.BookMapper;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * @author sqn
 */
@RestController
@RequestMapping("/test")
public class TestController {
    @Resource
    StringRedisTemplate stringRedisTemplate;
    @Resource
    BookMapper bookMapper;

    @GetMapping("/{id}")
    public Boolean get(@PathVariable Integer id) {
        final List<Book> list = bookMapper.selectList(Wrappers.emptyWrapper());
        stringRedisTemplate.opsForValue().set("book", JSONUtil.toJsonStr(list), 10, TimeUnit.SECONDS);
        return true;
    }
}
