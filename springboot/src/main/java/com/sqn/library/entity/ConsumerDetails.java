package com.sqn.library.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * <p>
 * 
 * </p>
 *
 * @author shenqn
 * @since 2022-08-30
 */
@Data
@TableName("consumer_details")
@ApiModel(value = "ConsumerDetails对象", description = "")
public class ConsumerDetails implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("ID")
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("用户ID")
    private Integer uid;

    @ApiModelProperty("金额")
    private Double cost;

    @ApiModelProperty("消费类型")
    private String type;

    @ApiModelProperty("备注")
    private String comment;

    @ApiModelProperty("消费类别")
    private String category;

    @ApiModelProperty("创建时间")
    private Timestamp createtime;


}
