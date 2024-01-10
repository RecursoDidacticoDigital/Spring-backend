package com.weeks2.strapi.api.local;

import com.weeks2.strapi.api.common.AppEndPointsSchool;
import com.weeks2.strapi.school.member.MemberService;
import com.weeks2.strapi.school.member.auth.AuthMemberRequest;
import com.weeks2.strapi.school.utility.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
@Controller
@RequestMapping(AppEndPointsSchool.AUTH_PATH)
public class AuthController {
    @Autowired
    private MemberService loginService;

    @PostMapping("/local")
    public ResponseEntity<AuthResponse> authenticate(@RequestBody AuthMemberRequest authMemberRequest){
        // Hash the password
        String passwordHash = SecurityUtils.toSHA256(authMemberRequest.getPassword());
        return loginService.validateMemberAccount(authMemberRequest, passwordHash);
    }
}
