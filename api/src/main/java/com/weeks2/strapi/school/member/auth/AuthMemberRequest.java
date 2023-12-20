package com.weeks2.strapi.school.member.auth;

import lombok.Data;

@Data
public class AuthMemberRequest {
    private String account;
    private String password;

    public AuthMemberRequest(String account, String password){
        this.account = account;
        this.password = password;
    }
}
