package com.sqn.library.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.sqn.library.entity.Book;
import org.apache.ibatis.annotations.Param;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 图书信息表 服务类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-11
 */
public interface IBookService extends IService<Book> {

    /**
     * @param tPage
     * @param name
     * @param author
     * @param category
     * @return
     * @Param 取别名，和xml文件里的参数一致
     */
    Page<Book> findPage(Page<Book> tPage, @Param("name") String name, @Param("author") String author, @Param(
            "category") String category);

    List<Book> getByUid(Long id);

    Page<Book> findPageByUid(Page<Book> objectPage, String uid, String name, String author, String category);

    Map<String, List<Integer>> booksPurchaseStatistics(String year, Long id);

    void exportBooks(HttpServletResponse response, List<Book> list) throws IOException;
}
