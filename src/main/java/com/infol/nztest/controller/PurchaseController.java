package com.infol.nztest.controller;

import com.infol.nztest.service.LoginService;
import com.infol.nztest.service.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/purchase")
public class PurchaseController {
    @Autowired
    private PurchaseService purchaseService;
    @Autowired
    private LoginService loginService;
    @RequestMapping("/purchasebill")
    public String purchase(Model model,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String spdaList = "";
        String sxbmList="";
        if (f_zybm == null) {

        } else {
            spdaList = purchaseService.GetSpda("",f_shbm);
            sxbmList=loginService.GetZysxbm(f_zybm,f_shbm);
        }
        model.addAttribute("spdalist", spdaList);
        model.addAttribute("sxbmList", sxbmList);
        return "purchase/purchasebill";
    }
    @RequestMapping("/purchasereturnbill")
    public String purchasereturnbill(Model model,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String spdaList = "";
        String sxbmList="";
        if (f_zybm == null) {

        } else {
            spdaList = purchaseService.GetSpda("",f_shbm);
            sxbmList=loginService.GetZysxbm(f_zybm,f_shbm);
        }
        model.addAttribute("spdalist", spdaList);
        model.addAttribute("sxbmList", sxbmList);
        return "purchase/purchasereturnbill";
    }
    @RequestMapping("/purchasedetail")
    public String purchasedetail(Model model,HttpServletRequest request){
        Date date = new Date();
        SimpleDateFormat dateFormat= new SimpleDateFormat("yyyyMMdd");
        String str=dateFormat.format(date);
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String saleList = "";
        if (f_zybm == null) {

        } else {
            saleList= purchaseService.GetBillDetail("","",str,str,f_shbm,f_zybm);
        }
        model.addAttribute("spgjList",saleList );
        return "purchase/purchasedetail";
    }

    @RequestMapping("/GetSpda")
    @ResponseBody
    public String GetSpda(String spxx,HttpServletRequest request) {
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = purchaseService.GetSpda(spxx,f_shbm);
        }
        return result;
    }

    @RequestMapping("/GetCsda")
    @ResponseBody
    public String GetCsda(String csxx,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = purchaseService.GetCsda(csxx,f_shbm);
        }
        return result;
    }
    @RequestMapping("/AddCsda")
    @ResponseBody
    public String AddCsda(String f_csmc,String f_sjhm,String f_xxdz,HttpServletRequest request ){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = purchaseService.AddCsda(f_csmc,f_sjhm,f_xxdz,f_shbm);
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
            result = purchaseService.SavaBill(csbm,yhje,jsje,spxx,f_zybm,f_bmbm,f_zymc,f_shbm,f_djbz);
        }
        return result;
    }

    @RequestMapping("/SavaBill_refund")
    @ResponseBody
    public String SavaBill_refund(String f_ydjh,String f_bmbm,String f_gysbm, String yhje, String jsje, String spxx, HttpServletRequest request) {
        String f_sjhm = (String) request.getSession().getAttribute("f_sjhm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = purchaseService.SavaBill_refund(f_ydjh,f_gysbm, yhje, jsje, spxx, f_zybm, f_bmbm, f_zymc,f_shbm);
        }
        return result;
    }
    @RequestMapping("/GetJhZbxx")
    @ResponseBody
    public String GetJhZbxx(String f_gysbm,String f_bmbm,String f_spxx,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = purchaseService.GetJhZbxx(f_gysbm,f_shbm,f_bmbm,f_spxx);
        }
        return result;
    }
    @RequestMapping("/showDetail")
    @ResponseBody
    public String showDetail(String f_djh,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = purchaseService.showDetail(f_djh,f_shbm);
        }
        return result;
    }


    @RequestMapping("/GetJhcbmx")
    @ResponseBody
    public String GetJhcbmx(String data,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = purchaseService.GetJhcbmx(data,f_shbm);
        }
        return result;
    }


    @RequestMapping("/GetBillDetail")
    @ResponseBody
    public String GetBillDetail(String cxtj,String f_ksrq,String f_jsrq,HttpServletRequest request) {
        f_ksrq=f_ksrq.replace("-","");
        f_jsrq=f_jsrq.replace("-","");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = purchaseService.GetBillDetail(cxtj, f_bmbm,f_ksrq,f_jsrq,f_shbm,f_zybm);
        }
        return result;
    }
    @RequestMapping("/GetSpkcBySptm")
    @ResponseBody
    public String GetSpkcBySptm(String f_sptm,String f_bmbm,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = purchaseService.GetSpkcBySptm(f_sptm,f_shbm,f_bmbm);
        }
        return result;
    }
    ///销售明细查询
    @RequestMapping("/GetSpgjDetail")
    @ResponseBody
    public String GetSpgjDetail(String cxtj,String f_ksrq,String f_jsrq,HttpServletRequest request){
        f_ksrq=f_ksrq.replace("-","");
        f_jsrq=f_jsrq.replace("-","");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = purchaseService.GetSpgjDetail(cxtj,f_ksrq,f_jsrq,f_shbm,f_zybm);
        }
        return result;
    }

    /**
     * 加载仓库信息
     * @param request
     * @return
     */
    @RequestMapping("/loadCkxx")
    @ResponseBody
    public String loadCkxx(HttpServletRequest request){
        return purchaseService.loadCkxx(request);
    }

}
