package com.infol.nztest.controller;

import com.infol.nztest.service.IndexService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
//@RequestMapping("/")
public class IndexController {

    @Autowired
    private IndexService indexService;
    @RequestMapping("/hello")
    @ResponseBody
    public String Hello(){
        return indexService.Hello();
    }

    @RequestMapping("/index")
    public String gotoindex(HttpServletRequest request){
        String msgList=indexService.GetMsg();
        request.getSession().setAttribute("msgList",msgList);
        return "index";
    }
    @RequestMapping("/salesbill")
    public String salesbill(Model model){
        model.addAttribute("ddd","dd11");
        return "sale/salesbill";
    }
    public String GetModel() {
        return super.toString();
    }
}
