package com.weeks2.strapi.api.controller;
import com.weeks2.strapi.api.lesson.Lesson;
import com.weeks2.strapi.api.common.AppEndPointsSchool;
import com.weeks2.strapi.api.service.LessonService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Slf4j
@RestController
@RequestMapping(AppEndPointsSchool.LESSON_PATH_)
public class LessonController {
    @Autowired
    private LessonService lessonService;
    @GetMapping
    public List<Lesson.Attributes> get(@RequestHeader HttpHeaders headers) {
        return lessonService.fetch(headers);
    }

    @GetMapping("/{id}")
    public List<Lesson.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return lessonService.findById(headers,id);
    }

    @PostMapping
    public ResponseEntity<String> create(@RequestHeader HttpHeaders headers, @RequestBody Lesson.Attributes body) {
        lessonService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
