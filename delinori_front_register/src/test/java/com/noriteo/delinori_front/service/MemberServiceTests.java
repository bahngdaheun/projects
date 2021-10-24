package com.noriteo.delinori_front.service;

import com.noriteo.delinori_front.dto.MemberDTO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.stream.IntStream;

@SpringBootTest
@Log4j2
public class MemberServiceTests {

    @Autowired
    private MemberService memberService;

    @Test
    public void testRegister() {
        IntStream.rangeClosed(200, 223).forEach(i-> {
            MemberDTO memberDTO=MemberDTO.builder()
                    .mid("nori"+i)
                    .mname("노리"+i)
                    .mpw("nori"+i)
                    .maddress("서울시 종로구 종로"+i)
                    .memail("nori"+i+"@delinori.com")
                    .mphone("010-"+i+"07"+i+"-28"+i+"3")
                    .build();
            String mid=memberService.register(memberDTO);
            log.info("MID: "+mid);
        });
    }

    @Test
    public void testModify() {
        MemberDTO memberDTO=MemberDTO.builder().mid("nori1").maddress("서울시 강남구 역삼동")
                .mphone("010-1234-5678").build();
        memberService.modify(memberDTO);
    }

}
