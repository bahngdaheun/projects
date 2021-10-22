package com.noriteo.delinori.qna.service;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.ReplyResponseDTO;
import com.noriteo.delinori.qna.dto.QnaReplyDTO;
import com.noriteo.delinori.qna.mapper.QnaMapper;
import com.noriteo.delinori.qna.mapper.QnaReplyMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class QnaReplyServiceImpl implements QnaReplyService {

    private final QnaReplyMapper qnaReplyMapper;
    private final QnaMapper qnaMapper;

    @Override
    public int add(QnaReplyDTO qnaReplyDTO) {
        int count = qnaReplyMapper.insert(dtoToEntity(qnaReplyDTO));
        qnaMapper.updateReplyCnt(qnaReplyDTO.getQno(),1);

        return count;
    }

    @Override
    public List<QnaReplyDTO> getRepliesWithQno(Long qno) {
        return qnaReplyMapper.getListWithQna(qno, PageRequestDTO.builder().build()).stream()
                .map(reply -> entityToDTO(reply))
                .collect(Collectors.toList());
    }

    @Override
    public ReplyResponseDTO getRepliesPage(PageRequestDTO pageRequestDTO, Long qno) {

        return new ReplyResponseDTO(
                qnaReplyMapper.getCountReplies(qno),
                qnaReplyMapper.getListWithQna(qno,pageRequestDTO)
        );
    }

    @Override
    public int remove(Long rno) {
        return qnaReplyMapper.delete(rno);
    }

    @Override
    public int modify(QnaReplyDTO qnaReplyDTO) {
        return qnaReplyMapper.update(dtoToEntity(qnaReplyDTO));
    }
}
