package com.noriteo.delinori.notice.dto;

import com.noriteo.delinori.notice.domain.Notice;
import com.noriteo.delinori.notice.domain.NoticeAttach;
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
public class NoticeDTO {

    private Long nno;
    private String title;
    private String writer;
    private String content;
    private LocalDateTime regDate;
    private LocalDateTime modDate;
    private int replyCnt;

    @Builder.Default
    private List<NoticeUploadResponseDTO> files  = new ArrayList<>(); //첨부파일을 넣을 공간.


    public Notice getDomain() {
        Notice notice = Notice.builder()
                .nno(nno)
                .title(title)
                .writer(writer)
                .content(content)
                .regDate(regDate)
                .modDate(modDate)
                .build();

        files.forEach(noticeUploadResponseDTO -> {
            NoticeAttach attach = NoticeAttach.builder()
                    .fileName(noticeUploadResponseDTO.getFileName())
                    .uuid(noticeUploadResponseDTO.getUuid())
                    .image(noticeUploadResponseDTO.isImage())
                    .path(noticeUploadResponseDTO.getUploadPath())
                    .build();

            notice.addAttach(attach);
        });


        return notice;


    }

}

