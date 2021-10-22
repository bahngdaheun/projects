package com.noriteo.delinori.common.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@Getter
public class ReplyResponseDTO<E> {

    private int replyCnt;
    private List<E> list;
}
