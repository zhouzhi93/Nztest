package com.infol.nztest.controller;

import com.infol.nztest.service.AdminClerkService;
import com.infol.nztest.service.ClerkService;
import com.infol.nztest.service.JGClerkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/JGClerk")
public class JGClerkController {
    @Autowired
    private JGClerkService clerkService ;

    //后台管理平台人员管理
    @RequestMapping("/gotoClerk")
    public String gotoClerk(Model model){
        return "superviseClerk/JGClerk";
    }

    //监管平台人员管理
    @RequestMapping("/gotoJGClerk")
    public String gotoJGClerk(Model model){
        return "superviseClerk/JGRYClerk";
    }

    @RequestMapping("/getClerk")
    @ResponseBody
    public String getClerk(String zybm){
        return clerkService.getZymx(zybm);
    }

    @RequestMapping("/addClerk")
    @ResponseBody
    public String addClerk(String zylx, String zymc, String zykl, String dh,String dwmc,String fgqy){
        return clerkService.addZymx(zylx,zymc,zykl,dh,dwmc,fgqy);
    }

    @RequestMapping("/removeClerk")
    @ResponseBody
    public String removeClerk(String zybm){
        return clerkService.removeZymx(zybm);
    }

    @RequestMapping("/updateClerk")
    @ResponseBody
    public String updateClerk(String zylx, String zybm, String zymc, String zykl, String dh,String dwmc,String fgqy){
        return clerkService.updateZymx(zylx,zybm,zymc,zykl,dh,dwmc,fgqy);
    }

    @RequestMapping("/getQymx")
    @ResponseBody
    public String getQymx(){
        return clerkService.getQymx();
    }

/*    @RequestMapping("/saveQymx")
    @ResponseBody
    public void saveQymx(){
        clerkService.saveQymx();
    }*/

}
