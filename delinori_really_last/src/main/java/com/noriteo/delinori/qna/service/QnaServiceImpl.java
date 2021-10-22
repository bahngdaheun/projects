package com.noriteo.delinori.qna.service;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.qna.domain.Qna;
import com.noriteo.delinori.qna.dto.QnaDTO;
import com.noriteo.delinori.qna.mapper.QnaMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class QnaServiceImpl implements QnaService{

    private final QnaMapper qnaMapper;

    @Override
    public Long register(QnaDTO qnaDTO) {
        Qna qna = qnaDTO.getDomain();

        qnaMapper.insert(qna);

        Long qno = qna.getQno();

        qna.getAttachList().forEach(attach -> {
            attach.setQno(qno);
            qnaMapper.insertAttach(attach);
        });

        return qna.getQno();
    }

    @Override
    public PageResponseDTO<QnaDTO> getDTOList(PageRequestDTO pageRequestDTO) {
        List<QnaDTO> dtoList = qnaMapper.getList(pageRequestDTO).stream().map(qna -> qna.getDTO()).collect(Collectors.toList());
        int count = qnaMapper.getCount(pageRequestDTO);

        PageResponseDTO<QnaDTO> pageResponseDTO = PageResponseDTO.<QnaDTO>builder()
                .dtoList(dtoList)
                .count(count)
                .build();
        return pageResponseDTO;
    }

    @Override
    public QnaDTO read(Long qno) {

        Qna qna = qnaMapper.select(qno);

        log.info("read service====================================");

        return qna!= null ? qna.getDTO(): null;
    }

    @Override
    public boolean remove(Long qno) {
        return qnaMapper.delete(qno) > 0;
    }
}
