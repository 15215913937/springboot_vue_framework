package com.sqn.library.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.sqn.library.entity.Health;
import com.sqn.library.entity.Target;
import com.sqn.library.mapper.TargetMapper;
import com.sqn.library.service.ITargetService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
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
public class TargetServiceImpl extends ServiceImpl<TargetMapper, Target> implements ITargetService {
    @Resource
    TargetMapper targetMapper;

    @Override
    public boolean refreshStatus(Integer uid) {
        Date date = new Date();
        Date nextDate = new Date(date.getTime() + 24 * 60 * 60 * 1000);
        Date preDate = new Date(date.getTime() - 24 * 60 * 60 * 1000);
        LambdaQueryWrapper<Target> wrapper = Wrappers.lambdaQuery();
        List<Target> list = targetMapper.selectList(wrapper.eq(Target::getUid, uid));
        for (Target target : list) {
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
}
