package com.sqn.library.common;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

/**
 * @Author shenqn
 * @Date 2022/7/23  0:01
 */
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    protected void configure(HttpSecurity http) throws Exception{
        http.authorizeHttpRequests().antMatchers("/**").permitAll()
                .and().csrf().disable();
    }
}
