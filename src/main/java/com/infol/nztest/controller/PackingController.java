package com.infol.nztest.controller;

import com.infol.nztest.service.PackingService;
import util.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;


@Controller
@RequestMapping("/packing")
public class PackingController {
    @Autowired
    private PackingService server ;

    @RequestMapping("/packingspda")
    public String purchase(String f_bmbm,String spxx,Model model,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        //String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String spdaList = "";
        if (f_zybm == null) {

        } else {
            spdaList = server.getSpda(f_shbm,f_bmbm,spxx);
        }
        model.addAttribute("spdalist",spdaList );
        return "pack/packbill";
    }
    @RequestMapping("/packManageRecord")
    public String packManageRecord(String f_bmbm,String spxx,Model model,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        //String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String spdaList = "";
        if (f_zybm == null) {

        } else {
            spdaList = server.getSpda(f_shbm,f_bmbm,spxx);
        }
        model.addAttribute("spdalist",spdaList );
        String depts = server.depts(f_shbm,f_zybm,null);
        model.addAttribute("bmdalist",depts);
        return "pack/packmanagerecord";
    }
    @RequestMapping("/packingreturnbill")
    public String purchasereturnbill(String f_bmbm,Model model,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        //String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String spdaList = "";
        if (f_zybm == null) {

        } else {
            spdaList = server.getSpda(f_shbm,f_bmbm,null);
        }
        model.addAttribute("spdalist",spdaList );
        return "pack/packingreturnbill";
    }
    @RequestMapping("/packingdetail")
    public String purchasedetail(Model model,HttpServletRequest request){
        Calendar date = new GregorianCalendar();
        String str = String.valueOf(date.get(Calendar.YEAR)*10000+(date.get(Calendar.MONTH)+1)*100+date.get(Calendar.DATE));
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String saleList = "";
        if (f_zybm == null) {
        } else {
            //saleList= server.GetBillDetail("","",str,f_shbm);
        }
        model.addAttribute("spgjList",saleList );
        return "pack/packdetail";
    }

    @RequestMapping("/bzwbrd")
    public String bzwbrd(String f_bmbm,String spxx,Model model,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        //String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String spdaList = "";
        if (f_zybm == null) {

        } else {
            spdaList = server.getSpda(f_shbm,f_bmbm,spxx);
        }
        model.addAttribute("spdalist",spdaList );
        return "pack/bzwbrd";
    }

    @RequestMapping("/bzwbrcx")
    public String bzwbrcx(Model model,HttpServletRequest request){
        Calendar date = new GregorianCalendar();
        String str = String.valueOf(date.get(Calendar.YEAR)*10000+(date.get(Calendar.MONTH)+1)*100+date.get(Calendar.DATE));
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String saleList = "";
        if (f_zybm == null) {
        } else {
            //saleList= server.GetBillDetail("","",str,f_shbm);
        }
        model.addAttribute("spgjList",saleList );
        return "pack/bzwbrcx";
    }

    @RequestMapping("/bzwbccx")
    public String bzwbccx(Model model,HttpServletRequest request){
        Calendar date = new GregorianCalendar();
        String str = String.valueOf(date.get(Calendar.YEAR)*10000+(date.get(Calendar.MONTH)+1)*100+date.get(Calendar.DATE));
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String saleList = "";
        if (f_zybm == null) {
        } else {
            //saleList= server.GetBillDetail("","",str,f_shbm);
        }
        model.addAttribute("spgjList",saleList );
        return "pack/bzwbccx";
    }

    @RequestMapping("/bzwbcd")
    public String bzwbcd(String f_bmbm,String spxx,Model model,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        //String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String spdaList = "";
        if (f_zybm == null) {

        } else {
            spdaList = server.getSpda(f_shbm,f_bmbm,spxx);
        }
        model.addAttribute("spdalist",spdaList );
        return "pack/bzwbcd";
    }

