package com.sqn.library.controller.dto;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.sqn.library.entity.Book;
import com.sqn.library.entity.Menu;
import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Pattern;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Data
public class UserVo {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String username;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date birthday;
    private String name;
    private String sex;
    private String avatar;
    private Long role;
    private String openId;
    private Date createTime;
    private Timestamp recentLogin;
    private Integer isDelete;
    private Integer status;
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
