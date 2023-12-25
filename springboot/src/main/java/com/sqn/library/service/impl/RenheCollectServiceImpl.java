package com.sqn.library.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sqn.library.entity.RenheCollect;
import com.sqn.library.mapper.RenheCollectMapper;
import com.sqn.library.service.IRenheCollectService;
import org.springframework.stereotype.Service;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.util.Base64;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2023-12-16
 */
@Service
public class RenheCollectServiceImpl extends ServiceImpl<RenheCollectMapper, RenheCollect> implements IRenheCollectService {

    @Override
    public String getHotmapBase64(String bedId, String clearFlag, String pressures) {
        try {
            pressures = URLDecoder.decode(pressures, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        String heatmapApi = "https://mettressapi.cnzxa.cn/api/work/heatmap";

        String apiUrlWithParams = heatmapApi + "?bedId=" + bedId + "&clearFlag=" + clearFlag + "&pressures=" + pressures;
        try {
            // 创建URL对象
            URL url = new URL(apiUrlWithParams);

            // 打开连接
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // 设置请求方法为GET
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Token", "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyVHlwZUlkIjoiMSIsIm91dEZsYWciOiIwIiwibW9iaWxlIjoiMTUyMTU5MTM5MzciLCJ0ZXN0ZXJGbGFnIjoiMSIsImRvUmVhbFdvcmsiOiIwIiwiaWQiOiIyNCIsImV4cCI6MTcwMzc3OTIwMCwidXNlcm5hbWUiOiLmsojlpYfnlLcifQ.2hSKJiT4T_ih_uN5OKROzzq0PmwV5GkLOFLaXbaMh_k");
            // 获取响应内容
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }

            // 关闭连接和输入流
            in.close();
            conn.disconnect();
            String responseStr = response.toString();
            log.debug(responseStr);
            return responseStr.substring(20, responseStr.length() - 13);
        } catch (Exception e) {
            e.printStackTrace();
            log.error(String.valueOf(e));
            return "-1";
        }
    }

    @Override
    public String getHotMap(Long id, String base64, String savePath) {
        try {
            if ("-1".equals(base64)) {
                return "数据错误";
            }
            String newSavePath = savePath + id + "_hotImg.jpg";
            final File file = new File(newSavePath);
            if (file.exists()) {
                return newSavePath;
            }
            // 解码base64字符串为二进制数据
            byte[] imageBytes = Base64.getDecoder().decode(base64);

            // 创建一个输出流
            FileOutputStream outputStream = new FileOutputStream(newSavePath);

            // 写入图像数据到输出流
            outputStream.write(imageBytes);

            // 关闭输出流
            outputStream.close();
            log.debug("The heatmap was saved successfully!");
            return newSavePath;

        } catch (IOException e) {
            e.printStackTrace();
            log.error(String.valueOf(e));
            return String.valueOf(e);
        }
    }
}
