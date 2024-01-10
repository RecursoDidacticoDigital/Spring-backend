package com.weeks2.strapi.school.timeblock;
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
@RequestMapping(AppEndPointsSchool.TIMEBLOCK_PATH_)
public class TimeblockController {
    private final TimeblockService timeblockService;

    public TimeblockController(TimeblockService timeblockService) {
        this.timeblockService = timeblockService;
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @GetMapping
    public List<Timeblock.Attributes> get(@RequestHeader HttpHeaders headers) {
        return timeblockService.fetch(headers);
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @GetMapping("/{id}")
    public List<Timeblock.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return timeblockService.findById(headers,id);
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        timeblockService.delete(headers,id);
        return ResponseEntity.ok("SUCCESS");
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @PutMapping("/{id}")
    public ResponseEntity<String> put(@RequestHeader HttpHeaders headers, @PathVariable("id") int id, @RequestBody Timeblock.Attributes body){
        timeblockService.put(headers, id, body);
        return ResponseEntity.ok("SUCCESS"+body);
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @PostMapping
    public ResponseEntity<String> create(@RequestHeader HttpHeaders headers, @RequestBody Timeblock.Attributes body) {
        log.info("{}",body);
        timeblockService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
