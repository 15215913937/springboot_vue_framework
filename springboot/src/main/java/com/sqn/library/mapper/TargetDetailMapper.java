package com.sqn.library.mapper;

import com.sqn.library.entity.TargetDetail;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author shenqn
 * @since 2023-03-08
 */
public interface TargetDetailMapper extends BaseMapper<TargetDetail> {
    @Select("select * from target_detail where t_id=#{id} and status=0")
    List<TargetDetail> queryList(Long id);
}
