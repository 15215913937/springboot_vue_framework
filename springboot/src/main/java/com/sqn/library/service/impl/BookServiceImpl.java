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
import java.util.*;

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
    public Map<String, ArrayList<Integer>> booksPurchaseStatistics(String year, Integer id) {
        List<Book> list1 = bookMapper.getMonthlyNumberOfSpecifiedUsersByYear(year, id);
        int m1 = 0, m2 = 0, m3 = 0, m4 = 0, m5 = 0, m6 = 0, m7 = 0, m8 = 0, m9 = 0, m10 = 0, m11 = 0, m12 = 0;
        for (Book book : list1) {
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
        ArrayList<Integer> one = CollUtil.newArrayList(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12);
        List<Book> list2 = bookMapper.queryByYear(year);
        int n1 = 0, n2 = 0, n3 = 0, n4 = 0, n5 = 0, n6 = 0, n7 = 0, n8 = 0, n9 = 0, n10 = 0, n11 = 0, n12 = 0;
        for (Book book : list2) {
            Date buyDate = book.getBuyDate();
            Month month = DateTime.of(buyDate).monthEnum();
            switch (month) {
                case JANUARY:
                    n1 += 1;
                    break;
                case FEBRUARY:
                    n2 += 1;
                    break;
                case MARCH:
                    n3 += 1;
                    break;
                case APRIL:
                    n4 += 1;
                    break;
                case MAY:
                    n5 += 1;
                    break;
                case JUNE:
                    n6 += 1;
                    break;
                case JULY:
                    n7 += 1;
                    break;
                case AUGUST:
                    n8 += 1;
                    break;
                case SEPTEMBER:
                    n9 += 1;
                    break;
                case OCTOBER:
                    n10 += 1;
                    break;
                case NOVEMBER:
                    n11 += 1;
                    break;
                case DECEMBER:
                    n12 += 1;
                    break;
                default:
                    break;
            }
        }
        ArrayList<Integer> all = CollUtil.newArrayList(n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12);
        HashMap<String, ArrayList<Integer>> map = new HashMap<>();
        map.put("all", all);
        map.put("one", one);
        return map;
    }
}
