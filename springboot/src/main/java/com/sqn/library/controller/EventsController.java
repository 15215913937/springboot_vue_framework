package com.sqn.library.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Events;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.EventsMapper;
import com.sqn.library.service.IEventsService;
import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ConcurrentModificationException;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/events")
@Api(tags = "事件管理")
public class EventsController {

    @Resource
    EventsMapper eventsMapper;
    @Resource
    IEventsService eventsService;

    //事件新增或修改接口
    @PostMapping()
    public Result<?> save(@RequestBody Events events) {
        if (StrUtil.isBlank(events.getTitle()) || StrUtil.isBlank(events.getContent())) {
            throw new CustomException(Constants.CODE_COMMON_ERR, "必填项不能为空！");
        }
        events.setCreateTime(new Date());
        eventsService.saveOrUpdate(events);
        return Result.success();
    }
    //事件新增接口
//    @PostMapping
//    public Result<?> save(@RequestBody Events events) {
//        events.setCreateTime(new Date());
//        eventsMapper.insert(events);
//        return Result.success();
//    }
//
//    //事件修改接口
//    @PutMapping
//    public Result<?> update(@RequestBody Events events) {
//        eventsMapper.updateById(events);
//        return Result.success();
//    }

    //事件删除接口
    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        eventsMapper.deleteById(id);
        return Result.success();
    }

    //事件查询接口
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String title,
                              @RequestParam(defaultValue = "") String author
    ) {
        LambdaQueryWrapper<Events> wrapper = Wrappers.<Events>lambdaQuery();
        if (StrUtil.isNotBlank(title) || StrUtil.isNotBlank(author)) {
            wrapper.like(Events::getTitle, title).like(Events::getAuthor, author);
        }
        Page<Events> eventsPage = eventsMapper.selectPage(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(eventsPage);
    }

    //事件批量删除
    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        eventsMapper.deleteBatchIds(ids);
        return Result.success();
    }
}
