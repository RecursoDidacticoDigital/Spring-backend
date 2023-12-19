package com.weeks2.strapi.school.member;

import com.weeks2.strapi.common.ClientRest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class MemberService {
    @Value("${api.member}")
    private String url;
    @Autowired
    private ClientRest rest;

    public List<Member.Attributes> fetch(HttpHeaders authHeader) {
        return rest.httpGetRequest(url, authHeader, MemberList.class)
                .getMembers().stream()
                .map(this::toMemberWithId)
                .collect(Collectors.toList());
    }

    private Member.Attributes toMemberWithId(Member member) {
        var l = member.getAttributes();
        l.setId(member.getId());
        return l;
    }

    public void create(HttpHeaders headers,Member.Attributes data) {
        log.info("Data: ");
        var payload = new MemberPayload();
        payload.setData(data);

        var response = rest.httpPostRequest(url, headers,payload,MemberData.class);
        log.info("response {}",response);
    }

    public List<Member.Attributes> findById(HttpHeaders authHeader,int id) {
        return fetch(authHeader).stream()
                .filter(l-> l.getId() == id)
                .collect(Collectors.toList());
    }
}
