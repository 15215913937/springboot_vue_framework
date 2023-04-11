package com.sqn.library.controller;

import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.service.QrCodeService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

/**
 * @author sqn
 */
@RestController
@RequestMapping("/qr")
public class QrCodeController {
    @Resource
    private QrCodeService codeService;

    // 生成二维码并将其返回给前端调用者_hutool
    @PostMapping("/generate/v3")
    public Result<?> generateV3(String content, HttpServletResponse servletResponse, String timestamp) {
        try {
            //将生成的二维码文件存放于文件目录中
            //final String fileName=LOCALDATEFORMAT.get().format(new Date());
            //codeService.createCodeToFile(content,RootPath+File.separator+fileName+".png");

            //将生成的二维码文件直接返回给前端响应流
            long l = System.currentTimeMillis();
            long l1 = Long.parseLong(timestamp);
            if (l - l1 > 60) {
                return Result.error(Constants.CODE_COMMON_ERR, "请求错误");
            }
            codeService.createCodeToStream(content, servletResponse);
        } catch (Exception e) {
            return Result.error(Constants.CODE_INTERNAL_ERR, "内部错误");
        }
        return Result.success();
    }
}
