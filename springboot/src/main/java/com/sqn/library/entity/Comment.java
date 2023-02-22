package com.sqn.library.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * <p>
 *
 * </p>
 *
 * @author shenqn
 * @since 2023-02-20
 */
@Data
@TableName("comment")
@ApiModel(value = "Comment对象", description = "事件评论")
public class Comment implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("评论id")
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty("评论内容")
    private String content;

    @ApiModelProperty("评论人id")
    private Integer userId;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty("创建时间")
    private Date createTime;

    @ApiModelProperty("是否删除0：未删除；1：删除")
    private Integer isDelete;

    @ApiModelProperty("所属事件id")
    private Integer eventId;

    @ApiModelProperty("父评论id")
    private Integer parentId;

    @ApiModelProperty("根评论id")
    private Integer rootParentId;

    // 评论下的子评论集
    @TableField(exist = false)
    private List<Comment> childList;

    // 评论人用户名
    @TableField(exist = false)
    private String username;


}
