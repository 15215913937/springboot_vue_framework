package com.sqn.library.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.entity.Book;
import org.apache.ibatis.annotations.Mapper;

import javax.annotation.Resource;

@Mapper
public interface BookMapper extends BaseMapper<Book> {


    Page<Book> findPage(Page<Book> page, String name, String author, String category);

    Page<Book> findPageByUid(Page<Book> objectPage, String uid, String name, String author, String category);
}
