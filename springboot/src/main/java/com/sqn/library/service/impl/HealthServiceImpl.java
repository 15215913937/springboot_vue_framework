package com.sqn.library.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sqn.library.entity.Health;
import com.sqn.library.mapper.HealthMapper;
import com.sqn.library.service.IHealthService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
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

    @Override
    public List<Health> getByUid(Integer uid) {
        LambdaQueryWrapper<Health> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Health::getUid, uid).orderByDesc(Health::getCreateTime);
        return healthMapper.selectList(wrapper);
    }
}
