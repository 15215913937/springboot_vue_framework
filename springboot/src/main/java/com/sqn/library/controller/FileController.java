package com.sqn.library.controller;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Files;
import com.sqn.library.entity.User;
import com.sqn.library.mapper.FileMapper;
import com.sqn.library.service.IFileService;
import com.sqn.library.service.impl.FileServiceImpl;
import io.swagger.annotations.Api;
import org.apache.catalina.security.SecurityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.jnlp.FileSaveService;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
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
@Api(tags = "文件上传管理")
public class FileController {
    //获取当前端口
    @Value("${server.port}")
    private String port;

    //获取当前ip
    @Value("${server.ip}")
    private String ip;
    //定义返回接口的ip
//    private static final String ip = "http://localhost";
    //定义文件存储的路径
    @Value("${files.upload.path}")
    private String fileUploadPath;

    @Resource
    FileMapper fileMapper;

    @Resource
    IFileService iFileService;

    @PostMapping("/testUpload")
    public String testUpload(@RequestParam MultipartFile file) throws IOException {
        String originalFilename = file.getOriginalFilename();
        String type = FileUtil.extName(originalFilename);
        long size = file.getSize();

        //定义上传文件的唯一标识（前缀）
        String flag = IdUtil.fastSimpleUUID();
        String fileFlag = flag + StrUtil.DOT + type;
        File uploadFile = new File(fileUploadPath + fileFlag);
        //判断配置的文件目录是否存在，若不存在，则新建一个新的文件目录
        File parentFile = uploadFile.getParentFile(); //取父级目录
        if (!parentFile.exists()) {
            parentFile.mkdirs();
        }
        String url;
        //把获取到的文件存储到磁盘路径中
        file.transferTo(uploadFile);
        //获取文件的MD5
        String md5 = SecureUtil.md5(uploadFile);
        //从数据库查询是否存在相同的记录
        Files dbFiles = iFileService.getFileByMd5(md5);
        //获取文件的url
        if (dbFiles != null) {
            url = dbFiles.getUrl();
            //由于文件已存在，删除刚刚上传的文件
            uploadFile.delete();
        } else {
            //数据库不存在重复文件，新建链接
            url = ip + ":" + port + "/files/test/" + fileFlag;
        }


        //存储数据库
        Files saveFiles = new Files();
        saveFiles.setName(originalFilename);
        saveFiles.setSize(size / 1024);
        saveFiles.setType(type);
        saveFiles.setUrl(url);
        saveFiles.setMd5(md5);
        fileMapper.insert(saveFiles);
        return url;
    }

    @GetMapping("/test/{fileFlag}")
    public void download(@PathVariable String fileFlag, HttpServletResponse response) throws IOException {
        //根据文件的唯一标识码获取文件
        File uploadFile = new File(fileUploadPath + fileFlag);
        //设置输出流的格式
        ServletOutputStream outputStream = response.getOutputStream();
        response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileFlag, "UTF-8"));
        response.setContentType("application/octet-stream");
        //读取文件的字节流
        outputStream.write(FileUtil.readBytes(uploadFile));
        outputStream.flush();
        outputStream.close();
    }


    //更新接口
    @PostMapping("/update")
    public Result<?> update(@RequestBody Files files) {
        return Result.success(fileMapper.updateById(files));
    }

    //删除接口
    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        Files files = fileMapper.selectById(id);
        files.setIsDelete(true);
        fileMapper.updateById(files);
        return Result.success();
    }

    //批量删除
    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        iFileService.deleteBatch(ids);
        return Result.success();
    }

    //分页查询接口
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String name,
                              @RequestParam(defaultValue = "") String type) {
        LambdaQueryWrapper<Files> wrapper = Wrappers.<Files>lambdaQuery();
        wrapper.eq(Files::getIsDelete, false).orderByDesc(Files::getId);
        //查询未删除的数据
        if (StrUtil.isNotBlank(name) || StrUtil.isNotBlank(type)) {
            wrapper.like(Files::getName, name).like(Files::getType, type);
        }
        return Result.success(fileMapper.selectPage(new Page<>(pageNum, pageSize), wrapper));
    }


    //--------------------------------以下是事件论坛文件上传接口-------------------------------------


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
        //定义文件名
        String rootFilePath =
                System.getProperty("user.dir") + "/springboot/src/main/resources/files/" + flag + "_" +
                        originalFilename;

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
        json.set("errno", 0);
        JSONArray array = new JSONArray();
        JSONObject data = new JSONObject();
        array.add(data);
        data.set("url", url);
        json.set("data", array);
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
