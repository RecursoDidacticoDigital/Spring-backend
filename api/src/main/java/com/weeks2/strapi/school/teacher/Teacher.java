package com.weeks2.strapi.school.teacher;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.weeks2.strapi.api.config.StrapiConstants;
import lombok.Data;

import java.util.Date;

@Data
public class Teacher {
    @JsonProperty("id")
    private int id;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Attributes attributes;
    @Data
    public static class Attributes {
        @JsonInclude(JsonInclude.Include.NON_NULL)
        Integer id;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String teacherName;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String teacherEmail;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String teacherPassword;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String teacherAccount;
        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = StrapiConstants.pattern)
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Date createdAt;
        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = StrapiConstants.pattern)
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Date updatedAt;
        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = StrapiConstants.pattern)
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Date publishedAt;
        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = StrapiConstants.pattern)
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Date start;
        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = StrapiConstants.pattern)
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private Date end;
    }
}
