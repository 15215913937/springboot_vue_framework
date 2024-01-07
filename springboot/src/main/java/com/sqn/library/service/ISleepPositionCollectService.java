package com.sqn.library.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.sqn.library.entity.SleepPositionCollect;

import java.util.Map;

/**
 * @author shenqn
 * @since 2023-12-30
 */
public interface ISleepPositionCollectService extends IService<SleepPositionCollect> {

    Byte getSleepReg(String bedId);

    boolean isReg(Byte actualSleepPosition, Byte recognition);

    Map<Object, Object> getPressureListByBedId(Long id, String bedId, Integer period, String createTime);
}
