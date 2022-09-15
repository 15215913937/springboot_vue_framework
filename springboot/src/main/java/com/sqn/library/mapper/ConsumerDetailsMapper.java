package com.sqn.library.mapper;

import com.sqn.library.entity.ConsumerDetails;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author shenqn
 * @since 2022-08-30
 */
public interface ConsumerDetailsMapper extends BaseMapper<ConsumerDetails> {
    @Select("SELECT SUM(cost) FROM `consumer_details` where uid = #{id} and DATE_FORMAT(createtime,\"%Y %m\") = date_format(curdate(),'%Y %m') GROUP BY type")
    List<Float> getCurrentMonthExpense(Integer id);

    List<Float> getLastMonthExpense(Integer id);
}
