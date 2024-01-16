package com.weeks2.strapi.school.classroom;

import com.weeks2.strapi.api.common.ClientRest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class ClassroomService {
    @Value("${strapi.classroom}")
    private String url;
    @Autowired
    private ClientRest rest;

    public List<Classroom.Attributes> fetch(HttpHeaders authHeader) {
        return rest.httpGetRequest(url, authHeader, ClassroomList.class)
                .getClassrooms().stream()
                .map(this::toClassroomWithId)
                .collect(Collectors.toList());
    }

    private Classroom.Attributes toClassroomWithId(Classroom classroom) {
        var l = classroom.getAttributes();
        l.setId(classroom.getId());
        return l;
    }

    public void create(HttpHeaders headers,Classroom.Attributes data) {
        log.info("Data: ");
        var payload = new ClassroomPayload();
        payload.setData(data);

        var response = rest.httpPostRequest(url, headers,payload, ClassroomData.class);
        log.info("response {}",response);
    }

    public void delete(HttpHeaders headers, int id){
        rest.httpDeleteRequest(url+"/"+id, headers);
    }

    public List<Classroom.Attributes> findById(HttpHeaders authHeader,int id) {
        return fetch(authHeader).stream()
                .filter(l-> l.getId() == id)
                .collect(Collectors.toList());
    }

    public List<Classroom.Attributes> findByName(HttpHeaders authHeader, String name) {
        return fetch(authHeader).stream()
                .filter(classroom -> classroom.getName().equals(name))
                .collect(Collectors.toList());
    }

    public void put(HttpHeaders headers, int id, Classroom.Attributes body){
        var payload = getClassroomPayload(body);
        var response = rest.httpPutRequest(url+"/"+id, headers, payload, ClassroomData.class).getData();
        log.info("{}",response);
    }

    public void patch(HttpHeaders headers, int id, Classroom.Attributes body){
        var payload = getClassroomPayload(body);
        var response = rest.httpPatchRequest(url+"/"+id, headers, payload, ClassroomData.class).getData();
        log.info("{}",response);
    }

    private static ClassroomPayload getClassroomPayload(Classroom.Attributes data) {
        var payload = new ClassroomPayload();
        payload.setData(data);
        return payload;
    }
}
