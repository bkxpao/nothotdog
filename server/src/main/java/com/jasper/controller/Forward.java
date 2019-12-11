package com.jasper.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/")
public class Forward {
    private static final Logger logger = LoggerFactory.getLogger(Forward.class);
    @RequestMapping("/index")
    public String index() {
        return "/index";
    }

    @RequestMapping("/dogge")
    @ResponseBody
    public String dogge() {
        boolean flag = Math.random() > 0.5;
        return "{\"flag\":\""+flag+"\"}";
    }
}