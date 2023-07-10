package com.infol.nztest.controller;

import com.infol.nztest.service.LoginService;
import com.infol.nztest.service.PurchaseService;
import com.infol.nztest.service.SalesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/production")
public class ProductionController {
    @Autowired
    private PurchaseService purchaseService;
    @Autowired
    private LoginService loginService;
    @Autowired
    private SalesService salesService;
    @RequestMapping("/pickupbill")
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
        return "production/pickupbill";
    }

    @RequestMapping("/pickupdetail")
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
        return "production/pickupdetail";
    }
    @RequestMapping("/productsalesbill")
    public String salesbill(Model model,HttpServletRequest request) {
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
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
        return "production/productsalesbill";
    }
    @RequestMapping("/productsalesdetail")
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
        return "production/productsalesdetail";
    }
}
