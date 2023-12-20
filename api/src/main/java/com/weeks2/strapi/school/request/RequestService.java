package com.weeks2.strapi.school.request;

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

    public void create(HttpHeaders headers,Request.Attributes data) {
        log.info("Data: ");
        var payload = new RequestPayload();
        payload.setData(data);

        var response = rest.httpPostRequest(url, headers,payload, RequestData.class);
        log.info("response {}",response);
    }

    public List<Request.Attributes> findById(HttpHeaders authHeader,int id) {
        return fetch(authHeader).stream()
                .filter(l-> l.getId() == id)
                .collect(Collectors.toList());
    }
}
