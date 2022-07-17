package com.sqn.library.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @Author shenqn
 * @Date 2022/7/17  22:40
 */
@TableName("dict")
@Data
public class Dict {

    private String name;
    private String value;
    private String type;
}
