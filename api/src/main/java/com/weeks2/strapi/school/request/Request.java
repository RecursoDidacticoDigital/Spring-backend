package com.weeks2.strapi.school.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class Request {
    @JsonProperty("id")
    private int id;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Attributes attributes;
    @Data
    public static class Attributes{
        @JsonInclude(JsonInclude.Include.NON_NULL)
        Integer id;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String username;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String useraccount;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String department;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer classroomid;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String classroom;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer dayid;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer timeblockid;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String subject;
        private int approved;
    }
}