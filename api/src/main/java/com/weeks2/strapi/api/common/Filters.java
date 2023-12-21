package com.weeks2.strapi.api.common;

import java.util.Arrays;

/**
 * https://docs.strapi.io/dev-docs/api/rest/filters-locale-publication#filtering
 * Queries can accept a filters parameter with the following syntax:
 * GET /api/:pluralApiId?filters[field][operator]=value
 */
public enum Filters {
    EQ("$eq", "Equal"),
    EQI("$eqi", "Equal (case-insensitive)"),
    NE("$ne", "Not equal"),
    NEI("$nei", "Not equal (case-insensitive)"),
    LT("$lt", "Less than"),
    LTE("$lte", "Less than or equal to"),
    GT("$gt", "Greater than"),
    GTE("$gte", "Greater than or equal to"),
    IN("$in", "Included in an array"),
    NOT_IN("$notIn", "Not included in an array"),
    CONTAINS("$contains", "Contains"),
    NOT_CONTAINS("$notContains", "Does not contain"),
    CONTAINS_I("$containsi", "Contains (case-insensitive)"),
    NOT_CONTAINS_I("$notContainsi", "Does not contain (case-insensitive)"),
    NULL("$null", "Is null"),
    NOT_NULL("$notNull", "Is not null"),
    BETWEEN("$between", "Is between"),
    STARTS_WITH("$startsWith", "Starts with"),
    STARTS_WITH_I("$startsWithi", "Starts with (case-insensitive)"),
    ENDS_WITH("$endsWith", "Ends with"),
    ENDS_WITH_I("$endsWithi", "Ends with (case-insensitive)"),
    OR("$or", "Joins the filters in an 'or' expression"),
    AND("$and", "Joins the filters in an 'and' expression"),
    NOT("$not", "Joins the filters in a 'not' expression"),
    KEY("$key", "Key"),

    LIVE("live", "returns only published entries (default)"),
    PREVIEW("preview", "returns both draft entries & published entries)");

    private final String value;
    private final String description;

    Filters(String value, String description) {
        this.value = value;
        this.description = description;
    }

    public String getValue() {
        return value;
    }

    public String getDescription() {
        return description;
    }

    public static Filters getByValue(String value) {
        return Arrays.stream(values())
                .filter(operator -> operator.value.equalsIgnoreCase(value))
                .findFirst()
                .orElse(null);
    }

    /**
     * GET /api/:pluralApiId?filters[field][operator]=value
     *
     */
    public static String addFilter(String uri, String field,Filters operator,String value) {
        return new StringBuilder(uri).append(uri.contains("?") ? '&' : '?')
                .append("filters[").append(field).append("][")
                .append(operator.getValue()).append("]=")
                .append(value)
                .toString();
    }

    /**
     * GET /api/lessons?publicationState=preview | live
     */
    public static String addPublicationState(String uri, Filters operator) {
        return new StringBuilder(uri).append(uri.contains("?") ? '&' : '?')
                .append("publicationState=").append(operator.getValue())
                .toString();
    }
}

