package com.weeks2.strapi.api.lesson;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.weeks2.strapi.api.config.StrapiConstants;
import lombok.Data;

import java.util.Date;
@Data
public class Lesson {
    @JsonProperty("id")
    private int id;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Attributes attributes;
    @Data
    public static class Attributes {
        @JsonInclude(JsonInclude.Include.NON_NULL)
        Integer id;
        private String title;
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
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String tenantId;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String memberId;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String instructorId;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String serviceTypeId;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private boolean confirmed;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String tenantRole;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private boolean cancelled;
    }
}
