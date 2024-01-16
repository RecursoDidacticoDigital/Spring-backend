package com.weeks2.strapi.school.classroom;
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
@RequestMapping(AppEndPointsSchool.CLASSROOM_PATH_)
public class ClassroomController {
    @Autowired
    private ClassroomService classroomService;

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @GetMapping
    public List<Classroom.Attributes> get(@RequestHeader HttpHeaders headers) {
        return classroomService.fetch(headers);
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @GetMapping("/findById/{id}")
    public List<Classroom.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return classroomService.findById(headers,id);
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @GetMapping("/findByName/{name}")
    public List<Classroom.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("name") String name) {
        return classroomService.findByName(headers,name);
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @GetMapping("/availableByName/{name}")
    public boolean getAvailable(@RequestHeader HttpHeaders headers, @PathVariable("name") String name) {
        log.info("NAME: {}", name);
        boolean result = classroomService.getAvailable(headers,name);
        log.info("RESULT: {}", result);
        return result;
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        classroomService.delete(headers,id);
        return ResponseEntity.ok("SUCCESS");
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @PutMapping("/{id}")
    public ResponseEntity<String> put(@RequestHeader HttpHeaders headers, @PathVariable("id") int id, @RequestBody Classroom.Attributes body){
        classroomService.put(headers, id, body);
        return ResponseEntity.ok("SUCCESS");
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @PatchMapping("/{id}")
    public ResponseEntity<String> patch(@RequestHeader HttpHeaders headers, @PathVariable("id") int id, @RequestBody Classroom.Attributes body){
        classroomService.patch(headers, id, body);
        return ResponseEntity.ok("SUCCESS");
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @PostMapping
    public ResponseEntity<String> create(@RequestHeader HttpHeaders headers, @RequestBody Classroom.Attributes body) {
        classroomService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
