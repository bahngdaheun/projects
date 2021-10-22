package com.noriteo.delinori.board.mapper;

import com.noriteo.delinori.board.domain.Reply;

import java.util.List;

public interface BoardReplyMapper {

    int insert(Reply reply);

    List<Reply> getListWithBoard(Long bno);

    int delete(Long rno);

    int update(Reply reply);
}
