package com.noriteo.delinori.common.dto;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ReplyPageMaker {

    private int start, end, page, size, total;
    private boolean prev, next;

    public ReplyPageMaker(int page, int size, int total) {

        this.page = page;
        this.size = size;
        this.total = total;

        //마지막 페이지 계산
        end = (int)(Math.ceil(page / 10.0)) * 10; //소수점으로 나오기위해서 10.0으로 나눔
        start = end - 9;

        prev = start > 1;
        next = (total / (double)size) > end;

        end = end * size > total ? (int)(Math.ceil(total / (double)size)) : end;
    }
}
