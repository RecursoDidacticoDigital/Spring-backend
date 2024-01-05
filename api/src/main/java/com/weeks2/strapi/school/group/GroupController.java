package com.weeks2.strapi.school.group;
import com.weeks2.strapi.api.common.AppEndPointsSchool;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Slf4j
@RestController
@RequestMapping(AppEndPointsSchool.GROUP_PATH_)
public class GroupController {
    @Autowired
    private GroupService groupService;
    @GetMapping
    public List<Group.Attributes> get(@RequestHeader HttpHeaders headers) {
        return groupService.fetch(headers);
    }

    @GetMapping("/{id}")
    public List<Group.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return groupService.findById(headers,id);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        groupService.delete(headers,id);
        return ResponseEntity.ok("SUCCESS");
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> put(@RequestHeader HttpHeaders headers, @PathVariable("id") int id, @RequestBody Group.Attributes body){
        groupService.put(headers, id, body);
        return ResponseEntity.ok("{\n"+body+"\n}");
    }

    @PostMapping
    public ResponseEntity<String> create(@RequestHeader HttpHeaders headers, @RequestBody Group.Attributes body) {
        groupService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
