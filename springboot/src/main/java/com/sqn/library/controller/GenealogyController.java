package com.sqn.library.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Genealogy;
import com.sqn.library.mapper.GenealogyMapper;
import com.sqn.library.service.IGenealogyService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 家谱 前端控制器
 * </p>
 *
 * @author shenqn
 * @since 2023-07-19
 */
@RestController
@RequestMapping("/genealogy")
public class GenealogyController {

    @Resource
    private IGenealogyService genealogyService;

    @Resource
    GenealogyMapper genealogyMapper;

    /**
     * 新增或者更新
     */
    @PostMapping
    public Result<?> save(@RequestBody Genealogy genealogy) {
        genealogyService.saveOrUpdate(genealogy);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        genealogyService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        genealogyService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result<?> findAll() {
        return Result.success(genealogyService.list());
    }

    @GetMapping("/findParents")
    public Result<?> tree() {
        return Result.success(genealogyService.tree());
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Long id) {
        return Result.success(genealogyService.getById(id));
    }

    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam Integer status,
                              @RequestParam(defaultValue = "") String name
    ) {
        return Result.success(genealogyMapper.findPage(new Page<>(pageNum, pageSize), name, status));
    }
}
