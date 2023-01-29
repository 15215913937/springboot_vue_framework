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
    public ArrayList<Float> statisticsByIdAndYear(Integer id, String year) {
        List<ConsumerDetails> list = consumerDetailsMapper.statisticsByIdAndYear(id, year);
        float m1 = 0, m2 = 0, m3 = 0, m4 = 0, m5 = 0, m6 = 0, m7 = 0, m8 = 0, m9 = 0, m10 = 0, m11 = 0, m12 = 0;
        for (ConsumerDetails consumerDetails : list) {
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
        return CollUtil.newArrayList(Math.round(m1 * 100) / 100f,
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
    }
}
