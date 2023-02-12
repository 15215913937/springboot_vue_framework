package com.sqn.library.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.Month;
import com.sqn.library.entity.ConsumerDetails;
import com.sqn.library.mapper.ConsumerDetailsMapper;
import com.sqn.library.service.IConsumerDetailsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2022-08-30
 */
@Service
public class ConsumerDetailsServiceImpl extends ServiceImpl<ConsumerDetailsMapper, ConsumerDetails> implements IConsumerDetailsService {
    @Resource
    ConsumerDetailsMapper consumerDetailsMapper;

    @Override
    public HashMap<Object, Object> statisticsByIdAndYear(Integer id, String year) {
        List<ConsumerDetails> list1 = consumerDetailsMapper.monthlyExpenditureStatistics(id, year);
        List<ConsumerDetails> list2 = consumerDetailsMapper.monthlyIncomeStatistics(id, year);
        float m1 = 0, m2 = 0, m3 = 0, m4 = 0, m5 = 0, m6 = 0, m7 = 0, m8 = 0, m9 = 0, m10 = 0, m11 = 0, m12 = 0;
        float n1 = 0, n2 = 0, n3 = 0, n4 = 0, n5 = 0, n6 = 0, n7 = 0, n8 = 0, n9 = 0, n10 = 0, n11 = 0, n12 = 0;
        for (ConsumerDetails consumerDetails : list1) {
            Date createTime = consumerDetails.getCreatetime();
            Month month = DateTime.of(createTime).monthEnum();
            switch (month) {
                case JANUARY:
                    m1 += consumerDetails.getCost();
                    break;
                case FEBRUARY:
                    m2 += consumerDetails.getCost();
                    break;
                case MARCH:
                    m3 += consumerDetails.getCost();
                    break;
                case APRIL:
                    m4 += consumerDetails.getCost();
                    break;
                case MAY:
                    m5 += consumerDetails.getCost();
                    break;
                case JUNE:
                    m6 += consumerDetails.getCost();
                    break;
                case JULY:
                    m7 += consumerDetails.getCost();
                    break;
                case AUGUST:
                    m8 += consumerDetails.getCost();
                    break;
                case SEPTEMBER:
                    m9 += consumerDetails.getCost();
                    break;
                case OCTOBER:
                    m10 += consumerDetails.getCost();
                    break;
                case NOVEMBER:
                    m11 += consumerDetails.getCost();
                    break;
                case DECEMBER:
                    m12 += consumerDetails.getCost();
                    break;
                default:
                    break;
            }
        }
        for (ConsumerDetails consumerDetails : list2) {
            Date createTime = consumerDetails.getCreatetime();
            Month month = DateTime.of(createTime).monthEnum();
            switch (month) {
                case JANUARY:
                    n1 += consumerDetails.getCost();
                    break;
                case FEBRUARY:
                    n2 += consumerDetails.getCost();
                    break;
                case MARCH:
                    n3 += consumerDetails.getCost();
                    break;
                case APRIL:
                    n4 += consumerDetails.getCost();
                    break;
                case MAY:
                    n5 += consumerDetails.getCost();
                    break;
                case JUNE:
                    n6 += consumerDetails.getCost();
                    break;
                case JULY:
                    n7 += consumerDetails.getCost();
                    break;
                case AUGUST:
                    n8 += consumerDetails.getCost();
                    break;
                case SEPTEMBER:
                    n9 += consumerDetails.getCost();
                    break;
                case OCTOBER:
                    n10 += consumerDetails.getCost();
                    break;
                case NOVEMBER:
                    n11 += consumerDetails.getCost();
                    break;
                case DECEMBER:
                    n12 += consumerDetails.getCost();
                    break;
                default:
                    break;
            }
        }
        ArrayList<Float> outcome = CollUtil.newArrayList(Math.round(m1 * 100) / 100f,
                Math.round(m2 * 100) / 100f,
                Math.round(m3 * 100) / 100f,
                Math.round(m4 * 100) / 100f,
                Math.round(m5 * 100) / 100f,
                Math.round(m6 * 100) / 100f,
                Math.round(m7 * 100) / 100f,
                Math.round(m8 * 100) / 100f,
                Math.round(m9 * 100) / 100f,
                Math.round(m10 * 100) / 100f,
                Math.round(m11 * 100) / 100f,
                Math.round(m12 * 100) / 100f);
        ArrayList<Float> income = CollUtil.newArrayList(Math.round(n1 * 100) / 100f,
                Math.round(n2 * 100) / 100f,
                Math.round(n3 * 100) / 100f,
                Math.round(n4 * 100) / 100f,
                Math.round(n5 * 100) / 100f,
                Math.round(n6 * 100) / 100f,
                Math.round(n7 * 100) / 100f,
                Math.round(n8 * 100) / 100f,
                Math.round(n9 * 100) / 100f,
                Math.round(n10 * 100) / 100f,
                Math.round(n11 * 100) / 100f,
                Math.round(n12 * 100) / 100f);
        final HashMap<Object, Object> map = new HashMap<>();
        map.put("income",income);
        map.put("outcome",outcome);
        return map;
    }
}
