package com.weeks2.strapi.common;

import com.weeks2.strapi.school.day.Day;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class ClientRest {

    @Autowired
    private RestTemplate restTemplate;

    public <T> T httpGetRequest(String url, HttpHeaders authHeader, Class<T> responseType) {
        return restTemplate.exchange(url, HttpMethod.GET,
                new HttpEntity<>(buildHeaders(authHeader)),
                responseType
        ).getBody();
    }

    public <P, R> R  httpPostRequest(String url, HttpHeaders authHeader, P payload, Class<R> response) {
        return restTemplate.exchange(url, HttpMethod.POST, new HttpEntity<>(payload,buildHeaders(authHeader)), response).getBody();
    }
    private HttpHeaders buildHeaders(HttpHeaders authHeaders) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", authHeaders.getFirst(HttpHeaders.AUTHORIZATION));
        headers.set("Content-Type", "application/json");
        return headers;
    }

    public <P, R> R  httpPutRequest(String url, HttpHeaders authHeader, P payload, Class<R> response) {
        return restTemplate.exchange(url, HttpMethod.PUT, new HttpEntity<>(payload,buildHeaders(authHeader)), response).getBody();
    }
}
