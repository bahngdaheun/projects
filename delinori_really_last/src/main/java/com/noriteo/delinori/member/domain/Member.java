package com.noriteo.delinori.member.domain;

import com.noriteo.delinori.member.dto.MemberDTO;
import com.noriteo.delinori.member.dto.UploadResponseDTO;
import lombok.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Member {

    private String mid, mname, mpw, maddress, memail, mphone;
    private boolean enable, delifile;

    @Builder.Default
    private List<DeliAttach> attachList=new ArrayList<>();

    public MemberDTO getDTO() {
            MemberDTO memberDTO=MemberDTO.builder()
                    .mid(mid)
                    .mname(mname)
                    .mpw(mpw)
                    .maddress(maddress)
                    .memail(memail)
                    .mphone(mphone)
                    .enable(enable)
                    .delifile(delifile)
                    .build();

        List<UploadResponseDTO> uploadResponseDTOList=attachList.stream().map(attach -> {
            UploadResponseDTO uploadResponseDTO=UploadResponseDTO.builder()
                    .uuid(attach.getUuid())
                    .fileName(attach.getFileName())
                    .uploadPath(attach.getPath())
                    .image(attach.isImage())
                    .build();
            return uploadResponseDTO;
        }).collect(Collectors.toList());
        memberDTO.setFiles(uploadResponseDTOList);
        return memberDTO;
    }

    public void setMid(String mid) {
        this.mid=mid;
    }

    public void addAttach(DeliAttach attach){
        attachList.add(attach);
    }

}
