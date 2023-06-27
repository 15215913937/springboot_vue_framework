package com.sqn.library.controller;

import cn.hutool.core.util.StrUtil;
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
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;


/**
 * @author sqn
 */
@Slf4j
@Api(tags = "书籍管理")
@RestController
@RequestMapping("/book")// 统一接口加前缀
public class BookController {
    @Resource
    BookMapper bookMapper;
    @Resource
    IBookService iBookService;
    @Resource
    UserMapper userMapper;


    /**
     * 图书编辑
     *
     * @param book 传入对象实体
     * @return
     */
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

    /**
     * 删除
     *
     * @param id
     * @return
     */
    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        bookMapper.deleteById(id);
        return Result.success();
    }

    /**
     * 查询
     *
     * @param pageNum
     * @param pageSize
     * @param name
     * @param author
     * @param category
     * @return
     */
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String name,
                              @RequestParam(defaultValue = "") String author,
                              @RequestParam(defaultValue = "") String category) {

        Page<Book> bookPage = iBookService.findPage(new Page<>(pageNum, pageSize), name, author, category);
        return Result.success(bookPage);
    }

    @GetMapping("/getOneBooks")
    public Result<?> findPageByUid(
            @RequestParam(defaultValue = "") String uid,
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(defaultValue = "") String name,
            @RequestParam(defaultValue = "") String author,
            @RequestParam(defaultValue = "") String category) {
        Page<Book> bookPage = iBookService.findPageByUid(new Page<>(pageNum, pageSize), uid, name, author, category);
        return Result.success(bookPage);
    }

    /**
     * 批量删除
     *
     * @return
     */
    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        bookMapper.deleteBatchIds(ids);
        return Result.success();
    }

    /**
     * 导出接口
     */
    @GetMapping("/export")
    public void export(HttpServletResponse response) throws Exception {
        // 从数据库获取全部数据
        List<Book> list = iBookService.list();
        for (Book book : list) {
            User user = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getId, book.getUid()));
            book.setUsername(user.getName());
        }
        iBookService.exportBooks(response, list);
        log.info("export success!");
    }
}
