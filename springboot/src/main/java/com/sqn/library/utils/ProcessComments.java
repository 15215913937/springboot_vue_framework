package com.sqn.library.utils;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sqn.library.entity.Comment;
import com.sqn.library.entity.User;
import com.sqn.library.mapper.UserMapper;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @author sqn
 */
@Component
public class ProcessComments {
    @Resource
    UserMapper userMapper;

    public List<Comment> processComments(List<Comment> list) {

        HashMap<Long, Comment> map = new HashMap<>();
        List<Comment> result = new ArrayList<>();

        for (Comment comment : list) {
            LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
            User user = userMapper.selectOne(wrapper.eq(User::getId, comment.getUserId()));
            if (user == null) {
                break;
            }
            comment.setUsername(user.getUsername());
            comment.setAvatar(user.getAvatar());
        }
        //将所有父评论加入map
        for (Comment comment : list) {
            if (comment.getParentId() == null) {
                result.add(comment);
            }
            map.put(comment.getId(), comment);
        }

        //子评论加入到父评论的child中
        for (Comment comment : list) {
            Integer id = comment.getParentId();
            if (id != null) {
                Comment p = map.get((long) id);
                if (p.getChildList() == null) {
                    p.setChildList(new ArrayList<>());
                }
                p.getChildList().add(comment);
            }
        }
        return result;
    }
}
