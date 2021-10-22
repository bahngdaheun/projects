package com.noriteo.delinori.member.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UploadResponseDTO {

    //파일 하나 업로드할 때마다 만들어야 하는 객체 총 4개
    private String uuid;
    private String uploadPath;
    private String fileName;
    private boolean image;

    public String getThumbnail(){
        return uploadPath+"/s_"+uuid+"_"+fileName;
    }

    public String getFileLink(){//원래 파일의 위치
        return uploadPath+"/"+uuid+"_"+fileName;
    }

}
