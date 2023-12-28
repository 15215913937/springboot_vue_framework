package com.sqn.library.controller.dto;

import lombok.Data;

import java.util.List;

/**
 * @author sqn
 */
@Data
public class RenheCollectDTO {
    private String bedId;

    private String code;

    private String mat;

    private String batch;

    private Float coefficient;

    private Long firstPressure;

    private Long finalPressure;

    private List<String> pressure;

}
