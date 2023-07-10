package com.infol.nztest.controller;

import com.infol.nztest.service.ClerkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/clerk")
public class ClerkController {
    @Autowired
    private ClerkService clerkService ;

    @RequestMapping("/gotoClerk")
    public String gotoClerk(Model model){
        return "initialValue/clerk";
    }

    @RequestMapping("/getClerk")
    @ResponseBody
    public String getClerk(String zybm, HttpServletRequest request){
        return clerkService.getZymx(zybm,request);
    }

    /**
     * 获取职员权限
     * @param zybm
     * @param qxxx
     * @param request
     * @return
     */
    @RequestMapping("/getZyqx")
    @ResponseBody
    public String getZyqx(String zybm,String qxxx,HttpServletRequest request){
        return clerkService.getZyqx(zybm,qxxx,request);
    }

    @RequestMapping("/addClerk")
    @ResponseBody
    public String addClerk(String zymc, String sjh, String zyqx, String zykl,String sxbm,String zyjs, HttpServletRequest request){
        return clerkService.addZymx(zymc,sjh,zyqx,zykl,sxbm,zyjs,request);
    }

    @RequestMapping("/removeClerk")
    @ResponseBody
    public String removeClerk(String zybm, HttpServletRequest request){
        return clerkService.removeZymx(zybm,request);
    }

    @RequestMapping("/updateClerk")
    @ResponseBody
    public String updateClerk(String zybm, String zymc, String sjh, String zyqx, String zykl,String sxbm,String zyjs, HttpServletRequest request){
        return clerkService.updateZymx(zybm,zymc,sjh,zyqx,zykl,sxbm,zyjs,request);
    }

}
