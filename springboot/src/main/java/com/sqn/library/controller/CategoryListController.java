package com.sqn.library.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.mapper.CategoryListMapper;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sqn.library.common.Result;


import com.sqn.library.service.ICategoryListService;
import com.sqn.library.entity.CategoryList;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
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
        CategoryList res = categoryListMapper.selectById(categoryList.getId());
        categoryListService.saveOrUpdate(categoryList);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Integer id) {
        categoryListService.removeById(id);
        return Result.success();
    }

//    @PostMapping("/deleteBatch")
//    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
//        categoryListService.removeByIds(ids);
//        return Result.success();
//    }

    @GetMapping
    public Result<?> findAll() {
        return Result.success(categoryListService.list());
    }


    @GetMapping("/search")
    public Result<?> searchTo(@RequestParam(defaultValue = "") String name){
        List<CategoryList> lists = categoryListMapper.selectList(Wrappers.<CategoryList>lambdaQuery().like(CategoryList::getName, name));
        return  Result.success(lists);
    }

}

