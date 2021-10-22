package com.noriteo.delinori.board.service;

import com.noriteo.delinori.board.domain.Reply;
import com.noriteo.delinori.board.dto.BoardReplyDTO;

import java.util.List;

public interface BoardReplyService {

    int add(BoardReplyDTO boardReplyDTO);

    List<BoardReplyDTO> getRepliesWithBno(Long bno);

    int remove(Long rno);

    int modify(BoardReplyDTO boardReplyDTO);

    default Reply dtoToEntity(BoardReplyDTO dto) {
        Reply reply = Reply.builder()
                .rno(dto.getRno())
                .bno(dto.getBno())
                .reply(dto.getReply())
                .replyer(dto.getReplyer())
                .replyDate(dto.getReplyDate())
                .modDate(dto.getModDate())
                .build();
        return reply;
    }

    default BoardReplyDTO entityToDTO(Reply reply) {
        BoardReplyDTO boardReplyDTO = BoardReplyDTO.builder()
                .rno(reply.getRno())
                .bno(reply.getBno())
                .reply(reply.getReply())
                .replyer(reply.getReplyer())
                .replyDate(reply.getReplyDate())
                .modDate(reply.getModDate())
                .build();
        return boardReplyDTO;
    }

}
