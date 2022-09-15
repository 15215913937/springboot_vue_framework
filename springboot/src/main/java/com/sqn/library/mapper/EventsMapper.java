package com.sqn.library.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sqn.library.entity.Events;
import io.swagger.models.auth.In;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface EventsMapper extends BaseMapper<Events> {
    @Select("update events set `view_count` = `view_count`+1 where `id` = ${id}")
    void updateViewCount(Integer id);
}
