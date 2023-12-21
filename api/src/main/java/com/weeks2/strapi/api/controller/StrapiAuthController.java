package com.weeks2.strapi.api.controller;

import com.weeks2.strapi.api.local.AuthRequest;
import com.weeks2.strapi.api.local.AuthResponse;
import com.weeks2.strapi.api.service.StrapiAuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/api/auth")
public class StrapiAuthController {
    @Autowired
    private StrapiAuthService loginService;

    @PostMapping("/local")
    public ResponseEntity<AuthResponse> authenticate(@RequestBody AuthRequest authRequest) {
        return loginService.auth(authRequest);
    }
}
