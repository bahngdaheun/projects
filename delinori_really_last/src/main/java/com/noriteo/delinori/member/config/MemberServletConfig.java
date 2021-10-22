package com.noriteo.delinori.member.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableWebMvc
@ComponentScan(basePackages = "com.noriteo.delinori.member.controller")
public class MemberServletConfig implements WebMvcConfigurer {
}
