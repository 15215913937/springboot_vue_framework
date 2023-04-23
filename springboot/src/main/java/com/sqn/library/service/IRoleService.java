package com.sqn.library.service;

import com.sqn.library.entity.Role;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-17
 */
public interface IRoleService extends IService<Role> {

    void setRoleMenu(Long roleId, List<Long> menuIds);

    List<Long> getRoleMenu(Long roleId);
}
