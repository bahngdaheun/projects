package com.noriteo.delinori_front.controller;

import com.noriteo.delinori_front.dto.MemberDTO;
import com.noriteo.delinori_front.dto.MemberPageRequestDTO;
import com.noriteo.delinori_front.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {

    private final MemberService memberService;

    @GetMapping("/main")
    public void main() {
    }

    @GetMapping("/register")
    public void register() {
    }

    @PostMapping("/register")
    public String registerPost(MemberDTO memberDTO, RedirectAttributes redirectAttributes) {
        String mid=memberService.register(memberDTO);
        redirectAttributes.addFlashAttribute("result", mid);
        return "redirect:/member/list";
    }

    @GetMapping("/deliread")
    public void deliRead(String mid, MemberPageRequestDTO memberPageRequestDTO, Model model) {
        model.addAttribute("dto", memberService.deliRead(mid));
    }

    @GetMapping("/read")
    public void noriRead(String mid, MemberPageRequestDTO memberPageRequestDTO, Model model) {
        model.addAttribute("dto", memberService.noriRead(mid));
    }
}
