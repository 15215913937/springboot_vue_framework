package com.sqn.library.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.sqn.library.entity.Files;
import com.sqn.library.mapper.FileMapper;
import com.sqn.library.service.IFileService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2022-07-11
 */
@Service
public class FileServiceImpl extends ServiceImpl<FileMapper, Files> implements IFileService {
    @Resource
    FileMapper fileMapper;

    @Override
    public void deleteBatch(List<Integer> ids) {
        LambdaQueryWrapper<Files> wrapper = Wrappers.<Files>lambdaQuery();
        //select * from files where id in (id,id,id...)
        wrapper.in(Files::getId, ids);
        List<Files> files = fileMapper.selectList(wrapper);
        for (Files file : files) {
            file.setIsDelete(true);
            fileMapper.updateById(file);
        }
    }

    /**
     * 通过文件的md5查询文件
     *
     * @param md5
     */
    @Override
    public Files getFileByMd5(String md5) {
        //查询文件的md5是否存在
        LambdaQueryWrapper<Files> wrapper = Wrappers.<Files>lambdaQuery();
        wrapper.eq(Files::getMd5, md5);
        List<Files> filesList = fileMapper.selectList(wrapper);
        return filesList.size() == 0 ? null : filesList.get(0);
    }

}
