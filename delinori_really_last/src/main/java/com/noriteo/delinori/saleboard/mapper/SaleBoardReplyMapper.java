package com.noriteo.delinori.saleboard.mapper;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.saleboard.domain.Reply;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SaleBoardReplyMapper {

    int insert(Reply reply);

    int replyUpdate(Reply reply);

    List<Reply> getListWithPaging(
            @Param("pageRequestDTO") PageRequestDTO pageRequestDTO,
            @Param("sno") Long sno);

    int getCountBySno(Long sno);

    int delete(Long rno);

    int update(Reply reply);

}
