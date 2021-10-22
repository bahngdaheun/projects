package com.noriteo.delinori.notice.domain;

import com.noriteo.delinori.notice.dto.NoticeDTO;
import com.noriteo.delinori.notice.dto.NoticeUploadResponseDTO;
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
public class Notice {

    private Long nno;
    private String title, writer, content;
    private LocalDateTime regDate, modDate;
    private int replyCnt;

    @Builder.Default
    private List<NoticeAttach> attachList = new ArrayList<>();

    public NoticeDTO getDTO() {
        NoticeDTO noticeDTO = NoticeDTO.builder()
                .nno(nno)
                .title(title)
                .content(content)
                .writer(writer)
                .regDate(regDate)
                .modDate(modDate)
                .build();

        List<NoticeUploadResponseDTO> noticeUploadResponseDTOList = attachList.stream().map(attach -> {
            NoticeUploadResponseDTO noticeUploadResponseDTO = NoticeUploadResponseDTO.builder()
                    .uuid(attach.getUuid())
                    .fileName(attach.getFileName())
                    .uploadPath(attach.getPath())
                    .image(attach.isImage())
                    .build();
            return noticeUploadResponseDTO;
        }).collect(Collectors.toList());

        noticeDTO.setFiles(noticeUploadResponseDTOList);

        return noticeDTO;

    }

    public void setNno(Long nno) { //board는 읽기전용이라서 setter 따로 선언
        this.nno = nno;
    }

    public void addAttach(NoticeAttach attach) { attachList.add(attach);}
}
