package com.sqn.library.controller;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.UUID;

/**
 * @author sqn
 */
@RestController
@RequestMapping("/qr_login")
public class LoginController {
    public static final String QR_CODE = UUID.randomUUID().toString();

    boolean isLogin = false;

    @GetMapping("/qrcode")
    public String getQrCode() {
        return QR_CODE;
    }

    @GetMapping("/checkLoginStatus")
    public boolean checkLoginStatus() {
        return isLogin;
    }

    @PostMapping
    public void login(HttpServletRequest request) {
        String qrCodeScanned = request.getParameter("qrCode");
        if (qrCodeScanned.equals(QR_CODE)) {
            isLogin = true;
        }
    }
}
