package com.noriteo.delinori_front.service;

import com.noriteo.delinori_front.dto.MemberDTO;
import com.noriteo.delinori_front.entity.Member;
import com.noriteo.delinori_front.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@Log4j2
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

    private final ModelMapper modelMapper;
    private final MemberRepository memberRepository;

    @Override
    public String register(MemberDTO memberDTO) {
        Member member=modelMapper.map(memberDTO, Member.class);
        memberRepository.save(member);
        return member.getMid();
    }

    @Override
    public MemberDTO deliRead(String mid) {
        Optional<Member> result=memberRepository.findById(mid);
        if(result.isEmpty()) {
            throw new RuntimeException("NOT FOUND");
        }
        return modelMapper.map(result.get(), MemberDTO.class);
    }

    @Override
    public MemberDTO noriRead(String mid) {
        Optional<Member> result=memberRepository.findById(mid);
        if(result.isEmpty()) {
            throw new RuntimeException("NOT FOUND");
        }
        return modelMapper.map(result.get(), MemberDTO.class);
    }

    @Override
    public void modify(MemberDTO memberDTO) {
        Optional<Member> result=memberRepository.findById(memberDTO.getMid());
        if(result.isEmpty()) {
            throw new RuntimeException("NOT FOUND");
        }
        Member member=result.get();
        member.change(memberDTO.getMpw(), memberDTO.getMaddress(), memberDTO.getMemail(), memberDTO.getMphone());
        memberRepository.save(member);
    }

    @Override
    public void remove(String mid) {
        memberRepository.deleteById(mid);
    }
}
