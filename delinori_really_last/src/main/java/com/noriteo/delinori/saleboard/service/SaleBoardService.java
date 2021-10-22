package com.noriteo.delinori.saleboard.service;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.saleboard.dto.SaleBoardDTO;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface SaleBoardService {

    Long register(SaleBoardDTO saleBoardDTO);

    PageResponseDTO<SaleBoardDTO> getDTOList(PageRequestDTO pageRequestDTO);

    SaleBoardDTO read(Long sno);

    boolean remove(Long sno);

}
