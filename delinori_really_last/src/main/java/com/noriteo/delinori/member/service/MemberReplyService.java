package com.noriteo.delinori.member.service;

import com.noriteo.delinori.member.domain.Reply;
import com.noriteo.delinori.member.dto.MemberReplyDTO;

import java.util.List;

public interface MemberReplyService {

    int add(MemberReplyDTO memberReplyDTO);

    int addGno(MemberReplyDTO memberReplyDTO);

    List<MemberReplyDTO> getRepliesWithMid(String mid);

    int remove(Long rno);

    int modify(MemberReplyDTO memberReplyDTO);

    default Reply dtoToEntity(MemberReplyDTO dto){
        Reply reply= Reply.builder()
                .rno(dto.getRno())
                .mid(dto.getMid())
                .reply(dto.getReply())
                .replyer(dto.getReplyer())
                .replyDate(dto.getReplyDate())
                .modDate(dto.getModDate())
                .gno(dto.getGno())
                .build();
        return reply;
    }

    default MemberReplyDTO entityToDTO(Reply reply){//default 쓰면 인터페이스도 몸체를 가질 수 있음

        MemberReplyDTO memberReplyDTO = MemberReplyDTO.builder()
                .rno(reply.getRno())
                .mid(reply.getMid())
                .reply(reply.getReply())
                .replyer(reply.getReplyer())
                .replyDate(reply.getReplyDate())
                .modDate(reply.getModDate())
                .gno(reply.getGno())
                .build();
        return memberReplyDTO;
    }
}
