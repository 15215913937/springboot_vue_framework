package com.sqn.library.controller;

import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Book;
import com.sqn.library.entity.User;
import com.sqn.library.mapper.BookMapper;
import com.sqn.library.mapper.UserMapper;
import com.sqn.library.service.IBookService;
import com.sqn.library.service.IUserService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import static cn.hutool.core.date.LocalDateTimeUtil.parseDate;

@Api(tags = "书籍管理")
@RestController
@RequestMapping("/book")//统一接口加前缀
public class BookController {
    @Resource
    BookMapper bookMapper;
    @Resource
    IBookService iBookService;

    @Resource
    IUserService iUserService;

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
//        LambdaQueryWrapper<Book> wrapper = Wrappers.<Book>lambdaQuery();
//        if (StrUtil.isNotBlank(name) || StrUtil.isNotBlank(author) || StrUtil.isNotBlank(category)) {
//            wrapper.like(Book::getBookname, name).like(Book::getAuthor, author).like(Book::getCategory, category);
//        }
//        Page<Book> bookPage = bookMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
//        List<Book> records = bookPage.getRecords();
//        for (Book record : records) {
//            User user = iUserService.getById(record.getUid());
//            if(user!=null){
//                record.setUsername(user.getName());
//            }
//        }
        Page<Book> bookPage = iBookService.findPage(new Page<>(pageNum, pageSize), name, author, category);
        return Result.success(bookPage);
    }

    //批量删除
    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        bookMapper.deleteBatchIds(ids);
        return Result.success();
    }

    /**
     * 导出接口
     */
    @GetMapping("/export")
    private void export(HttpServletResponse response) throws Exception {
        //从数据库获取全部数据
        List<Book> list = iBookService.list();
        //在内存操作，写出到浏览器
        ExcelWriter writer = ExcelUtil.getWriter(true);
        //自定义标题别名
        writer.addHeaderAlias("id", "ID");
        writer.addHeaderAlias("bookname", "书名");
        writer.addHeaderAlias("author", "作者");
        writer.addHeaderAlias("category", "类别");
        writer.addHeaderAlias("version", "版本");
        writer.addHeaderAlias("publishingHouse", "出版社");
        writer.addHeaderAlias("uid", "购买者");
        writer.addHeaderAlias("price", "价格");
        writer.addHeaderAlias("buyDate", "购买日期");
        writer.addHeaderAlias("comment", "备注");
        writer.addHeaderAlias("cover", "封面");

        //一次性写出list内的对象到excel，使用默认样式，强制输出标题
        writer.write(list, true);

        //设置浏览器响应格式
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String fileName = URLEncoder.encode("书籍信息", "UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");

        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        out.close();
        writer.close();

    }
}
