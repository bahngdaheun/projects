package com.noriteo.delinori.saleboard.dto;

import com.noriteo.delinori.saleboard.domain.SaleBoard;
import com.noriteo.delinori.saleboard.domain.SaleBoardAttach;
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
public class SaleBoardDTO {

    private Long sno;
    private String title;
    private String content;
    private String writer;
    private LocalDateTime regDate;
    private LocalDateTime modDate;
    private int replyCount;

    @Builder.Default
    private List<UploadResponseDTO> files = new ArrayList<>();

    public SaleBoard getDomain() {

        SaleBoard saleBoard = SaleBoard.builder()
                .sno(sno)
                .title(title)
                .content(content)
                .writer(writer)
                .regDate(regDate)
                .modDate(modDate)
                .build();

        files.forEach(uploadResponseDTO -> {
            SaleBoardAttach attach = SaleBoardAttach.builder()
                    .fileName(uploadResponseDTO.getFileName())
                    .uuid(uploadResponseDTO.getUuid())
                    .image(uploadResponseDTO.isImage())
                    .path(uploadResponseDTO.getUploadPath())
                    .build();

            saleBoard.addAttach(attach);
        });

        return  saleBoard;
    }

}
