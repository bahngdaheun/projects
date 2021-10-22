package com.noriteo.delinori.member.controller;

import com.noriteo.delinori.member.dto.MemberReplyDTO;
import com.noriteo.delinori.member.service.MemberReplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Log4j2
@RestController
@RequestMapping("/member/replies")
@RequiredArgsConstructor
public class MemberReplyController {

    private final MemberReplyService memberReplyService;

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PostMapping("")
    public int add(@RequestBody MemberReplyDTO memberReplyDTO){

        log.info("==========");
        log.info(memberReplyDTO);

        return memberReplyService.add(memberReplyDTO);
    }

    @DeleteMapping("/{rno}")
    public String remove(@PathVariable(name = "rno") Long rno){
        log.info("---reply remove----");
        log.info("rno: "+rno);
        memberReplyService.remove(rno);
        return "success";
    }

    @PutMapping("/{rno}")
    public String modify(@PathVariable(name = "rno") Long rno, @RequestBody MemberReplyDTO memberReplyDTO){
        log.info("---reply modify----"+rno);
        log.info(memberReplyDTO);
        memberReplyService.modify(memberReplyDTO);
        return "success";
    }

    @GetMapping("/list/{mid}")
    public List<MemberReplyDTO> getMemberReplies(@PathVariable(name = "mid") String mid){
       //서비스 계층 호출: 모델에 안 담고 바로 반환
        return memberReplyService.getRepliesWithMid(mid);
    }


}
