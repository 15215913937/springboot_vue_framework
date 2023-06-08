package com.sqn.library.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Events;
import com.sqn.library.entity.User;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.EventsMapper;
import com.sqn.library.service.IEventsService;
import com.sqn.library.utils.TokenUtils;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

/**
 * @author sqn
 */
@RestController
@RequestMapping("/events")
@Api(tags = "事件管理")
@Slf4j
public class EventsController {

    @Resource
    EventsMapper eventsMapper;
    @Resource
    IEventsService eventsService;

    /**
     * 事件新增或修改接口
     *
     * @param events
     * @return
     */
    @PostMapping
    public Result<?> save(@RequestBody Events events) {
        if (StrUtil.isBlank(events.getTitle()) || StrUtil.isBlank(events.getContent())) {
            log.error("必填项不能为空！");
            throw new CustomException(Constants.CODE_COMMON_ERR, "必填项不能为空！");
        }
        User user = TokenUtils.getUser();
        if (user == null) {
            log.info("用户不存在！");
        }
        assert user != null;
        events.setAuthor((user.getId()));
        eventsService.saveOrUpdate(events);
        return Result.success();
    }

    /**
     * 事件删除接口
     *
     * @param id
     * @return
     */
    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        eventsMapper.deleteById(id);
        return Result.success();
    }

    /**
     * 事件查询接口
     *
     * @param pageNum
     * @param pageSize
     * @param title
     * @param author
     * @param startTime
     * @param endTime
     * @return
     */
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String title,
                              @RequestParam(defaultValue = "") Long author,
                              @RequestParam(defaultValue = "") String startTime,
                              @RequestParam(defaultValue = "") String endTime
    ) {
        Page<Events> eventsPage = eventsMapper.findPage(new Page<>(pageNum, pageSize), title, author, startTime,
                endTime);
        return Result.success(eventsPage);
    }

    @GetMapping("/{id}")
    public Result<?> findOneEvent(@PathVariable Long id) {
        Events event = eventsService.queryById(id);
        return Result.success(event);
    }

    /**
     * 事件批量删除
     *
     * @param ids
     * @return
     */
    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Long> ids) {
        eventsMapper.deleteBatchIds(ids);
        return Result.success();
    }

    /**
     * 点击查看计数
     *
     * @param id
     * @return
     */
    @PostMapping("/{id}")
    public Result<?> addCount(@PathVariable Long id) {
        log.info("阅读eventId={}数量+1", id);
        eventsMapper.updateViewCount(id);
        return Result.success();
    }

    @GetMapping("/authorList")
    public Result<Object> getAuthorList() {
        List<HashMap<Long, String>> list = eventsMapper.getAuthor();
        return Result.success(list);
    }

}
