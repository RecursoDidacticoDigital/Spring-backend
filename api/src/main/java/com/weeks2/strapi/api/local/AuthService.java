package com.weeks2.strapi.api.local;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class AuthService {
    @Autowired
    private RestTemplate restTemplate;
    @Value("${strapi.auth}")
    String authApi;

    @Value("${strapi.register}")
    String authApiRegister;

    public ResponseEntity<AuthResponse> auth(AuthRequest authRequest) {
        return restTemplate.postForEntity(authApi, new HttpEntity<>(
                String.format("{\"identifier\": \"%s\", \"password\": \"%s\"}",
                        authRequest.getIdentifier(),
                        authRequest.getPassword()),
                createHeader()), AuthResponse.class);
    }

    public AuthResponse createUser(String username, String email, String password) {
        return restTemplate.postForObject(authApiRegister, new HttpEntity<>(
                String.format("{\"username\": \"%s\", \"email\":\"%s\", \"password\":\"%s\", \"tenantId\":%d, \"tenantRole\":%d}",
                        username, email, password,0,0), createHeader()), AuthResponse.class);
    }

    private HttpHeaders createHeader() {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        return headers;
    }
}
