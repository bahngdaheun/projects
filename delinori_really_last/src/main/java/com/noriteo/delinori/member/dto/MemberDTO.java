package com.noriteo.delinori.member.dto;

import com.noriteo.delinori.member.domain.DeliAttach;
import com.noriteo.delinori.member.domain.Member;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberDTO{

    private String mid;
    private String mname;
    private String mpw;
    private String maddress;
    private String memail;
    private String mphone;
    private boolean enable;
    private boolean delifile;

    @Builder.Default
    private List<UploadResponseDTO> files=new ArrayList<>();

    public Member getDomain() {
            Member member = Member.builder()
                    .mid(mid)
                    .mname(mname)
                    .mpw(mpw)
                    .maddress(maddress)
                    .memail(memail)
                    .mphone(mphone)
                    .enable(enable)
                    .delifile(files.size() > 0 )
                    .build();

            files.forEach(uploadResponseDTO -> {
                DeliAttach attach = DeliAttach.builder()
                        .fileName(uploadResponseDTO.getFileName())
                        .uuid(uploadResponseDTO.getUuid())
                        .image(uploadResponseDTO.isImage())
                        .path(uploadResponseDTO.getUploadPath())
                        .build();

                member.addAttach(attach);
            });
            return member;
    }
}
