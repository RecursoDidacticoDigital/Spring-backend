package com.weeks2.strapi.school.teacher;
import com.weeks2.strapi.api.common.AppEndPointsSchool;
import com.weeks2.strapi.school.day.Day;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(AppEndPointsSchool.TEACHER_PATH_)
public class TeacherController {
    @Autowired
    private TeacherService teacherService;
    @GetMapping
    public List<Teacher.Attributes> get(@RequestHeader HttpHeaders headers) {
        return teacherService.fetch(headers);
    }

    @GetMapping("/{id}")
    public List<Teacher.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return teacherService.findById(headers,id);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        teacherService.delete(headers,id);
        return ResponseEntity.ok("SUCCESS");
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> put(@RequestHeader HttpHeaders headers, @PathVariable("id") int id, @RequestBody Teacher.Attributes body){
        teacherService.put(headers, id, body);
        return ResponseEntity.ok("SUCCESS");
    }

    @PostMapping
    public ResponseEntity create(@RequestHeader HttpHeaders headers, @RequestBody Teacher.Attributes body) {
        teacherService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
