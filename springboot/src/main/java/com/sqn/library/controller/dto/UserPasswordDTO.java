package com.sqn.library.controller.dto;

import lombok.Data;

/**
 * 接收前端请求的参数
 *
 * @Author shenqn
 * @Date 2022/7/23  15:05
 */
@Data
public class UserPasswordDTO {
    private String username;
    private String password;
    private String newPassword;
}
