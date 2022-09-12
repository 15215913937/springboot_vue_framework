package com.sqn.library.controller;

import cn.hutool.core.lang.intern.InternUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Book;
import com.sqn.library.entity.User;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.BookMapper;
import com.sqn.library.mapper.UserMapper;
import com.sqn.library.service.IBookService;
import com.sqn.library.service.IUserService;
import com.sqn.service.IpCountService;
import io.swagger.annotations.Api;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.sql.Wrapper;
import java.text.SimpleDateFormat;
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
    UserMapper userMapper;
    @Autowired
    IpCountService ipCountService;

    //图书新增或修改接口
    @PostMapping
    public Result<?> save(@RequestBody Book book) {
        if (StrUtil.isBlank(book.getBookname()) || StrUtil.isBlank(book.getAuthor()) || StrUtil.isBlank(book.getUid()) || book.getPrice() == null) {
            throw new CustomException(Constants.CODE_COMMON_ERR, "必填项不能为空！");
        }
        Book one =
                bookMapper.selectOne(Wrappers.<Book>lambdaQuery()
                        .eq(Book::getBookname, book.getBookname())
                        .eq(Book::getAuthor, book.getAuthor()));
        if ((one != null && book.getId() == null) || (one != null && !one.getId().equals(book.getId()))) {
            throw new CustomException(Constants.CODE_COMMON_ERR, "该书籍已存在");
        }
        if (book.getBuyDate() == null) {
            book.setBuyDate(new Date());
        }

        iBookService.saveOrUpdate(book);
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
//        自定义starter
        ipCountService.count();
        Page<Book> bookPage = iBookService.findPage(new Page<>(pageNum, pageSize), name, author, category);
        return Result.success(bookPage);
    }

    @GetMapping("/byUid")
    public Result<?> findPageById(@RequestParam Integer uid,
                                  @RequestParam(defaultValue = "1") Integer pageNum,
                                  @RequestParam(defaultValue = "10") Integer pageSize,
                                  @RequestParam(defaultValue = "") String name,
                                  @RequestParam(defaultValue = "") String author,
                                  @RequestParam(defaultValue = "") String category) {

        Page<Book> bookPage = iBookService.findPageByUid(new Page<>(pageNum, pageSize), uid, name, author, category);
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
        for (Book book : list) {
            User user = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getId, book.getUid()));
            book.setUsername(user.getName());
        }
        //在内存操作，写出到浏览器
        ExcelWriter writer = ExcelUtil.getWriter(true);
        //自定义标题别名
        writer.addHeaderAlias("id", "ID");
        writer.addHeaderAlias("bookname", "书名");
        writer.addHeaderAlias("author", "作者");
        writer.addHeaderAlias("category", "类别");
        writer.addHeaderAlias("version", "版本");
        writer.addHeaderAlias("publishingHouse", "出版社");
        writer.addHeaderAlias("username", "购买者");
        writer.addHeaderAlias("price", "价格");
        writer.addHeaderAlias("buyDate", "购买日期");
        writer.addHeaderAlias("comment", "备注");
        writer.addHeaderAlias("cover", "封面");
        // 设置只导出有别名的字段
        writer.setOnlyAlias(true);

        writer.setColumnWidth(8, 20);
        // 设置默认行高
//        bigWriter.setDefaultRowHeight(18);
        // 设置冻结行
        writer.setFreezePane(1);
        //一次性写出list内的对象到excel，使用默认样式，强制输出标题
        writer.write(list, true);
//        设置时间戳
        SimpleDateFormat timestamp = new SimpleDateFormat("yyyyMMddHHmmss");
        String timeStamp = timestamp.format(new Date());
        //设置浏览器响应格式
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String fileName = URLEncoder.encode("所有书籍", "UTF-8") + timeStamp;
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");

        ServletOutputStream out = response.getOutputStream();
        writer.flush(out, true);
        out.close();
        writer.close();

    }
}
