package com.sqn.library.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.entity.Book;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Mapper
public interface BookMapper extends BaseMapper<Book> {


    Page<Book> findPage(Page<Book> page, String name, String author, String category);

    Page<Book> findPageByUid(Page<Book> objectPage, String uid, String name, String author, String category);

    @Select("SELECT * FROM book WHERE YEAR(buy_date) = #{year}")
    List<Book> queryByYear(String year);

    @Select("SELECT * FROM book WHERE YEAR(buy_date) = #{year} and uid = #{id}")
    List<Book> getMonthlyNumberOfSpecifiedUsersByYear(String year, Integer id);
}
