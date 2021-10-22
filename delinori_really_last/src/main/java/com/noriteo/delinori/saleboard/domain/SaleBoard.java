package com.noriteo.delinori.saleboard.domain;

import com.noriteo.delinori.saleboard.dto.SaleBoardDTO;
import com.noriteo.delinori.saleboard.dto.UploadResponseDTO;
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
public class SaleBoard {

    private Long sno;
    private String title, content, writer;
    private LocalDateTime regDate, modDate;
    private int replyCnt;

    @Builder.Default
    private List<SaleBoardAttach> attachList = new ArrayList<>();

    public SaleBoardDTO getDTO() {
        SaleBoardDTO saleBoardDTO = SaleBoardDTO.builder()
                .sno(sno)
                .title(title)
                .content(content)
                .writer(writer)
                .regDate(regDate)
                .modDate(modDate)
                .build();

        //BoardAttach -> NoticeUploadResponseDTO -> List
        List<UploadResponseDTO> uploadResponseDTOList = attachList.stream().map(attach -> {
            UploadResponseDTO uploadResponseDTO = UploadResponseDTO.builder()
                    .uuid(attach.getUuid())
                    .fileName(attach.getFileName())
                    .uploadPath(attach.getPath())
                    .image(attach.isImage())
                    .build();
            return uploadResponseDTO;
        }).collect(Collectors.toList());

        saleBoardDTO.setFiles(uploadResponseDTOList);

        return saleBoardDTO;
    }

    public void setSno(Long sno) {
        this.sno = sno;
    }

    public void addAttach(SaleBoardAttach attach) {
        attachList.add(attach);
    }

}
