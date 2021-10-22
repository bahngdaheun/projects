package com.noriteo.delinori.saleboard.controller;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.saleboard.dto.SaleBoardReplyDTO;
import com.noriteo.delinori.saleboard.service.SaleBoardReplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Log4j2
@RestController //@ResponseBody
@RequestMapping("/saleboard/replies")
@RequiredArgsConstructor
public class SaleBoardReplyController {

    private final SaleBoardReplyService saleBoardReplyService;

    @PostMapping("")
    public int add(@RequestBody SaleBoardReplyDTO saleBoardReplyDTO) {

        log.info("c replyAdd==============================");
        log.info(saleBoardReplyDTO);

        return saleBoardReplyService.add(saleBoardReplyDTO);

    }

    @DeleteMapping("/{rno}")
    public String remove(@PathVariable(name = "rno") Long rno) {
        log.info("-----------reply remove-----------");

        log.info("rno : " + rno);

        saleBoardReplyService.Remove(rno);

        return "success";
    }

    @PutMapping("/{rno}")
    public String modify(@PathVariable(name = "rno") Long rno, @RequestBody SaleBoardReplyDTO saleBoardReplyDTO) {

        log.info("----------reply modify------------");
        log.info(saleBoardReplyDTO);

        saleBoardReplyService.modify(saleBoardReplyDTO);

        return "success";

    }

    @GetMapping(value = "/list/{sno}/{page}", produces = "application/json")
    public ResponseEntity<PageResponseDTO> getList (
            @PathVariable("page") int page,
            @PathVariable("sno") Long sno) {

        PageRequestDTO pageRequestDTO = PageRequestDTO.builder()
                .page(page)
                .size(10)
                .build();

        log.info("=====================================");
        log.info("sno : " + sno);
        log.info("pageRequestDTO : " + pageRequestDTO);

        return new ResponseEntity<>(saleBoardReplyService.getRepliesList(pageRequestDTO, sno), HttpStatus.OK);


    }

}