package com.noriteo.delinori.board.domain;

import com.noriteo.delinori.board.dto.BoardDTO;
import com.noriteo.delinori.board.dto.UploadResponseDTO;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Board {

    private int replyCnt;
    private Long bno;
    private String title,writer,content,show;
    private LocalDateTime regDate,modDate;

    @Builder.Default
    private List<BoardAttach> attachList = new ArrayList<>();

    public BoardDTO getDTO(){
        BoardDTO boardDTO = BoardDTO.builder()
                .bno(bno)
                .title(title)
                .content(content)
                .writer(writer)
                .regDate(regDate)
                .modDate(modDate)
                .show(show)
                .build();

        List<UploadResponseDTO> uploadResponseDTOList = attachList.stream().map(attach -> {
            UploadResponseDTO uploadResponseDTO = UploadResponseDTO.builder()
                    .uuid(attach.getUuid())
                    .fileName(attach.getFileName())
                    .uploadPath(attach.getPath())
                    .image(attach.isImage())
                    .build();
            return uploadResponseDTO;
        }).collect(Collectors.toList());

        boardDTO.setFiles(uploadResponseDTOList);


        return boardDTO;
    }

    public void setBno(Long bno){
        this.bno = bno;
    }

    public void addAttach(BoardAttach attach) {

        if(attachList == null){
            this.attachList = new ArrayList<>();
        }

        attachList.add(attach);

    }
}
