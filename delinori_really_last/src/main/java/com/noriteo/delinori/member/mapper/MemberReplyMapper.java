package com.noriteo.delinori.member.mapper;

import com.noriteo.delinori.member.domain.Reply;

import java.util.List;

public interface MemberReplyMapper {

    int insert(Reply reply);

    List<Reply> getListWithMember(String mid);

    int delete(Long rno);

    int update(Reply reply);

    int replyUpdate(Reply reply);

}
