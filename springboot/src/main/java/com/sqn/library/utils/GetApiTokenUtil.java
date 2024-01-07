package com.sqn.library.utils;

import cn.hutool.json.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

/**
 * @author sqn
 */
@Slf4j
@Component
public class GetApiTokenUtil {

    @Value("${bed.host}")
    private String bedHost;

    @Value("${mettress.host}")
    private String mettressHost;

    public String getMettressToken() {
        String url = mettressHost + "api/sys/user/login?name=沈奇男&loginPassword=1";
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
        return data.getStr("token");
    }

    public String getBedToken() {
        String url = bedHost + "api/sys/user/login?username=15215913937&password=123456";
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
        return data.getStr("token");
    }

    public JSONObject getApiResponse(String url, String token) {
        // 创建HttpHeaders对象，并设置请求头内容
        HttpHeaders headers = new HttpHeaders();
        headers.set("Token", token);
        // 创建HttpEntity对象，并将请求头设置到其中
        HttpEntity<String> entity = new HttpEntity<>(headers);

        RestTemplate restTemplate = new RestTemplate();
        // 发送GET请求，获取响应
        ResponseEntity<String> response = restTemplate.exchange(
                url,
                HttpMethod.GET,
                entity,
                String.class
        );

        // 从响应的JSON中提取data字段的值
        String jsonString = response.getBody();
        return new JSONObject(jsonString);
    }
}
