package com.weeks2.strapi.school.teacher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/teacher")
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

    @PostMapping
    public ResponseEntity create(@RequestHeader HttpHeaders headers, @RequestBody Teacher.Attributes body) {
        teacherService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
