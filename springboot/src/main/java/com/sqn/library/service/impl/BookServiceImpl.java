package com.sqn.library.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.Month;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.entity.Book;
import com.sqn.library.mapper.BookMapper;
import com.sqn.library.service.IBookService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

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
    @Resource
    BookMapper bookMapper;

    @Override
    public ArrayList<Integer> OneList(String year, Integer id) {
        List<Book> list = bookMapper.getMonthlyNumberOfSpecifiedUsersByYear(year, id);
        int m1 = 0;
        int m2 = 0;
        int m3 = 0;
        int m4 = 0;
        int m5 = 0;
        int m6 = 0;
        int m7 = 0;
        int m8 = 0;
        int m9 = 0;
        int m10 = 0;
        int m11 = 0;
        int m12 = 0;
        for (Book book : list) {
            Date buyDate = book.getBuyDate();
            Month month = DateTime.of(buyDate).monthEnum();
            switch (month) {
                case JANUARY:
                    m1 += 1;
                    break;
                case FEBRUARY:
                    m2 += 1;
                    break;
                case MARCH:
                    m3 += 1;
                    break;
                case APRIL:
                    m4 += 1;
                    break;
                case MAY:
                    m5 += 1;
                    break;
                case JUNE:
                    m6 += 1;
                    break;
                case JULY:
                    m7 += 1;
                    break;
                case AUGUST:
                    m8 += 1;
                    break;
                case SEPTEMBER:
                    m9 += 1;
                    break;
                case OCTOBER:
                    m10 += 1;
                    break;
                case NOVEMBER:
                    m11 += 1;
                    break;
                case DECEMBER:
                    m12 += 1;
                    break;
                default:
                    break;
            }
        }
        return CollUtil.newArrayList(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12);
    }

    @Override
    public Page<Book> findPage(Page<Book> page, String name, String author, String category) {
        return bookMapper.findPage(page, name, author, category);
    }

    @Override
    public List<Book> getByUid(Integer id) {
        final LambdaQueryWrapper<Book> wrapper = Wrappers.<Book>lambdaQuery();
        wrapper.eq(Book::getUid, id);
        return bookMapper.selectList(wrapper);
    }

    @Override
    public Page<Book> findPageByUid(Page<Book> objectPage, String uid, String name, String author, String category) {
        return bookMapper.findPageByUid(objectPage, uid, name, author, category);
    }

    @Override
    public ArrayList<Integer> getNumberOfBooksPurchasedeEachMonthByYear(String year) {
        final List<Book> list = bookMapper.queryByYear(year);
        int m1 = 0;
        int m2 = 0;
        int m3 = 0;
        int m4 = 0;
        int m5 = 0;
        int m6 = 0;
        int m7 = 0;
        int m8 = 0;
        int m9 = 0;
        int m10 = 0;
        int m11 = 0;
        int m12 = 0;
        for (Book book : list) {
            Date buyDate = book.getBuyDate();
            Month month = DateTime.of(buyDate).monthEnum();
            switch (month) {
                case JANUARY:
                    m1 += 1;
                    break;
                case FEBRUARY:
                    m2 += 1;
                    break;
                case MARCH:
                    m3 += 1;
                    break;
                case APRIL:
                    m4 += 1;
                    break;
                case MAY:
                    m5 += 1;
                    break;
                case JUNE:
                    m6 += 1;
                    break;
                case JULY:
                    m7 += 1;
                    break;
                case AUGUST:
                    m8 += 1;
                    break;
                case SEPTEMBER:
                    m9 += 1;
                    break;
                case OCTOBER:
                    m10 += 1;
                    break;
                case NOVEMBER:
                    m11 += 1;
                    break;
                case DECEMBER:
                    m12 += 1;
                    break;
                default:
                    break;
            }
        }
        return CollUtil.newArrayList(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12);
    }
}
