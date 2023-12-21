package com.weeks2.strapi.api.config;

import org.springframework.http.HttpRequest;
import org.springframework.http.client.ClientHttpRequestExecution;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.ClientHttpResponse;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

public class Interceptor implements ClientHttpRequestInterceptor {

    @Override
    public ClientHttpResponse intercept(HttpRequest request, byte[] body, ClientHttpRequestExecution execution) throws IOException {
        System.out.println("==== Request Details ====");
        System.out.println("URI         : " + request.getURI());
        System.out.println("Method      : " + request.getMethod());
        System.out.println("Headers     : " + request.getHeaders());
        System.out.println("Request Body: " + new String(body, StandardCharsets.UTF_8));
        System.out.println("=========================");
        ClientHttpResponse response = execution.execute(request, body);
        System.out.println("==== Response Details ====");
        System.out.println("Status code : " + response.getStatusCode());
        System.out.println("Headers     : " + response.getHeaders());
        //System.out.println("Response Body: " + StreamUtils.copyToString(response.getBody(), StandardCharsets.UTF_8));
        System.out.println("==========================");
        System.out.println("==========================");
        return response;
    }
}
