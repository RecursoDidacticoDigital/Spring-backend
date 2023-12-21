package com.weeks2.strapi.api.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class ConfigRestTemplate {

    @Bean
    public RestTemplate init() {
        var rest = new RestTemplate();
       rest.getInterceptors().add(new Interceptor());
        return rest;
    }
}
