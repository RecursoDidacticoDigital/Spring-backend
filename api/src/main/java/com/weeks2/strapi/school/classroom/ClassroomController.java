package com.weeks2.strapi.school.classroom;
import com.weeks2.strapi.api.common.AppEndPointsSchool;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Slf4j
@RestController
@RequestMapping(AppEndPointsSchool.CLASSROOM_PATH_)
public class ClassroomController {
    @Autowired
    private ClassroomService classroomService;
    @GetMapping
    public List<Classroom.Attributes> get(@RequestHeader HttpHeaders headers) {
        return classroomService.fetch(headers);
    }

    @GetMapping("/{id}")
    public List<Classroom.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return classroomService.findById(headers,id);
    }

    @DeleteMapping("/{id}")
    public List<Classroom.Attributes> delete(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return classroomService.findById(headers,id);
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> put(@RequestHeader HttpHeaders headers, @PathVariable("id") int id, @RequestBody Classroom.Attributes body){
        classroomService.put(headers, id, body);
        return ResponseEntity.ok("SUCCESS");
    }

    @PostMapping
    public ResponseEntity<String> create(@RequestHeader HttpHeaders headers, @RequestBody Classroom.Attributes body) {
        classroomService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
