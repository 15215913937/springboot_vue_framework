package com.sqn.library;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 加载类或引导类，是一个容器，是整个程序的入口，用于加载bean
 * 运行后初始化Spring容器，扫描引导类所在包加载bean
 */
@SpringBootApplication
//开启缓存
//@EnableCaching
public class LibraryApplication {
    public static void main(String[] args) {
        SpringApplication.run(LibraryApplication.class, args);
    }
}
