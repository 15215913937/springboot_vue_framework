package com.sqn.library.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sqn.library.entity.Comment;
import com.sqn.library.mapper.CommentMapper;
import com.sqn.library.service.ICommentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author shenqn
 * @since 2023-02-20
 */
@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {

    @Resource
    CommentMapper commentMapper;

    @Override
    public boolean rmById(Long cId) {
        final Date date = new Date();
        final Timestamp time = new Timestamp(date.getTime());
        LambdaQueryWrapper<Comment> wrapper = new LambdaQueryWrapper<>();
        List<Comment> comments = commentMapper.selectList(wrapper.eq(Comment::getId, cId).or().eq(Comment::getParentId, cId));
        for (Comment comment : comments) {
            comment.setDelTime(time);
            comment.setIsDelete(true);
            commentMapper.updateById(comment);
        }
        return true;
    }
}
