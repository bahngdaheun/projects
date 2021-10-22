package com.noriteo.delinori.qna.dto;

import com.noriteo.delinori.common.dto.UploadResponseDTO;
import com.noriteo.delinori.qna.domain.Qna;
import com.noriteo.delinori.qna.domain.QnaAttach;
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
public class QnaDTO {

    private Long qno;
    private String title;
    private String content;
    private String writer;
    private LocalDateTime regDate;
    private LocalDateTime modDate;
    private int replyCnt;

    @Builder.Default
    private List<UploadResponseDTO> files = new ArrayList<>();

    public Qna getDomain() {
        Qna qna = Qna.builder()
                .qno(qno)
                .title(title)
                .content(content)
                .writer(writer)
                .regDate(regDate)
                .modDate(modDate)
                .build();

        files.forEach(uploadResponseDTO -> {
            QnaAttach attach = QnaAttach.builder()
                    .uuid(uploadResponseDTO.getUuid())
                    .fileName(uploadResponseDTO.getFileName())
                    .image(uploadResponseDTO.isImage())
                    .path(uploadResponseDTO.getUploadPath())
                    .build();

            qna.addAttach(attach);
        });

        return qna;
    }
}
