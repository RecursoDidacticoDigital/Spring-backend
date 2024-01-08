package com.weeks2.strapi.common;

import com.weeks2.strapi.api.common.ClientRest;
import com.weeks2.strapi.api.lesson.Lesson;
import com.weeks2.strapi.api.lesson.LessonData;
import com.weeks2.strapi.api.lesson.LessonList;
import com.weeks2.strapi.api.lesson.LessonPayload;
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
import org.springframework.web.client.HttpClientErrorException;

import java.lang.reflect.Executable;

import static org.junit.jupiter.api.Assertions.*;

@Slf4j
@SpringBootTest
public class ClientRestTest {
    @Autowired
    ClientRest clientRest;

    @Autowired
    AuthService strapiAuthService;
    @Value("${strapi.lesson}")
    private String url;

    private ResponseEntity<AuthResponse> token;

    //@BeforeEach
    void init() {
        token = strapiAuthService.auth(new AuthRequest("normanroa97@hotmail.com",
                "91b4d142823f7d20c5f08df69122de43f35f057a988d9619f6d3138485c9a203")
        );
    }

    @Test
    void testWhenCreateUser() {
        try {
              String username = "test5";
              String email = "c5@gmail.com";
              AuthRequest authRequest = new AuthRequest(email,"000000");
              var userCreated = strapiAuthService.createUser(username,authRequest.getIdentifier(),authRequest.getPassword());
              log.info("{}",userCreated.getUser().getId());
              token = strapiAuthService.auth(new AuthRequest(authRequest.getIdentifier(),authRequest.getPassword()));
        }
        catch (HttpClientErrorException e) {
              log.info("{}",e.getMessage());
        }
        assertNotNull(token);
    }
    @Test
    void testGet(){
        assertTrue(!clientRest.httpGetRequest(url,createHeaders(), LessonList.class).getLessons().isEmpty());
    }

    @Test
    void testPost(){
        var lesson = clientRest.httpPostRequest(url,createHeaders(), getLessonPayload(),
                LessonData.class).getData();
        log.info("{}",lesson);
        assertTrue(1185 < lesson.getId());
    }

    private static LessonPayload getLessonPayload() {
        var payload = new LessonPayload();
        var data = new Lesson.Attributes();
        data.setTitle("T1");
        payload.setData(data);
        return payload;
    }

    private HttpHeaders createHeaders() {
        var headers = new HttpHeaders();
        headers.set("Authorization", "Bearer "+ token.getBody().getJwt());
        headers.set("Content-Type", "application/json");
        return headers;
    }
}
