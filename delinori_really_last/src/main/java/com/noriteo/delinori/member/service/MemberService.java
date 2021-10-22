package com.noriteo.delinori.member.service;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.common.dto.PageResponseDTO;
import com.noriteo.delinori.member.dto.MemberDTO;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface MemberService {

    String registerDeli(MemberDTO memberDTO);

    String registerNori(MemberDTO memberDTO);

    PageResponseDTO<MemberDTO> getDTOListDeli(PageRequestDTO pageRequestDTO);

    PageResponseDTO<MemberDTO> getDTOListNori(PageRequestDTO pageRequestDTO);

    MemberDTO readDeli(String mid);

    MemberDTO readNori(String mid);

    boolean removeDeli(String mid);

    boolean removeNori(String mid);

}
