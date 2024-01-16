package com.weeks2.strapi.school.request;

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
public class RequestService {
    @Value("${strapi.request}")
    private String url;
    @Autowired
    private ClientRest rest;

    public List<Request.Attributes> fetch(HttpHeaders authHeader) {
        return rest.httpGetRequest(url, authHeader, RequestList.class)
                .getRequests().stream()
                .map(this::toRequestWithId)
                .collect(Collectors.toList());
    }

    private Request.Attributes toRequestWithId(Request request) {
        var l = request.getAttributes();
        l.setId(request.getId());
        return l;
    }

    public void create(HttpHeaders headers,Request.Attributes body) {
        log.info("Data: ");
        var payload = getRequestPayload(body);
        var response = rest.httpPostRequest(url, headers,payload, RequestData.class);
        log.info("response {}",response);
    }

    public void delete(int id){
        rest.httpDeleteRequest2(url+"/"+id);
    }

    public List<Request.Attributes> findById(HttpHeaders authHeader,int id) {
        return fetch(authHeader).stream()
                .filter(l-> l.getId() == id)
                .collect(Collectors.toList());
    }

    public void put(HttpHeaders headers, int id, Request.Attributes body){
        var payload = getRequestPayload(body);
        var response = rest.httpPutRequest(url+"/"+id, headers, payload, RequestData.class).getData();
        log.info("{}",response);
    }

    public void patch(HttpHeaders headers, int id, Request.Attributes body){
        var payload = getRequestPayload(body);
        var response = rest.httpPatchRequest(url+"/"+id, headers, payload, RequestData.class).getData();
        log.info("{}",response);
    }

    private static RequestPayload getRequestPayload(Request.Attributes data) {
        var payload = new RequestPayload();
        payload.setData(data);
        return payload;
    }
}
