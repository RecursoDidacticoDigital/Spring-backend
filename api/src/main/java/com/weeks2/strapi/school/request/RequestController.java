package com.weeks2.strapi.school.request;
import com.weeks2.strapi.api.common.AppEndPointsSchool;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Slf4j
@RestController
@RequestMapping(AppEndPointsSchool.REQUEST_PATH_)
public class RequestController {
    @Autowired
    private RequestService requestService;
    @GetMapping
    public List<Request.Attributes> get(@RequestHeader HttpHeaders headers) {
        return requestService.fetch(headers);
    }

    @GetMapping("/{id}")
    public List<Request.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return requestService.findById(headers,id);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        requestService.delete(headers,id);
        return ResponseEntity.ok("SUCCESS");
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> put(@RequestHeader HttpHeaders headers, @PathVariable("id") int id, @RequestBody Request.Attributes body){
        requestService.put(headers, id, body);
        return ResponseEntity.ok("SUCCESS");
    }

    @PostMapping
    public ResponseEntity<String> create(@RequestHeader HttpHeaders headers, @RequestBody Request.Attributes body) {
        requestService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
