package com.noriteo.delinori.qna.service;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.qna.dto.QnaDTO;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface QnaService {
    Long register(QnaDTO qnaDTO);

    PageResponseDTO<QnaDTO> getDTOList(PageRequestDTO pageRequestDTO);

    QnaDTO read(Long qno);

    boolean remove(Long qno);

}
