package com.sqn.library.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.entity.Genealogy;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 家谱 Mapper 接口
 * </p>
 *
 * @author shenqn
 * @since 2023-07-19
 */
@Mapper
public interface GenealogyMapper extends BaseMapper<Genealogy> {

    Page<Genealogy> findPage(Page<Genealogy> genealogyPage, String name, Integer status);
}
