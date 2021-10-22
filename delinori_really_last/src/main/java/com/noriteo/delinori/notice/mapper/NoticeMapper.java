package com.noriteo.delinori.notice.mapper;

import com.noriteo.delinori.common.dto.PageRequestDTO;
import com.noriteo.delinori.notice.domain.Notice;
import com.noriteo.delinori.notice.domain.NoticeAttach;
import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
public interface NoticeMapper {

    void insert(Notice notice);

    List<Notice> getList(PageRequestDTO pageRequestDTO);

    int getCount(PageRequestDTO pageRequestDTO);

    Notice select(Long nno);

    int delete(Long nno);

    int updateReplyCnt(@Param("nno") Long nno, @Param("num") int num);

    int insertAttach(NoticeAttach attach);

    int deleteAttach(Long nno);

}
