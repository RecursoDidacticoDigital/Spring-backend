package com.weeks2.strapi.school.classroom;

import com.weeks2.strapi.common.ClientRest;
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

    public List<Classroom.Attributes> findById(HttpHeaders authHeader,int id) {
        return fetch(authHeader).stream()
                .filter(l-> l.getId() == id)
                .collect(Collectors.toList());
    }
}
