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

    public ResponseEntity<AuthResponse> auth(AuthRequest authRequest) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        return restTemplate.postForEntity(authApi, new HttpEntity<>(
                String.format("{\"identifier\": \"%s\", \"password\": \"%s\"}",
                        authRequest.getIdentifier(),
                        authRequest.getPassword()),
                headers),
                AuthResponse.class);
    }

    public AuthResponse createUser(String username, String email, String password) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> requestEntity = new HttpEntity<>(String.format("{\"username\": \"%s\", \"email\":\"%s\", \"password\":\"%s\", \"tenantId\":%d, \"tenantRole\":%d}",
                username, email, password,0,0), headers);
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.postForObject("https://api-core-q9s1.onrender.com/api/auth/local/register",
                requestEntity, AuthResponse.class);
    }
}
