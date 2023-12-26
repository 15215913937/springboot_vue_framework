package com.sqn.library.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * @author sqn
 */
@Component
public class ApiRequestUtil {
    public String sendGetRequest(String apiUrlWithParams, String token) {
        try {
            // 创建URL对象
            URL url = new URL(apiUrlWithParams);

            // 打开连接
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // 设置请求方法为GET
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Token", token);

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
//            String responseStr = response.toString();
            ObjectMapper objectMapper = new ObjectMapper();


            // 转换为JSON对象
            Object json = objectMapper.readValue(response.toString(), Object.class);

            // 转换为格式化的JSON字符串
            String formattedJson = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(json);

            return formattedJson;
//            return responseStr.substring(20, responseStr.length() - 13);
        } catch (Exception e) {
            e.printStackTrace();
            return "错误：" + e;
        }
    }
}
