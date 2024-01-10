package com.weeks2.strapi.school.member;
import com.weeks2.strapi.api.common.AppEndPointsSchool;
import com.weeks2.strapi.api.local.AuthResponse;
import com.weeks2.strapi.school.member.auth.AuthMemberRequest;
import com.weeks2.strapi.school.member.auth.AuthMemberResponse;
import com.weeks2.strapi.school.utility.SecurityUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Slf4j
@CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
@RestController
@RequestMapping(AppEndPointsSchool.MEMBER_PATH_)
public class MemberController {
    @Autowired
    private MemberService memberService;
    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @GetMapping
    public List<Member.Attributes> get(@RequestHeader HttpHeaders headers) {
        return memberService.fetch(headers);
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @GetMapping("/{id}")
    public List<Member.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return memberService.findById(headers,id);
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        memberService.delete(headers,id);
        return ResponseEntity.ok("SUCCESS");
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @PutMapping("/{id}")
    public ResponseEntity<String> put(@RequestHeader HttpHeaders headers, @PathVariable("id") int id, @RequestBody Member.Attributes body){
        memberService.put(headers, id, body);
        return ResponseEntity.ok("SUCCESS"+body);
    }

    @PostMapping
    public ResponseEntity<String> create(@RequestBody Member.Attributes body) {
        log.info("{}",body);

        // Encode the password
        if(body.getPassword() != null && !body.getPassword().isEmpty()){
            String encodedPassword = SecurityUtils.toSHA256(body.getPassword());
            body.setPassword(encodedPassword);
        }

        // Assign rol if not provided
        if(body.getRol() == null && body.getAccount() != null){
            memberService.assignRol(body);
        }
        if(body.getAccount() == null){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Account is necessary");
        }
        log.info("{}",body);
        memberService.createMember(body);
        return ResponseEntity.ok("SUCCESSFUL");
    }

    @PostMapping("/local")
    public ResponseEntity<AuthResponse> authenticate(@RequestBody AuthMemberRequest authMemberRequest){
        // Hash the password
        String passwordHash = SecurityUtils.toSHA256(authMemberRequest.getPassword());
        return memberService.validateMemberAccount(authMemberRequest, passwordHash);
    }
}
