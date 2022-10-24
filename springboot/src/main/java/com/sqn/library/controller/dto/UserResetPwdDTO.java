package com.sqn.library.controller.dto;

import lombok.Data;

/**
 * @author sqn
 */
@Data
public class UserResetPwdDTO {
    private String username;
    private String newPassword;
}