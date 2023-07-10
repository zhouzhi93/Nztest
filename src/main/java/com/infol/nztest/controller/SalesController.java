package com.infol.nztest.controller;

import com.infol.nztest.service.LoginService;
import com.infol.nztest.service.SalesService;
import com.infol.nztest.service.StorService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/sales")
public class SalesController {
    @Autowired
    private SalesService salesService;
    @Autowired
    private LoginService loginService;

    @Autowired
    private StorService storService;

    @RequestMapping("/salesbill")
    public String salesbill(Model model,HttpServletRequest request) {
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String catalogue = request.getSession().getServletContext().getRealPath("WebReader");
        String spdaList = "";
        String sxbmList="";
        if (f_zybm == null) {

        } else {
            spdaList = salesService.GetSpda("",f_shbm);
            sxbmList=loginService.GetZysxbm(f_zybm,f_shbm);
        }
        System.out.println("json:"+spdaList.toString());
        model.addAttribute("spdalist", spdaList);
        model.addAttribute("sxbmList", sxbmList);
        model.addAttribute("webreader",catalogue);
        return "sale/salesbill";
    }

    @RequestMapping("/GetSpda")
    @ResponseBody
    public String GetSpda(String spxx,HttpServletRequest request) {
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.GetSpda(spxx,f_shbm);
        }
        return result;
    }
    @RequestMapping("/GetSpda_PD")
    @ResponseBody
    public String GetSpda_PD(String url,HttpServletRequest request) {
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        String type="0";//查询商品模式，默认pd开头
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            String pd="";
            if(url.startsWith("http")){
                type="1";
                String v=url;
                int s=v.length();
                int i=0;
                String _bm=null;
                boolean ty=false;
                if(s>4&&v.startsWith("http")){//扫描
                    for(i=s;i>0;i--){
                        if("1234567890".indexOf(v.substring(i-1,i))==-1){
                            _bm = v.substring(i);
                            break;
                        }
                    }
                    if(_bm.length()==32){//处理
                        ty=true;
                        _bm = (_bm.startsWith("1")?"PD":(_bm.startsWith("2")?"WP":"LS"))+_bm.substring(1,7);
                    }
                } else {
                    _bm = v.substring(0,2).toUpperCase();
                    if("PD".equalsIgnoreCase(_bm)||"WP".equalsIgnoreCase(_bm)||"LS".equalsIgnoreCase(_bm)){
                        _bm = v;
                        ty=true;
                    } else _bm=null;

                }
                pd=_bm;
            }else {
                pd=url;
            }
            result = salesService.GetSpda_PD(pd,f_shbm,type);
        }
        return result;
    }
    @RequestMapping("/GetKhda")
    @ResponseBody
    public String GetKhda(String khxx,String identity,HttpServletRequest request) {
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.GetKhda(khxx,identity,f_shbm);
        }
        return result;
    }

    @RequestMapping("/AddKhda")
    @ResponseBody
    public String AddKhda(String f_khmc, String f_sjhm,String f_sfzh,String f_bzxx, String f_xxdz,HttpServletRequest request) {
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.AddKhda(f_khmc, f_sjhm,f_sfzh,f_bzxx, f_xxdz,f_shbm);
        }
        return result;
    }

    /**
     * 保存订单
     * @param khbm
     * @param f_bmbm
     * @param yhje
     * @param jsje
     * @param spxx
     * @param redio
     * @param zfbz
     * @param request
     * @return
     */
    @RequestMapping("/SavaBill")
    @ResponseBody
    public String SavaBill(String khbm,String f_bmbm, String yhje, String jsje, String spxx,
                           String redio,Integer zfbz,HttpServletRequest request) {
        String f_sjhm = (String) request.getSession().getAttribute("f_sjhm");//手机号码
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");//职员编码
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");//职员名称
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");//商户编码
        String catalogue = request.getSession().getServletContext().getRealPath("record/");//获取record路径
        String stor = storService.getBmmx(f_bmbm,request);//查询编码档案表
        JSONArray storJson = new JSONArray(stor);
        JSONObject json = storJson.getJSONObject(0);
        String result = "";
        //如果职员编码非空，保存
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.SavaBill(khbm, yhje, jsje, spxx, f_zybm, f_bmbm, f_zymc,f_shbm,redio,catalogue,
                                            json.get("F_JHGSBM").toString(),zfbz);
        }
        return result;
    }
    @RequestMapping("/SavaBill_Refund")
    @ResponseBody
    public String SavaBill_Refund(String f_djh,String f_bmbm, String yhje, String jsje, String spxx, HttpServletRequest request) {
        String f_sjhm = (String) request.getSession().getAttribute("f_sjhm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.SavaBill_refund(f_djh, yhje, jsje, spxx, f_zybm, f_bmbm, f_zymc,f_shbm);
        }
        return result;
    }
    /*销售退货单*/
    @RequestMapping("/salesreturn")
    public String salesreturnbill(Model model,HttpServletRequest request) {
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String spdaList = "";
        String sxbmList="";
        if (f_zybm == null) {

        } else {
            spdaList = salesService.GetSpda("",f_shbm);
            sxbmList=loginService.GetZysxbm(f_zybm,f_shbm);
        }
        model.addAttribute("spdalist", spdaList);
        model.addAttribute("sxbmList", sxbmList);
        return "sale/salesreturnbill";
    }

    @RequestMapping("/salesdetail")
    public String saledetail(Model model,HttpServletRequest request) {
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
            saleList = salesService.GetBillDetail("", "",str,str,f_shbm,f_zybm);
        }
        model.addAttribute("saleList", saleList);
        return "sale/saledetail";
    }

    @RequestMapping("/saleZbxx")
    @ResponseBody
    public String saleZbxx(String f_khxx,String f_bmbm,String f_spxx,HttpServletRequest request) {
        String f_sjhm = (String) request.getSession().getAttribute("f_sjhm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.GetSaleZbxx(f_khxx,f_shbm,f_bmbm,f_spxx);
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
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.GetBillDetail(cxtj, f_bmbm, f_ksrq,f_jsrq, f_shbm,f_zybm);
        }
        return result;
    }

    @RequestMapping("/GetBillDetailByKhbm")
    @ResponseBody
    public String GetBillDetailByKhbm(String khbm,String searchSpxx,String f_ksrq,String f_jsrq,HttpServletRequest request) {
        f_ksrq=f_ksrq.replace("-","");
        f_jsrq=f_jsrq.replace("-","");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.GetBillDetailByKhbm(khbm,searchSpxx, f_bmbm, f_ksrq,f_jsrq, f_shbm,f_zybm);
        }
        return result;
    }

    @RequestMapping("/GetSalecbmx")
    @ResponseBody
    public String GetSalecbmx(String data,HttpServletRequest request) {
        String f_sjhm = (String) request.getSession().getAttribute("f_sjhm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.GetSalecbmx(data,f_shbm);
        }
        return result;
    }

    /**
     * 获取销售单详情
     * @param f_djh
     * @param request
     * @return
     */
    @RequestMapping("/getXsdXq")
    @ResponseBody
    public String getXsdXq(String f_djh,HttpServletRequest request) {
        String f_sjhm = (String) request.getSession().getAttribute("f_sjhm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.getXsdXq(f_djh,f_shbm);
        }
        return result;
    }


    ///销售明细查询
    @RequestMapping("/GetSalesDetail")
    @ResponseBody
    public String GetSalesDetail(String cxtj,String f_ksrq,String f_jsrq,HttpServletRequest request){
        f_ksrq=f_ksrq.replace("-","");
        f_jsrq=f_jsrq.replace("-","");
        String f_sjhm = (String) request.getSession().getAttribute("f_sjhm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.GetSalesDetail(cxtj,f_ksrq,f_jsrq,f_shbm,f_zybm);
        }
        return result;
    }

    @RequestMapping("/GetSalesDetailByKhbm")
    @ResponseBody
    public String GetSalesDetailByKhbm(String khbm,String searchSpxx,String f_ksrq,String f_jsrq,HttpServletRequest request){
        f_ksrq=f_ksrq.replace("-","");
        f_jsrq=f_jsrq.replace("-","");
        String f_sjhm = (String) request.getSession().getAttribute("f_sjhm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.GetSalesDetailByKhbm(khbm,searchSpxx,f_ksrq,f_jsrq,f_shbm,f_zybm);
        }
        return result;
    }


    ///根据单据号查询销售明细查询
    @RequestMapping("/GetSalesDetailByDjh")
    @ResponseBody
    public String GetSalesDetailByDjh(String djh,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.GetSalesDetailByDjh(djh,f_shbm,f_zybm);
        }
        return result;
    }
    ///销售明细查询
    @RequestMapping("/GetWxsp")
    @ResponseBody
    public String GetWxsp(String f_djlx,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.GetWxsp(f_zybm,f_shbm,f_djlx);
        }
        return result;
    }


    @RequestMapping("/getkhxx")
    @ResponseBody
    public String getkhxx(String khbm,HttpServletRequest request) {
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.getkhxx(khbm,f_shbm);
        }
        return result;
    }

    @RequestMapping("/loadLsxsd")
    @ResponseBody
    public String loadLsxsd(String khbm,String f_djh,String zdrq,HttpServletRequest request) {
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.loadLsxsd(khbm,f_djh,zdrq,f_shbm);
        }
        return result;
    }

    @RequestMapping("/firstXsd")
    @ResponseBody
    public String firstXsd(String khbm,HttpServletRequest request) {
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.firstXsd(khbm,f_shbm);
        }
        return result;
    }

    @RequestMapping("/finallyXsd")
    @ResponseBody
    public String finallyXsd(String khbm,HttpServletRequest request) {
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.finallyXsd(khbm,f_shbm);
        }
        return result;
    }

    @RequestMapping("/afterXsd")
    @ResponseBody
    public String afterXsd(String khbm,String f_djh,String zdrq,HttpServletRequest request) {
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = salesService.afterXsd(khbm,f_djh,zdrq,f_shbm);
        }
        return result;
    }

    @RequestMapping("/GetKhdaByCsbm")
    @ResponseBody
    public String GetKhdaByCsbm(String f_csbm,String cslx, HttpServletRequest request){
        return salesService.GetKhdaByCsbm(f_csbm,cslx,request);
    }

    @RequestMapping("/getJdrqqj")
    @ResponseBody
    public String getJdrqqj(String khbm,String rq, HttpServletRequest request){
        return salesService.getJdrqqj(khbm,rq,request);
    }

}
