package com.sqn.library.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.mapper.CommentMapper;
import com.sqn.library.utils.ProcessComments;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sqn.library.common.Result;


import com.sqn.library.service.ICommentService;
import com.sqn.library.entity.Comment;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author shenqn
 * @since 2023-02-20
 */
@RestController
@RequestMapping("/comment")
public class CommentController {

    @Resource
    private ICommentService commentService;

    @Resource
    ProcessComments processComments;

    @Resource
    CommentMapper commentMapper;

    /**
     * 新增或者更新
     */
    @PostMapping
    public Result<?> save(@RequestBody Comment comment) {
        commentService.saveOrUpdate(comment);
        return Result.success();
    }

    @DeleteMapping("/{cId}")
    public Result<?> delete(@PathVariable Long cId) {
        if (Boolean.FALSE.equals(commentService.rmById(cId))) {
            return Result.error(Constants.CODE_COMMON_ERR, Constants.CODE_ERROR_MESSAGE);
        }
        return Result.success();

    }

    @GetMapping("/{id}")
    public Result<?> findByEventId(@PathVariable Integer id) {
        LambdaQueryWrapper<Comment> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Comment::getEventId, id).orderByDesc(Comment::getCreateTime);
        final List<Comment> list = commentMapper.selectList(wrapper);
        return Result.success(processComments.processComments(list));
    }
}
