package com.noriteo.delinori_front.entity;

import lombok.*;

import javax.persistence.*;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@ToString
@Table(name = "member")
public class Member {

    @Id
    private String mid;

    private String mname;
    private String mpw;
    private String maddress;
    private String memail;
    private String mphone;
    private boolean enable;
    private boolean delifile;
    private int replyCnt;
    private String shown;

    public void change(String mpw, String maddress, String memail, String mphone) {
        this.mpw=mpw;
        this.maddress=maddress;
        this.memail=memail;
        this.mphone=mphone;
    }

}
