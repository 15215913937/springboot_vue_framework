package com.sqn.library.service;

import com.sqn.library.entity.Comment;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author shenqn
 * @since 2023-02-20
 */
public interface ICommentService extends IService<Comment> {

    boolean rmById(Long cId);
}
