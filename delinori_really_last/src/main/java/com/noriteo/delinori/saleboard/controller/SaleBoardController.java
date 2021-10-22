package com.noriteo.delinori.saleboard.controller;

import com.noriteo.delinori.common.dto.PageMaker;
import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.saleboard.dto.SaleBoardDTO;
import com.noriteo.delinori.saleboard.service.SaleBoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/saleboard/*")
@Log4j2
@RequiredArgsConstructor
public class SaleBoardController {


    private final SaleBoardService saleBoardService;


    @PostMapping("/register")
    public String registerPost(SaleBoardDTO saleBoardDTO, RedirectAttributes redirectAttributes) {

        log.info("saleBoardDTO : " + saleBoardDTO);

        Long sno = saleBoardService.register(saleBoardDTO);

        log.info("================c : registerPost=============");
        log.info(sno);

        redirectAttributes.addFlashAttribute("result", sno);

        return "redirect:/saleboard/list";

    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/register")
    public void registerGet() {

    }

    @GetMapping("/list")
    public void getList(PageRequestDTO pageRequestDTO, Model model) {

        log.info("c getList..................." + pageRequestDTO);

        log.info("================================");
        log.info(saleBoardService);
        log.info("================================");

        PageResponseDTO<SaleBoardDTO> responseDTO = saleBoardService.getDTOList(pageRequestDTO);

        model.addAttribute("dtoList", responseDTO.getDtoList());

        int total = responseDTO.getCount();
        int page = pageRequestDTO.getPage();
        int size = pageRequestDTO.getSize();

        model.addAttribute("pageMaker", new PageMaker(page, size, total));

    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping(value = {"/read", "/modify"})
    public void read(Long sno, PageRequestDTO pageRequestDTO, Model model) {

        log.info("c      read " + sno);
        log.info("c      read " + pageRequestDTO);

        model.addAttribute("saleBoardDTO", saleBoardService.read(sno));

    }

    @PostMapping("/remove")
    public String remove(Long sno, RedirectAttributes redirectAttributes) {

        log.info("c       remove : " + sno);

        if(saleBoardService.remove(sno)) {
            log.info(sno);
            redirectAttributes.addFlashAttribute("result", "success");
        }
        return "redirect:/saleboard/list";
    }

}
