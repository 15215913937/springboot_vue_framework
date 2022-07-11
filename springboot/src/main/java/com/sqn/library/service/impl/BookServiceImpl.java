package com.sqn.library.service.impl;

import com.sqn.library.entity.Book;
import com.sqn.library.mapper.BookMapper;
import com.sqn.library.service.IBookService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 图书信息表 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-11
 */
@Service
public class BookServiceImpl extends ServiceImpl<BookMapper, Book> implements IBookService {

}
