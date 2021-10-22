package com.noriteo.delinori.common.config;

import com.noriteo.delinori.common.security.config.SecurityConfig;
import com.noriteo.delinori.common.security.config.SecurityServletConfig;
import lombok.extern.log4j.Log4j2;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration;

@Log4j2
public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override
    protected Class<?>[] getRootConfigClasses() {//루트설정

        log.info("1-----------------------");
        log.info("1-----------------------");

        return new Class[]{RootConfig.class, SecurityConfig.class};
    }

    @Override
    protected Class<?>[] getServletConfigClasses() {//서블릿설정

        log.info("2-----------------------");
        log.info("2-----------------------");//정상적으로 설정이 완료되면 로그가 찍히는 것.

        return new Class[]{ServletConfig.class, SecurityServletConfig.class};
    }

    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }

    @Override //한글처리
    protected Filter[] getServletFilters() {
        CharacterEncodingFilter utf8Filter = new CharacterEncodingFilter();
        utf8Filter.setEncoding("UTF-8");
        utf8Filter.setForceEncoding(true);

        return new Filter[] { utf8Filter };
    }

    @Override
    protected void customizeRegistration(ServletRegistration.Dynamic registration) {

        registration.setInitParameter("throwExceptionIfNoHandlerFound","true");

        MultipartConfigElement multipartConfigElement
                = new MultipartConfigElement("C:\\upload\\temp", 1024*1024*10, 1024*1024*20, 1023*1024*1); //1메가 넘으면 파일에다 저장해줘

        registration.setMultipartConfig(multipartConfigElement);

    }
}
