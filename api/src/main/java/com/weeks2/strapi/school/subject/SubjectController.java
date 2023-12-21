package com.weeks2.strapi.school.subject;
import com.weeks2.strapi.api.common.AppEndPointsSchool;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Slf4j
@RestController
@RequestMapping(AppEndPointsSchool.SUBJECT_PATH_)
public class SubjectController {
    @Autowired
    private SubjectService subjectService;
    @GetMapping
    public List<Subject.Attributes> get(@RequestHeader HttpHeaders headers) {
        return subjectService.fetch(headers);
    }

    @GetMapping("/{id}")
    public List<Subject.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return subjectService.findById(headers,id);
    }

    @DeleteMapping("/{id}/delete")
    public List<Subject.Attributes> delete(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return subjectService.findById(headers,id);
    }

    @PutMapping("/{id}/put")
    public List<Subject.Attributes> put(@RequestHeader HttpHeaders headers, @PathVariable("id") int id){
        return subjectService.findById(headers, id);
    }

    @PostMapping
    public ResponseEntity<String> create(@RequestHeader HttpHeaders headers, @RequestBody Subject.Attributes body) {
        log.info("{}",body);
        // Id auto-incremental
        // TODO: Poner esto en un método.
        if(body.getId() == null){
            int i = 1;
            List<Subject.Attributes> subjectExist = subjectService.fetch(headers);
            if(!subjectExist.isEmpty()){
                while(i <= subjectExist.size()){
                    if(i == subjectExist.size()){
                        body.setId(i+1);
                        break;
                    }
                    i++;
                }
            } else {
                body.setId(1);
            }
        }
        subjectService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
