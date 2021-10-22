package com.noriteo.delinori.member.domain;

import lombok.*;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class DeliAttach {

    private String uuid;
    private String mid;
    private String path;
    private String fileName;
    private boolean image;

    public void setMid(String mid){
        this.mid=mid;
    }

}
