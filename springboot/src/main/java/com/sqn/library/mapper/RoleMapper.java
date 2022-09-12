package com.sqn.library.mapper;

import com.sqn.library.entity.Role;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author shenqn
 * @since 2022-07-17
 */
public interface RoleMapper extends BaseMapper<Role> {
    @Select("select id from role where flag = #{flag}")
    Integer selectByFlag(@Param("flag") String flag);
}
