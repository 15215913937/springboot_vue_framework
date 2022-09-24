package com.sqn.library.service;

import com.sqn.library.entity.Events;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-11
 */
public interface IEventsService extends IService<Events> {

    Integer getByAuthor(Integer id);

    Events queryById(Integer id);
}
