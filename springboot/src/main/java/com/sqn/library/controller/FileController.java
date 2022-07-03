package com.sqn.library.controller;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.sqn.library.common.Result;
import lombok.val;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

/**
 * @Author shenqn
 * @Date 2022/6/29  21:08
 */
//文件上传
@RestController
@RequestMapping("/files")
public class FileController {
    //获取当前端口
    @Value("${server.port}")
    private String port;
    //定义返回接口的ip
    private static final String ip = "http://localhost";

    /**
     * 上传接口
     *
     * @param file
     * @return
     * @throws IOException
     */
    @PostMapping("/upload")
    public Result<?> upload(MultipartFile file) throws IOException {

        String originalFilename = file.getOriginalFilename(); //获取原文件名称
        //定义上传文件的唯一标识（前缀）
        String flag = IdUtil.fastSimpleUUID();
        String rootFilePath =
                System.getProperty("user.dir") + "/springboot/src/main/resources/files/" + flag + "_" + originalFilename;
        //获取上传路径
        FileUtil.writeBytes(file.getBytes(), rootFilePath);//利用工具hutool完成文件写入到上传路径文件下的操作，获取字节流要抛出异常
        return Result.success(ip + ":" + port + "/files/" + flag); //返回结果url
    }

    /**
     * 富文本文件上传接口
     */
    @PostMapping("/editor/upload")
    public JSONObject editorUpload(MultipartFile file) throws IOException {

        String originalFilename = file.getOriginalFilename(); //获取原文件名称
        //定义上传文件的唯一标识（前缀）
        String flag = IdUtil.fastSimpleUUID();
        String rootFilePath =
                System.getProperty("user.dir") + "/springboot/src/main/resources/files/" + flag + "_" + originalFilename;
        //获取上传路径
        FileUtil.writeBytes(file.getBytes(), rootFilePath);//利用工具hutool完成文件写入到上传路径文件下的操作，获取字节流要抛出异常
        String url = ip + ":" + port + "/files/" + flag;
        //富文本图片上传格式
        JSONObject json = new JSONObject();
        json.set("errno",0);
        JSONArray array = new JSONArray();
        JSONObject data = new JSONObject();
        array.add(data);
        data.set("url",url);
        json.set("data",array);
        return json; //返回结果url
    }

    /**
     * 下载接口
     *
     * @param flag
     * @param response
     */
    @GetMapping("/{flag}")
    public void getFiles(@PathVariable String flag, HttpServletResponse response) {
        OutputStream os;//新建一个输出流对象
        //定义文件上传的根路径
        String basePath = System.getProperty("user.dir") + "/springboot/src/main/resources/files/";
        List<String> fileNames = FileUtil.listFileNames(basePath);//获取根路径下所有文件名称
        //找到跟参数一致的文件
        String fileName = fileNames.stream().filter(name -> name.contains(flag)).findAny().orElse("");
        try {
            if (StrUtil.isNotEmpty(fileName)) {
                response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"
                ));
                response.setContentType("application/octet-stream");
                byte[] bytes = FileUtil.readBytes(basePath + fileName);//通过文件的路径读取的文件字节流
                os = response.getOutputStream();//通过输出流返回文件
                os.write(bytes);
                os.flush();
                os.close();
            }
        } catch (Exception e) {
            System.out.println("文件下载失败");
        }
    }
}
