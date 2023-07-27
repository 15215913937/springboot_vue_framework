package com.sqn.library.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sqn.library.entity.Genealogy;
import com.sqn.library.mapper.GenealogyMapper;
import com.sqn.library.service.IGenealogyService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 家谱 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2023-07-19
 */
@Service
public class GenealogyServiceImpl extends ServiceImpl<GenealogyMapper, Genealogy> implements IGenealogyService {
    @Override
    public List<Genealogy> tree() {
        LambdaQueryWrapper<Genealogy> queryWrapper = Wrappers.lambdaQuery();
        List<Genealogy> list = this.list(queryWrapper);
        return list.stream()
                .filter(f -> f.getFatherId() == null)
                .filter(f -> f.getMotherId() == null)
//                .map(g -> covert(g, list))
                .collect(Collectors.toList());
    }

    /**
     * 将权限转换为带有子级的权限对象
     * 当找不到子级权限的时候map操作不会再递归调用covert
     */
//    public Genealogy covert(Genealogy permission, List<Genealogy> permissionList) {
//        List<Genealogy> children = permissionList.stream()
//                .filter(subPermission -> subPermission.getPId().equals(permission.getId()))
//                .map(subPermission -> covert(subPermission, permissionList))
//                .collect(Collectors.toList());
//        permission.setChildren(children);
//        return permission;
//    }
}
