package com.sqn.library.service.impl;

import cn.hutool.json.JSONObject;
import com.sqn.library.entity.SleepPositionCollect;
import com.sqn.library.mapper.SleepPositionCollectMapper;
import com.sqn.library.service.ISleepPositionCollectService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sqn.library.utils.GetApiTokenUtil;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2023-12-30
 */
@Service
public class SleepPositionCollectServiceImpl extends ServiceImpl<SleepPositionCollectMapper, SleepPositionCollect> implements ISleepPositionCollectService {
    @Resource
    GetApiTokenUtil getApiTokenUtil;

    @Override
    public Byte getSleepReg(String bedId) {
        String url = "https://bedapi.cnzxa.cn/api/user/mattress/status?bedId=" + bedId;
        // 创建HttpHeaders对象，并设置请求头内容
        HttpHeaders headers = new HttpHeaders();
        headers.set("Token", getApiTokenUtil.getBedToken());
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
        JSONObject json = new JSONObject(jsonString);
        JSONObject data = (JSONObject) json.get("data");
        // 0无人 1 仰卧 3,4侧卧 5坐姿
        return Byte.valueOf(data.get("sleepPositionId").toString());
    }

    @Override
    public boolean isReg(Byte actualSleepPosition, Byte recognition) {
        return (actualSleepPosition == 0 && recognition == 0) ||
                (actualSleepPosition == 1 && recognition == 1) ||
                ((actualSleepPosition == 2 || actualSleepPosition == 3) && (recognition == 3 || recognition == 4)) ||
                (actualSleepPosition == 4 && recognition == 5);
    }
}
