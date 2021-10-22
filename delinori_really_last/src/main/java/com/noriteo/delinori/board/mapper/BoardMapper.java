package com.noriteo.delinori.board.mapper;

import com.noriteo.delinori.board.domain.Board;
import com.noriteo.delinori.board.domain.BoardAttach;
import com.noriteo.delinori.common.dto.PageRequestDTO;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface BoardMapper {

    void insert(Board board);

    List<Board> getList(PageRequestDTO pageRequestDTO);

    int getCount(PageRequestDTO pageRequestDTO);

    Board select(Long bno);



    @Select("select now()")
    String getTime();




    int updateShow(Long bno);

    int update(Board board);

    int updateReplyCnt(@Param("bno") Long bno, @Param("num") int num);

    int insertAttach(BoardAttach attach);
}
