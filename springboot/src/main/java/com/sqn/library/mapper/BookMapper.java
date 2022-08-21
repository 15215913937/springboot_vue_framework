package com.sqn.library.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.entity.Book;

import javax.annotation.Resource;


public interface BookMapper extends BaseMapper<Book> {


    Page<Book> findPage(Page<Book> page, String name, String author, String category);

    Page<Book> findPageByUid(Page<Book> page, Integer uid, String name, String author, String category);

}
