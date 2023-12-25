package com.sqn.library.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.sqn.library.entity.RenheCollect;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author shenqn
 * @since 2023-12-16
 */
public interface IRenheCollectService extends IService<RenheCollect> {

    String getHotmapBase64(String bedId, String clearFlag, String pressures);
    String getHotMap(Long id,String base64,String savePath);
}
