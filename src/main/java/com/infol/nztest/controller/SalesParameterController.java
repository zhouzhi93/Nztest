package com.infol.nztest.controller;

import com.infol.nztest.service.SalesParameterService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/parameters")
public class SalesParameterController {
    @Autowired
    private SalesParameterService salesParameterService ;
    @RequestMapping("/salesparameter")
    public String salesparameter(Model model){
        return "parameter/salesparameter";
    }

    @RequestMapping("/procurementparameter")
    public String procurementparameter(Model model){
        return "parameter/procurementparameter";
    }

    @RequestMapping("/getXstzs")
    @ResponseBody
    public String getXstzs(String ksrq,String jsrq,String spmc,String djh,String sptm,String khbm,String khmc,String qybm,
                           Integer pageIndex,Integer pageSize,HttpServletRequest request){

        String result = salesParameterService.getXstzs(ksrq,jsrq,spmc,djh,sptm,khbm,khmc,qybm,pageIndex,pageSize,request);
        String total = salesParameterService.getXstzs_total(ksrq,jsrq,spmc,djh,sptm,khbm,khmc,qybm,request);
        JSONObject jsonObject= new JSONObject();
        jsonObject.put("list",result);
        jsonObject.put("total",total);
        return jsonObject.toString();
    }

    @RequestMapping("/getCjtzs")
    @ResponseBody
    public String getCjtzs(String ksrq,String jsrq,String spmc,String djh,String sptm,String gysbm,String gysmc,String qybm,Integer pageIndex,Integer pageSize, HttpServletRequest request){

        String result = salesParameterService.getCjtzs(ksrq,jsrq,spmc,djh,sptm,gysbm,gysmc,qybm,pageIndex,pageSize,request);
        String total = salesParameterService.getCjtzs_total(ksrq,jsrq,spmc,djh,sptm,gysbm,gysmc,qybm,request);
        JSONObject jsonObject= new JSONObject();
        jsonObject.put("list",result);
        jsonObject.put("total",total);
        return jsonObject.toString();
    }

}
