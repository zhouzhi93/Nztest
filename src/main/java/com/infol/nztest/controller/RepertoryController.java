package com.infol.nztest.controller;

import com.infol.nztest.service.LoginService;
import com.infol.nztest.service.PurchaseService;
import com.infol.nztest.service.RepertoryService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/repertorys")
public class RepertoryController {
    @Autowired
    private RepertoryService repertoryService ;
    @Autowired
    private PurchaseService purchaseService;
    @Autowired
    private LoginService loginService;
    @RequestMapping("/gotoRepertory")
    public String salesparameter(Model model){
        return "repertory/repertoryStatement";
    }

    @RequestMapping("/gotoYkcl")
    public String gotoYkcl(Model model,HttpServletRequest request){
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
        return "repertory/ykcl";
    }

    @RequestMapping("/gotoCkbb")
    public String gotoCkbb(Model model){
        return "repertory/ckbb";
    }

    @RequestMapping("/getKctzs")
    @ResponseBody
    public String getKctzs(String kcrq,String spmc,String djh,String sptm,String gysbm,String gysmc,
                           Integer pageIndex,Integer pageSize, HttpServletRequest request){
        String result = repertoryService.getKctzs(kcrq,spmc,djh,sptm,gysbm,gysmc,pageIndex,pageSize,request);
        String total = repertoryService.getKctzs_total(kcrq,spmc,djh,sptm,gysbm,gysmc,request);
        JSONObject jsonObject= new JSONObject();
        jsonObject.put("list",result);
        jsonObject.put("total",total);
        return jsonObject.toString();
    }

    @RequestMapping("/getKctzsBj")
    @ResponseBody
    public String getKctzsBj(HttpServletRequest request){
        return repertoryService.getKctzsBj(request);
    }

    @RequestMapping("/getKcpcmx")
    @ResponseBody
    public String getKcpcmx(String kcrq, String sptm, HttpServletRequest request){
        return repertoryService.getKcpcmx(kcrq,sptm,request);
    }

    /**
     * 获取权限信息
     * @param f_JB
     * @param f_Qxbm
     * @return
     */
    @RequestMapping("/getQxxx")
    @ResponseBody
    public String getQxxx(int f_JB,String f_Qxbm,HttpServletRequest request){
        return repertoryService.getQxxx(f_JB,f_Qxbm,request);
    }

    /**
     * 保存菜单
     * @param yjcd
     * @param ejcd
     * @param newcd
     * @return
     */
    @RequestMapping("/savecd")
    @ResponseBody
    public String savecd(String yjcd,String ejcd,String newcd,HttpServletRequest request){
        return repertoryService.savecd(yjcd,ejcd,newcd,request);
    }


    @RequestMapping("/savaBill")
    @ResponseBody
    public String savaBill(String f_bmbm,String yhje,String jsje,String spxx,String ycckbm,String yrckbm, HttpServletRequest request){
        String f_sjhm = (String) request.getSession().getAttribute("f_sjhm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = repertoryService.SavaBill(yhje,jsje,spxx,f_zybm,f_bmbm,f_zymc,f_shbm,ycckbm,yrckbm);
        }
        return result;
    }

    @RequestMapping("/loadBm")
    @ResponseBody
    public String loadBm(HttpServletRequest request){
        return repertoryService.loadBm(request);
    }

    @RequestMapping("/loadCk")
    @ResponseBody
    public String loadCk(HttpServletRequest request){
        return repertoryService.loadCk(request);
    }

    @RequestMapping("/loadSp")
    @ResponseBody
    public String loadSp(HttpServletRequest request){
        return repertoryService.loadSp(request);
    }

    @RequestMapping("/loadGys")
    @ResponseBody
    public String loadGys(HttpServletRequest request){
        return repertoryService.loadGys(request);
    }

    @RequestMapping("/loadCkbb")
    @ResponseBody
    public String loadCkbb(String kcrq,String f_bmbm,String f_ckbm,String sptm,String gysbm,
                           Integer pageIndex,Integer pageSize, HttpServletRequest request){
        String result = repertoryService.loadCkbb(kcrq,f_bmbm,f_ckbm,sptm,gysbm,pageIndex,pageSize,request);
        return result;
    }

}
