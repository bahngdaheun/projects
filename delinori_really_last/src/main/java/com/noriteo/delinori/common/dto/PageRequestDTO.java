package com.noriteo.delinori.common.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PageRequestDTO {

    @Builder.Default //기본값 주고 선언
    private int page = 1;
    @Builder.Default
    private int size = 10;

    private String type; //검색 조건
    private String keyword; //검색어

    public int getSkip() {

        return (page - 1) * size;
    }

    public String getType() {

        if(type == null || type.trim().length() == 0) {
            return null;
        }
        return type;
    }

    public String[] getArr() {
        return type == null? new String[]{}: type.split("");
    }

}
