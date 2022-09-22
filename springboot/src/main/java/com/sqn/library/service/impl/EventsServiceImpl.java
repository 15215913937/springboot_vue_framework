package com.sqn.library.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.sqn.library.entity.Events;
import com.sqn.library.mapper.EventsMapper;
import com.sqn.library.service.IEventsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-11
 */
@Service
public class EventsServiceImpl extends ServiceImpl<EventsMapper, Events> implements IEventsService {
    @Resource
    EventsMapper eventsMapper;

    @Override
    public Integer getByAuthor(Integer id) {
        final LambdaQueryWrapper<Events> wrapper = Wrappers.<Events>lambdaQuery();
        wrapper.eq(Events::getAuthor, id);
        final List<Events> myEventsList = eventsMapper.selectList(wrapper);
        return myEventsList.size();
    }
}
