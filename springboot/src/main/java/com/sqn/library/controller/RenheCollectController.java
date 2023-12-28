package com.sqn.library.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.controller.dto.RenheCollectDTO;
import com.sqn.library.controller.dto.RenheScreenCapDTO;
import com.sqn.library.entity.RenheCollect;
import com.sqn.library.mapper.RenheCollectMapper;
import com.sqn.library.service.IRenheCollectService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.io.File;
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
    private IRenheCollectService renheCollectService;
    @Resource
    RenheCollectMapper renheCollectMapper;

    @PostMapping("/exportPressureAndHotImg")
    public Result<?> exportPressureAndHotImg(@RequestBody List<RenheScreenCapDTO> renheScreenCapDTOList) {
        String desktopPath = System.getProperty("user.home") + File.separator + "Desktop";
        Integer i = renheCollectService.export_PressureAndHot_Img(renheScreenCapDTOList, desktopPath);
        if (i == renheScreenCapDTOList.size()) {
            return Result.success("图片生成成功！");
        } else {
            return Result.error(Constants.CODE_DATA_ERR, "仅生成" + i + "份图片，可尝试重新导出");
        }
    }

    @GetMapping("/hotmap")
    @CrossOrigin(origins = "https://mettressapi.cnzxa.cn/api/work/heatmap")
    public Result<?> hotmap(@RequestParam String pressure, @RequestParam String bedId) {
        String hotmapBase64 = renheCollectService.getHotmapBase64(pressure, bedId);
        return Result.success(hotmapBase64);
    }

    /***
     * 垫子压力数据首次保存
     * @param renheCollectDTO
     * @return`
     */
    @PostMapping("/saveFirstPressure")
    Result<?> saveFirstPressure(@RequestBody RenheCollectDTO renheCollectDTO) {
        List<String> pressure = renheCollectDTO.getPressure();
        String strPressure = String.join(",", pressure);
        final RenheCollect renheCollect = new RenheCollect();
        renheCollect.setCode(renheCollectDTO.getCode());
        renheCollect.setBatch(renheCollectDTO.getBatch());
        renheCollect.setBedId(renheCollectDTO.getBedId());
        renheCollect.setMat(renheCollectDTO.getMat());
        renheCollect.setFirstPressure(renheCollectDTO.getFirstPressure());
        renheCollect.setCoefficient(renheCollectDTO.getCoefficient());
        renheCollect.setPressure(strPressure);
        renheCollectMapper.insert(renheCollect);
        return Result.success();
    }

    /***
     * 垫子压力数据最终保存
     * @param renheCollectDTO
     * @return
     */
    @PostMapping("/saveFinalPressure")
    Result<?> saveFinalPressure(@RequestBody RenheCollectDTO renheCollectDTO) {
        RenheCollect renhe = renheCollectMapper.selectOne(Wrappers.<RenheCollect>lambdaQuery().eq(RenheCollect::getCode, renheCollectDTO.getCode()));
        if (renhe != null) {
            if (renhe.getFinalPressure() == null) {
                List<String> pressure = renheCollectDTO.getPressure();
                String strPressure = String.join(",", pressure);
                renhe.setFinalPressure(renheCollectDTO.getFinalPressure());
                renhe.setPressure(strPressure);
                renheCollectMapper.updateById(renhe);
                return Result.success("最终数据存储成功");
            } else {
                return Result.error(Constants.CODE_DATA_ERR, "数据重复存储");
            }
        } else {
            return Result.error(Constants.CODE_DATA_ERR, "硬件码不存在");
        }


    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        renheCollectService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        renheCollectService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping()
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "20") Integer pageSize,
                              @RequestParam(defaultValue = "") String code,
                              @RequestParam(defaultValue = "") String bedId,
                              @RequestParam(defaultValue = "") String mat,
                              @RequestParam(required = false) Long batch,
                              @RequestParam(required = false) Float coefficient) {
        Page<RenheCollect> userPage = renheCollectMapper.findPage(new Page<>(pageNum, pageSize), code, bedId, mat, batch, coefficient);
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

    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize) {
        QueryWrapper<RenheCollect> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return Result.success(renheCollectService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }
}
