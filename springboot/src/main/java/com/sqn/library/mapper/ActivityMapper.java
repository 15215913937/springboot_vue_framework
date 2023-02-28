package com.sqn.library.mapper;

import com.sqn.library.entity.Activity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author shenqn
 * @since 2023-02-23
 */
public interface ActivityMapper extends BaseMapper<Activity> {
    @Select("select id from activity where name = #{s}")
    Integer selectByName(String s);
}
