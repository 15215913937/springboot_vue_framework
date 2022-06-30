package com.sqn.library.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Event;
import com.sqn.library.mapper.EventMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/event")
public class EventController {
    @Resource
    EventMapper eventMapper;

    //事件新增接口
    @PostMapping
    public Result<?> save(@RequestBody Event event) {
        eventMapper.insert(event);
        return Result.success();
    }

    //事件修改接口
    @PutMapping
    public Result<?> update(@RequestBody Event event) {
        eventMapper.updateById(event);
        return Result.success();
    }

    //事件删除接口
    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        eventMapper.deleteById(id);
        return Result.success();
    }

    //事件查询接口
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String title,
                              @RequestParam(defaultValue = "") String author,
                              @RequestParam(defaultValue = "") String createTime) {
        LambdaQueryWrapper<Event> wrapper = Wrappers.<Event>lambdaQuery();
        if (StrUtil.isNotBlank(title)||StrUtil.isNotBlank(author)||StrUtil.isNotBlank(createTime)) {
            wrapper.like(Event::getTitle, title).like(Event::getAuthor,author).like(Event::getCreateTime,createTime);
        }
        Page<Event> eventPage = eventMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(eventPage);
    }
}
