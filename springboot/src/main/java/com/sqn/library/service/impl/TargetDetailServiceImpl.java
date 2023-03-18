package com.sqn.library.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.sqn.library.entity.TargetDetail;
import com.sqn.library.mapper.TargetDetailMapper;
import com.sqn.library.service.ITargetDetailService;
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
 * @since 2023-03-08
 */
@Service
public class TargetDetailServiceImpl extends ServiceImpl<TargetDetailMapper, TargetDetail> implements ITargetDetailService {
    @Resource
    TargetDetailMapper targetDetailMapper;

    @Override
    public List<TargetDetail> getTargetDetailByTId(Integer tId) {
        LambdaQueryWrapper<TargetDetail> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(TargetDetail::getTId, tId);
        return targetDetailMapper.selectList(wrapper);
    }
}
