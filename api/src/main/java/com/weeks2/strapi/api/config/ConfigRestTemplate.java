package com.weeks2.strapi.api.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import com.weeks2.strapi.api.common.AppEndPointsSchool;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class ConfigRestTemplate {

    @Bean
    public RestTemplate init() {
        var rest = new RestTemplate();
       rest.getInterceptors().add(new Interceptor());
        return rest;
    }
    @Bean
    public WebMvcConfigurer corsConfigurer(){
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry){
                registry.addMapping("/**")
                        // Replace with Flutter's app origin
                        .allowedOrigins(AppEndPointsSchool.FLUTTER_APP_PATH)
                        .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                        .allowedHeaders("*")
                        .allowCredentials(true);
            }
        };
    }
}