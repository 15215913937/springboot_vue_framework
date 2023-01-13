package com.sqn.library.utils;

import org.springframework.stereotype.Component;

import java.text.DecimalFormat;

/**
 * @author sqn
 */
@Component
public class ConsumeCalculate {
    public String ratioYearOnYear(Double currentExpense, Double lastExpense) {
        final DecimalFormat df = new DecimalFormat("#.00%");
        double result = 0;
        if (currentExpense != null && lastExpense != null) {
            if (lastExpense != 0d) {
                result = (Math.abs(currentExpense - lastExpense) / lastExpense);
            }
            String toResult = df.format(result);
            if (lastExpense == 0 || currentExpense - lastExpense == 0) {
                toResult = "0" + toResult;
            } else if (currentExpense - lastExpense > 0) {
                toResult = "↑" + toResult;
            } else if (currentExpense - lastExpense < 0) {
                toResult = "↓" + toResult;
            }
            return toResult;
        }else{
            return "0.00%";
        }
    }

    public static void main(String[] args) {
        final ConsumeCalculate calculate = new ConsumeCalculate();
        final String s = calculate.ratioYearOnYear(null, 110d);
        System.out.println(s);
    }
}
