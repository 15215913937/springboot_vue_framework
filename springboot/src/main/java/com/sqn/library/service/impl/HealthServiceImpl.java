package com.sqn.library.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.sqn.library.entity.Activity;
import com.sqn.library.entity.Health;
import com.sqn.library.mapper.ActivityMapper;
import com.sqn.library.mapper.HealthMapper;
import com.sqn.library.service.IHealthService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2023-02-23
 */
@Service
public class HealthServiceImpl extends ServiceImpl<HealthMapper, Health> implements IHealthService {
    @Resource
    HealthMapper healthMapper;
    @Resource
    ActivityMapper activityMapper;
    @Resource
    IHealthService iHealthService;

    @Override
    public List<Health> getByUid(Integer uid) {
        LambdaQueryWrapper<Health> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Health::getUid, uid).orderByDesc(Health::getCreateTime);
        List<Health> healthList = healthMapper.selectList(wrapper);
        for (Health health : healthList) {
            Health health1 = transformActivitiesToName(health);
            if (health1 == null) {
                continue;
            }
            health.setActivityMarks(health1.getActivityMarks());
        }
        return healthList;
    }

    @Override
    public boolean add(Health health) {
        if (health.getActivityMarks() == null) {
            iHealthService.save(health);
            return true;
        }
        Health health1 = transformActivitiesToId(health);
        iHealthService.save(health1);
        return true;
    }

    @Override
    public ArrayList<Health> queryHistoryActivities(Integer uid) {
        LambdaQueryWrapper<Health> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(Health::getUid, uid).isNotNull(Health::getActivities).orderByDesc(Health::getId);
        List<Health> list = iHealthService.list(wrapper);
        ArrayList<Health> days = new ArrayList<>();
        String d = "";
        for (Health health : list) {
            Date createTime = health.getCreateTime();
            String ct = createTime.toString();
            String date = ct.substring(4, 10);
            if (!d.equals(date)) {
                days.add(health);
                d = date;
            }
        }
        for (Health day : days) {
            Health health1 = transformActivitiesToName(day);
            if (health1 == null) {
                continue;
            }
            day.setActivityMarks(health1.getActivityMarks());
        }
        return days;
    }

    @Override
    public Health transformActivitiesToName(Health health) {
        if (StrUtil.isEmpty(health.getActivities())) {
            return null;
        }
        ArrayList<String> list = new ArrayList<>();
        String[] strings = health.getActivities().split(",");
        for (String string : strings) {
            int i = Integer.parseInt(string);
            Activity activity = activityMapper.selectById(i);
            list.add(activity.getName());
        }
        health.setActivityMarks(list);
        return health;
    }

    @Override
    public Health transformActivitiesToId(Health health) {
        ArrayList<Integer> list = new ArrayList<>();
        ArrayList<String> activityList = health.getActivityMarks();
        for (String s : activityList) {
            Integer activityId = activityMapper.selectByName(s);
            if (activityId == null) {
                Activity act = new Activity();
                act.setName(s);
                activityMapper.insert(act);
                activityId = activityMapper.selectByName(s);
            }
            list.add(activityId);
        }
        String s = StrUtil.toString(list);

        health.setActivities(s.substring(1, s.length() - 1).replace(" ", ""));
        return health;
    }

}
