package com.noriteo.delinori.board.config;


import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan(basePackages = "com.noriteo.delinori.board.mapper" )
@ComponentScan(basePackages = "com.noriteo.delinori.board.service")
public class BoardRootConfig {
}
