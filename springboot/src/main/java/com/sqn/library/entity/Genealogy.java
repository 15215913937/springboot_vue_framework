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
import java.util.List;

/**
 * <p>
 * 家谱
 * </p>
 *
 * @author shenqn
 * @since 2023-07-19
 */
@Data
@TableName("genealogy")
@ApiModel(value = "Genealogy对象", description = "家谱")
public class Genealogy implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty("姓名")
    private String name;

    @ApiModelProperty("绑定账户")
    private Long userId;

    @ApiModelProperty("父亲")
    private Long fatherId;

    @ApiModelProperty("母亲")
    private Long motherId;

    @ApiModelProperty("儿子")
    private Long sonId;

    @ApiModelProperty("女儿")
    private Long daughterId;

    @ApiModelProperty("妻子")
    private Long wifeId;

    @ApiModelProperty("丈夫")
    private Long husbandId;

    @ApiModelProperty("兄妹")
    private Long broSisId;

    @ApiModelProperty("直系亲属")
    private Long isImmediateFamily;

    @ApiModelProperty("状态")
    private Integer status;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ApiModelProperty("创建时间")
    private Date createTime;

    @TableField(exist = false)
    private List<Genealogy> children;


}
