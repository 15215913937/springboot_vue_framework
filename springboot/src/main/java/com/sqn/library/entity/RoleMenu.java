package com.sqn.library.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @Author shenqn
 * @Date 2022/7/18  23:22
 */
@TableName("role_menu")
@Data
public class RoleMenu {

    private Integer roleId;
    private Integer menuId;
}
