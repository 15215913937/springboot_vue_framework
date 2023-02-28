package com.sqn.library.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

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
@TableName("target")
@ApiModel(value = "Target对象", description = "")
public class Target implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("id")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("用户id")
    private Integer uid;

    @ApiModelProperty("目标代号")
    private String code;

    @ApiModelProperty("目标描述")
    private String content;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ApiModelProperty("创建时间")
    private Date createTime;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    @ApiModelProperty("开始日期")

    private Date startTime;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    @ApiModelProperty("结束日期")

    private Date endTime;

    @ApiModelProperty("完成状态；0：未开始，1：进行中，2：已完成，3：未完成")
    private Integer status;

    @ApiModelProperty("完成进度")
    private Integer schedule;

    @ApiModelProperty("级别；0：困难，1：正常，2：轻松")
    private Integer level;

    @ApiModelProperty("是否删除；0：未删除，1：已删除")
    private Boolean isDelete;


}
