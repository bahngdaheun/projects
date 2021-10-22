package com.noriteo.delinori.saleboard.service;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.saleboard.domain.SaleBoard;
import com.noriteo.delinori.saleboard.dto.SaleBoardDTO;
import com.noriteo.delinori.saleboard.mapper.SaleBoardMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class SaleBoardServiceImpl implements SaleBoardService {

    private final SaleBoardMapper saleBoardMapper;

    @Override
    public Long register(SaleBoardDTO saleBoardDTO) {

        SaleBoard saleBoard = saleBoardDTO.getDomain();

        saleBoardMapper.insert(saleBoard);

        Long sno = saleBoard.getSno();

        saleBoard.getAttachList().forEach(attach -> {
            attach.setSno(sno);
            saleBoardMapper.insertAttach(attach);
        });

        return saleBoard.getSno();

    }

    @Override
    public PageResponseDTO<SaleBoardDTO> getDTOList(PageRequestDTO pageRequestDTO) {

        List<SaleBoardDTO> dtoList = saleBoardMapper.getList(pageRequestDTO).stream().map(saleBoard -> saleBoard.getDTO()).collect(Collectors.toList());
        int count = saleBoardMapper.getCount(pageRequestDTO);

        PageResponseDTO<SaleBoardDTO> pageResponseDTO = PageResponseDTO.<SaleBoardDTO>builder()
                .dtoList(dtoList)
                .count(count)
                .build();

        return pageResponseDTO;
    }

    @Override
    public SaleBoardDTO read(Long sno) {

        SaleBoard saleBoard = saleBoardMapper.select(sno);

        if(saleBoard != null) {
            return saleBoard.getDTO();
        }
        return null;
    }

    @Override
    public boolean remove(Long sno) {
        return saleBoardMapper.delete(sno) > 0;
    }

}
