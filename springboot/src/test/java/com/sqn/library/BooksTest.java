package com.sqn.library;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.ResultMatcher;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.ContentResultMatchers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.result.StatusResultMatchers;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Author shenqn
 * @Date 2022/9/4  17:06
 */
//配置随机端环境
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
//开启虚拟MVC调用
@AutoConfigureMockMvc
//纳入spring事务管理
@Transactional
public class BooksTest {
    @Test
//    注入虚拟MVC调用对象
    void getBooks(@Autowired MockMvc mvc) throws Exception {
        //创建虚拟请求
        MockHttpServletRequestBuilder builder = MockMvcRequestBuilders.get("/book");
//        执行请求
        ResultActions action = mvc.perform(builder);
//        设置预期值，与实际值进行比较，成功测试通过，失败测试失败
//        定义本次调用的预期值status,状态匹配
        StatusResultMatchers status = MockMvcResultMatchers.status();
//        预期本次调用成功的状态200
        ResultMatcher ok = status.isOk();
//        添加预期值到本次调用过程中进行匹配
        action.andExpect(ok);

    }
}
