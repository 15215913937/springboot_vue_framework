package com.sqn.library.utils;

import cn.hutool.json.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Slf4j
@Component
public class GetApiTokenUtil {
    public String getMettressToken() {
        String url = "https://mettressapi.cnzxa.cn/api/sys/user/login?name=沈奇男&loginPassword=1";
        RestTemplate restTemplate = new RestTemplate();

        // 发送GET请求，获取响应
        ResponseEntity<String> response = restTemplate.exchange(
                url,
                HttpMethod.GET,
                null,
                String.class
        );

        // 从响应的JSON中提取data字段的值
        String jsonString = response.getBody();
        JSONObject json = new JSONObject(jsonString);
        JSONObject data = (JSONObject) json.get("data");
        return (String) data.get("token");
    }
    public String getBedToken() {
        String url = "https://bedapi.cnzxa.cn//api/sys/user/login?username=15215913937&password=123456";
        RestTemplate restTemplate = new RestTemplate();

        // 发送GET请求，获取响应
        ResponseEntity<String> response = restTemplate.exchange(
                url,
                HttpMethod.GET,
                null,
                String.class
        );

        // 从响应的JSON中提取data字段的值
        String jsonString = response.getBody();
        JSONObject json = new JSONObject(jsonString);
        JSONObject data = (JSONObject) json.get("data");
        String token = (String) data.get("token");
        return token;
    }
}
