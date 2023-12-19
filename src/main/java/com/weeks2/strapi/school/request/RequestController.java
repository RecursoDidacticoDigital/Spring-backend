package com.weeks2.strapi.school.request;
import com.weeks2.strapi.common.Constants;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@Slf4j
@RestController
@RequestMapping(Constants.API+"/request")
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

    @PostMapping
    public ResponseEntity<String> create(@RequestHeader HttpHeaders headers, @RequestBody Request.Attributes body) {
        requestService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
