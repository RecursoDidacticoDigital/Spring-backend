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
        private String member_name;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String member_account;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String department;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer classroom_id;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String classroom;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer day_id;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Integer timeblock_id;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String subject;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private boolean approved;
    }
}