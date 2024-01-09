package com.sqn.library.service.impl;

import cn.hutool.json.JSONObject;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sqn.library.controller.dto.RenheScreenCapDTO;
import com.sqn.library.entity.RenheCollect;
import com.sqn.library.mapper.RenheCollectMapper;
import com.sqn.library.service.IRenheCollectService;
import com.sqn.library.utils.GetApiTokenUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Base64;
import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2023-12-16
 */
@Slf4j
@Service
public class RenheCollectServiceImpl extends ServiceImpl<RenheCollectMapper, RenheCollect> implements IRenheCollectService {

    @Resource
    GetApiTokenUtil apiTokenUtil;

    @Override
    public String getHotmapBase64(String pressures, String bedId) {
        try {
            pressures = URLDecoder.decode(pressures, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String responseStr = "/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIfIiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCAINAMgDASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAAf/xAAUEAEAAAAAAAAAAAAAAAAAAAAA/8QAFgEBAQEAAAAAAAAAAAAAAAAAAAQG/8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8AkoDZpwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH//2Q==";

        String heatmapApi = "https://mettressapi.cnzxa.cn/api/work/heatmap";

        String apiUrlWithParams = heatmapApi + "?bedId=" + bedId + "&clearFlag=1&pressures=" + pressures;
        try {
            JSONObject apiResponse = apiTokenUtil.getApiResponse(apiUrlWithParams, apiTokenUtil.getMettressToken());
            responseStr = apiResponse.getStr("data");
        } catch (Exception e) {
            e.printStackTrace();
            log.error(String.valueOf(e));
        }
        return responseStr;
    }

    public void getHotMap(String base64, String savePath) {
        String newSavePath = savePath + "/hotImg.jpg";
        try {
            // 解码base64字符串为二进制数据
            byte[] imageBytes = Base64.getDecoder().decode(base64);

            // 创建一个输出流
            FileOutputStream outputStream = new FileOutputStream(newSavePath);

            // 写入图像数据到输出流
            outputStream.write(imageBytes);

            // 关闭输出流
            outputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
            log.error("热力图生成失败：" + e);
        }
    }

    @Override
    public Integer export_PressureAndHot_Img(List<RenheScreenCapDTO> renheScreenCapDTOList, String savPath) {

        // 成功生成图片的数量
        int successCount = 0;
        for (RenheScreenCapDTO renheScreenCapDTO : renheScreenCapDTOList) {
            // 保存文件路径
            String parentFolder = String.format("%s/第%s批/%s", savPath, renheScreenCapDTO.getBatch(), renheScreenCapDTO.getCode());
            String s = checkOrCreateDirectory(parentFolder);
            String base64 = getHotmapBase64(renheScreenCapDTO.getPressure(), renheScreenCapDTO.getBedId());
            // 生成热力图
            getHotMap(base64, s);

            // 生成压力图
            successCount = getPressureImg(renheScreenCapDTO.getPressure(), s, successCount);
        }
        return successCount;
    }

    @Override
    public String getPosition(String pressure) {
        String url = "https://bedapi.test.cnzxa.cn/api/test/predictPosition";
        String jsonRequestBody = "{\"pressureList\": [" + pressure + "]}";
        try {
            JSONObject apiResponse = apiTokenUtil.callApi(HttpMethod.POST, url, jsonRequestBody, null);
            return apiResponse.getStr("data");
        } catch (Exception e) {
            log.error("Error occurred while calling API for pressure: " + pressure, e);
            // 可以根据具体情况处理异常，比如抛出异常或返回默认值
            return "Error: Unable to retrieve position";
        }
    }

    private Integer getPressureImg(String pressure, String parentFilePath, Integer successCount) {
        // 压力图像设置
        int rows = 21; // 行数
        int cols = 8; // 列数
        int cellWidth = 40; // 格子宽度
        int cellHeight = 30; // 格子高度
        int imageWidth = cellWidth * cols; // 图像宽度
        int imageHeight = cellHeight * rows; // 图像高度
        // 解析参数
        String[] values = pressure.split(",");
        // 创建 BufferedImage 对象
        BufferedImage image = new BufferedImage(imageWidth, imageHeight, BufferedImage.TYPE_INT_RGB);
        // 获取 Graphics2D 对象
        Graphics2D g2d = image.createGraphics();
        // 填充底色
        g2d.setColor(Color.WHITE);
        g2d.fillRect(0, 0, imageWidth, imageHeight);

        // 绘制格子
        int index = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (index < values.length) {
                    String value = values[index];

                    // 获取格子位置和绘制数值的中心坐标
                    int x = j * cellWidth;
                    int y = i * cellHeight;
                    int centerX = x + (cellWidth >> 1); // 右移1位等同于除以2
                    int centerY = y + (cellHeight >> 1);

                    // 绘制格子背景
                    Color color = getColorFromValue(value); // 获取颜色
                    g2d.setColor(color);
                    g2d.fillRect(x, y, cellWidth, cellHeight);

                    // 绘制格子边框
                    g2d.setColor(Color.WHITE);
                    g2d.drawRect(x, y, cellWidth, cellHeight);

                    // 绘制数值
                    Font font = new Font("Arial", Font.PLAIN, 16);
                    FontMetrics fm = g2d.getFontMetrics(font);
                    int stringWidth = fm.stringWidth(value); // 获取数值的宽度
                    int stringHeight = fm.getHeight(); // 获取数值的高度
                    int textX = centerX - (stringWidth / 2); // 计算数值的X坐标
                    int textY = centerY + (stringHeight / 2); // 计算数值的Y坐标

                    g2d.setColor(Color.BLACK); // 设置字体颜色为黑色
                    g2d.setFont(font);
                    g2d.drawString(value, textX, textY);

                    index++;
                }
            }
        }
        // 释放资源
        g2d.dispose();

        // 输出图像
        File outputFile = new File(parentFilePath + "/pressureImg.png");
        try {
            ImageIO.write(image, "png", outputFile);
            successCount++;
            log.info("文件保存路径：" + parentFilePath);
        } catch (IOException e) {
            e.printStackTrace();
            log.error("图片输出错误：" + e);
        }
        return successCount;
    }

