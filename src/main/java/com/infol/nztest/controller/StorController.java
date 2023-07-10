package com.infol.nztest.controller;

import com.infol.nztest.service.StorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/stor")
public class StorController {
    @Autowired
    private StorService storService ;

    @RequestMapping("/gotoStor")
    public String gotoClerk(Model model){
        return "initialValue/stor";
    }

    @RequestMapping("/getStor")
    @ResponseBody
    public String getBmmx(String bmxx, HttpServletRequest request){
        return storService.getBmmx(bmxx,request);
    }

    @RequestMapping("/addStor")
    @ResponseBody
    public String addBmmx(String bmmc, String yb, String dz, String dh,String cz,String email,String khh,
                          String zh,String sh,String fr,String tybz,String jwd,String jyxkzh, String jyfzrq, String jysxrq, String jyxkztp,
                          String jwjg,String hfzm,String xsjg, String scxkzh,String scfzrq,String scsxrq,String scxkztp,String zxbz,
                          String aqbz,String hbdj,String xxqy,
                          String dkqppbm,String yjdz,String yjmm,String yjzh,String jhgsbm,HttpServletRequest request){
        return storService.addBmmx(bmmc,yb,dz,dh,cz,email,khh,zh,sh,fr,tybz,jwd,jyxkzh,jyfzrq,jysxrq,
                                    jyxkztp,jwjg,hfzm,xsjg,scxkzh,scfzrq,scsxrq,scxkztp,zxbz,aqbz,hbdj,xxqy,
                                dkqppbm,yjdz,yjmm,yjzh,jhgsbm,request);
    }

    @RequestMapping("/removeStor")
    @ResponseBody
    public String removeBmmx(String bmbm, HttpServletRequest request){
        return storService.removeBmmx(bmbm,request);
    }

    @RequestMapping("/updateStor")
    @ResponseBody
    public String updateBmmx(String bmbm,String bmmc, String yb, String dz, String dh,String cz,String email,
                             String khh,String zh,String sh,String fr,String tybz,String jwd,String jyxkzh, String jyfzrq, String jysxrq, String jyxkztp,
                             String jwjg,String hfzm,String xsjg, String scxkzh,String scfzrq,String scsxrq,String scxkztp,String zxbz,
                             String aqbz,String hbdj,String xxqy,
                             String dkqppbm,String yjdz,String yjmm,String yjzh,String jhgsbm,HttpServletRequest request){
        return storService.updateBmmx(bmbm,bmmc,yb,dz,dh,cz,email,khh,zh,sh,fr,tybz,jwd,jyxkzh,jyfzrq,jysxrq,
                                        jyxkztp,jwjg,hfzm,xsjg,scxkzh,scfzrq,scsxrq,scxkztp,zxbz,aqbz,hbdj,xxqy,
                                    dkqppbm,yjdz,yjmm,yjzh,jhgsbm,request);
    }

    @RequestMapping("/getjhgsda")
    @ResponseBody
    public String getJhgsda(HttpServletRequest request){
        return storService.getJhgsda(request);
    }

    @RequestMapping("/getdkqppda")
    @ResponseBody
    public String getDkqppda(HttpServletRequest request){
        return storService.getDkqppda(request);
    }

}
