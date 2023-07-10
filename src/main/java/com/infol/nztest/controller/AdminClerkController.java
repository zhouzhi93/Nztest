package com.infol.nztest.controller;

import com.infol.nztest.service.AdminClerkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/adminClerk")
public class AdminClerkController {
    @Autowired
    private AdminClerkService clerkService ;

    @RequestMapping("/gotoClerk")
    public String gotoClerk(Model model){
        return "admin/adminClerk";
    }

    @RequestMapping("/getClerk")
    @ResponseBody
    public String getClerk(String zybm){
        return clerkService.getZymx(zybm);
    }

    @RequestMapping("/addClerk")
    @ResponseBody
    public String addClerk(String zymc, String sjh, String zykl){
        return clerkService.addZymx(zymc,sjh,zykl);
    }

    @RequestMapping("/removeClerk")
    @ResponseBody
    public String removeClerk(String zybm){
        return clerkService.removeZymx(zybm);
    }

    @RequestMapping("/updateClerk")
    @ResponseBody
    public String updateClerk(String zybm, String zymc, String sjh, String zykl){
        return clerkService.updateZymx(zybm,zymc,sjh,zykl);
    }

}
