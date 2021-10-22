package com.noriteo.delinori.qna.controller;

import com.noriteo.delinori.common.dto.PageMaker;
import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.qna.dto.QnaDTO;
import com.noriteo.delinori.qna.service.QnaService;
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
@RequestMapping("/qna/*")
@Log4j2
@RequiredArgsConstructor
public class QnaController {

    private final QnaService qnaService;

    @GetMapping("/register")
    public void getRegister(){

    }

    @PostMapping("/register")
    public String postRegister(QnaDTO qnaDTO, RedirectAttributes redirectAttributes){

        log.info("=============c     postRegister============");
        log.info("qnaDTO : " + qnaDTO);

        Long qno = qnaService.register(qnaDTO);

        redirectAttributes.addFlashAttribute("result",qno);

        return "redirect:/qna/list";
    }

    @GetMapping("/list")
    public void getList(PageRequestDTO pageRequestDTO, Model model){

        log.info("c         getList........................................." + pageRequestDTO);

        PageResponseDTO<QnaDTO> responseDTO = qnaService.getDTOList(pageRequestDTO);
        model.addAttribute("dtoList", responseDTO.getDtoList());

        int total = responseDTO.getCount();
        int page = pageRequestDTO.getPage();
        int size =pageRequestDTO.getSize();

        model.addAttribute("pageMaker",new PageMaker(page,size,total));

    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/read")
    public void read(Long qno, PageRequestDTO pageRequestDTO, Model model) {

        log.info("c          read" + qno);
        log.info("c          read" + pageRequestDTO);

        model.addAttribute("qnaDTO", qnaService.read(qno));
    }

    @PostMapping("/remove")
    public String  remove(Long qno, RedirectAttributes redirectAttributes){

        log.info("c            removeController" + qno);

        if (qnaService.remove(qno)){
            log.info("remove success");
            redirectAttributes.addFlashAttribute("result","removed");
        }
        return "redirect:/qna/list";
    }

}
