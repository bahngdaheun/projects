package com.noriteo.delinori.board.service;

import com.noriteo.delinori.board.dto.BoardReplyDTO;
import com.noriteo.delinori.board.mapper.BoardMapper;
import com.noriteo.delinori.board.mapper.BoardReplyMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
@Transactional
public class BoardReplyServiceImpl implements BoardReplyService {

    private final BoardMapper boardMapper;
    private final BoardReplyMapper boardReplyMapper;


    @Override
    public int add(BoardReplyDTO boardReplyDTO) {
        int count = boardReplyMapper.insert(dtoToEntity(boardReplyDTO));
        boardMapper.updateReplyCnt(boardReplyDTO.getBno(),1);

        return count;
    }

    @Override
    public List<BoardReplyDTO> getRepliesWithBno(Long bno) {
        return boardReplyMapper.getListWithBoard(bno).stream()
                .map(reply -> entityToDTO(reply)).collect(Collectors.toList());//한줄로 끝내는 방법 이것도 이해는 못함..
    }

    @Override
    public int remove(Long rno) {
        return boardReplyMapper.delete(rno);
    }

    @Override
    public int modify(BoardReplyDTO boardReplyDTO) {
        return boardReplyMapper.update(dtoToEntity(boardReplyDTO));
    }


}
