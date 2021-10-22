package com.noriteo.delinori.qna.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableWebMvc
@ComponentScan(basePackages = "com.noriteo.delinori.qna.controller")
public class QnaServletConfig implements WebMvcConfigurer {
}
