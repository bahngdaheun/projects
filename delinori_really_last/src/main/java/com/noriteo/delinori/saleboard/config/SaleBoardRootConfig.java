package com.noriteo.delinori.saleboard.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@MapperScan(basePackages = "com.noriteo.delinori.saleboard.mapper")
@ComponentScan(basePackages = "com.noriteo.delinori.saleboard.service")
@Import(SaleBoardAOPConfig.class)
public class SaleBoardRootConfig {
}
