package com.weeks2.strapi;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("")
@RestController
public class StrapiController {
    @GetMapping
    String init() {
        return "Strapi api works";
    }
}
