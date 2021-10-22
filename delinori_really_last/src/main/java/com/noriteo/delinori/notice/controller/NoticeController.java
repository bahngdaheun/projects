package com.noriteo.delinori.notice.controller;

import com.noriteo.delinori.common.dto.PageMaker;
import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.notice.dto.NoticeDTO;
import com.noriteo.delinori.notice.service.NoticeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/notice/*")
@Log4j2
@RequiredArgsConstructor
public class NoticeController {

    private final NoticeService noticeService;

//    @PreAuthorize("isAuthenticated()")
    @GetMapping("/register")
    public void registerGet(){ //항상 똑같은 페이지  -> void
        //자동으로 해당하는 jsp로 감
    }

    @PostMapping("/register")
    public String registerPost(NoticeDTO noticeDTO, RedirectAttributes redirectAttributes){ // 리다이렉트 하려고 String사용

        log.info("noticeDTOM           " + noticeDTO);

        //Long bno = 111L;
        //Long bno = boardService.register(boardDTO);
        Long nno = noticeService.register(noticeDTO);

        log.info("==================c              registerPost=========================");
        log.info(nno);
        redirectAttributes.addFlashAttribute("result",nno); //addFlashAttribute ->일회성으로 처리. 뒤로가기 누르면 주소값(bno)이 나와서.
        //알림창 나오게 값을 받는거라서 한 번만 사용-> 일회성

        return "redirect:/notice/list"; // 리다이렉트 했을 때 새롭게 생성한 bno번호를보고 싶음 -> mybatis설정
    }

    @GetMapping("/list")
    public void getList(PageRequestDTO pageRequestDTO, Model model){
        //jsp로 담아서 보내줘야 한다. -> model사용(담아서 사용할 떄는 model)
        log.info("c         getList........................................." + pageRequestDTO);//c : controller

        PageResponseDTO<NoticeDTO> responseDTO = noticeService.getDTOList(pageRequestDTO);

        //기본형의 경우 model 을 사용하지 않아도 자동으로 전달됨.
        model.addAttribute("dtoList", responseDTO.getDtoList()); //boardList.jsp를 찾아감

        int total = responseDTO.getCount();
        int page = pageRequestDTO.getPage();
        int size = pageRequestDTO.getSize();   // 세개 있으면 페이지 메이커를 만들 수 있다

        model.addAttribute("pageMaker", new PageMaker(page,size,total));   // 필요한거 전달


        //model.addAttribute("pageMaker", new PageMaker(pageRequestDTO.getPage();,size,total));  이런식으로 줄이는것도 가능
    }  // 페이지와 사이즈를 파라미터로 던진다.


    @GetMapping(value = {"/read"})
    public void read(Long nno, PageRequestDTO pageRequestDTO,Model model) {  //자동으로 모델에 전달. PageRequestDTO를 파라미터로 사용하지 않으면 개별 값을 다 파라미터로 선언해야함;;
        log.info("c   read" +  nno );
        log.info("c   read" + pageRequestDTO);


        model.addAttribute("noticeDTO", noticeService.read(nno)); // model 파라미터 자체가 다른 값 을 감싸서 전달. 파라미터 자체가 값을 가공해서 전달.


    }





    @PostMapping("/remove")
    public String remove(Long nno, RedirectAttributes redirectAttributes) { // RedirectAttributes -> 값을 자동으로 전달해주는 타입(역할) response.Sendredirect 의 역할  -> 리턴으로 감.
        log.info("c       remove:" + nno);

        noticeService.remove(nno);

        log.info("성공");

//        공f (noticeService.remove(nno)) {
//            log.info("remove success");
//            redirectAttributes.addFlashAttribute("result", "success");  //모달
//            //jsp가 없기 때문에 개발자 도구 콘솔창으로 확인시 키 값만 나온다. -> 확인을 위해서 사용.
//        }
        return "redirect:/notice/list";  //삭제를 하고 모달창이 떠야함.

    }

}



