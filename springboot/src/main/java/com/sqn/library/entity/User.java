package com.sqn.library.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Pattern;
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
    private String role;
    private String openId;
    private Float balance;
    @Length(min = 11, max = 11, message = "手机号只能是11位")
    @Pattern(regexp = "^[1][3,4,5,6,7,8,9][0-9]{9}$", message = "手机号格式有误")
    private String phone;
    @TableField(exist = false)
    private String token;

    @TableField(exist = false)
    private List<Book> bookList;

    @TableField(exist = false)
    private List<Menu> menus;

}
