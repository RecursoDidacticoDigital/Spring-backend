package com.weeks2.strapi.school.member.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class StrapiMemberAuthService {
    @Autowired
    private RestTemplate restTemplate;
    @Value("${strapi.memberauth}")
    String memberAuthApi;

    public ResponseEntity<AuthMemberResponse> auth(AuthMemberRequest authMemberRequest){
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        return restTemplate.postForEntity(memberAuthApi, new HttpEntity<>(
                String.format("{\"account\": \"%s\", \"password\": \"%s\"}",
                        authMemberRequest.getAccount(),
                        authMemberRequest.getPassword()),
                headers),
                AuthMemberResponse.class);
    }
}
