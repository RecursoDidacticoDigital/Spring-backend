package com.weeks2.strapi.common;

import com.weeks2.strapi.api.local.AuthResponse;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;

public class TestUtils {
    public static HttpHeaders createHeaders(ResponseEntity<AuthResponse> token) {
        var headers = new HttpHeaders();
        headers.set("Authorization", "Bearer "+ token.getBody().getJwt());
        headers.set("Content-Type", "application/json");
        return headers;
    }
}
