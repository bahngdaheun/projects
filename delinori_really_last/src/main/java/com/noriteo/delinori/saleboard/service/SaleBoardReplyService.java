package com.noriteo.delinori.saleboard.service;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.saleboard.domain.Reply;
import com.noriteo.delinori.saleboard.dto.SaleBoardReplyDTO;

import java.util.List;

public interface SaleBoardReplyService {

    int add(SaleBoardReplyDTO saleBoardReplyDTO);

    int addGno(SaleBoardReplyDTO saleBoardReplyDTO);

    PageResponseDTO<SaleBoardReplyDTO> getRepliesList(PageRequestDTO pageRequestDTO, Long sno);

    int Remove(Long rno);

    int modify(SaleBoardReplyDTO saleBoardReplyDTO);

    default Reply dtoToEntity(SaleBoardReplyDTO dto) {
        Reply reply = Reply.builder()
                .rno(dto.getRno())
                .sno(dto.getSno())
                .reply(dto.getReply())
                .replyer(dto.getReplyer())
                .replyDate(dto.getReplyDate())
                .modDate(dto.getModDate())
                .gno(dto.getGno())
                .build();
        return reply;
    }

    default SaleBoardReplyDTO entityToDTO(Reply reply) {

        SaleBoardReplyDTO saleBoardReplyDTO = SaleBoardReplyDTO.builder()
                .rno(reply.getRno())
                .sno(reply.getSno())
                .reply(reply.getReply())
                .replyer(reply.getReplyer())
                .replyDate(reply.getReplyDate())
                .modDate(reply.getModDate())
                .gno(reply.getGno())
                .build();

        return saleBoardReplyDTO;
    }
}
