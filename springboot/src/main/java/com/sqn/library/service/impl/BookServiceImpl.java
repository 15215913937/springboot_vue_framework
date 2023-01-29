package com.sqn.library.service.impl;

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
import java.util.stream.Collectors;

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
    public Map<String, List<Integer>> booksPurchaseStatistics(String year, Integer id) {
        List<Book> list1 = bookMapper.getMonthlyNumberOfSpecifiedUsersByYear(year, id);
        int[] m = new int[12];
        for (Book book : list1) {
            Date buyDate = book.getBuyDate();
            Month month = DateTime.of(buyDate).monthEnum();
            switch (month) {
                case JANUARY:
                    m[0] += 1;
                    break;
                case FEBRUARY:
                    m[1] += 1;
                    break;
                case MARCH:
                    m[2] += 1;
                    break;
                case APRIL:
                    m[3] += 1;
                    break;
                case MAY:
                    m[4] += 1;
                    break;
                case JUNE:
                    m[5] += 1;
                    break;
                case JULY:
                    m[6] += 1;
                    break;
                case AUGUST:
                    m[7] += 1;
                    break;
                case SEPTEMBER:
                    m[8] += 1;
                    break;
                case OCTOBER:
                    m[9] += 1;
                    break;
                case NOVEMBER:
                    m[10] += 1;
                    break;
                case DECEMBER:
                    m[11] += 1;
                    break;
                default:
                    break;
            }
        }
        List<Integer> one = Arrays.stream(m).boxed().collect(Collectors.toList());
        List<Book> list2 = bookMapper.queryByYear(year);
        int[] n = new int[12];
        for (Book book : list2) {
            Date buyDate = book.getBuyDate();
            Month month = DateTime.of(buyDate).monthEnum();
            switch (month) {
                case JANUARY:
                    n[0] += 1;
                    break;
                case FEBRUARY:
                    n[1] += 1;
                    break;
                case MARCH:
                    n[2] += 1;
                    break;
                case APRIL:
                    n[3] += 1;
                    break;
                case MAY:
                    n[4] += 1;
                    break;
                case JUNE:
                    n[5] += 1;
                    break;
                case JULY:
                    n[6] += 1;
                    break;
                case AUGUST:
                    n[7] += 1;
                    break;
                case SEPTEMBER:
                    n[8] += 1;
                    break;
                case OCTOBER:
                    n[9] += 1;
                    break;
                case NOVEMBER:
                    n[10] += 1;
                    break;
                case DECEMBER:
                    n[11] += 1;
                    break;
                default:
                    break;
            }
        }
        List<Integer> all = Arrays.stream(n).boxed().collect(Collectors.toList());
        HashMap<String, List<Integer>> map = new HashMap<>();
        map.put("all", all);
        map.put("one", one);
        return map;
    }
}
