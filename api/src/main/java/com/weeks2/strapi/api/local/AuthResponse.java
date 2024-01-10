package com.weeks2.strapi.api.local;

import com.fasterxml.jackson.annotation.JsonProperty;

public class AuthResponse {
        private String jwt;
        @JsonProperty("user")
        private AuthUser user;
        private String role;
        private String errorMessage;


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

    public String getRole() { return role; }

    public void setRole(String role) { this.role = role; }

    public String getErrorMessage(){
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage){
        this.errorMessage = errorMessage;
    }
}
