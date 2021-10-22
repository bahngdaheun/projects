package com.noriteo.delinori.board.domain;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Reply {

    private Long rno;//JPA(myBaits랑 비슷한데 요새 많이 쓰는것)에서는 LONG이 기본
    private Long bno;
    private String replyer;
    private String reply;
    private LocalDateTime replyDate;
    private LocalDateTime modDate;
}
