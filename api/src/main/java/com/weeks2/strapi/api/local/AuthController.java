package com.weeks2.strapi.api.local;

import com.weeks2.strapi.api.common.AppEndPointsSchool;
import com.weeks2.strapi.school.member.MemberService;
import com.weeks2.strapi.school.member.auth.AuthMemberRequest;
import com.weeks2.strapi.school.utility.SecurityUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
@Controller
@RequestMapping(AppEndPointsSchool.AUTH_PATH)
@Slf4j
public class AuthController {
    @Autowired
    private MemberService loginService;

    @PostMapping("/local")
    public ResponseEntity<AuthResponse> authenticate(@RequestBody AuthMemberRequest authMemberRequest){
        // Hash the password
        String passwordHash = SecurityUtils.toSHA256(authMemberRequest.getPassword());
        return loginService.validateMemberAccount(authMemberRequest, passwordHash);
    }

    @GetMapping("/local/headers")
    public ResponseEntity<AuthResponse> authHeaders(@RequestHeader HttpHeaders headers){
        log.info("GET REQUEST: authHeaders {}", headers);
        try{
            String authHeader = headers.getFirst(HttpHeaders.AUTHORIZATION);
            if(authHeader != null && authHeader.startsWith("Bearer")){
                String token = authHeader.substring(7);

                boolean isValidToken = loginService.validateToken(token);
                if(!isValidToken){
                    throw new Exception("Invalid token");
                }
                log.info("Authorization succestul!");
                return ResponseEntity.status(HttpStatus.ACCEPTED).body(new AuthResponse());
            } else {
                throw new Exception("Authorization header is missing or doesn't contain a Bearer token");
            }
        } catch(Exception e){
            log.error("Error in authHeaders: {}", e.getMessage());
            return ResponseEntity
                    .status(HttpStatus.UNAUTHORIZED)
                    .build();
        }
    }
}
