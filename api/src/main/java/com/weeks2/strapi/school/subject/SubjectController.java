package com.weeks2.strapi.school.subject;
import com.weeks2.strapi.api.common.AppEndPointsSchool;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Slf4j
@CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
@RestController
@RequestMapping(AppEndPointsSchool.SUBJECT_PATH_)
public class SubjectController {
    @Autowired
    private SubjectService subjectService;
    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @GetMapping
    public List<Subject.Attributes> get(@RequestHeader HttpHeaders headers) {
        return subjectService.fetch(headers);
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @GetMapping("/findById/{id}")
    public List<Subject.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return subjectService.findById(headers,id);
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @GetMapping("/findByString/{string}")
    public List<Subject.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("string") String string) {
        return subjectService.findByString(headers,string);
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        subjectService.delete(headers,id);
        return ResponseEntity.ok("SUCCESS");
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @PutMapping("/{id}")
    public ResponseEntity<String> put(@RequestHeader HttpHeaders headers, @PathVariable("id") int id, @RequestBody Subject.Attributes body){
        subjectService.put(headers, id, body);
        return ResponseEntity.ok("SUCCESS"+body);
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @PostMapping
    public ResponseEntity<String> create(@RequestHeader HttpHeaders headers, @RequestBody Subject.Attributes body) {
        log.info("{}",body);
        subjectService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
