package com.sqn.library.service;

import com.sqn.library.entity.Menu;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-17
 */
public interface IMenuService extends IService<Menu> {

    List<Menu> findAllMenus(String name);

    ArrayList<Menu> findRoleMenus(Long roleId);
}
