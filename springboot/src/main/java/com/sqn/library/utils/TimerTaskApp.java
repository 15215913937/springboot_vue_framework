package com.sqn.library.utils;

import java.util.Timer;
import java.util.TimerTask;

/**
 * @Author shenqn
 * @Date 2022/9/8  22:44
 */
public class TimerTaskApp {
    public static void main(String[] args) {
        Timer timer = new Timer();
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                System.out.println("running ...");
            }
        };
        //task 新建任务；delay 起始时间 0表示当前开始；period 计时间隔
        timer.schedule(task, 0, 2000);
    }
}
