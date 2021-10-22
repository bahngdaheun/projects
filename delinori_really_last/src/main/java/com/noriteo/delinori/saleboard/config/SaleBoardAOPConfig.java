package com.noriteo.delinori.saleboard.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@Configuration
@EnableAspectJAutoProxy
@ComponentScan("com.noriteo.delinori.saleboard.aop")
public class SaleBoardAOPConfig {
}
