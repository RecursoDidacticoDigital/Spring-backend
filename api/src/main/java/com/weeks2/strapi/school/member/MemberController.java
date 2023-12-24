package com.weeks2.strapi.school.member;
import com.weeks2.strapi.api.common.AppEndPointsSchool;
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
    public List<Member.Attributes> delete(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return memberService.findById(headers,id);
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> put(@RequestHeader HttpHeaders headers, @RequestBody Member.Attributes body){
        memberService.put(headers, body);
        return ResponseEntity.ok("SUCCESS"+body);
    }

    @PostMapping
    public ResponseEntity<String> create(@RequestHeader HttpHeaders headers, @RequestBody Member.Attributes body) {
        log.info("{}",body);
        // Id auto-incremental
        // TODO: Poner esto en un método.
        if(body.getId() == null){
            int i = 1;
            List<Member.Attributes> memberExist = memberService.fetch(headers);
            if(!memberExist.isEmpty()){
                while(i <= memberExist.size()){
                    if(i == memberExist.size()){
                        body.setId(i+1);
                        break;
                    }
                    i++;
                }
            } else {
                body.setId(1);
            }
        }
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
