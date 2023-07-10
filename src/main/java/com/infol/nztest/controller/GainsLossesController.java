package com.infol.nztest.controller;

import util.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

import com.infol.nztest.service.GainsLossesService;
import com.infol.nztest.service.SalesService;

@Controller
@RequestMapping("/gainsLosses")
public class GainsLossesController {
    @Autowired
    private GainsLossesService gainsLossesService ;


    @RequestMapping("/gainsSave")
    @ResponseBody
    public String salesbill(HttpServletRequest request){
        //String f_dwid,String f_djlx,String f_djh,String f_zdrq,String f_bmbm,String sub,String spxx
        String f_dwid= (String)request.getSession().getAttribute(Parameter.DEPT);
        //request.getParameter("f_dwid");

        String f_djlx=request.getParameter("f_djlx");
        String f_djh=request.getParameter("f_djh");
        String f_zdrq=request.getParameter("f_zdrq");
        String f_bmbm=request.getParameter("f_bmbm");//f_dwid;//(String)request.getSession().getAttribute(Parameter.BMBM);
        String f_zybm = (String)request.getSession().getAttribute(Parameter.USER);
        String f_zymc = (String)request.getSession().getAttribute(Parameter.NAME);
        String sub=request.getParameter("sub");
        String spxx = request.getParameter("spxx");
        HashMap datas = new HashMap();
        datas.put("f_zybm",f_zybm);
        datas.put("f_zdrbm",f_zybm);
        datas.put("f_zdrmc",f_zymc);
        datas.put("f_dwid",f_dwid);
        datas.put("f_djlx",f_djlx);
        datas.put("f_djh",f_djh);
        datas.put("f_zdrq",f_zdrq);
        datas.put("f_bmbm",f_bmbm);
        datas.put("sub",sub);
        datas.put("spxx",spxx);
        return gainsLossesService.savebill(datas);
    }
    @RequestMapping("/gainsLossesbill")
    public String getSpda(HttpServletRequest request,Model model){
        String f_dwid= (String)request.getSession().getAttribute(Parameter.DEPT);
        String f_zybm= (String)request.getSession().getAttribute(Parameter.USER);
        String f_bmbm=request.getParameter("f_bmbm");
        String spdaList= gainsLossesService.getSpda(f_dwid,f_bmbm,"");
        model.addAttribute("spdalist",spdaList );
        //String depts = gainsLossesService.getDept(f_dwid,f_zybm);
        String depts = gainsLossesService.depts(f_dwid,f_zybm,null);
        model.addAttribute("bmdalist",depts);
        return "gainsLosses/gainsLossesbill";
    }
    @RequestMapping("/GetSpda")
    @ResponseBody
    public String searchSpda(String spxx,String f_bmbm,HttpServletRequest request){
        String f_dwid= (String)request.getSession().getAttribute(Parameter.DEPT);
        String f_zybm= (String)request.getSession().getAttribute(Parameter.USER);
        //String f_bmbm=request.getParameter("f_bmbm");
        //System.out.println(f_bmbm+"====f_bmbm");
        return gainsLossesService.getSpda(f_dwid,f_bmbm,spxx);
    }
    @RequestMapping("/gainsquery")
    public String gainsquery(HttpServletRequest request,Model model){
        return "gainsLosses/gainsLossesquery";
    }

    @RequestMapping("/gainsLossesquery")
    @ResponseBody
    public java.util.List query(HttpServletRequest request){
        String f_zybm = (String)request.getSession().getAttribute(Parameter.USER);//当前登陆的职员
        String f_cxms = request.getParameter("f_cxms");
        String f_dwid= (String)request.getSession().getAttribute(Parameter.DEPT);
        String f_ksrq = request.getParameter("f_ksrq");
        String f_jsrq = request.getParameter("f_jsrq");
        String f_bmbm = request.getParameter("f_bmbm");
        String f_spbm = request.getParameter("f_spbm");
        String f_djlx = request.getParameter("f_djlx");
        String f_djh  = request.getParameter("f_djh");

        return gainsLossesService.query(f_cxms,f_ksrq,f_jsrq,f_dwid,f_zybm,f_bmbm,f_spbm,f_djlx,f_djh);
    }

}
