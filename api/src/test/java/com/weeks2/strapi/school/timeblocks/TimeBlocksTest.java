package com.weeks2.strapi.school.timeblocks;

import com.weeks2.strapi.api.common.ClientRest;
import com.weeks2.strapi.api.lesson.LessonData;
import com.weeks2.strapi.api.local.AuthRequest;
import com.weeks2.strapi.api.local.AuthResponse;
import com.weeks2.strapi.api.local.AuthService;
import com.weeks2.strapi.school.timeblock.Timeblock;
import com.weeks2.strapi.school.timeblock.TimeblockData;
import com.weeks2.strapi.school.timeblock.TimeblockPayload;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;

import java.sql.Time;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

@Slf4j
@SpringBootTest
public class TimeBlocksTest {
    @Autowired
    ClientRest clientRest;

    @Autowired
    AuthService strapiAuthService;
    @Value("${strapi.timeblock}")
    private String url;

    private ResponseEntity<AuthResponse> token;

    @BeforeEach
    void init() {
        token = strapiAuthService.auth(new AuthRequest("normanroa97@hotmail.com",
                "91b4d142823f7d20c5f08df69122de43f35f057a988d9619f6d3138485c9a203")
        );
    }
    @Test
    void testPatch(){
        var timeblock = clientRest.httpPathRequest(url,createHeaders(), createPayload(), TimeblockData.class).getData();
        log.info("{}",timeblock);
        assertTrue(1185 < timeblock.getId());
    }

    private static TimeblockPayload createPayload() {
        var payload = new TimeblockPayload();
        var data = new Timeblock.Attributes();
        data.setStartTime(Time.valueOf("23:00:00"));
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
