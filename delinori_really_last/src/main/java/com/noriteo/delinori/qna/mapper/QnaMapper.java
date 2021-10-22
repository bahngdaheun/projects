package com.noriteo.delinori.qna.mapper;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.qna.domain.Qna;
import com.noriteo.delinori.qna.domain.QnaAttach;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface QnaMapper {

    void insert(Qna qna);

    List<Qna> getList(PageRequestDTO pageRequestDTO);

    int getCount(PageRequestDTO pageRequestDTO);

    Qna select (Long qno);

    int delete(Long qno);

    int updateReplyCnt(@Param("qno") Long qno, @Param("num") int num);

    int insertAttach(QnaAttach attach);

    int deleteAttach(Long qno);

}
