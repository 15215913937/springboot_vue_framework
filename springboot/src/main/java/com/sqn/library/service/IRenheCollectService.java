package com.sqn.library.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.sqn.library.controller.dto.RenheScreenCapDTO;
import com.sqn.library.entity.RenheCollect;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author shenqn
 * @since 2023-12-16
 */
public interface IRenheCollectService extends IService<RenheCollect> {

    String getHotmapBase64(String pressures,String bedId);

    Integer export_PressureAndHot_Img(List<RenheScreenCapDTO> renheScreenCapDTOList, String savePath);
}
