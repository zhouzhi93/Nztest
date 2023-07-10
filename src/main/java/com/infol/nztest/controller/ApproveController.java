package com.infol.nztest.controller;

import com.infol.nztest.service.ApproveService;
import com.infol.nztest.service.StorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/approve")
public class ApproveController {
    @Autowired
    private ApproveService approveService ;
    @Autowired
    private StorService storService;

    @RequestMapping("/gotoApprove")
    public String gotoApprove(Model model){
        return "approve/Approve";
    }

    @RequestMapping("/gotoQuery")
    public String gotoQuery(Model model){
        return "admin/shcx";
    }

    @RequestMapping("/getShmx")
    @ResponseBody
    public String getShmx(String shzt){
        return approveService.getShmx(shzt);
    }

    @RequestMapping("/SpSh")
    @ResponseBody
    public String SpSh(String shzt, String shbm,String lxbm,String shmc, String yy,String f_sjhm){
        String result = approveService.SpSh(shzt,shbm,lxbm,shmc,yy,f_sjhm);
        if("ok".equals(result)){
            storService.responseBmmx(shbm,shbm);
        }
        return result;
    }

    @RequestMapping("/updateShzt")
    @ResponseBody
    public String updateShzt(String shzt, String shbm){
        String result = approveService.updateShzt(shzt,shbm);
        return result;
    }

}
