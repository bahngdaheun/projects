package com.noriteo.delinori.common.controller;

import lombok.extern.log4j.Log4j2;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Log4j2
@Controller
public class ChartController {

//    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @GetMapping("/chart")
    public void chart(){
        log.warn("chart.........");
    }

}
