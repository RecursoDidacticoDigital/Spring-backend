package com.weeks2.strapi.api.lesson;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.weeks2.strapi.api.common.ClientRest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class LessonMapper {
    @Autowired
    ClientRest clientRest;
    private LessonModel toLesson(JsonNode jsonNode) {
        try {
            log.info("{}",jsonNode);
            var lessonModel = clientRest.mapNode(jsonNode, LessonModel.class);
            lessonModel.setId(jsonNode.get("id").asInt());
            return lessonModel;
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }
}
