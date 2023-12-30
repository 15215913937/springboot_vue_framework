package com.sqn.library.controller;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.sqn.library.entity.Book;
import com.sqn.library.mapper.BookMapper;
import com.sqn.library.utils.GetApiTokenUtil;
import com.sqn.library.utils.ImgErToFileUtil;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * @author sqn
 */
@RestController
@RequestMapping("/test")
public class TestController {
    @Resource
    StringRedisTemplate stringRedisTemplate;
    @Resource
    BookMapper bookMapper;
    @Resource
    GetApiTokenUtil apiTokenUtil;

    @GetMapping("/{id}")
    public Boolean get(@PathVariable Long id) {
        final List<Book> list = bookMapper.selectList(Wrappers.emptyWrapper());
        stringRedisTemplate.opsForValue().set("book", JSONUtil.toJsonStr(list), 10, TimeUnit.SECONDS);
        return true;
    }

    @PostMapping("/ImgErToFile")
    public int imgErToFile(@RequestBody String imgStr, String imgPath, String imgName) {
        return ImgErToFileUtil.saveToImgByStr(imgStr, imgPath, imgName);
    }

    @GetMapping("/testApiToken")
    public String testApiToken(){
        return apiTokenUtil.getMettressToken();
    }
}
