package com.infol.nztest.controller;

import com.infol.nztest.service.CommodityService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/commodity")
public class CommodityController {
    @Autowired
    private CommodityService commodityService ;

    @RequestMapping("/gotoCommodity")
    public String gotoCommodity(Model model){
        return "initialValue/commodity";
    }

    @RequestMapping("/gotoSplb")
    public String gotoSplb(Model model){
        return "initialValue/splb";
    }

    @RequestMapping("/gotoSplbTree")
    public String gotoSplbTree(Model model){
        return "initialValue/splbTree";
    }

    @RequestMapping("/getMaxSptm")
    @ResponseBody
    public String getMaxSptm(String splbbm, HttpServletRequest request){
        return commodityService.getMaxSptm(splbbm,request);
    }

    @RequestMapping("/getSpda")
    @ResponseBody
    public String getSpda(String f_spxx,Integer pageIndex,Integer pageSize,Integer xjbz, HttpServletRequest request){
        String result = commodityService.getSpda(f_spxx,pageIndex,pageSize,xjbz,request);
        String total = commodityService.getSpda_total(f_spxx,xjbz,request);
        JSONObject jsonObject= new JSONObject();
        jsonObject.put("list",result);
        jsonObject.put("total",total);
        return jsonObject.toString();
    }

    @RequestMapping("/getSpmx")
    @ResponseBody
    public String getSpda2(String spxx, HttpServletRequest request){
        return commodityService.GetSpda(spxx,request);
    }

    @RequestMapping("/saveSpda")
    @ResponseBody
    public String saveSpda(String sptm,String djh,String spmc,String spfl,String ggxh,String jldw,String xsj,
                           String jhj,String jxsl,String xxsl,String scxkz,String ghs,String scqy,String splx,String nybz,
                           String nycpdjz,String nycpbz,String nycpbq,String nycpsms,String nycpzmwjbh,
                           String zhl,String jx,String mbzzl,String mbzzldw,String ppmc,String yxcf,String dx,
                           String yxq,String syfw,String fzdx,String sfcz,HttpServletRequest request){
        return commodityService.saveSpda(sptm,djh,spmc,spfl,ggxh,jldw,xsj,jhj,jxsl,xxsl,scxkz,ghs,scqy,splx,nybz,
                                        nycpdjz,nycpbz,nycpbq,nycpsms,nycpzmwjbh,zhl,jx,mbzzl,mbzzldw,ppmc,yxcf,
                                        dx,yxq,syfw,fzdx,sfcz,request);
    }

    @RequestMapping("/saveBjkc")
    @ResponseBody
    public String saveBjkc(String sptm,String bjkc,HttpServletRequest request){
        return commodityService.saveBjkc(sptm,bjkc,request);
    }

    @RequestMapping("/updateSpda")
    @ResponseBody
    public String updateSpda(String sptm,String djh,String spmc,String spfl,String ggxh,String jldw,String xsj,
                             String jhj,String jxsl,String xxsl,String scxkz,String ghs,String scqy,String splx,String nybz,
                             String nycpdjz,String nycpbz,String nycpbq,String nycpsms,String nycpzmwjbh,
                             String zhl,String jx,String mbzzl,String mbzzldw,String ppmc,String yxcf,String dx,String yxq,
                             String syfw,String sfcz,String fzdx,HttpServletRequest request){
        return commodityService.updateSpda(sptm,djh,spmc,spfl,ggxh,jldw,xsj,jhj,jxsl,xxsl,scxkz,ghs,scqy,splx,nybz,
                                            nycpdjz,nycpbz,nycpbq,nycpsms,nycpzmwjbh,zhl,jx,mbzzl,mbzzldw,ppmc,yxcf,dx,
                                            yxq,syfw,sfcz,fzdx,request);
    }

    @RequestMapping("/stopstart")
    @ResponseBody
    public String stopstart(String sptm,Integer xjbz,HttpServletRequest request){
        return commodityService.stopstart(sptm,xjbz,request);
    }

    @RequestMapping("/removeSpda")
    @ResponseBody
    public String removeSpda(String sptm, HttpServletRequest request){
        return commodityService.removeSpda(sptm,request);
    }

    @RequestMapping("/getSplbda")
    @ResponseBody
    public String getSplbda(String splbbm, HttpServletRequest request){
        return commodityService.getSplb(splbbm,request);
    }

    @RequestMapping("/getSplbmx")
    @ResponseBody
    public String getSplbmx(String splbbm,String jb, HttpServletRequest request){
        return commodityService.getSplbmx(splbbm,jb,request);
    }

    @RequestMapping("/getMaxsplb")
    @ResponseBody
    public String getMaxsplb(String splbbm,String jb, HttpServletRequest request){
        return commodityService.getMaxSplbbm(splbbm,jb,request);
    }

    @RequestMapping("/saveSplbda")
    @ResponseBody
    public String saveSplbda(String splbbm, String splbmc, String bz,String jb, HttpServletRequest request){
        return commodityService.saveSplbda(splbbm,splbmc,bz,jb,request);
    }

    @RequestMapping("/loadDx")
    @ResponseBody
    public String loadDx( HttpServletRequest request){
        return commodityService.loadDx(request);
    }

    @RequestMapping("/loadSyfw")
    @ResponseBody
    public String loadSyfw( HttpServletRequest request){
        return commodityService.loadSyfw(request);
    }

}
