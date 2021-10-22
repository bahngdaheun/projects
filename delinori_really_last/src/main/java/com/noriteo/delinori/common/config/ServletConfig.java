package com.noriteo.delinori.common.config;

import com.noriteo.delinori.board.config.BoardServletConfig;
import com.noriteo.delinori.common.converter.StringToLocalDateTimeConverter;
import com.noriteo.delinori.common.security.config.SecurityConfig;
import com.noriteo.delinori.common.security.config.SecurityServletConfig;
import com.noriteo.delinori.member.config.MemberServletConfig;
import com.noriteo.delinori.notice.config.NoticeServletConfig;
import com.noriteo.delinori.qna.config.QnaServletConfig;
import com.noriteo.delinori.saleboard.config.SaleBoardServletConfig;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;
import org.springframework.format.FormatterRegistry;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@EnableWebMvc
@ComponentScan(basePackages = {"com.noriteo.delinori.common.exception", "com.noriteo.delinori.common.controller"})
@Import({SaleBoardServletConfig.class,
        BoardServletConfig.class,
        MemberServletConfig.class,
        NoticeServletConfig.class,
        QnaServletConfig.class, SecurityServletConfig.class})
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class ServletConfig implements WebMvcConfigurer {

    @Override
    public void addFormatters(FormatterRegistry registry) {
        registry.addConverter(new StringToLocalDateTimeConverter());
    }

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {

        InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/views/");
        bean.setSuffix(".jsp");
        registry.viewResolver(bean);
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");

    }
}
