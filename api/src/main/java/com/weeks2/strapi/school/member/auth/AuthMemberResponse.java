package com.weeks2.strapi.school.member.auth;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.weeks2.strapi.school.member.Member;

public class AuthMemberResponse {
        private String jwt;
        @JsonProperty("member")
        private Member member;

    public String getJwt() { return jwt; }

    public void setJwt(String jwt) { this.jwt = jwt; }

    public Member getMember() { return member; }

    public void setMember(Member member) { this.member = member; }
}
