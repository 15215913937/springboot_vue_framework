package com.sqn.library.service.impl;

import com.sqn.library.entity.Activity;
import com.sqn.library.mapper.ActivityMapper;
import com.sqn.library.service.IActivityService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2023-02-23
 */
@Service
public class ActivityServiceImpl extends ServiceImpl<ActivityMapper, Activity>implements IActivityService {

}
