package com.noriteo.delinori.board.service;


import com.noriteo.delinori.board.domain.Board;
import com.noriteo.delinori.board.dto.BoardDTO;
import com.noriteo.delinori.board.mapper.BoardMapper;
import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService{

    private final BoardMapper boardMapper;


    @Override
    public Long register(BoardDTO boardDTO) {

        Board board = boardDTO.getDomain();

        boardMapper.insert(board);

        Long bno = board.getBno();

        log.info("============================");
        log.info(boardDTO.getFiles());

        log.info("============================");

        log.info(board.getAttachList());

        log.info("============================");

       if(board.getAttachList() != null){
            board.getAttachList().forEach(attach -> {
                attach.setBno(bno);
                boardMapper.insertAttach(attach);
            });
        }


        return board.getBno();
    }

    @Override
    public PageResponseDTO<BoardDTO> getDTOList (PageRequestDTO pageRequestDTO) {

        List<BoardDTO> dtoList = boardMapper.getList(pageRequestDTO).stream().map(board -> board.getDTO()).collect(Collectors.toList());
        int count = boardMapper.getCount(pageRequestDTO);

        PageResponseDTO<BoardDTO> pageResponseDTO = PageResponseDTO.<BoardDTO>builder()
                .dtoList(dtoList)
                .count(count)
                .build();

        return pageResponseDTO;
    }

    @Override
    public BoardDTO read(Long bno) {
        Board board = boardMapper.select(bno);

        if(board != null){
            return board.getDTO();
        }
        return null;
    }

    @Override
    public boolean remove(Long bno) {

        return boardMapper.updateShow(bno) > 0;
    }

    @Override
    public boolean modify(BoardDTO boardDTO) {

        Board board = boardDTO.getDomain();

        return boardMapper.update(board) > 0;
    }


}
