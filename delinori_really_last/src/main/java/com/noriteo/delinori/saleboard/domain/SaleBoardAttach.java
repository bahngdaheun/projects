package com.noriteo.delinori.saleboard.domain;

import lombok.*;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class SaleBoardAttach {

    private String uuid;
    private Long sno;
    private String fileName;
    private String path;
    private boolean image;

    public void setSno(Long sno) {
        this.sno = sno;
    }

}
