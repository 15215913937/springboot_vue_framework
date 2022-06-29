package com.sqn.library.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@TableName("book")
@Data
public class Book {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String bookname;
    private String author;
    private String category;
    private String version;
    private String publishingHouse;
    private String purchaser;
    private BigDecimal price;
    @JsonFormat(pattern = "yyyy-MM-dd",timezone = "GMT+8")
    private Date buyDate;
    private String comment;
    private String cover;
}
