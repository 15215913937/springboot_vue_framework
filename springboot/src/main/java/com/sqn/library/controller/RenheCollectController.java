package com.sqn.library.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.controller.dto.RenheCollectDTO;
import com.sqn.library.controller.dto.RenheGetPressureDTO;
import com.sqn.library.entity.RenheCollect;
import com.sqn.library.mapper.RenheCollectMapper;
import com.sqn.library.service.IRenheCollectService;
import com.sqn.library.utils.ApiRequestUtil;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author shenqn
 * @since 2023-12-16
 */
@RestController
@RequestMapping("/renhe-collect")
public class RenheCollectController {

    @Resource
    private IRenheCollectService renheCollectService;
    @Resource
    RenheCollectMapper renheCollectMapper;
    @Resource
    ApiRequestUtil apiRequestUtil;

    /**
     * 新增或者更新
     */
    @PostMapping
    public Result<?> save(@RequestBody RenheCollect renheCollect) {
        renheCollectService.saveOrUpdate(renheCollect);
        return Result.success();
    }

    @GetMapping("/hotmap")
    @CrossOrigin(origins = "https://mettressapi.cnzxa.cn/api/work/heatmap")
    public Result<?> hotmap(@RequestParam String bedId, @RequestParam(defaultValue = "1") String clearFlag, @RequestParam String pressures) {
        String hotmapBase64 = renheCollectService.getHotmapBase64(bedId, clearFlag, pressures);
        return Result.success(hotmapBase64);
    }

    /***
     * 垫子压力数据监测并保存
     * @param renheCollectDTO
     * @return
     */
    @PostMapping("/dataCollect")
    Result<?> dataCollect(@RequestBody RenheCollectDTO renheCollectDTO) {
        if (renheCollectDTO.getCode().isEmpty() || renheCollectDTO.getBedId().isEmpty()) {
            return Result.error(Constants.CODE_COMMON_ERR, "必填项必须设置");
        }
        RenheGetPressureDTO pressureDTO = renheCollectService.dataAnalysis(renheCollectDTO.getBedId());
        RenheCollect renheCollect = new RenheCollect();
        renheCollect.setBatch(renheCollectDTO.getBatch());
        renheCollect.setBedId(renheCollectDTO.getBedId());
        renheCollect.setMat(renheCollectDTO.getMat());
        renheCollect.setCoefficient(renheCollectDTO.getCoefficient());
        renheCollectService.save(renheCollect);

        return Result.success();
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
