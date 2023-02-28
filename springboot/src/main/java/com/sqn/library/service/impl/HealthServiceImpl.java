package com.sqn.library.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sqn.library.entity.Activity;
import com.sqn.library.entity.Health;
import com.sqn.library.mapper.ActivityMapper;
import com.sqn.library.mapper.HealthMapper;
import com.sqn.library.service.IHealthService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
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
            if (StrUtil.isEmpty(health.getActivities())) {
                continue;
            }
            ArrayList<String> list = new ArrayList<>();
            String[] strings = health.getActivities().split(",");
            for (String string : strings) {
                int i = Integer.parseInt(string);
                Activity activity = activityMapper.selectById(i);
                list.add(activity.getName());
            }
            health.setActivityMarks(list);
        }
        return healthList;
    }

    @Override
    public boolean add(Health health) {
        ArrayList<Integer> list = new ArrayList<>();
        if (health.getActivityMarks().isEmpty()) {
            iHealthService.save(health);
            return true;
        }
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
        iHealthService.save(health);
        return true;
    }

}
