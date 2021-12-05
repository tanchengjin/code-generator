package com.tanchengjin.generatorcode.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class IndexController {
    @RequestMapping(value = {"/", ""}, method = RequestMethod.GET)
    public String index() {
        return "Hello,World";
    }
}
