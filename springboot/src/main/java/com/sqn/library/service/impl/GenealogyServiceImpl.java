package com.sqn.library.service.impl;

import com.sqn.library.entity.Genealogy;
import com.sqn.library.mapper.GenealogyMapper;
import com.sqn.library.service.IGenealogyService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 家谱 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2023-07-19
 */
@Service
public class GenealogyServiceImpl extends ServiceImpl<GenealogyMapper, Genealogy>implements IGenealogyService {

}
