package com.sqn.library.utils;

import com.sqn.library.common.Result;
import com.sqn.library.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.Constants;

import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.regex.Pattern;

import static com.sqn.library.common.Constants.CODE_INTERNAL_ERR;

@Slf4j
public class TimeUtil {

    /**
     * yyyy-MM-dd HH:mm:ss
     */
    private static final String FORMAT_STRAND = "yyyy-MM-dd HH:mm:ss";
    private static final Pattern REG_STRAND = Pattern.compile("^[1-9]\\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])\\s+(20|21|22|23|[0-1]\\d):[0-5]\\d:[0-5]\\d$");

    /**
     * yyyy-M-d HH:mm:ss
     */
    private static final String FORMAT_STRAND_SIMPLE = "yyyy-M-d HH:mm:ss";
    private static final Pattern REG_STRAND_SIMPLE = Pattern.compile("^[1-9]\\d{3}-([1-9]|1[0-2])-([1-9]|[1-2][0-9]|3[0-1])\\s+(20|21|22|23|[0-1]\\d):[0-5]\\d:[0-5]\\d$");


    /**
     * yyyy/MM/dd HH:mm:ss
     */
    private static final String FORMAT_SLASH = "yyyy/MM/dd HH:mm:ss";
    private static final Pattern REG_SLASH = Pattern.compile("^[1-9]\\d{3}/(0[1-9]|1[0-2])/(0[1-9]|[1-2][0-9]|3[0-1])\\s+(20|21|22|23|[0-1]\\d):[0-5]\\d:[0-5]\\d$");

    /**
     * yyyy/M/d HH:mm:ss
     */
    private static final String FORMAT_SLASH_SIMPLE = "yyyy/M/d HH:mm:ss";
    private static final Pattern REG_SLASH_SIMPLE = Pattern.compile("^[1-9]\\d{3}/([1-9]|1[0-2])/([1-9]|[1-2][0-9]|3[0-1])\\s+(20|21|22|23|[0-1]\\d):[0-5]\\d:[0-5]\\d$");

    /**
     * yyyy/MM/dd HH:mm
     */
    private static final String FORMAT_SLASH_NOT_SECOND = "yyyy/MM/dd HH:mm";
    private static final Pattern REG_SLASH_NOT_SECOND = Pattern.compile("^[1-9]\\d{3}/(0[1-9]|1[0-2])/(0[1-9]|[1-2][0-9]|3[0-1])\\s+(20|21|22|23|[0-1]\\d):[0-5]\\d$");

    /**
     * yyyy/M/d HH:mm
     */
    private static final String FORMAT_SLASH_NOT_SECOND_SIMPLE = "yyyy/M/d HH:mm";
    private static final Pattern REG_SLASH_NOT_SECOND_SIMPLE = Pattern.compile("^[1-9]\\d{3}/([1-9]|1[0-2])/([1-9]|[1-2][0-9]|3[0-1])\\s+(20|21|22|23|[0-1]\\d):[0-5]\\d$");


    public static int getNow() {
        long currentTimeMillis = System.currentTimeMillis();
        return (int) (currentTimeMillis / 1000);
    }

    public static int toTimestamp(String time) {
        LocalDateTime dateTime = LocalDateTime.parse(time, DateTimeFormatter.ofPattern(getFormat(time)));
        long epochSecond = dateTime.toEpochSecond(ZoneOffset.of("+8"));
        return (int) epochSecond;
    }

    public static String formatTimestamp(Integer timestamp, String format) {
        LocalDateTime time = LocalDateTime.ofEpochSecond(timestamp, 0, ZoneOffset.of("+8"));
        return time.format(DateTimeFormatter.ofPattern(format));
    }

    private static String getFormat(String timeString) {
        if (REG_STRAND.matcher(timeString).matches()) {
            return FORMAT_STRAND;
        } else if (REG_STRAND_SIMPLE.matcher(timeString).matches()) {
            return FORMAT_STRAND_SIMPLE;
        } else if (REG_SLASH.matcher(timeString).matches()) {
            return FORMAT_SLASH;
        } else if (REG_SLASH_SIMPLE.matcher(timeString).matches()) {
            return FORMAT_SLASH_SIMPLE;
        } else if (REG_SLASH_NOT_SECOND.matcher(timeString).matches()) {
            return FORMAT_SLASH_NOT_SECOND;
        } else if (REG_SLASH_NOT_SECOND_SIMPLE.matcher(timeString).matches()) {
            return FORMAT_SLASH_NOT_SECOND_SIMPLE;
        }
        log.error("没找到合适的时间格式：{}", timeString);
        throw new CustomException(CODE_INTERNAL_ERR, "没有合适的时间格式");
    }

    /**
     * 获取时分秒时间点
     *
     * @param time
     * @return 返回数值 hmmss 如 2021-08-26 16:17:23 >>> 161723
     */
    public static int toTimePointFormat(String time) {
        String[] point = time.split(":");
        return Integer.parseInt(point[0]) * 10000 + Integer.parseInt(point[1]) * 100 + Integer.parseInt(point[2]);
    }

    public static int toTimePoint(String time) {
        LocalDateTime dateTime = LocalDateTime.parse(time, DateTimeFormatter.ofPattern(getFormat(time)));
        String format = dateTime.format(DateTimeFormatter.ofPattern("HH:mm:ss"));
        String[] point = format.split(":");
        return Integer.parseInt(point[0]) * 10000 + Integer.parseInt(point[1]) * 100 + Integer.parseInt(point[2]);
    }
}
