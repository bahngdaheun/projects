package com.noriteo.delinori.saleboard.dto;

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

    public String getThumbnail() { //get메서드 쓰면 자동으로 json 처리됨
        return uploadPath + "/s_" + uuid + "_" + fileName;
    }

    public String getFileLink() { //원본 이미지 링크 처리
        return uploadPath + "/" + uuid + "_" + fileName;
    }

}
