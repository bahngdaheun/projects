package com.noriteo.delinori.common.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UploadResponseDTO {

    //파일업로드가 되면 해당 네가지의 객체가 생성되는 것
    private String uuid; //유효아이디값
    private String fileName;
    private boolean image;
    private String uploadPath;

    public String getThumbnail(){
        return uploadPath+"/s_"+uuid+"_"+fileName;
    }

    public String getFileLink(){
        return uploadPath+"/"+uuid+"_"+fileName;
    }

}
