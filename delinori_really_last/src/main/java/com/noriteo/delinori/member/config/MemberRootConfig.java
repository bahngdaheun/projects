package com.noriteo.delinori.member.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@MapperScan(basePackages = "com.noriteo.delinori.member.mapper")
@ComponentScan(basePackages = "com.noriteo.delinori.member.service")
//@Import(MemberAOPConfig.class)
public class MemberRootConfig {
}
