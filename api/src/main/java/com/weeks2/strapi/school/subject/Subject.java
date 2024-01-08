package com.weeks2.strapi.school.subject;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class Subject {
    @JsonProperty("id")
    private int id;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Attributes attributes;
    @Data
    public static class Attributes{
        @JsonInclude(JsonInclude.Include.NON_NULL)
        Integer id;
        private String group;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String name;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String classroom;
        private String laboratory;
        private String teacher;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer day_id1;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer day_id2;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer day_id3;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer day_id4;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer day_id5;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer timeblock_id1;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer timeblock_id2;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer timeblock_id3;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer timeblock_id4;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer timeblock_id5;
    }
}