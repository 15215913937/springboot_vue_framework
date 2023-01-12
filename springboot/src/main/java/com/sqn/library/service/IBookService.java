package com.sqn.library.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.entity.Book;
import com.baomidou.mybatisplus.extension.service.IService;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
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

    ArrayList<Integer> OneList(String year,Integer id);

    /**@Param  取别名，和xml文件里的参数一致
     *
     * @param tPage
     * @param name
     * @param author
     * @param category
     * @return
     */
    Page<Book> findPage(Page<Book> tPage, @Param("name") String name, @Param("author") String author, @Param(
            "category") String category);

    List<Book> getByUid(Integer id);

    Page<Book> findPageByUid(Page<Book> objectPage, String uid, String name, String author, String category);

    ArrayList<Integer> getNumberOfBooksPurchasedeEachMonthByYear(String year);
}
