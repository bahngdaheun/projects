package com.noriteo.delinori.board.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UploadResponseDTO {

    private String uuid;
    private String fileName;
    private boolean image;
    private String uploadPath;

    public String getThumbnail() {
        return uploadPath+"/s_"+uuid+"_"+fileName;
    }

    public String getFileLink() {
        return uploadPath+"/"+uuid+"_"+fileName;
    }

}
