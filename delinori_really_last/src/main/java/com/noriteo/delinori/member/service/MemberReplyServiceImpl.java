package com.noriteo.delinori.member.service;

import com.noriteo.delinori.member.dto.MemberReplyDTO;
import com.noriteo.delinori.member.mapper.MemberMapper;
import com.noriteo.delinori.member.mapper.MemberReplyMapper;
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
public class MemberReplyServiceImpl implements MemberReplyService {

    private final MemberReplyMapper memberReplyMapper;
    private final MemberMapper memberMapper;

    @Override
    public List<MemberReplyDTO> getRepliesWithMid(String mid) {
        return memberReplyMapper.getListWithMember(mid).stream().map(reply -> entityToDTO(reply)).collect(Collectors.toList());
    }

    @Override
    public int remove(Long rno) {
        return memberReplyMapper.delete(rno);
    }

    @Override
    public int modify(MemberReplyDTO memberReplyDTO) {
        return memberReplyMapper.update(dtoToEntity(memberReplyDTO));
    }

    @Override
    public int add(MemberReplyDTO memberReplyDTO) {
         int count= memberReplyMapper.insert(dtoToEntity(memberReplyDTO));
         memberMapper.updateReplyCnt(memberReplyDTO.getMid(), 1);//댓글 1개 추가하면 count도 1 늘게
        addGno(memberReplyDTO);
        return count;
    }

    @Override
    public int addGno(MemberReplyDTO memberReplyDTO) {
        return memberReplyMapper.replyUpdate(dtoToEntity(memberReplyDTO));
    }
}
