package com.sqn.library.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sqn.library.entity.Health;
import com.sqn.library.entity.Target;
import com.sqn.library.mapper.TargetMapper;
import com.sqn.library.service.ITargetService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2023-02-23
 */
@Service
public class TargetServiceImpl extends ServiceImpl<TargetMapper, Target>implements ITargetService {
    @Resource
    TargetMapper targetMapper;

    @Override
    public List<Target> getByUid(Integer uid) {
        LambdaQueryWrapper<Target> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Target::getUid, uid).orderByDesc(Target::getStartTime);
        return targetMapper.selectList(wrapper);
    }
}
