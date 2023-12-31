package com.weeks2.strapi.common;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.weeks2.strapi.api.common.ClientRest;
import com.weeks2.strapi.api.common.Filters;
import com.weeks2.strapi.api.lesson.Lesson;
import com.weeks2.strapi.api.lesson.LessonModel;
import com.weeks2.strapi.api.local.AuthRequest;
import com.weeks2.strapi.api.local.AuthResponse;
import com.weeks2.strapi.api.local.AuthService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;

import java.util.stream.Collectors;

@Slf4j
@SpringBootTest
class DataConverterTest {
    @Autowired
    ClientRest clientRest;

    @Autowired
    AuthService strapiAuthService;

    @Value("${strapi.lesson}")
    private String url;


    private ResponseEntity<AuthResponse> token;

    @BeforeEach
    void init() {
        token = strapiAuthService.auth(new AuthRequest("ch.ibarrac@gmail.com",
                "91b4d142823f7d20c5f08df69122de43f35f057a988d9619f6d3138485c9a203")
        );
    }

    @Test
    void testResponse()  {
        var data = clientRest.httpGetRequest(uriFilter(),createHeaders(), ClientRest.DataList.class)
                .getData()
                .stream()
                .map(jsonNode -> toLesson(jsonNode))
                .collect(Collectors.toList());

        log.info("data {}",data);

    }

    private String uriFilter(){
        return Filters.addFilter(url,"id",Filters.EQ,"1195");
    }

    @Test
    void testURIFilter() {
        log.info("{}",uriFilter());
    }

    private LessonModel toLesson(JsonNode jsonNode) {
        try {
            log.info("{}",jsonNode);
            var attributes = clientRest.mapNode(jsonNode, LessonModel.class);
            attributes.setId(jsonNode.get("id").asInt());
            return attributes;
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    private HttpHeaders createHeaders() {
        var headers = new HttpHeaders();
        headers.set("Authorization", "Bearer "+ token.getBody().getJwt());
        headers.set("Content-Type", "application/json");
        return headers;
    }
}
