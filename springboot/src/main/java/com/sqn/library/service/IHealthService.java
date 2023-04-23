package com.sqn.library.service;

import com.sqn.library.entity.Health;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author shenqn
 * @since 2023-02-23
 */
public interface IHealthService extends IService<Health> {

    List<Health> getByUid(Long uid);

    boolean add(Health health);

    ArrayList<Health> queryHistoryActivities(Long uid);

    Health transformActivitiesToName(Health health);

    Health transformActivitiesToId(Health health);
}
