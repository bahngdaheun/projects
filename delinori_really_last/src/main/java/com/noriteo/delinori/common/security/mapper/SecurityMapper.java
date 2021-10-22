package com.noriteo.delinori.common.security.mapper;

import com.noriteo.delinori.common.security.domain.SecurityMember;
import org.apache.ibatis.annotations.Select;

public interface SecurityMapper {

    SecurityMember findByMid(String mid);


    String getTime();
}
