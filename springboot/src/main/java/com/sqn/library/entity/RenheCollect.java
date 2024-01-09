package com.sqn.library.entity;

import com.baomidou.mybatisplus.annotation.IdType;
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
 * @since 2023-12-16
 */
@Data
@TableName("renhe_collect")
@ApiModel(value = "RenheCollect对象", description = "韧和传感器数据采集")
public class RenheCollect implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty("垫子编码关键位")
    private String code;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ApiModelProperty("创建日期")
    private Date createTime;

    @ApiModelProperty("压力")
    private String pressure;

    @ApiModelProperty("使用床垫")
    private String bedId;

    @ApiModelProperty("垫子类型：stand;plus;pro")
    private String mat;

    @ApiModelProperty("批次")
    private String batch;

    @ApiModelProperty("首次压力值")
    private Long firstPressure;

    @ApiModelProperty("最终总和（前45个最大压力值总和）")
    private Long finalPressure;

    @ApiModelProperty("系数：1；1.5")
    private Float coefficient;

    @ApiModelProperty("状态；默认未审核过0，合格1，不合格2")
    private Integer status;

    @ApiModelProperty("备注")
    private String remarks;
    @ApiModelProperty("IDLE 无人 SIT坐姿  SUPINE睡姿")
    private String position;


}
