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
        private Integer dayid1;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer dayid2;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer dayid3;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer dayid4;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer dayid5;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer timeblockid1;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer timeblockid2;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer timeblockid3;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer timeblockid4;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer timeblockid5;
    }
}