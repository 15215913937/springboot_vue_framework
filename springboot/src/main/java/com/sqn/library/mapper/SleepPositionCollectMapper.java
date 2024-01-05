package com.sqn.library.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.entity.SleepPositionCollect;
import org.apache.ibatis.annotations.Select;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author shenqn
 * @since 2023-12-30
 */
public interface SleepPositionCollectMapper extends BaseMapper<SleepPositionCollect> {

    Page<SleepPositionCollect> findPage(Page<SleepPositionCollect> page, Long userInfoId, Byte mat, Byte project, Byte actualSleepPosition, Byte isReg);

    @Select("select * from `sleep_position_collect` where flag = #{flag}")
    SleepPositionCollect findByflag(String flag);
}
