package com.sqn.library.service;

import com.sqn.library.entity.Target;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author shenqn
 * @since 2023-02-23
 */
public interface ITargetService extends IService<Target> {

    boolean refreshStatus(Integer uid);
}
