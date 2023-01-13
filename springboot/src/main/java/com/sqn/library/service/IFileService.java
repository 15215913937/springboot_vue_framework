package com.sqn.library.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.sqn.library.entity.Files;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-11
 */
public interface IFileService extends IService<Files> {

    void deleteBatch(List<Integer> ids);

    Files getFileByMd5(String md5);
}
