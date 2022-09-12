package com.sqn.library.mapper;

import com.sqn.library.entity.CategoryList;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author shenqn
 * @since 2022-08-23
 */
public interface CategoryListMapper extends BaseMapper<CategoryList> {

    List<CategoryList> findBooks(@Param("name") String name, @Param("flag") String flag);
}
