package com.sqn.library.mapper;

import com.sqn.library.entity.Target;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author shenqn
 * @since 2023-02-23
 */
public interface TargetMapper extends BaseMapper<Target> {
    @Select("select * from target where uid = #{uid} and status = 1")
    List<Target> queryList(Long uid);
}
