package com.sqn.library.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Book;
import com.sqn.library.mapper.BookMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;

import static cn.hutool.core.date.LocalDateTimeUtil.parseDate;

@RestController
@RequestMapping("/book")//统一接口加前缀
public class BookController {
    @Resource
    BookMapper bookMapper;

    //图书新增接口
    @PostMapping
    public Result<?> save(@RequestBody Book book) {
        if (book.getBuyDate() == null) {
            book.setBuyDate(new Date());
        }
        bookMapper.insert(book);
        return Result.success();
    }

    //图书信息修改接口
    @PutMapping
    public Result<?> update(@RequestBody Book book) {
        if (book.getBuyDate() == null) {
            book.setBuyDate(new Date());
        }
        bookMapper.updateById(book);
        return Result.success();
    }

    //删除接口
    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        bookMapper.deleteById(id);
        return Result.success();
    }

    //查询接口
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String name,
                              @RequestParam(defaultValue = "") String author,
                              @RequestParam(defaultValue = "") String category) {
        LambdaQueryWrapper<Book> wrapper = Wrappers.<Book>lambdaQuery();
        if (StrUtil.isNotBlank(name)||StrUtil.isNotBlank(author)||StrUtil.isNotBlank(category)) {
            wrapper.like(Book::getBookname, name).like(Book::getAuthor, author).like(Book::getCategory, category);
        }
        Page<Book> bookPage = bookMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(bookPage);
    }
}
