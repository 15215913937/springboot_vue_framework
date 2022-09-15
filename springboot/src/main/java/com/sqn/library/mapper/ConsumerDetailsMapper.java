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
    //    本月消费
    @Select("SELECT SUM(cost) FROM `consumer_details` where uid = #{id} and DATE_FORMAT(createtime,\"%Y %m\") = " +
            "date_format(curdate(),'%Y %m') GROUP BY type ORDER BY type")
    List<Float> getCurrentMonthExpense(Integer id);

    //上月消费
    @Select("SELECT SUM( cost ) FROM `consumer_details` WHERE uid = #{id} AND DATE_FORMAT( createtime, \"%Y %m\" ) = " +
            "date_format( date_sub(curdate(), interval 1 MONTH), '%Y %m' ) GROUP BY type ORDER BY type")
    List<Float> getLastMonthExpense(Integer id);
}
