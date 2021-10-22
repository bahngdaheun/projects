package com.noriteo.delinori.qna.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan(basePackages = "com.noriteo.delinori.qna.mapper")
@ComponentScan(basePackages = "com.noriteo.delinori.qna.service")
//@Import(QnaAOPConfig.class)
public class QnaRootConfig {
}
