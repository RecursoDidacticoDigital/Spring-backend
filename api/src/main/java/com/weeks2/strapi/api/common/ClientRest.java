package com.weeks2.strapi.api.common;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.weeks2.strapi.school.day.Day;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Service
public class ClientRest {

    @Autowired
    private RestTemplate restTemplate;

    @Autowired private ObjectMapper mapper;

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

    /**
     * update complete payload
     */

    public <P, R> R  httpPutRequest(String url, HttpHeaders authHeader, P payload, Class<R> response) {
        return restTemplate.exchange(url, HttpMethod.PUT, new HttpEntity<>(payload,buildHeaders(authHeader)), response).getBody();
    }

    /**
     * Update partial payload
     */
    public <P, R> R  httpPathRequest(String url, HttpHeaders authHeader, P payload, Class<R> response) {
        return restTemplate.exchange(url, HttpMethod.PATCH, new HttpEntity<>(payload,buildHeaders(authHeader)), response).getBody();
    }

    public <T> T mapNode(JsonNode json, Class<T> responseType) throws JsonProcessingException {
        return mapper.readValue(json.get("attributes").toString(), responseType);
    }

    @Data
    public static class DataList {
        List<JsonNode> data;
        public DataList(){}
    }
}
