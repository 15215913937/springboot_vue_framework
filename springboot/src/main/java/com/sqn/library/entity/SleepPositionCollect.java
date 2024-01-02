package com.sqn.library.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 *
 * </p>
 *
 * @author shenqn
 * @since 2023-12-30
 */
@Data
@TableName("sleep_position_collect")
@ApiModel(value = "SleepPositionCollect对象", description = "")
public class SleepPositionCollect implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty("user_info的id值")
    private Long userInfoId;

    @TableField(exist = false)
    private String name;

    @ApiModelProperty("床垫id")
    private String bedId;

    @ApiModelProperty("舒适层:1stand 2plus 3pro")
    private Byte mat;

    @ApiModelProperty("是否启用自动模式0关1开")
    private Boolean isAutomode;

    @ApiModelProperty("是否启用微调0关1开")
    private Boolean isFineAdjustment;

    @ApiModelProperty("测试项目：1、正中识别2、1/3身体在传感器外")
    private Byte project;

    @ApiModelProperty("检测周期，单位秒")
    private Integer period;

    @ApiModelProperty("睡姿识别：0无人1仰卧2侧卧3坐姿")
    private Byte recognition;

    @ApiModelProperty("实际睡姿")
    private Byte actualSleepPosition;

    @ApiModelProperty("识别是否成功：0失败1成功")
    private Byte isReg;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ApiModelProperty("创建时间")
    private Date createTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ApiModelProperty("开始时间")
    private Date startTime;
}
