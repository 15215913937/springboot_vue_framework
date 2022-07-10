package com.sqn.library.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.w3c.dom.ls.LSInput;

import java.util.Date;
import java.util.List;

@TableName("user")
@Data
public class User {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String username;
    private String password;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date birthday;
    private String name;
    private String sex;
    private String avatar;
    private Integer role;
    @TableField(exist = false)
    private String token;

    @TableField(exist = false)
    private List<Book> bookList;
}
