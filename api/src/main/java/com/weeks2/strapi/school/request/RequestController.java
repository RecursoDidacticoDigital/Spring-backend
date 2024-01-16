package com.weeks2.strapi.school.request;
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
@RequestMapping(AppEndPointsSchool.REQUEST_PATH_)
public class RequestController {
    @Autowired
    private RequestService requestService;
    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @GetMapping
    public List<Request.Attributes> get(@RequestHeader HttpHeaders headers) {
        return requestService.fetch(headers);
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @GetMapping("/{id}")
    public List<Request.Attributes> get(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        return requestService.findById(headers,id);
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> delete(@RequestHeader HttpHeaders headers, @PathVariable("id") int id) {
        log.info("id: {}", id);
        log.info("headers: {}", headers);
        requestService.delete(id);
        return ResponseEntity.ok("SUCCESS");
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @PutMapping("/{id}")
    public ResponseEntity<String> put(@RequestHeader HttpHeaders headers, @PathVariable("id") int id, @RequestBody Request.Attributes body){
        requestService.put(headers, id, body);
        return ResponseEntity.ok("SUCCESS");
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @PatchMapping("/{id}")
    public ResponseEntity<String> patch(@RequestHeader HttpHeaders headers, @PathVariable("id") int id, @RequestBody Request.Attributes body){
        requestService.patch(headers, id, body);
        return ResponseEntity.ok("SUCCESS");
    }

    @CrossOrigin(origins = AppEndPointsSchool.FLUTTER_APP_PATH)
    @PostMapping
    public ResponseEntity<String> create(@RequestHeader HttpHeaders headers, @RequestBody Request.Attributes body) {
        requestService.create(headers,body);
        return ResponseEntity.ok("SUCCESSFUL");
    }
}
