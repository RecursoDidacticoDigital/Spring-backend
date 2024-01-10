package com.weeks2.strapi.school.member.auth;

import com.weeks2.strapi.api.common.AppEndPointsSchool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
@Controller
@RequestMapping(AppEndPointsSchool.MEMBER_AUTH_PATH)
public class StrapiMemberAuthController {
    @Autowired
    private StrapiMemberAuthService loginService;

    @PostMapping("/local")
    public ResponseEntity<AuthMemberResponse> authenticate(@RequestBody AuthMemberRequest authMemberRequest){
        return loginService.auth(authMemberRequest);
    }
}