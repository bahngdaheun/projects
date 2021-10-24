package com.noriteo.delinori_front.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class MemberPageRequestDTO {

    @Builder.Default
    private int page = 1;

    @Builder.Default
    private int size = 10;

    private String type;

    private String keyword;

    public int getSkip() {

        return (page -1) * size;
    }

    public char[] getTypes() {
        if(type == null || type.isEmpty()){
            return null;
        }
        return type.toCharArray();
    }

}
