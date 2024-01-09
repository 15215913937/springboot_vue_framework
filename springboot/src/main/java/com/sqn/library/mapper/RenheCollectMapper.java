package com.sqn.library.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.entity.RenheCollect;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author shenqn
 * @since 2023-12-16
 */
public interface RenheCollectMapper extends BaseMapper<RenheCollect> {

    Page<RenheCollect> findPage(Page<RenheCollect> page, @Param("code") String code, @Param("bedId") String bedId, @Param("mat") String mat, @Param("batch") Long batch, @Param("coefficient") Float coefficient,@Param("status") String status,@Param("position") String position);
}
