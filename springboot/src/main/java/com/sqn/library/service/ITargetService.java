package com.sqn.library.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.sqn.library.entity.Target;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author shenqn
 * @since 2023-02-23
 */
public interface ITargetService extends IService<Target> {

    boolean refreshStatus(Long uid);

    boolean terminateTarget(Long id);

    Integer add(Target target);

    Target queryById(Long id);

    boolean refreshAllTargetSchedule(Long uid);
}
