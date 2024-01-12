package com.sqn.library.utils;

import cn.hutool.json.JSONObject;
import com.sqn.library.common.Constants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;
import java.util.concurrent.TimeUnit;

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

    @Resource
    RedisUtils redisUtils;

    public String getMettressToken() {
        String s = redisUtils.get(Constants.METTRESSTOKEN);
        if (s == null) {
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
            s = data.getStr("token");
            redisUtils.setEx(Constants.METTRESSTOKEN, s, 1, TimeUnit.DAYS);
        }
        return s;
    }

    public String getBedToken() {
        String s = redisUtils.get(Constants.BEDTOKEN);
        if (s == null) {
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
            s = data.getStr("token");
            redisUtils.setEx(Constants.BEDTOKEN, s, 1, TimeUnit.DAYS);
        }
        return s;
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

    public JSONObject callApi(HttpMethod method, String url, String requestBody, String token) {
        // 创建HttpHeaders对象
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        // 如果提供了token值，则设置请求头内容
        if (token != null && !token.isEmpty()) {
            headers.set("Token", token);
        }

        // 创建HttpEntity对象，并将请求头和请求体设置到其中
        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);
        RestTemplate restTemplate = new RestTemplate();

        // 发送请求，根据传入的 method 参数确定使用的请求方法
        ResponseEntity<String> response = restTemplate.exchange(
                url,
                method,
                entity,
                String.class
        );

        // 从响应的JSON中提取data字段的值
        String jsonString = response.getBody();
        log.info(jsonString);
        return new JSONObject(jsonString);
    }
}
