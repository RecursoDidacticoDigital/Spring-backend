package com.weeks2.strapi.school.timeblock;
import com.weeks2.strapi.common.AppEndPointsSchool;
import com.weeks2.strapi.school.subject.Subject;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Slf4j
@RestController
@RequestMapping(AppEndPointsSchool.TIMEBLOCK_PATH_)
public class TimeblockController {
    @Autowired
    private TimeblockService timeblockService;
    @GetMapping
    public List<Timeblock.Attributes> get(@RequestHeader HttpHeaders headers) {
        return timeblockService.fetch(headers);
    }

    @GetMapping("/{id}")
    public List<Timeblock.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return timeblockService.findById(headers,id);
    }

    @PostMapping
    public ResponseEntity<String> create(@RequestHeader HttpHeaders headers, @RequestBody Timeblock.Attributes body) {
        log.info("{}",body);
        // Id auto-incremental
        // TODO: Poner esto en un método.
        if(body.getId() == null){
            int i = 1;
            List<Timeblock.Attributes> timeblockExist = timeblockService.fetch(headers);
            if(!timeblockExist.isEmpty()){
                while(i <= timeblockExist.size()){
                    if(i == timeblockExist.size()){
                        body.setId(i+1);
                        break;
                    }
                    i++;
                }
            } else {
                body.setId(1);
            }
        }
        timeblockService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
