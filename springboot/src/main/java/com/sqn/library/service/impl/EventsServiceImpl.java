package com.sqn.library.service.impl;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Events;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.EventsMapper;
import com.sqn.library.service.IEventsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sqn.library.utils.RedisUtils;
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

    @Resource
    RedisUtils redisUtils;

    @Override
    public Integer getByAuthor(Integer id) {
        final LambdaQueryWrapper<Events> wrapper = Wrappers.<Events>lambdaQuery();
        wrapper.eq(Events::getAuthor, id);
        final List<Events> myEventsList = eventsMapper.selectList(wrapper);
        return myEventsList.size();
    }

    @Override
    public Events queryById(Integer id) {
        String key = Constants.EVENT_KEY + id;
//        redis查询
        String eventJson = redisUtils.getRedis(key);
//        不判断是否存在
        if (StrUtil.isNotBlank(eventJson)) {
//            存在，直接返回
            return JSONUtil.toBean(eventJson, Events.class);
        }
//        不存在，根据id查询数据库
        Events event = eventsMapper.getById(id);
//        数据库也不存在，返回错误
        if (event == null) {
            throw new CustomException(Constants.CODE_DATA_ERR, "数据不存在");
        }
        redisUtils.setObjectToRedis(key, event, Constants.LOGIN_INFO_TTL);
        return event;
    }
}
