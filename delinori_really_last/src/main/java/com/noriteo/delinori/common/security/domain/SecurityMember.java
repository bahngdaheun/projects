package com.noriteo.delinori.common.security.domain;

import com.noriteo.delinori.member.domain.MemberRole;
import lombok.*;
import org.w3c.dom.stylesheets.LinkStyle;

import java.util.List;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SecurityMember {

    private String mid;
    private String mname;
    private String mpw;
    private String maddress;
    private String memail;
    private String mphone;
    private boolean enable;
    private boolean delifile;
    private String show;

    private List<SecurityMemberRole> roleList;
}
