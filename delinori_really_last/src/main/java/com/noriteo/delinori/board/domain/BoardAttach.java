package com.noriteo.delinori.board.domain;

import lombok.*;

@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BoardAttach {

    private String uuid;
    private Long bno;
    private String path;
    private String fileName;
    private boolean image;

    public void setBno(Long bno) {
        this.bno=bno;
    }
}
