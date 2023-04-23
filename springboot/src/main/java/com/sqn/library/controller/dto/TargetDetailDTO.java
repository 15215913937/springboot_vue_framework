package com.sqn.library.controller.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

/**
 * @author sqn
 */
@Data
public class TargetDetailDTO {
    private Long id;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    private ArrayList<HashMap<String, String>> targetDetails;
}
