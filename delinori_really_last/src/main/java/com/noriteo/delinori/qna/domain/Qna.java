package com.noriteo.delinori.qna.domain;

import com.noriteo.delinori.common.dto.UploadResponseDTO;
import com.noriteo.delinori.qna.dto.QnaDTO;
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

public class Qna {

    private Long qno;
    private String title, content, writer;
    private LocalDateTime regDate, modDate;
    private int replyCnt;

    @Builder.Default
    private List<QnaAttach> attachList = new ArrayList<>();

    public QnaDTO getDTO() {
        QnaDTO qnaDTO = QnaDTO.builder()
                .qno(qno)
                .title(title)
                .content(content)
                .writer(writer)
                .regDate(regDate)
                .modDate(modDate)
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

        qnaDTO.setFiles(uploadResponseDTOList);

        return qnaDTO;
    }

    public void setQno(Long qno) {
        this.qno = qno;
    }

    public void addAttach(QnaAttach attach){
        attachList.add(attach);
    }
}
