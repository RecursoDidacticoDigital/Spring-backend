package com.weeks2.strapi.school.member;
import com.weeks2.strapi.common.AppEndPointsSchool;
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

    @DeleteMapping("/{id}/delete")
    public List<Member.Attributes> delete(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return memberService.findById(headers,id);
    }

    @PutMapping("/{id}/put")
    public List<Member.Attributes> put(@RequestHeader HttpHeaders headers, @PathVariable("id") int id){
        return memberService.findById(headers, id);
    }

    @PostMapping
    public ResponseEntity<String> create(@RequestHeader HttpHeaders headers, @RequestBody Member.Attributes body) {
        log.info("{}",body);
        if(body.getRol() == null && body.getAccount() != null){
            if(body.getAccount().length() == 10){
                body.setRol("STUDENT");
            }
            if(body.getAccount().length() == 6){
                body.setRol("TEACHER");
            }
        }
        else{
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Account is necessary");
        }
        log.info("{}",body);
        memberService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
