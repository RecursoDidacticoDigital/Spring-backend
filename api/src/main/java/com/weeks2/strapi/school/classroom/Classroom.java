package com.weeks2.strapi.school.classroom;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.weeks2.strapi.school.subject.Subject;
import lombok.Data;

@Data
public class Classroom {
    @JsonProperty("id")
    private int id;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Attributes attributes;
    @Data
    public static class Attributes{
        @JsonInclude(JsonInclude.Include.NON_NULL)
        Integer id;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String number;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String name;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer subjects;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer building;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer queue;
    }
}
