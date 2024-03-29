package com.sqn.library.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.sqn.library.common.Constants;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.DictMapper;
import com.sqn.library.mapper.MenuMapper;
import com.sqn.library.utils.RedisUtils;
import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sqn.library.common.Result;


import com.sqn.library.service.IMenuService;
import com.sqn.library.entity.Menu;

import org.springframework.web.bind.annotation.RestController;


/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author shenqn
 * @since 2022-07-17
 */
@RestController
@RequestMapping("/menu")
@Api(tags = {"菜单管理"})
public class MenuController {

    @Resource
    private IMenuService menuService;

    @Resource
    DictMapper dictMapper;

    @Resource
    MenuMapper menuMapper;
    @Resource
    RedisUtils redisUtils;

    /** 新增或者更新
     *
     * @param menu
     * @return
     */
    @PostMapping
    public Result<?> save(@RequestBody Menu menu) {
        Menu res = menuMapper.selectOne(Wrappers.<Menu>lambdaQuery().eq(Menu::getName, menu.getName()));
        if ((res != null && menu.getId() == null) || (res != null && !res.getId().equals(menu.getId()))) {
            throw new CustomException(Constants.CODE_COMMON_ERR, "该菜单名称已存在");
        }
        if (StrUtil.isBlank(menu.getPath()) && StrUtil.isBlank(menu.getPagePath())) {
            throw new CustomException(Constants.CODE_COMMON_ERR, "页面路径未填写");
        }
        menuService.saveOrUpdate(menu);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Integer id) {
        menuService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        menuService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result<?> findAll(@RequestParam(defaultValue = "") String name) {
//        1、从缓存中获取数据,返回的是一个json
//        String jsonStr = stringRedisTemplate.opsForValue().get(Constants.MENUS_KEY);
//        List<Menu> menus;
//        if (StrUtil.isBlank(jsonStr)) { //如果jsonStr是空的
//            menus = menuService.findMenus(name);
//            //再去缓存到redis
//            stringRedisTemplate.opsForValue().set(Constants.MENUS_KEY, JSONUtil.toJsonStr(menus));
//        } else {
//            //从redis缓存中获取数据
//            //通过TypeReference将jsonStr转化为任意一种class泛型
//            menus = JSONUtil.toBean(jsonStr, new TypeReference<List<Menu>>() {
//            }, true);
//        }
        List<Menu> menus = menuService.findAllMenus(name);
        return Result.success(menus);
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Integer id) {
        return Result.success(menuService.getById(id));
    }


    @GetMapping("/icons")
    public Result<?> getIcons() {
        QueryWrapper<Object> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("type", Constants.DICT_TYPE_ICON);
        return Result.success(dictMapper.selectList(null));
    }

    /**
     * 查询出menu表中所有菜单id
     */
    @GetMapping("/ids")
    public Result<?> findAllIds() {
        return Result.success(menuService.list().stream().map(Menu::getId));
    }

}

