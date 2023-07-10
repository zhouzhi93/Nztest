package com.infol.nztest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/infolsearch")
public class InfolsearchController {
    @RequestMapping("/certsearch")
    public String certsearch(){
        return "infolsearch/certsearch";
    }
}