    private Color getColorFromValue(String value) {
        int intValue = Integer.parseInt(value);

        // 根据数值范围设置对应的颜色
        if (intValue >= 0 && intValue <= 9) {
            return Color.decode("#E3E3E3"); // 红色
        } else if (intValue >= 10 && intValue <= 20) {
            return Color.decode("#CCCCCC"); // 绿色
        } else if (intValue >= 21 && intValue <= 30) {
            return Color.decode("#E5C4C4"); // 蓝色
        } else if (intValue >= 31 && intValue <= 50) {
            return Color.decode("#FFAFAF"); // 蓝色
        } else if (intValue >= 51 && intValue <= 100) {
            return Color.decode("#FF5C5C"); // 蓝色
        } else if (intValue >= 101 && intValue <= 150) {
            return Color.decode("#E60E0E"); // 蓝色
        } else {
            return Color.decode("#A60000"); // 灰色
        }
    }

    /***
     * 路径检查
     * @param directoryPath
     * @return
     */
    public String checkOrCreateDirectory(String directoryPath) {
        String desktopPath = System.getProperty("user.home") + File.separator + "Desktop";
        File directory = new File(directoryPath);

        // 判断文件夹是否存在
        if (directory.exists()) {
            if (directory.isDirectory()) {
                // 文件夹已存在，返回路径
                return directory.getAbsolutePath();
            } else {
                // 路径存在但不是一个文件夹，输出错误信息
                log.error(directoryPath + " 不是一个文件夹路径，路径已替换至桌面");
                return desktopPath;
            }
        } else {
            // 文件夹不存在，尝试创建
            if (directory.mkdirs()) {
                // 创建成功，返回路径
                return directory.getAbsolutePath();
            } else {
                // 创建失败，输出错误信息
                log.error("无法创建文件夹：" + directoryPath + "，路径已替换至桌面");
                return desktopPath;
            }
        }
    }
}
