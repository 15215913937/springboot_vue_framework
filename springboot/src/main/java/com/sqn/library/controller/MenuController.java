package com.sqn.library.controller;


import cn.hutool.core.lang.TypeReference;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.DictMapper;
import com.sqn.library.mapper.MenuMapper;
import com.sqn.library.utils.RedisUtils;
import io.swagger.annotations.Api;
import org.springframework.data.redis.core.StringRedisTemplate;
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
    StringRedisTemplate stringRedisTemplate;
    @Resource
    MenuMapper menuMapper;

    // 新增或者更新
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
        flushRedis(Constants.MENUS_KEY);
        return Result.success();

    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Integer id) {
        menuService.removeById(id);
        flushRedis(Constants.MENUS_KEY);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        menuService.removeByIds(ids);
        flushRedis(Constants.MENUS_KEY);
        return Result.success();
    }

    @GetMapping
    public Result<?> findAll(@RequestParam(defaultValue = "") String name) {
//        1、从缓存中获取数据,返回的是一个json
        String jsonStr = stringRedisTemplate.opsForValue().get(Constants.MENUS_KEY);
        List<Menu> menus;
        if (StrUtil.isBlank(jsonStr)) { //如果jsonStr是空的
            menus = menuService.findMenus(name);
            //再去缓存到redis
            stringRedisTemplate.opsForValue().set(Constants.MENUS_KEY, JSONUtil.toJsonStr(menus));
        } else {
            //从redis缓存中获取数据
//            通过TypeReference将jsonStr转化为任意一种class泛型
            menus = JSONUtil.toBean(jsonStr, new TypeReference<List<Menu>>() {
            }, true);
        }

        return Result.success(menus);
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Integer id) {
        return Result.success(menuService.getById(id));
    }

    @GetMapping("/page")
    public Result<?> findPage(@RequestParam(defaultValue = "") String name,
                              @RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize) {
        QueryWrapper<Menu> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("name", name);
        queryWrapper.orderByDesc("id");
        return Result.success(menuService.page(new Page<>(pageNum, pageSize), queryWrapper));
    }

    @GetMapping("/icons")
    public Result<?> getIcons() {
        QueryWrapper<Object> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("type", Constants.DICT_TYPE_ICON);
        return Result.success(dictMapper.selectList(null));
    }

    //查询出menu表中所有菜单id
    @GetMapping("/ids")
    public Result<?> findAllIds() {
        return Result.success(menuService.list().stream().map(Menu::getId));
    }

    //清空缓存
    public void flushRedis(String key) {
        stringRedisTemplate.delete(key);
    }
}

