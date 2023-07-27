package com.sqn.library.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.sqn.library.entity.Genealogy;

import java.util.List;

/**
 * <p>
 * 家谱 服务类
 * </p>
 *
 * @author shenqn
 * @since 2023-07-19
 */
public interface IGenealogyService extends IService<Genealogy> {

    List<Genealogy> tree();
}
