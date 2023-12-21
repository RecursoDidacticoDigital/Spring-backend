package com.weeks2.strapi.api.local;

import com.fasterxml.jackson.annotation.JsonProperty;

public class AuthResponse {
        private String jwt;
        @JsonProperty("user")
        private AuthUser user;

    public String getJwt() {
        return jwt;
    }

    public void setJwt(String jwt) {
        this.jwt = jwt;
    }

    public AuthUser getUser() {
        return user;
    }

    public void setUser(AuthUser user) {
        this.user = user;
    }
}
