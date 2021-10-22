package com.noriteo.delinori.notice.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class NoticeUploadResponseDTO {

    private String uuid;
    private String fileName;
    private boolean image;
    private String uploadPath;

    public String getThumbnail() { //썸네일 처리
        return uploadPath + "/s_" + uuid + "_" + fileName;
    }

    //원본 링크
    public String getFileLink() { // 원본 파일의 경로를 볼 수 있게 선언. getThumbnail에 s_만 빼면 된다.
        return uploadPath + "/" + uuid + "_" + fileName;
    }

}
