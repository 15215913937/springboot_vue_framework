package com.sqn.library.service;

import com.sqn.library.entity.TargetDetail;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author shenqn
 * @since 2023-03-08
 */
public interface ITargetDetailService extends IService<TargetDetail> {

    List<TargetDetail> getTargetDetailByTId(Integer tId);
}
