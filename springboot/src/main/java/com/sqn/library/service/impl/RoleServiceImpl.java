package com.sqn.library.service.impl;

import com.sqn.library.entity.Role;
import com.sqn.library.entity.RoleMenu;
import com.sqn.library.mapper.RoleMapper;
import com.sqn.library.mapper.RoleMenuMapper;
import com.sqn.library.service.IRoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-17
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

    @Resource
    RoleMenuMapper roleMenuMapper;

    @Transactional //代码执行出错的时候能够进行事务的回滚
    @Override
    public void setRoleMenu(Long roleId, List<Long> menuIds) {
        //第一种方法
//        QueryWrapper<RoleMenu> queryWrapper = new QueryWrapper<>();
//        queryWrapper.eq("role_id",roleId);
//        roleMenuMapper.delete(queryWrapper);
        //第二种方法，自己写sql语句

        roleMenuMapper.deleteByRoleId(roleId); //先删除当前角色id所有的绑定关系

        //再把前端传过来的菜单id数组绑定到当前这个角色id上去
        for (Long menuId : menuIds) {
            RoleMenu roleMenu = new RoleMenu();
            roleMenu.setRoleId(roleId);
            roleMenu.setMenuId(menuId);
            roleMenuMapper.insert(roleMenu);
        }
    }

    @Override
    public List<Long> getRoleMenu(Long roleId) {
        return roleMenuMapper.selectByRoleId(roleId);
    }
}
