package com.weeks2.strapi.school.teacher;

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
public class TeacherService {
    @Value("${strapi.teacher}")
    private String url;
    @Autowired
    private ClientRest rest;

    public List<Teacher.Attributes> fetch(HttpHeaders authHeader) {
        return rest.httpGetRequest(url, authHeader, TeacherList.class)
                .getTeachers().stream()
                .map(this::toTeacherWithId)
                .collect(Collectors.toList());
    }

    private Teacher.Attributes toTeacherWithId(Teacher teacher) {
        var l = teacher.getAttributes();
        l.setId(teacher.getId());
        return l;
    }

    public void create(HttpHeaders headers,Teacher.Attributes body) {
        var payload = getTeacherPayload(body);
        var response = rest.httpPostRequest(url, headers,payload, TeacherData.class);
        log.info("response {}",response);
    }

    public void delete(HttpHeaders headers, int id){
        rest.httpDeleteRequest(url+"/"+id, headers);
    }

    public List<Teacher.Attributes> findById(HttpHeaders authHeader,int id) {
        return fetch(authHeader).stream()
                .filter(l-> l.getId() == id)
                .collect(Collectors.toList());
    }

    public void put(HttpHeaders headers, int id, Teacher.Attributes body){
        var payload = getTeacherPayload(body);
        var response = rest.httpPutRequest(url+"/"+id, headers, payload, TeacherData.class).getData();
        log.info("{}",response);
    }

    private static TeacherPayload getTeacherPayload(Teacher.Attributes data) {
        var payload = new TeacherPayload();
        payload.setData(data);
        return payload;
    }
}
