package com.weeks2.strapi.api.local;

import com.weeks2.strapi.api.common.AppEndPointsSchool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(AppEndPointsSchool.AUTH_PATH)
public class AuthController {
    @Autowired
    private AuthService loginService;

    @PostMapping("/local")
    public ResponseEntity<AuthResponse> authenticate(@RequestBody AuthRequest authRequest) {
        return loginService.auth(authRequest);
    }
}
