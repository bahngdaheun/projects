package com.noriteo.delinori.notice.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableWebMvc
@ComponentScan(basePackages = "com.noriteo.delinori.notice.controller")
public class NoticeServletConfig implements WebMvcConfigurer {
}
