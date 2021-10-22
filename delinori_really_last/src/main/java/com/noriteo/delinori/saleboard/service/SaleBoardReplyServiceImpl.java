package com.noriteo.delinori.saleboard.service;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.saleboard.dto.SaleBoardReplyDTO;
import com.noriteo.delinori.saleboard.mapper.SaleBoardReplyMapper;
import com.noriteo.delinori.saleboard.mapper.SaleBoardMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class SaleBoardReplyServiceImpl implements SaleBoardReplyService {

    private final SaleBoardReplyMapper saleBoardReplyMapper;
    private final SaleBoardMapper saleBoardMapper;

    @Override
    @Transactional
    public int add(SaleBoardReplyDTO saleBoardReplyDTO) {

        int count = saleBoardReplyMapper.insert(dtoToEntity(saleBoardReplyDTO));
        saleBoardMapper.updateReplyCnt(saleBoardReplyDTO.getSno(), 1);

        addGno(saleBoardReplyDTO);

        return count;
    }

    @Override
    public int addGno(SaleBoardReplyDTO saleBoardReplyDTO) {
        return saleBoardReplyMapper.replyUpdate(dtoToEntity(saleBoardReplyDTO));
    }

//    @Override
//    public List<SaleBoardReplyDTO> getRepliesWithSno(Long sno) {
//        return saleBoardReplyMapper.getListWithBoard(sno).stream().map(reply -> entityToDTO(reply)).collect(Collectors.toList());
//    }

    @Override
    public PageResponseDTO<SaleBoardReplyDTO> getRepliesList(PageRequestDTO pageRequestDTO, Long sno) {

        List<SaleBoardReplyDTO> dtoList = saleBoardReplyMapper.getListWithPaging(pageRequestDTO, sno).stream().map(reply -> entityToDTO(reply)).collect(Collectors.toList());
        int count = saleBoardReplyMapper.getCountBySno(sno);

        PageResponseDTO<SaleBoardReplyDTO> pageResponseDTO = PageResponseDTO.<SaleBoardReplyDTO>builder()
                .dtoList(dtoList)
                .count(count)
                .build();

        return pageResponseDTO;
    }

    @Override
    public int Remove(Long rno) {
        return saleBoardReplyMapper.delete(rno);
    }

    @Override
    public int modify(SaleBoardReplyDTO saleBoardReplyDTO) {
        return saleBoardReplyMapper.update(dtoToEntity(saleBoardReplyDTO));
    }


}
