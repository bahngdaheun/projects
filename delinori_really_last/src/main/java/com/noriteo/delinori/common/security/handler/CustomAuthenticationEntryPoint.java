package com.noriteo.delinori.common.security.handler;

import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Log4j2
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {

    @Override
    public void commence(HttpServletRequest req, HttpServletResponse res, AuthenticationException authException) throws IOException, ServletException {
        //AuthenticationException : 인증에러

        log.error("------------------CustomAuthenticationEntryPoint-----------------");
        log.error("------------------CustomAuthenticationEntryPoint-----------------");
        log.error(authException);
        log.error("------------------CustomAuthenticationEntryPoint-----------------");
        log.error("------------------CustomAuthenticationEntryPoint-----------------");

        //JSON으로 들어올 때는 null이 아니다
        //JSON으로 안들어가면 JSON으로 바꿔서 보내준다.
        if(req.getContentType() != null && req.getContentType().contains("json")){
            res.setContentType("application/json;charset=UTF-8");
            res.setStatus(403);
            res.getWriter().write("{\'msg\':\'REST API ERROR\'}");
        }else {

            //일반적인 상황에서는 이쪽으로 리다이렉트를 시킨다.
            res.sendRedirect("/customLogin?delinori");
        }



    }
}