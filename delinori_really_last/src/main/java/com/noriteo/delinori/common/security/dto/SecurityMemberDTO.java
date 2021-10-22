package com.noriteo.delinori.common.security.dto;

import com.noriteo.delinori.common.security.domain.SecurityMember;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;
import java.util.stream.Collectors;

@Getter
@Setter
@ToString
public class SecurityMemberDTO extends User {

    private String mid;
    private String mname;
    private String mpw;
    private String maddress;
    private String memail;
    private String mphone;
    private boolean enable;
    private boolean delifile;
    private String show;

    public SecurityMemberDTO(SecurityMember securityMember){
        super(securityMember.getMid(),
                securityMember.getMpw(),
                securityMember.getRoleList().stream().map(securityMemberRole ->
                        new SimpleGrantedAuthority(securityMemberRole.getRole())).collect(Collectors.toList()));
        this.mid = securityMember.getMid();
        this.mname = securityMember.getMname();
        this.mpw = securityMember.getMpw();
        this.maddress = securityMember.getMaddress();
        this.memail = securityMember.getMemail();
        this.mphone = securityMember.getMphone();
        this.enable = securityMember.isEnable();
        this.delifile = securityMember.isDelifile();
        this.show = securityMember.getShow();
    }

    public SecurityMemberDTO(String username, String password, Collection<? extends GrantedAuthority> authorities) { //Collection : 권한정보
        super(username, password, authorities);
    }
}
