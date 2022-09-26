package com.sqn.library.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.entity.Book;
import com.baomidou.mybatisplus.extension.service.IService;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 图书信息表 服务类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-11
 */
public interface IBookService extends IService<Book> {

    List<Book> OneList(Integer UId);

    //@Param  取别名，和xml文件里的参数一致
    Page<Book> findPage(Page<Book> tPage, @Param("name") String name, @Param("author") String author, @Param(
            "category") String category);

    List<Book> getByUid(Integer id);

    Page<Book> findPageByUid(Page<Book> objectPage, String uid, String name, String author, String category);

}
