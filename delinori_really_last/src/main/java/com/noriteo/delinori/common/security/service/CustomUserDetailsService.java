package com.noriteo.delinori.common.security.service;

import com.noriteo.delinori.common.security.domain.SecurityMember;
import com.noriteo.delinori.common.security.dto.SecurityMemberDTO;
import com.noriteo.delinori.common.security.mapper.SecurityMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Log4j2
@RequiredArgsConstructor
@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final SecurityMapper securityMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        log.warn(username);
        log.warn(securityMapper);

        log.warn("CustomUserDetailService------------------------");
        log.warn("CustomUserDetailService------------------------");
        log.warn(securityMapper.getTime());
        log.warn("CustomUserDetailService------------------------");

        SecurityMember securityMember = securityMapper.findByMid(username);

        log.warn("securityMember====================================");
        log.warn(securityMember);

        if (securityMember ==null){
            throw new UsernameNotFoundException("NOT EXIST");
        }

        User result = new SecurityMemberDTO(securityMember);
        return result;
    }
}
