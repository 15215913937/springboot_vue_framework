package com.sqn.library.controller.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author shenqn
 * @Date 2022/9/19  22:21
 */
@Data
public class LoginDTO {
    private String username;
    private String password;
    private String phone;
    private String code;
}
