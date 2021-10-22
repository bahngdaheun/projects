package com.noriteo.delinori.member.mapper;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.member.domain.DeliAttach;
import com.noriteo.delinori.member.domain.Member;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MemberMapper {

    void insertDeli(Member member);

    void insertNori(Member member);

    List<Member> getListDeli(PageRequestDTO pageRequestDTO);

    List<Member> getListNori(PageRequestDTO pageRequestDTO);

    int getCountDeli(PageRequestDTO pageRequestDTO);

    int getCountNori(PageRequestDTO pageRequestDTO);

    Member selectDeli(String mid);

    Member selectNori(String mid);

    int deleteDeli(String mid);

    int deleteNori(String mid);

    int insertAttach(DeliAttach attach);

    int deleteAttach(String mid);

    int updateReplyCnt(@Param("mid") String mid, @Param("num") int num);

}
