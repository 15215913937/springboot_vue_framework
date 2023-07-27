package com.sqn.library.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sqn.library.common.Constants;
import com.sqn.library.common.enums.ResultCodeEnum;
import com.sqn.library.entity.Menu;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.MenuMapper;
import com.sqn.library.mapper.RoleMenuMapper;
import com.sqn.library.service.IMenuService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-17
 */
@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements IMenuService {
    @Resource
    RoleMenuMapper roleMenuMapper;

    @Resource
    IMenuService iMenuService;

    @Override
    public List<Menu> findAllMenus(String name) {
        LambdaQueryWrapper<Menu> wrapper = Wrappers.lambdaQuery();
        if (name == null) {
            log.error("角色为空");
            throw new CustomException(Constants.CODE_DATA_ERR, ResultCodeEnum.DATA_ERROR.getMsg());
        }
        wrapper.like(Menu::getName, name);
        // 查询所有数据
        List<Menu> list = list(wrapper);
        // 找出pid为null的一级菜单
        List<Menu> parentNodes = list.stream()
                .filter(menu -> menu.getPid() == null)
                .collect(Collectors.toList());
        // 找出一级菜单的子菜单
        for (Menu menu : parentNodes) {
            // 筛选所有数据中pid=父级id的数据就是二级菜单
            List<Menu> childNode =
                    list.stream().filter(m -> menu.getId().equals(m.getPid())).collect(Collectors.toList());
            menu.setChildren(childNode);
        }
        return parentNodes;
    }

    @Override
    public ArrayList<Menu> findRoleMenus(Long roleId) {
        // 当前角色的所有菜单id集合
        List<Long> menuIds = roleMenuMapper.selectByRoleId(roleId);
        // 查出系统所有菜单
        List<Menu> menus = iMenuService.findAllMenus("");

        ArrayList<Menu> roleMenus = new ArrayList<>();
        // 筛选当前用户角色的菜单
        for (Menu menu : menus) {
            // 获取每个父菜单的子菜单
            List<Menu> children = menu.getChildren();
            if (menuIds.contains(menu.getId()) || (!menuIds.contains(menu.getId()) && !children.isEmpty())) {
                roleMenus.add(menu);
            }
            // 移除children里面不在menuIds集中的元素
            children.removeIf(child -> !menuIds.contains(child.getId()));
        }
        return roleMenus;
    }
}
