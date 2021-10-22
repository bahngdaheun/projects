package com.noriteo.delinori.qna.aop;

import lombok.extern.log4j.Log4j2;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Aspect
@Log4j2
@Component
public class QnaLogAspect {
    @Before("execution(* com.noriteo.delinori.qna.service.*.*(..))")

    public void logBefore(JoinPoint joinPoint){
        log.info("logBefore................");

        log.info(joinPoint.getTarget());//실제 객체
        log.info(Arrays.toString(joinPoint.getArgs()));

        log.info("logBefore...............END");
    }

    @AfterReturning("execution(* com.noriteo.delinori.qna.service.*.*(..))") // 이 기능을 누구랑 합칠겨나를 말해주는 것 : pointcut 설정
    public void logAfter(){
        log.info("logAfter................");
    }
}
