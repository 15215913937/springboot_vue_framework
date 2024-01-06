package com.sqn.library.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.entity.SleepPositionCollect;
import com.sqn.library.mapper.SleepPositionCollectMapper;
import com.sqn.library.service.ISleepPositionCollectService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author shenqn
 * @since 2023-12-30
 */
@Slf4j
@RestController
@RequestMapping("/sleep-position-collect")
public class SleepPositionCollectController {

    @Resource
    ISleepPositionCollectService sleepPositionCollectService;

    @Resource
    SleepPositionCollectMapper sleepPositionCollectMapper;

    /**
     * 新增
     */
    @PostMapping
    public Result<?> save(@RequestBody SleepPositionCollect sleepPositionCollect) {
        try {
            Byte recognition = sleepPositionCollectService.getSleepReg(sleepPositionCollect.getBedId());
            sleepPositionCollect.setRecognition(recognition);
            sleepPositionCollect.setIsReg(sleepPositionCollectService.isReg(sleepPositionCollect.getActualSleepPosition(), recognition));
            sleepPositionCollectService.save(sleepPositionCollect);
            return Result.success();
        } catch (Exception e) {
            e.printStackTrace();
            log.error("sleep-position-collect/save error :" + e);
            return Result.error(Constants.CODE_INTERNAL_ERR, "存储失败" + e);
        }

    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        sleepPositionCollectService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        sleepPositionCollectService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result<?> findAll() {
        return Result.success(sleepPositionCollectService.list());
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Long id) {
        return Result.success(sleepPositionCollectService.getById(id));
    }

    @GetMapping("/findPage")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(required = false) Long userInfoId,
                              @RequestParam(required = false) Byte project,
                              @RequestParam(required = false) Byte mat,
                              @RequestParam(required = false) Byte actualSleepPosition,
                              @RequestParam(required = false) Byte isReg
    ) {
        return Result.success(sleepPositionCollectMapper.findPage(new Page<>(pageNum, pageSize), userInfoId, mat, project, actualSleepPosition, isReg));
    }

    @GetMapping("/pressureListByOne")
    public Result<?> pressureListByOne(@RequestParam String bedId,
                                       @RequestParam Integer period,
                                       @RequestParam String createTime) {
        HashMap<String, Object> res = sleepPositionCollectService.getPressureListByBedId(bedId, period, createTime);
        if (res.get("code").equals(1)) {
            return Result.success(res.get("data"));
        } else {
            return Result.error(Constants.CODE_INTERNAL_ERR, res.get("data").toString());
        }

    }
}
