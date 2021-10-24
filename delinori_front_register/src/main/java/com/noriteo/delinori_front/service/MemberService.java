package com.noriteo.delinori_front.service;

import com.noriteo.delinori_front.dto.MemberDTO;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface MemberService {
    String register(MemberDTO memberDTO);

    MemberDTO deliRead(String mid);

    MemberDTO noriRead(String mid);

    void modify(MemberDTO memberDTO);

    void remove(String mid);
}
