package com.sqn.library.controller.dto;

import lombok.Data;

/**
 * @Author shenqn
 * @Date 2022/9/19  22:21
 */
@Data
public class LoginByPhoneDTO {
    private String phone;
    private String code;
}
