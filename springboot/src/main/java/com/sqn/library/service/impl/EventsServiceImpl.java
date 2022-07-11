package com.sqn.library.service.impl;

import com.sqn.library.entity.Events;
import com.sqn.library.mapper.EventsMapper;
import com.sqn.library.service.IEventsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-11
 */
@Service
public class EventsServiceImpl extends ServiceImpl<EventsMapper, Events> implements IEventsService {

}
