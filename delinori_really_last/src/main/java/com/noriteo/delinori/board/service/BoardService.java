package com.noriteo.delinori.board.service;

import com.noriteo.delinori.board.dto.BoardDTO;
import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface    BoardService {

    Long register(BoardDTO boardDTO);

    PageResponseDTO<BoardDTO> getDTOList(PageRequestDTO pageRequestDTO);

    BoardDTO read(Long bno);

    boolean remove(Long bno);

    boolean modify(BoardDTO boardDTO);
}
