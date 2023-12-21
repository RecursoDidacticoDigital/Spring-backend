package com.weeks2.strapi.api.lesson;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class LessonList {
    @JsonProperty("data")
    List<Lesson> lessons;

    public List<Lesson> getLessons() {
        return lessons;
    }
    public void setLessons(List<Lesson> lessons) {
        this.lessons = lessons;
    }
}
