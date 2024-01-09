package com.weeks2.strapi.school.member;
import com.weeks2.strapi.api.common.AppEndPointsSchool;
import com.weeks2.strapi.api.local.AuthResponse;
import com.weeks2.strapi.school.member.auth.AuthMemberRequest;
import com.weeks2.strapi.school.member.auth.AuthMemberResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Slf4j
@RestController
@RequestMapping(AppEndPointsSchool.MEMBER_PATH_)
public class MemberController {
    @Autowired
    private MemberService memberService;
    @GetMapping
    public List<Member.Attributes> get(@RequestHeader HttpHeaders headers) {
        return memberService.fetch(headers);
    }

    @GetMapping("/{id}")
    public List<Member.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return memberService.findById(headers,id);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        memberService.delete(headers,id);
        return ResponseEntity.ok("SUCCESS");
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> put(@RequestHeader HttpHeaders headers, @PathVariable("id") int id, @RequestBody Member.Attributes body){
        memberService.put(headers, id, body);
        return ResponseEntity.ok("SUCCESS"+body);
    }

    @PostMapping
    public ResponseEntity<String> create(@RequestBody Member.Attributes body) {
        log.info("{}",body);
        // Id auto-incremental
        if(body.getRol() == null && body.getAccount() != null){
            memberService.assignRol(body);
        }
        else{
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Account is necessary");
        }
        log.info("{}",body);
        memberService.createMember(body);
        return ResponseEntity.ok("SUCCESSFUL");
    }

    @PostMapping("/local")
    public ResponseEntity<AuthResponse> authenticate(@RequestBody AuthMemberRequest authMemberRequest){
        return memberService.validateMemberAccount(authMemberRequest);
    }
    /*
    {
        "identifier": "normanroa97@hotmail.com",
        "password": "91b4d142823f7d20c5f08df69122de43f35f057a988d9619f6d3138485c9a203"
    }
    */
}
