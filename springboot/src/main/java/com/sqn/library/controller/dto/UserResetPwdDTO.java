package com.sqn.library.controller.dto;

import lombok.Data;

@Data
public class UserResetPwdDTO {
    private String username;
    private String newPassword;
}