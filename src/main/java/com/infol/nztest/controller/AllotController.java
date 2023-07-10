package com.infol.nztest.controller;

import com.infol.nztest.service.AllotService;
import com.infol.nztest.service.LoginService;
import com.infol.nztest.service.PurchaseService;
import com.infol.nztest.service.StorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/allot")
public class AllotController {
    @Autowired
    private PurchaseService purchaseService;
    @Autowired
    private LoginService loginService;
    @Autowired
    private StorService storService;
    @Autowired
    private AllotService allotService;

    @RequestMapping("/allocationBill")
    public String allocationBill(Model model,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String spdaList = "";
        String sxbmList="";
        String drsxbmList = "";
        if (f_zybm == null) {

        } else {
            spdaList = purchaseService.GetSpda("",f_shbm);
            sxbmList=loginService.GetZysxbm(f_zybm,f_shbm);
            drsxbmList = storService.getBmmx("",request);
        }
        model.addAttribute("spdalist", spdaList);
        model.addAttribute("sxbmList", sxbmList);
        model.addAttribute("drsxbmList",drsxbmList);
        return "allot/allocationbill";
    }

    @RequestMapping("/allocationBillquery")
    public String allocationBillquery(Model model,HttpServletRequest request){
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
            saleList= allotService.GetBillDetail("","",str,str,f_shbm,f_zybm);
        }
        model.addAttribute("spzyList",saleList );
        return "allot/allocationbillquery";
    }

    //调拨
    @RequestMapping("/SavaBill")
    @ResponseBody
    public String SavaBill(String f_dcbmbm,String f_drbmbm,String yhje,String jsje,String spxx,Integer dblx,HttpServletRequest request) {
        String f_sjhm = (String) request.getSession().getAttribute("f_sjhm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = allotService.SavaBill(f_dcbmbm,f_drbmbm,yhje,jsje,spxx,f_shbm,f_zybm,f_zymc,dblx);
        }
        return result;
    }

    @RequestMapping("/GetZyHzcbmx")
    @ResponseBody
    public String GetZyHzcbmx(String f_djh,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = allotService.GetZyHzcbmx(f_djh,f_shbm);
        }
        return result;
    }

    ///商品转移主表查询
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
            result = allotService.GetBillDetail(cxtj, f_bmbm,f_ksrq,f_jsrq,f_shbm,f_zybm);
        }
        return result;
    }

    ///商品转移明细查询
    @RequestMapping("/GetSpzyDetail")
    @ResponseBody
    public String GetSpzyDetail(String cxtj,String f_ksrq,String f_jsrq,HttpServletRequest request){
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
            result = allotService.GetSpzyDetail(cxtj,f_ksrq,f_jsrq,f_shbm,f_zybm);
        }
        return result;
    }

    ///商品转移明细查询
    @RequestMapping("/GetSpkccbdj")
    @ResponseBody
    public String GetSpkccbdj(Integer f_xssl,String f_sptm,String f_dcbmbm,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = allotService.GetSpkccbdj(f_xssl,f_sptm,f_dcbmbm,f_shbm);
        }
        return result;
    }

}
