package com.sqn.library.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.entity.UserInfo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author shenqn
 * @since 2023-12-30
 */
public interface UserInfoMapper extends BaseMapper<UserInfo> {

    Page<UserInfo> findPage(Page<UserInfo> page, @Param("name") String name);
}
