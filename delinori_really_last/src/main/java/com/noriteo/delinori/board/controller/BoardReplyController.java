package com.noriteo.delinori.board.controller;

import com.noriteo.delinori.board.dto.BoardReplyDTO;
import com.noriteo.delinori.board.service.BoardReplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Log4j2
@RestController
@RequestMapping("/board/replies")
@RequiredArgsConstructor
public class BoardReplyController {

    private final BoardReplyService boardReplyService;

    @PostMapping("")
    public int add(@RequestBody BoardReplyDTO boardReplyDTO) {

        log.info("====================");
        log.info(boardReplyDTO);

        return boardReplyService.add(boardReplyDTO);

    }

    @GetMapping("/list/{bno}")
    public List<BoardReplyDTO> getBoardReplies(@PathVariable(name = "bno")Long bno){

        return boardReplyService.getRepliesWithBno(bno);
    }

    @DeleteMapping("/{rno}")
    public String remove(@PathVariable(name = "rno")Long rno) {
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        log.info("-------------------------------reply remove-----------------");

        boardReplyService.remove(rno);

        log.info("rno: " + rno);

        return "success";
    }

    @PutMapping("/{rno}")
    public String modify(@PathVariable(name = "rno")Long rno,
                         @RequestBody BoardReplyDTO boardReplyDTO) {
        log.info("-------------------reply--------------" + rno);
        log.info(boardReplyDTO);
        boardReplyService.modify(boardReplyDTO);
        return "success";
    }

}
