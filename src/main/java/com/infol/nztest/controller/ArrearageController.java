package com.infol.nztest.controller;

import com.infol.nztest.service.ArrearageService;
import com.infol.nztest.service.LoginService;
import com.infol.nztest.service.PurchaseService;
import com.infol.nztest.util.emay.SMS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.xml.crypto.Data;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/arrearage")
public class ArrearageController {
    @Autowired
    private ArrearageService arrearageService;
    @Autowired
    private LoginService loginService;

    @RequestMapping("/Prrearagedetail")
    public String arrearagedetail(Model model,HttpServletRequest request){
        Date date = new Date();
        SimpleDateFormat dateFormat= new SimpleDateFormat("yyyyMMdd");
        String str=dateFormat.format(date);
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String saleList = "";
        if (f_zybm == null) {

        } else {
            saleList= arrearageService.GetBillDetail("","",null,str,f_shbm,f_zybm);
        }
        model.addAttribute("spqkList",saleList );
        return "arrearage/arrearagedetail";
    }
    @RequestMapping("/GetBillDetail")
    @ResponseBody
    public String GetBillDetail(String cxtj,String f_ksrq,String f_jsrq,HttpServletRequest request) {
        //f_ksrq=f_ksrq.replace("-","");
        f_jsrq=f_jsrq.replace("-","");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = arrearageService.GetBillDetail(cxtj, f_bmbm,f_ksrq,f_jsrq,f_shbm,f_zybm);
        }
        return result;
    }
    @RequestMapping("/SavaBill")
    @ResponseBody
    public String SavaBill(String csbm,String f_bmbm,String yhje,String jsje,String spxx,String f_djbz, HttpServletRequest request) {
        String f_sjhm = (String) request.getSession().getAttribute("f_sjhm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = arrearageService.SavaBill(csbm,yhje,jsje,spxx,f_zybm,f_bmbm,f_zymc,f_shbm,f_djbz);
        }
        return result;
    }

    @RequestMapping("/proceeds")
    @ResponseBody
    public String proceeds(String f_djh,String f_bmbm,Double f_qkje,Double f_skje,Double f_syje,HttpServletRequest request ){
        return arrearageService.proceeds(f_djh,f_bmbm,f_qkje,f_skje,f_syje,request);
    }

    @RequestMapping("/dept")
    @ResponseBody
    public String dept(String khmc,String dh,String qkrq,String bmdh,String bmmc){
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyyMMdd");
            Date qkdate2 = dateFormat2.parse(qkrq);
            String qkdateStr2 = dateFormat.format(qkdate2);
            String content = "【盈放云平台】"+khmc+",您好,您在"+qkdateStr2+"日购买的农药款项还没有付款，烦请尽快付款。详询电话："+bmdh+" "+bmmc+"。";
            boolean res= SMS.setSingleSms(dh, content);
            if(res){
                return "ok";
            }else{
                throw new Exception("平台返回失败!");
            }

        }catch (Exception ex){
            return "发送失败:"+ex.getMessage();
        }
    }

}
