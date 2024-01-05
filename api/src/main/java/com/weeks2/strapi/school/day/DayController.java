package com.weeks2.strapi.school.day;
import com.weeks2.strapi.api.common.AppEndPointsSchool;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Slf4j
@RestController
@RequestMapping(AppEndPointsSchool.DAY_PATH_)
public class DayController {
    @Autowired
    private DayService dayService;
    @GetMapping
    public List<Day.Attributes> get(@RequestHeader HttpHeaders headers) {
        return dayService.fetch(headers);
    }

    @GetMapping("/{id}")
    public List<Day.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return dayService.findById(headers,id);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        dayService.delete(headers,id);
        return ResponseEntity.ok("SUCCESS");
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> put(@RequestHeader HttpHeaders headers, @PathVariable("id") int id, @RequestBody Day.Attributes body){
        dayService.put(headers, id, body);
        return ResponseEntity.ok("SUCCESS");
    }

    @PostMapping
    public ResponseEntity<String> create(@RequestHeader HttpHeaders headers, @RequestBody Day.Attributes body) {
        dayService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
