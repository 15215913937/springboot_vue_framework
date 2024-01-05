package com.sqn.library.service;

import com.sqn.library.entity.SleepPositionCollect;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 *
 * @author shenqn
 * @since 2023-12-30
 */
public interface ISleepPositionCollectService extends IService<SleepPositionCollect> {

    Byte getSleepReg(String bedId);

    boolean isReg(Byte actualSleepPosition, Byte recognition);
}
