package com.noriteo.delinori.member.service;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.member.domain.Member;
import com.noriteo.delinori.member.dto.MemberDTO;
import com.noriteo.delinori.member.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

    private final MemberMapper memberMapper;

    @Override
    public PageResponseDTO<MemberDTO> getDTOListDeli(PageRequestDTO pageRequestDTO) {
        List<MemberDTO> dtoList=memberMapper.getListDeli(pageRequestDTO).stream().map(member -> member.getDTO()).collect(Collectors.toList());
        int count=memberMapper.getCountDeli(pageRequestDTO);
        PageResponseDTO<MemberDTO> pageResponseDTO=PageResponseDTO.<MemberDTO>builder()
                .dtoList(dtoList)
                .count(count)
                .build();
        return pageResponseDTO;
    }

    @Override
    public PageResponseDTO<MemberDTO> getDTOListNori(PageRequestDTO pageRequestDTO) {
        List<MemberDTO> dtoList=memberMapper.getListNori(pageRequestDTO).stream().map(member -> member.getDTO()).collect(Collectors.toList());
        int count=memberMapper.getCountNori(pageRequestDTO);
        PageResponseDTO<MemberDTO> pageResponseDTO=PageResponseDTO.<MemberDTO>builder()
                .dtoList(dtoList)
                .count(count)
                .build();
        return pageResponseDTO;
    }

    @Override
    public MemberDTO readDeli(String mid) {
        Member member=memberMapper.selectDeli(mid);
        log.info("read service=====");
        return member!=null ? member.getDTO() : null;
    }

    @Override
    public MemberDTO readNori(String mid) {
        Member member=memberMapper.selectNori(mid);
        log.info("read service=====");
        return member!=null ? member.getDTO() : null;
    }

    @Override
    public String registerDeli(MemberDTO memberDTO) {
        Member member=memberDTO.getDomain();
        memberMapper.insertDeli(member);
        String mid=member.getMid();
        member.getAttachList().forEach(attach -> {
            attach.setMid(mid);
            memberMapper.insertAttach(attach);
        });
        return member.getMid();
    }

    @Override
    public String registerNori(MemberDTO memberDTO) {
        Member member=memberDTO.getDomain();
        memberMapper.insertNori(member);
        return member.getMid();
    }

    @Override
    public boolean removeDeli(String mid) {
        return memberMapper.deleteDeli(mid)>0;
    }

    @Override
    public boolean removeNori(String mid) {
        return memberMapper.deleteNori(mid)>0;
    }
}