    @RequestMapping("/packingCsda")
    @ResponseBody
    public String GetCsda(String csxx,String f_bmbm,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.GetCsda(csxx,f_shbm);
        }
        return result;
    }

    @RequestMapping("/packingGoods")
    @ResponseBody
    public String getGoods(String spxx,String f_bmbm,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.getSpda(f_shbm,f_bmbm,spxx);
        }
        return result;
    }

    @RequestMapping("/packingBill")
    @ResponseBody
    public String SavaBill(String csbm,String yhje,String f_bmbm,String jsje,String spxx,String f_djh,String sub,HttpServletRequest request) {
        String f_sjhm = (String) request.getSession().getAttribute("f_sjhm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.SavaBill(csbm,yhje,jsje,spxx,f_zybm,f_bmbm,f_zymc,f_shbm,f_djh,sub);
        }
        return result;
    }
    @RequestMapping("/packingManageRecordBill")
    @ResponseBody
    public String savaPackingManageRecordBill(String czfs,String yhje,String f_bmbm,String jsje,String spxx,String f_djh,String sub,HttpServletRequest request) {
        String f_sjhm = (String) request.getSession().getAttribute("f_sjhm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.savaPackingManageRecordBill(czfs,yhje,jsje,spxx,f_zybm,f_bmbm,f_zymc,f_shbm,f_djh,sub);
        }
        return result;
    }
    @RequestMapping("/packingZbxx")
    @ResponseBody
    public String GetJhZbxx(String f_gysbm,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.GetJhZbxx(f_gysbm,f_shbm);
        }
        return result;
    }
    @RequestMapping("/packingcbmx")
    @ResponseBody
    public String GetJhcbmx(String f_djh,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.GetJhcbmx(f_djh,f_shbm);
        }
        return result;
    }

    @RequestMapping("/queryDjxq")
    @ResponseBody
    public String queryDjxq(String f_djh,String f_bmbm,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.queryDjxq(f_djh,f_bmbm,f_shbm);
        }
        return result;
    }


    @RequestMapping("/packBillDetail")
    @ResponseBody
    public String GetBillDetail(String cxtj,String f_rq,HttpServletRequest request) {
        f_rq=f_rq.replace("-","");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.GetBillDetail(cxtj, f_bmbm,f_rq,f_shbm);
        }
        return result;
    }
    @RequestMapping("/packSpkcBySptm")
    @ResponseBody
    public String GetSpkcBySptm(String f_sptm,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.GetSpkcBySptm(f_sptm,f_shbm);
        }
        return result;
    }
    ///包装物回收明细查询
    @RequestMapping("/packSpgjDetail")
    @ResponseBody
    public String GetSpgjDetail(String cxtj,String f_rq,HttpServletRequest request){
        f_rq=f_rq.replace("-","");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.GetSpgjDetail(cxtj,f_rq,f_shbm);
        }
        return result;
    }
    //包装物回收明细查询
    @RequestMapping("/packQuery")
    @ResponseBody
    public String queryDetail(String f_ksrq,String f_jsrq,String cxms,String cxtj,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.queryDetail(f_shbm,cxms,f_ksrq,f_jsrq,f_zybm,cxtj);
        }
        return result;
    }


    @RequestMapping("/getBrckmc")
    @ResponseBody
    public String getBrckmc(String brckbm,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.getBrckmc(brckbm,f_shbm,f_zybm);
        }
        return result;
    }

    @RequestMapping("/getBcwd")
    @ResponseBody
    public String getBcwd(HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.getBcwd(f_shbm,f_zybm);
        }
        return result;
    }


    @RequestMapping("/bzwbrdBill")
    @ResponseBody
    public String bzwbrdBill(String brckbm,String bcwdbm,String spxx,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.bzwbrdBill(brckbm,bcwdbm,spxx,f_zybm,f_zymc,f_shbm);
        }
        return result;
    }

    @RequestMapping("/getBcckmc")
    @ResponseBody
    public String getBcckmc(String bcckbm,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.getBcckmc(bcckbm,f_shbm,f_zybm);
        }
        return result;
    }

    @RequestMapping("/getBrdw")
    @ResponseBody
    public String getBrdw(String bcdwbm,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.getBrdw(bcdwbm,f_shbm,f_zybm);
        }
        return result;
    }

    @RequestMapping("/bzwbcdBill")
    @ResponseBody
    public String bzwbcdBill(String bcckbm,String brdwbm,String spxx,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.bzwbcdBill(bcckbm,brdwbm,spxx,f_zybm,f_zymc,f_shbm);
        }
        return result;
    }


    @RequestMapping("/hzcx")
    @ResponseBody
    public String hzcx(String cxtj,String f_ksrq,String f_jsrq,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.hzcx(cxtj,f_ksrq,f_jsrq,f_shbm,f_zybm);
        }
        return result;
    }

    @RequestMapping("/bcdhzcx")
    @ResponseBody
    public String bcdhzcx(String cxtj,String f_ksrq,String f_jsrq,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.bcdhzcx(cxtj,f_ksrq,f_jsrq,f_shbm,f_zybm);
        }
        return result;
    }

    @RequestMapping("/mxcx")
    @ResponseBody
    public String mxcx(String cxtj,String f_ksrq,String f_jsrq,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.mxcx(cxtj,f_ksrq,f_jsrq,f_shbm,f_zybm);
        }
        return result;
    }

    @RequestMapping("/bcdmxcx")
    @ResponseBody
    public String bcdmxcx(String cxtj,String f_ksrq,String f_jsrq,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = server.bcdmxcx(cxtj,f_ksrq,f_jsrq,f_shbm,f_zybm);
        }
        return result;
    }


}
