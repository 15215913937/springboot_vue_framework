package com.sqn.library.service.impl;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sqn.library.entity.SleepPositionCollect;
import com.sqn.library.mapper.SleepPositionCollectMapper;
import com.sqn.library.service.IRenheCollectService;
import com.sqn.library.service.ISleepPositionCollectService;
import com.sqn.library.utils.GetApiTokenUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2023-12-30
 */
@Slf4j
@Service
public class SleepPositionCollectServiceImpl extends ServiceImpl<SleepPositionCollectMapper, SleepPositionCollect> implements ISleepPositionCollectService {
    @Resource
    GetApiTokenUtil getApiTokenUtil;

    @Value("${bed.host}")
    private String bedHost;

    @Resource
    IRenheCollectService renheCollectService;

    @Override
    public Byte getSleepReg(String bedId) {
        String url = bedHost + "api/user/mattress/status?bedId=" + bedId;
        String token = getApiTokenUtil.getBedToken();
        JSONObject apiResponse = getApiTokenUtil.getApiResponse(url, token);
        JSONObject data = (JSONObject) apiResponse.get("data");
        // 0无人 1 仰卧 3,4侧卧 5坐姿
        return Byte.valueOf(data.getStr("sleepPositionId"));
    }

    @Override
    public boolean isReg(Byte actualSleepPosition, Byte recognition) {
        return (actualSleepPosition == 5 && recognition == 0) ||
                (actualSleepPosition == 1 && recognition == 1) ||
                ((actualSleepPosition == 2 || actualSleepPosition == 3) && (recognition == 3 || recognition == 4)) ||
                (actualSleepPosition == 4 && recognition == 5);
    }

    @Override
    public Map<Object, Object> getPressureListByBedId(Long id, String bedId, Integer period, String createTime) {
        Map<Object, Object> map = new HashMap<>();
        Integer code = 1;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = dateFormat.parse(createTime);

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            calendar.add(Calendar.SECOND, period + 60);
            Date futureDate = calendar.getTime();
            calendar.setTime(date);
            calendar.add(Calendar.SECOND, -60);
            Date pastDate = calendar.getTime();

            String formattedStartTime = dateFormat.format(pastDate);
            String formattedEndTime = dateFormat.format(futureDate);
            String url = bedHost + "api/sys/bed/logs/pressure?denoise=true&bedId=" + bedId + "&startTime=" + formattedStartTime + "&endTime=" + formattedEndTime + "&currentPage=1&pageSize=10000";
            String token = getApiTokenUtil.getBedToken();
            JSONObject apiResponse = getApiTokenUtil.getApiResponse(url, token);

            if ("200".equals(apiResponse.get("code").toString())) {
                JSONObject data = apiResponse.getJSONObject("data");
                JSONArray list = data.getJSONArray("list");

                ArrayList<Object> list1 = new ArrayList<>();
                for (int i = list.size() - 1; i >= 0; i--) {
                    HashMap<String, String> listMap = new HashMap<>();
                    JSONObject jsonObject = list.getJSONObject(i);
                    String pressure = jsonObject.getStr("pressureList").replaceAll("\\[|\\]", "");
                    String time = jsonObject.getStr("time");
                    // 获取热力图base64
                    String hotmapBase64 = renheCollectService.getHotmapBase64(pressure, bedId);
                    listMap.put("pressure", pressure);
                    listMap.put("hotBase64", hotmapBase64);
                    listMap.put("time", time);
                    list1.add(listMap);
                }
                map.put("code", code);
                map.put("data", list1);
            } else {
                code = 0;
                map.put("code", code);
                map.put("data", "出错啦");
            }
        } catch (ParseException e) {
            e.printStackTrace();
            code = 0;
            map.put("code", code);
            map.put("data", "时间出错啦");
        }
        return map;
    }
}
