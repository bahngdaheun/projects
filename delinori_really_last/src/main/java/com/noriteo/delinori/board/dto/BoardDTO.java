package com.noriteo.delinori.board.dto;

import com.noriteo.delinori.board.domain.Board;
import com.noriteo.delinori.board.domain.BoardAttach;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BoardDTO {

//    private int replyCnt;
    private Long bno;
    private String title;
    private String writer;
    private String content;
    private LocalDateTime regDate;
    private LocalDateTime modDate;
    private String show;

    private List<UploadResponseDTO> files = new ArrayList<>();

    public Board getDomain() {

        Board board = Board.builder()
                .bno(bno)
                .title(title)
                .content(content)
                .writer(writer)
                .regDate(regDate)
                .modDate(modDate)
                .show(show)
                .build();

        files.forEach(uploadResponseDTO -> {
            BoardAttach attach = BoardAttach.builder()
                    .fileName(uploadResponseDTO.getFileName())
                    .uuid(uploadResponseDTO.getUuid())
                    .image(uploadResponseDTO.isImage())
                    .path(uploadResponseDTO.getUploadPath())
                    .build();

            board.addAttach(attach);
        });

            return board;
    }
}
