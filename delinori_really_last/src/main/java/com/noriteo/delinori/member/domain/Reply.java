package com.noriteo.delinori.member.domain;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Reply {

    private Long rno;
    private String mid;
    private String reply;
    private String replyer;
    private LocalDateTime replyDate;
    private LocalDateTime modDate;
    private Long gno;
}
