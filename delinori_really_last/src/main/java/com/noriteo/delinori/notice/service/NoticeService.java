package com.noriteo.delinori.notice.service;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.notice.dto.NoticeDTO;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface NoticeService {

    Long register(NoticeDTO noticeDTO);

    PageResponseDTO<NoticeDTO> getDTOList(PageRequestDTO pageRequestDTO);

    NoticeDTO read(Long nno);

    boolean remove(Long nno);
}
