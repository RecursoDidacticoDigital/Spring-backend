package com.weeks2.strapi.school.timeblock;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.weeks2.strapi.config.StrapiConstants;
import lombok.Data;

import java.sql.Time;

@Data
public class Timeblock {
    @JsonProperty("id")
    private int id;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Attributes attributes;
    @Data
    public static class Attributes{
        @JsonInclude(JsonInclude.Include.NON_NULL)
        Integer id;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String start;
        @JsonInclude(JsonInclude.Include.NON_NULL)
        private String end;
    }
}
