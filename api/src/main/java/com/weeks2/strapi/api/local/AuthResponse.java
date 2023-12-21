package com.weeks2.strapi.api.local;

import com.fasterxml.jackson.annotation.JsonProperty;

public class AuthResponse {
        private String jwt;
        @JsonProperty("user")
        private UserStrapi user;

    public String getJwt() {
        return jwt;
    }

    public void setJwt(String jwt) {
        this.jwt = jwt;
    }

    public UserStrapi getUser() {
        return user;
    }

    public void setUser(UserStrapi user) {
        this.user = user;
    }
}
