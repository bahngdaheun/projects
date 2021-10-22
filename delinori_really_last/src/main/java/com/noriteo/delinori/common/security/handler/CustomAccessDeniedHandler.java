package com.noriteo.delinori.common.security.handler;

import lombok.extern.log4j.Log4j2;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Log4j2
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest request,
                       HttpServletResponse response,
                       AccessDeniedException accessDeniedException) throws IOException, ServletException {
        log.warn("CustomAccessDeniedHandler...........................");
        log.warn("CustomAccessDeniedHandler...........................");
        log.warn(request.getHeader("Content-Type"));//이 예외가 발생했는데 json에서 발생한건지 알기위해서 content-type을 확인해본다.
        log.warn("CustomAccessDeniedHandler...........................");
        log.warn("CustomAccessDeniedHandler...........................");
    }
}
