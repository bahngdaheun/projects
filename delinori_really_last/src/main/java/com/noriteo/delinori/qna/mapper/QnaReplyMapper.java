package com.noriteo.delinori.qna.mapper;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.qna.domain.QnaReply;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface QnaReplyMapper {

    int insert(QnaReply qnaReply);

//    List<QnaReply> getList(Long qno);

    List<QnaReply> getListWithQna(@Param("qno") Long qno, @Param("pageRequestDTO") PageRequestDTO pageRequestDTO);

    int delete(Long rno);

    int update(QnaReply qnaReply);

    int getCountReplies(Long qno);
}
