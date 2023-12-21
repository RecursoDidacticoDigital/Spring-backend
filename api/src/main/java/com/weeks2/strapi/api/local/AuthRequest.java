package com.weeks2.strapi.api.local;

import lombok.Data;

@Data
public class AuthRequest {
    private String identifier;
    private String password;

    public AuthRequest(String identifier, String password) {
        this.identifier = identifier;
        this.password = password;
    }
}