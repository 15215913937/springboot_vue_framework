package com.sqn.library.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.ArrayList;
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
 * @since 2023-02-23
 */
@Data
@TableName("health")
@ApiModel(value = "Health对象", description = "")
public class Health implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("Id")
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty("用户id")
    private Long uid;

    @ApiModelProperty("身高")
    private Integer height;

    @ApiModelProperty("体重")
    private Integer weight;

    @ApiModelProperty("胸围")
    private Integer bust;

    @ApiModelProperty("腰围")
    private Integer waistline;

    @ApiModelProperty("臀围")
    private Integer hipline;

    @ApiModelProperty("肩围")
    private Integer shoulderWide;

    @ApiModelProperty("活动标签集")
    private String activities;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ApiModelProperty("创建日期")
    private Date createTime;

    @ApiModelProperty("是否删除；0：未删除，1：已删除")
    private Boolean isDelete;

    // 运动集
    @TableField(exist = false)
    private ArrayList<String> activityMarks;


}
