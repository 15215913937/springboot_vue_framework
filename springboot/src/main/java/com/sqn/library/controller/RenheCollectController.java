package com.sqn.library.controller;


import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.controller.dto.RenheCheckDTO;
import com.sqn.library.controller.dto.RenheCollectDTO;
import com.sqn.library.controller.dto.RenheScreenCapDTO;
import com.sqn.library.entity.RenheCollect;
import com.sqn.library.mapper.RenheCollectMapper;
import com.sqn.library.service.IRenheCollectService;
import com.sqn.library.utils.RedisUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author shenqn
 * @since 2023-12-16
 */
@Slf4j
@RestController
@RequestMapping("/renhe-collect")
public class RenheCollectController {

    @Resource
    IRenheCollectService renheCollectService;
    @Resource
    RenheCollectMapper renheCollectMapper;
    @Resource
    RedisUtils redisUtils;


    @PostMapping("/exportPressureAndHotImg")
    public Result<?> exportPressureAndHotImg(@RequestBody List<RenheScreenCapDTO> renheScreenCapDTOList) {
        String desktopPath = System.getProperty("user.home") + File.separator + "Desktop";
        String expectSaveFilePath = desktopPath + "\\PressureAndHotImg";
        Integer i = renheCollectService.export_PressureAndHot_Img(renheScreenCapDTOList, expectSaveFilePath);
        if (i == renheScreenCapDTOList.size()) {
            return Result.success(expectSaveFilePath);
        } else {
            return Result.error(Constants.CODE_DATA_ERR, "仅生成" + i + "份图片，可尝试重新导出");
        }
    }

    @GetMapping("/hotmap")
    @CrossOrigin(origins = "https://mettressapi.cnzxa.cn/api/work/heatmap")
    public Result<?> hotmap(@RequestParam Long id, @RequestParam String pressure, @RequestParam String bedId) {
        String s = redisUtils.get(Constants.RenheHotMapBase64 + id);
        if (s == null) {
            String hotmapBase64 = renheCollectService.getHotmapBase64(pressure, bedId);
            redisUtils.set(Constants.RenheHotMapBase64 + id, hotmapBase64);
            return Result.success(hotmapBase64);
        }
        return Result.success(s);
    }

    @GetMapping("/getPressure")
    public Result<?> getPressure(@RequestParam String bedId) {
        HashMap<String, String> res = renheCollectService.getPressureByBedId(bedId);
        return Result.success(res);
    }

    @PostMapping("/saveCollectData")
    Result<?> saveCollectData(@RequestBody RenheCollectDTO renheCollectDTO) {
        HashMap<String, String> res = renheCollectService.getPressureByBedId(renheCollectDTO.getBedId());
        if ("true".equals(res.get("online"))) {
            String pressure = res.get("pressure");
            RenheCollect renheCollect = new RenheCollect();
            renheCollect.setCode(renheCollectDTO.getCode());
            renheCollect.setBatch(renheCollectDTO.getBatch());
            renheCollect.setBedId(renheCollectDTO.getBedId());
            renheCollect.setMat(renheCollectDTO.getMat());
            renheCollect.setFirstPressure(renheCollectDTO.getFirstPressure());
            renheCollect.setFinalPressure(Long.valueOf(res.get("fiducial_value")));
            renheCollect.setCoefficient(renheCollectDTO.getCoefficient());
            renheCollect.setPressure(pressure);
            String position = renheCollectService.getPosition(pressure);
            renheCollect.setPosition(position);
            renheCollectMapper.insert(renheCollect);
            return Result.success();
        } else {
            return Result.error(Constants.CODE_DATA_ERR, "床垫离线");
        }

    }

    @GetMapping("/getPosition")
    public void getPosition() {
        List<RenheCollect> list = renheCollectMapper.selectList(Wrappers.<RenheCollect>lambdaQuery());
        for (RenheCollect l : list) {
            final String pressure = l.getPressure();
            try {
                String position = renheCollectService.getPosition(pressure);
                l.setPosition(position);
                renheCollectMapper.updateById(l);
            } catch (Exception e) {
                log.error("Error occurred while getting position for pressure: " + pressure, e);
            }
        }
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        renheCollectService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Long> ids) {
        for (Long id : ids) {
            String s = redisUtils.get(Constants.RenheHotMapBase64 + id);
            if (s != null) {
                redisUtils.delete(Constants.RenheHotMapBase64 + id);
            }
        }
        renheCollectService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping()
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "20") Integer pageSize,
                              @RequestParam(defaultValue = "") String code,
                              @RequestParam(defaultValue = "") String bedId,
                              @RequestParam(defaultValue = "") String mat,
                              @RequestParam(defaultValue = "") String status,
                              @RequestParam(defaultValue = "") String position,
                              @RequestParam(required = false) Long batch,
                              @RequestParam(required = false) Float coefficient) {
        Page<RenheCollect> userPage = renheCollectMapper.findPage(new Page<>(pageNum, pageSize), code, bedId, mat, batch, coefficient, status, position);
        return Result.success(userPage);
    }

    @GetMapping("/all")
    public Result<?> findAll() {
        return Result.success(renheCollectService.list());
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Long id) {
        return Result.success(renheCollectService.getById(id));
    }

    @PostMapping("/check")
    public Result<?> check(@RequestBody RenheCheckDTO renheCheckDTO) {
        RenheCollect one = renheCollectMapper.selectById(renheCheckDTO.getId());
        if (one == null) {
            return Result.error(Constants.CODE_DATA_ERR, "数据不存在");
        } else {
            one.setStatus(renheCheckDTO.getStatus());
            one.setRemarks(renheCheckDTO.getRemarks());
            renheCollectMapper.updateById(one);
            return Result.success("状态更新成功");
        }
    }

    @PostMapping("/saveRemark/{id}")
    public Result<?> saveRemark(@PathVariable Long id, @RequestBody(required = false) String remark) {
        log.info(remark);

        RenheCollect one = renheCollectMapper.selectById(id);
        if (one == null) {
            return Result.error(Constants.CODE_DATA_ERR, "数据不存在");
        } else {
            one.setRemarks(remark == null ? "" : remark);
            renheCollectMapper.updateById(one);
            return Result.success("备注更新成功");
        }
    }


    @GetMapping("/countBy")
    public Result<?> countBy(@RequestParam(defaultValue = "") String mat,
                             @RequestParam(defaultValue = "") String batch,
                             @RequestParam(required = false) String statusStr) {
        HashMap<String, Object> map = new HashMap<>();
        List<String> codeList = new ArrayList<>();
        List<RenheCollect> renheCollects;

        Integer status = null;
        if (StringUtils.isNotEmpty(statusStr)) {
            status = Integer.parseInt(statusStr);
        }
        if (status != null) {
            renheCollects = renheCollectMapper.selectList(Wrappers.<RenheCollect>lambdaQuery()
                    .eq(StringUtils.isNotEmpty(mat), RenheCollect::getMat, mat)
                    .eq(StringUtils.isNotEmpty(batch), RenheCollect::getBatch, batch)
                    .eq(RenheCollect::getStatus, status));
        } else {
            renheCollects = renheCollectMapper.selectList(Wrappers.<RenheCollect>lambdaQuery()
                    .eq(StringUtils.isNotEmpty(mat), RenheCollect::getMat, mat)
                    .eq(StringUtils.isNotEmpty(batch), RenheCollect::getBatch, batch));
        }

        for (RenheCollect renheCollect : renheCollects) {
            codeList.add(renheCollect.getCode());
        }
        map.put("codeList", codeList);
        map.put("total", codeList.size());
        return Result.success(map);
    }
}
