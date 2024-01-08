package com.weeks2.strapi.school.member;

import com.weeks2.strapi.api.common.ClientRest;
import com.weeks2.strapi.api.local.AuthRequest;
import com.weeks2.strapi.api.local.AuthResponse;
import com.weeks2.strapi.api.local.AuthService;
import com.weeks2.strapi.school.member.auth.AuthMemberRequest;
import com.weeks2.strapi.school.member.auth.AuthMemberResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.stream.Collectors;


@Service
@Slf4j
public class MemberService {
    @Value("${strapi.member}")
    private String url;
    @Autowired
    private ClientRest rest;
    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    AuthService auth;
    private ResponseEntity<AuthResponse> token;


    public void createMember(Member.Attributes data) {
        String memberAccount = data.getAccount();
        String memberPassword = data.getPassword();
        String memberName = data.getName();
        String memberEmail = data.getEmail();
        // create member with user and pass
        try{
            var payload = new MemberPayload();
            payload.setData(data);
            AuthMemberRequest request = new AuthMemberRequest(memberAccount, memberPassword);
            HttpHeaders headers = createHeaders(request);
            rest.httpPostRequest(url, headers, payload, MemberData.class);
        }
        catch(HttpClientErrorException e){
            log.info("{}", e.getMessage());
        }

        // create strapi user with member credential
        try{
            AuthRequest authRequest = new AuthRequest(memberEmail, memberPassword);
            var userCreated = auth.createUser(memberName, authRequest.getIdentifier(), authRequest.getPassword());
            log.info("{}",userCreated.getUser().getId());
            token = auth.auth(new AuthRequest(authRequest.getIdentifier(), authRequest.getPassword()));
        }
        catch(HttpClientErrorException e) {
            log.info("{}", e.getMessage());
        }

    }
    @Deprecated
    public void create(HttpHeaders headers,Member.Attributes data) {
        log.info("Data: ");
        var payload = new MemberPayload();
        payload.setData(data);

        var response = rest.httpPostRequest(url, headers,payload,MemberData.class);
        log.info("response {}",response);
    }
    private void validateMemberAccount() {
        // fetch members and validate exist username
        // auth in strapi with credential from member request
    }
    private HttpHeaders createHeaders(AuthMemberRequest auth) {
        token = this.auth.auth(new AuthRequest(auth.getAccount(), auth.getPassword()));
        var headers = new HttpHeaders();
        headers.set("Authorization", "Bearer "+ token.getBody().getJwt());
        headers.set("Content-Type", "application/json");
        return headers;
    }
    private boolean validateUser(AuthMemberRequest authMemberRequest) throws NoSuchMethodException {
        var userValid = fetch(createHeaders(authMemberRequest));
        throw new NoSuchMethodException("Not implemented");
    }

    @Deprecated
    private boolean isAuthenticated(Member.Attributes member, AuthMemberRequest authMemberRequest) {
       return member.getAccount().equals(authMemberRequest.getAccount()) &&
               member.getPassword().equals(authMemberRequest.getPassword());
    }

    public List<Member.Attributes> fetch(HttpHeaders authHeader) {
        return rest.httpGetRequest(url, authHeader, MemberList.class)
                .getMembers().stream()
                .map(this::toMemberWithId)
                .collect(Collectors.toList());
    }

    public ResponseEntity<AuthMemberResponse> auth(AuthMemberRequest authMemberRequest){
        ResponseEntity<AuthMemberResponse> response;
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        log.info("Account: "+authMemberRequest.getAccount());
        log.info("Password: "+authMemberRequest.getPassword());
        log.info("URL: "+url);
        response = restTemplate.postForEntity(url, new HttpEntity<>(
                        String.format("{\"account\": \"%s\", \"password\": \"%s\"}",
                                authMemberRequest.getAccount(),
                                authMemberRequest.getPassword()),
                        headers),
                AuthMemberResponse.class);
        log.info("Template: "+response);
        return response;
    }

    private Member.Attributes toMemberWithId(Member member) {
        var l = member.getAttributes();
        l.setId(member.getId());
        return l;
    }

    public void delete(HttpHeaders headers, int id){
        rest.httpDeleteRequest(url+"/"+id, headers);
    }

    public List<Member.Attributes> findById(HttpHeaders authHeader,int id) {
        return fetch(authHeader).stream()
                .filter(l-> l.getId() == id)
                .collect(Collectors.toList());
    }

    public List<Member.Attributes> findByEmail(HttpHeaders authHeader, String email){
        return fetch(authHeader).stream()
                .filter(l-> l.getEmail().equals(email))
                .collect(Collectors.toList());
    }

    public List<Member.Attributes> findByAccount(HttpHeaders authHeader, String account){
        return fetch(authHeader).stream()
                .filter(l-> l.getAccount().equals(account))
                .collect(Collectors.toList());
    }

    public void put(HttpHeaders headers, int id, Member.Attributes body){
        var payload = getMemberPayload(body);
        var response = rest.httpPutRequest(url+"/"+id, headers, payload, MemberData.class).getData();
        log.info("{}",response);
    }

    private static MemberPayload getMemberPayload(Member.Attributes data) {
        var payload = new MemberPayload();
        payload.setData(data);
        return payload;
    }


    public void assignRol(Member.Attributes body){
        if(body.getAccount().length() == 10){
            body.setRol("STUDENT");
        }
        if(body.getAccount().length() == 6){
            body.setRol("TEACHER");
        }
    }
}
