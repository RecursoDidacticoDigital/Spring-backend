package com.weeks2.strapi.school.subject;

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
public class SubjectService {
    @Value("${strapi.subject}")
    private String url;
    @Autowired
    private ClientRest rest;

    public List<Subject.Attributes> fetch(HttpHeaders authHeader) {
        return rest.httpGetRequest(url, authHeader, SubjectList.class)
                .getSubjects().stream()
                .map(this::toSubjectWithId)
                .collect(Collectors.toList());
    }

    private Subject.Attributes toSubjectWithId(Subject subject) {
        var l = subject.getAttributes();
        l.setId(subject.getId());
        return l;
    }

    public void create(HttpHeaders headers,Subject.Attributes body) {
        log.info("Data: ");
        var payload = getSubjectPayload(body);
        var response = rest.httpPostRequest(url, headers,payload, SubjectData.class);
        log.info("response {}",response);
    }

    public void delete(HttpHeaders headers, int id){
        rest.httpDeleteRequest(url+"/"+id, headers);
    }

    public List<Subject.Attributes> findById(HttpHeaders authHeader,int id) {
        return fetch(authHeader).stream()
                .filter(l-> l.getId() == id)
                .collect(Collectors.toList());
    }

    public List<Subject.Attributes> findByString(HttpHeaders authHeader,String string) {
        return fetch(authHeader).stream()
                .filter(l-> l.getClassroom().equals(string))
                .collect(Collectors.toList());
    }

    public void put(HttpHeaders headers, int id, Subject.Attributes body){
        var payload = getSubjectPayload(body);
        var response = rest.httpPutRequest(url+"/"+id, headers, payload, SubjectData.class).getData();
        log.info("{}",response);
    }

    public void putByName(HttpHeaders headers, String name, Subject.Attributes body){
        var payload = getSubjectPayload(body);
        var response = rest.httpPutRequest(url+"/"+name, headers, payload, SubjectData.class).getData();
        log.info("{}",response);
    }

    public void patch(HttpHeaders headers, int id, Subject.Attributes body){
        var payload = getSubjectPayload(body);
        var response = rest.httpPatchRequest(url+"/"+id, headers, payload, SubjectData.class).getData();
        log.info("{}",response);
    }

    private static SubjectPayload getSubjectPayload(Subject.Attributes data) {
        var payload = new SubjectPayload();
        payload.setData(data);
        return payload;
    }
}
