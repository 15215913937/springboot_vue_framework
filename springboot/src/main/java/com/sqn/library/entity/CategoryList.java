package com.sqn.library.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * <p>
 *
 * </p>
 *
 * @author shenqn
 * @since 2022-08-23
 */
@Data
@TableName("category_list")
@ApiModel(value = "CategoryList对象", description = "")
public class CategoryList implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("ID")
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty("书籍类别")
    private String name;

    @ApiModelProperty("唯一标识")
    private String flag;

    @TableField(exist = false)
    private List<Book> cBookList;


}
