package com.sqn.library.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.entity.Events;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.HashMap;
import java.util.List;

/**
 * @author sqn
 */
@Mapper
public interface EventsMapper extends BaseMapper<Events> {
    /** 查看数量点击一次加1
     *
     * @param id
     */
    @Select("update events set `view_count` = `view_count`+1 where `id` = ${id}")
    void updateViewCount(Long id);

    /** 获取作者列表
     *
     * @return
     */
    @Select("SELECT DISTINCT `events`.author id, `user`.name FROM `events` LEFT JOIN `user` ON`events`.author = `user`.id")
    List<HashMap<Long,String>> getAuthor();



    Page<Events> findPage(Page<Events> tPage, String title, Long author, String startTime, String endTime);

    @Select("SELECT * FROM ( SELECT `events`.*, `user`.NAME username FROM `events` LEFT JOIN `user` ON `events`.author = `user`.id ) a WHERE a.id = #{id}")
    Events getById(Long id);
}
