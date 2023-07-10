package com.infol.nztest.controller;

import com.infol.nztest.service.PackingService;
import com.infol.nztest.service.ReportFormService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/report")
public class ReportFormController {
    @Autowired
    private ReportFormService reportFormService ;

    @RequestMapping("/zhjxccx")
    public String zhjxccx(){
        return "report/zhjxccx";
    }

    @RequestMapping("/crkcx")
    public String crkcx(){
        return "report/crkcx";
    }

    @RequestMapping("/gotoXsjbb")
    public String gotoXsjbb(){
        return "report/xsjbb";
    }

    @RequestMapping("/loadBm")
    @ResponseBody
    public String loadBm(HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = reportFormService.loadBm(f_shbm,f_zybm);
        }
        return result;
    }

    @RequestMapping("/loadCk")
    @ResponseBody
    public String loadCk(HttpServletRequest request){
        return reportFormService.loadCk(request);
    }

    @RequestMapping("/loadZhjxc")
    @ResponseBody
    public String loadZhjxc(String bmbm,String ksrq,String jsrq,String spflbm,String sptm,
                           Integer pageIndex,Integer pageSize, HttpServletRequest request){
        String result = reportFormService.loadZhjxc(bmbm,ksrq,jsrq,spflbm,sptm,pageIndex,pageSize,request);
        return result;
    }

    @RequestMapping("/loadCrkcx")
    @ResponseBody
    public String loadCrkcx(String bmbm,String ckbm,String ksrq,String jsrq,String spflbm,String sptm,
                            Integer pageIndex,Integer pageSize, HttpServletRequest request){
        String result = reportFormService.loadCrkcx(bmbm,ckbm,ksrq,jsrq,spflbm,sptm,pageIndex,pageSize,request);
        return result;
    }


    @RequestMapping("/showDetail")
    @ResponseBody
    public String showDetail(String sptm,String bmbm,String ckbm,String ksrq,String jsrq,String spflbm,
                            HttpServletRequest request){
        String result = reportFormService.showDetail(sptm,bmbm,ckbm,ksrq,jsrq,spflbm,request);
        return result;
    }

    @RequestMapping("/loadXsj")
    @ResponseBody
    public String loadXsj(HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = reportFormService.loadXsj(f_shbm);
        }
        return result;
    }

    @RequestMapping("/getZylx")
    @ResponseBody
    public String getZylx(String f_khlx,String jyjId,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = reportFormService.getZylx(f_khlx,jyjId,f_shbm);
        }
        return result;
    }

    @RequestMapping("/loadJxsbb")
    @ResponseBody
    public String loadJxsbb(String jyjId, Integer pageIndex,Integer pageSize, HttpServletRequest request){
        String result = reportFormService.loadJxsbb(jyjId,pageIndex,pageSize,request);
        return result;
    }
}
