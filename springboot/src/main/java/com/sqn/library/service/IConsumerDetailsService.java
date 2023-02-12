package com.sqn.library.service;

import com.sqn.library.entity.ConsumerDetails;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.HashMap;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author shenqn
 * @since 2022-08-30
 */
public interface IConsumerDetailsService extends IService<ConsumerDetails> {
    HashMap<Object, Object> statisticsByIdAndYear(Integer id, String year);
}
