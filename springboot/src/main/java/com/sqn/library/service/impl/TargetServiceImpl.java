package com.sqn.library.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sqn.library.entity.Health;
import com.sqn.library.entity.Target;
import com.sqn.library.entity.TargetDetail;
import com.sqn.library.mapper.HealthMapper;
import com.sqn.library.mapper.TargetDetailMapper;
import com.sqn.library.mapper.TargetMapper;
import com.sqn.library.service.ITargetService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2023-02-23
 */
@Service
public class TargetServiceImpl extends ServiceImpl<TargetMapper, Target> implements ITargetService {
    @Resource
    TargetMapper targetMapper;

    @Resource
    TargetDetailMapper targetDetailMapper;

    @Resource
    HealthMapper healthMapper;

    @Override
    public boolean refreshStatus(Long uid) {
        Date date = new Date();
        Date nextDate = new Date(date.getTime() + 24 * 60 * 60 * 1000);
        Date preDate = new Date(date.getTime() - 24 * 60 * 60 * 1000);
        LambdaQueryWrapper<Target> wrapper = Wrappers.lambdaQuery();
        List<Target> list = targetMapper.selectList(wrapper.eq(Target::getUid, uid));
        for (Target target : list) {
            if (target.getStatus() == 4) {
                continue;
            }
            if (date.before(target.getStartTime())) {
                target.setStatus(0);
                targetMapper.updateById(target);
                continue;
            }
            if (target.getSchedule() < 100) {
                if (target.getEndTime().after(preDate)) {
                    target.setStatus(1);
                } else {
                    target.setStatus(3);
                }
            } else if (target.getSchedule() == 100) {
                target.setStatus(2);
            }
            targetMapper.updateById(target);
        }
        return true;
    }

    @Override
    public boolean terminateTarget(Long id) {
        Target target = targetMapper.selectById(id);
        if (target == null) {
            return false;
        }
        target.setStatus(4);
        targetMapper.updateById(target);
        return true;
    }

    @Override
    public Integer add(Target target) {
        final Target one = targetMapper.selectOne(Wrappers.<Target>lambdaQuery().eq(Target::getCode, target.getCode()));
        if (one != null) {
            return 0;
        }
        ArrayList<HashMap<String, String>> details = target.getTargetDetails();
        if (details.isEmpty()) {
            return 1;
        }
        targetMapper.insert(target);
        Target target1 = targetMapper.selectOne(Wrappers.<Target>lambdaQuery().eq(Target::getCode, target.getCode()));
        for (HashMap<String, String> detail : details) {
            TargetDetail targetDetail = new TargetDetail();
            targetDetail.setTId(target1.getId());
            targetDetail.setAId(Long.valueOf(detail.get("activityId")));
            targetDetail.setDuration(Integer.parseInt(detail.get("duration")));
            targetDetailMapper.insert(targetDetail);
        }
        return 2;
    }

    @Override
    public Target queryById(Long id) {
        Target target = targetMapper.selectOne(Wrappers.<Target>lambdaQuery().eq(Target::getId, id));
        List<TargetDetail> detailList = targetDetailMapper.selectList(Wrappers.<TargetDetail>lambdaQuery().eq(TargetDetail::getTId, id));
        ArrayList<HashMap<String, String>> list = new ArrayList<>();
        for (TargetDetail detail : detailList) {
            HashMap<String, String> map = new HashMap<>();
            map.put("activityId", detail.getAId().toString());
            map.put("duration", detail.getDuration().toString());
            list.add(map);
        }
        target.setTargetDetails(list);
        return target;
    }

    @Override
    public boolean refreshAllTargetSchedule(Long uid) {
        final List<Target> targets = targetMapper.queryList(uid);
        for (Target t : targets) {
            Date startTime = t.getStartTime();
            Date endTime = t.getEndTime();

            List<Health> healthList = healthMapper.selectList(Wrappers.<Health>lambdaQuery().between(Health::getCreateTime, startTime, endTime));
            ArrayList<String> list = new ArrayList<>();
            for (Health health : healthList) {
                list.add(health.getActivities());
            }
            final String s = list.toString();
            final String s1 = s.substring(1, s.length() - 1).replace(" ", "");
            List<String> list1 = Arrays.asList(s1.split(","));

            List<TargetDetail> targetDetails = targetDetailMapper.queryList(t.getId());
            for (TargetDetail td : targetDetails) {
                int count = 0;
                for (String l : list1) {
                    count = Collections.frequency(list1, td.getAId().toString());
                }
                if (count >= td.getDuration()) {
                    td.setBePrepared(td.getDuration());
                    td.setStatus(1);
                } else {
                    td.setBePrepared(count);
                }
                targetDetailMapper.updateById(td);
            }
            final List<TargetDetail> targetDetails1 = targetDetailMapper.selectList(Wrappers.<TargetDetail>lambdaQuery().eq(TargetDetail::getTId, t.getId()));
            int count1 = 0;
            int count2 = 0;
            int quotient = 0;
            for (TargetDetail targetDetail : targetDetails1) {
                count1 += targetDetail.getDuration();
                count2 += targetDetail.getBePrepared();
            }
            if (count1 != 0) {
                quotient = count2 * 100 / count1;
            }
            t.setSchedule(quotient);
            targetMapper.updateById(t);
        }
        return true;
    }
}
