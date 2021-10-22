package com.noriteo.delinori.saleboard.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableWebMvc
@ComponentScan(basePackages = "com.noriteo.delinori.saleboard.controller")
public class SaleBoardServletConfig implements WebMvcConfigurer {
}
