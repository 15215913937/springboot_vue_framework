package com.sqn.library.controller;


import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.sqn.library.common.Constants;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.CategoryListMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

import com.sqn.library.common.Result;


import com.sqn.library.service.ICategoryListService;
import com.sqn.library.entity.CategoryList;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author shenqn
 * @since 2022-08-23
 */
@RestController
@RequestMapping("/category-list")
public class CategoryListController {

    @Resource
    private ICategoryListService categoryListService;

    @Resource
    CategoryListMapper categoryListMapper;

    // 新增或者更新
    @PostMapping
    public Result<?> save(@RequestBody CategoryList categoryList) {
        LambdaQueryWrapper<CategoryList> wrapper = Wrappers.<CategoryList>lambdaQuery()
                .eq(CategoryList::getName, categoryList.getName())
                .or()
                .eq(CategoryList::getFlag, categoryList.getFlag());
        CategoryList one = categoryListMapper.selectOne(wrapper);
        if ((one != null && categoryList.getId() == null) || (one != null && !one.getId().equals(categoryList.getId()))) {
            throw new CustomException(Constants.CODE_COMMON_ERR, "该类别或标识已存在");
        }
        categoryListService.saveOrUpdate(categoryList);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Integer id) {
        categoryListService.removeById(id);
        return Result.success();
    }


    @GetMapping
    public Result<?> findAll() {
        return Result.success(categoryListService.list());
    }


    @GetMapping("/search")
    public Result<?> searchTo(@RequestParam(defaultValue = "") String name,
                              @RequestParam(defaultValue = "") String flag) {
        List<CategoryList> lists = categoryListMapper.findBooks(name, flag);
        return Result.success(lists);
    }


}

