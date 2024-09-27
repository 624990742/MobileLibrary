package com.example.mobilelibraryjava.filter;

import jakarta.servlet.Filter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.example.mobilelibraryjava.filter.EncodingFilter;

@Configuration
public class FilterConfig {    // Change 'interface' to 'class'

    @Bean
    public FilterRegistrationBean encodingFilter() {
        FilterRegistrationBean registrationBean = new FilterRegistrationBean<>();

        // 1. 实例化 EncodingFilter 类（假设已存在）
        EncodingFilter encodingFilter = new EncodingFilter();

        // 2. 设置过滤器实例
        registrationBean.setFilter(encodingFilter);

        // 3. 设置 URL 模式
        registrationBean.addUrlPatterns("/*");

        // 4. 设置过滤器名称
        registrationBean.setName("EncodingFilter");

        // 5. 添加初始化参数（注意参数名和值的修正）
        registrationBean.addInitParameter("charSet", "UTF-8");

        return registrationBean;
    }
}