package com.weeks2.strapi.api.lesson;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
@Data
public class LessonData {
    @JsonProperty("data")
    Lesson data;

    public Lesson getData() {
        return data;
    }

    public void setData(Lesson data) {
        this.data = data;
    }
}
