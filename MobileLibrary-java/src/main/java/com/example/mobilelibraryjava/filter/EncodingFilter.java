package com.example.mobilelibraryjava.filter;

import jakarta.servlet.*;
import java.io.IOException;

/**
 * @author yangcq
 * @description 过滤器Filter的工作原理
 */
public class EncodingFilter implements jakarta.servlet.Filter {

    @Override
    public void init(jakarta.servlet.FilterConfig filterConfig) throws jakarta.servlet.ServletException {
        System.out.println("----Filter初始化----");
    }

    @Override
    public void doFilter(jakarta.servlet.ServletRequest servletRequest, jakarta.servlet.ServletResponse servletResponse, jakarta.servlet.FilterChain filterChain) throws IOException, jakarta.servlet.ServletException {
        // 对request、response进行一些预处理
        servletRequest.setCharacterEncoding("UTF-8");
        servletResponse.setCharacterEncoding("UTF-8");
        servletResponse.setContentType("text/html;charset=UTF-8");
        System.out.println("----调用service之前执行一段代码----");
        filterChain.doFilter(servletRequest, servletResponse); // 执行目标资源，放行
        System.out.println("----调用service之后执行一段代码----");
    }

    @Override
    public void destroy() {
        System.out.println("----Filter销毁----");
    }
}