package com.sqn.library.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * <p>
 *
 * </p>
 *
 * @author shenqn
 * @since 2023-03-08
 */
@Data
@TableName("target_detail")
@ApiModel(value = "TargetDetail对象", description = "")
public class TargetDetail implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("ID")
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty("所属任务id")
    private Long tId;

    @ApiModelProperty("活动id")
    private Long aId;

    @ApiModelProperty("计划活动时长")
    private Integer duration;

    @ApiModelProperty("已完成时长")
    private Integer bePrepared;

    @ApiModelProperty("状态：0：未完成，1：已完成")
    private Integer status;


}
