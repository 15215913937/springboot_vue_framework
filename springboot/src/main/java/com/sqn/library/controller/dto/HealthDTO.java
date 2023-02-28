package com.sqn.library.controller.dto;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.sqn.library.entity.Activity;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
public class HealthDTO {
    private Integer id;

    private Integer uid;

    private Integer height;

    private Integer weight;

    private Integer bust;

    private Integer waistline;

    private Integer hipline;

    private Integer shoulderWide;

    private ArrayList<String> activityMarks;

}
