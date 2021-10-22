package com.noriteo.delinori.member.aop;

import lombok.extern.log4j.Log4j2;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Aspect
@Log4j2
@Component//스프링의 빈으로 만들기 위해 적용
public class TimeLogAspect {

    @Before("execution(* com.noriteo.delinori.member.service.*.*(..))")//pointcut 쓰기 위해 사용
    //*: 모든 메소드에 다 걸림
    public void logBefore(JoinPoint joinPoint){
        log.info("logBefore....");

        log.info(joinPoint.getTarget());//실제 객체 출력(BoardServiceImpl)
        log.info(Arrays.toString(joinPoint.getArgs()));//어떤 파라미터가 들어왔는지 알 수 있음
        //(PageRequestDTO에 담긴 기본값이 출력)

       log.info("logBefore....END");
    }

    @AfterReturning("execution(* com.noriteo.delinori.member.service.*.*(..))")//pointcut 쓰기 위해 사용
    //*: 모든 메소드에 다 걸림
    public void logAfter(){
        log.info("logAfter....");
    }

}
