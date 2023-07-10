package com.infol.nztest.controller;

import com.infol.nztest.service.ClientService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/initialvalues")
public class ClientController {
    @Autowired
    private ClientService clientService ;

    @RequestMapping("/gotoClient")
    public String gotoClient(Model model){
        return "initialValue/client";
    }

    @RequestMapping("/gotoSupplier")
    public String gotoSupplier(Model model){
        return "initialValue/supplier";
    }

    @RequestMapping("/gotoTjlxwh")
    public String gotoTjlxwh(Model model){
        return "initialValue/tjlxwh";
    }

    @RequestMapping("/gotoTjmxwh")
    public String gotoTjmxwh(Model model){
        return "initialValue/tjmxwh";
    }

    @RequestMapping("/gotoTjmxwhTree")
    public String gotoTjmxwhTree(Model model){
        return "initialValue/tjmxwhTree";
    }

    @RequestMapping("/gotoBtbzsz")
    public String gotoBtbzsz(Model model){
        return "initialValue/btbzsz";
    }

    @RequestMapping("/gotoJyjsz")
    public String gotoJyjsz(Model model){
        return "initialValue/jyjsz";
    }

    @RequestMapping("/gotoCssz")
    public String gotoCssz(Model model){
        return "initialValue/cssz";
    }

    @RequestMapping("/gotoCkda")
    public String gotoCkda(Model model){
        return "initialValue/ckda";
    }

    @RequestMapping("/gotoCkdaTree")
    public String gotoCkdaTree(Model model){
        return "initialValue/ckdaTree";
    }

    @RequestMapping("/gotoGsxx")
    public String gotoGsxx(Model model){
        return "initialValue/gsxx";
    }

    @RequestMapping("/updateKhmx")
    @ResponseBody
    public String updateKhmx(String f_khbm,String f_khmc, String f_sjhm, String f_sfzh, String f_qydz,
                             String f_xxdz, String f_bzxx,String f_lxr,String cslx,String f_xkzh, HttpServletRequest request,
                             String f_Dz,String f_Khh,String f_Yhkh,String f_Tyxym,String f_Sfjzps,String f_Khlx,String flbms,String sls){
        return clientService.updateKhmx(f_khbm,f_khmc,f_sjhm,f_sfzh,f_qydz,f_xxdz,f_bzxx,f_lxr,cslx,f_xkzh,request,f_Dz,f_Khh,f_Yhkh,f_Tyxym,f_Sfjzps,f_Khlx,flbms,sls);
    }

    @RequestMapping("/AddKhda")
    @ResponseBody
    public String AddKhda(String f_khmc,String f_sjhm,String f_sfzh,String f_qydz,String f_xxdz,
                          String f_bzxx,String f_lxr,String cslx,String f_xkzh, HttpServletRequest request ){
        return clientService.AddKhda(f_khmc,f_sjhm,f_sfzh,f_qydz,f_xxdz,f_bzxx,f_lxr,cslx,f_xkzh,request);
    }

    @RequestMapping("/AddKhdaNew")
    @ResponseBody
    public String AddKhdaNew(String f_khmc,String f_sjhm,String f_sfzh,String f_qydz,
                             String f_Dz,String f_Khh,String f_Yhkh,String f_Tyxym,String f_Sfjzps,String f_Khlx,
                             String f_bzxx,String f_lxr,String cslx,String f_xkzh,String flbms,String sls, HttpServletRequest request ){
        return clientService.AddKhdaNew(f_khmc,f_sjhm,f_sfzh,f_qydz,
                f_Dz,f_Khh,f_Yhkh,f_Tyxym,f_Sfjzps,f_Khlx,f_bzxx,f_lxr,cslx,f_xkzh,flbms,sls,request);
    }

    @RequestMapping("/GetKhda")
    @ResponseBody
    public String GetKhda(String khxx,String cslx,Integer pageIndex,Integer pageSize, HttpServletRequest request){
        String result = clientService.getKhda(khxx,cslx,pageIndex,pageSize,request);
        String total = clientService.getKhda_total(khxx,cslx,request);
        JSONObject jsonObject= new JSONObject();
        jsonObject.put("list",result);
        jsonObject.put("total",total);
        return jsonObject.toString();
    }

    @RequestMapping("/DeleteKhda")
    @ResponseBody
    public String DeleteKhda(String f_Csbm, HttpServletRequest request){
        return clientService.DeleteKhda(f_Csbm,request);
    }

    @RequestMapping("/getTjlxxx")
    @ResponseBody
    public String getTjlxxx(HttpServletRequest request){
        return clientService.getTjlxxx(request);
    }

    /**
     * 查询最大分类编码+1
     * @param request
     * @return
     */
    @RequestMapping("/queryMaxFlbm")
    @ResponseBody
    public String queryMaxFlbm(HttpServletRequest request){
        return clientService.queryMaxFlbm(request);
    }

    /**
     * 保存新增类型
     * @param f_tjlxmc
     * @param f_flbm
     * @param f_sfzylx
     * @param f_sfsynh
     * @param f_sfsydh
     * @param f_sfsyhzs
     * @param request
     * @return
     */
    @RequestMapping("/addlx")
    @ResponseBody
    public String addlx(String f_tjlxmc,String f_flbm,String f_sfzylx,String f_sfsynh,String f_sfsydh,String f_sfsyhzs, HttpServletRequest request){
        return clientService.addlx(f_tjlxmc,f_flbm,f_sfzylx,f_sfsynh,f_sfsydh,f_sfsyhzs,request);
    }

    /**
     * 保存修改类型
     * @param tjlxmc
     * @param flbm
     * @param sfzylx
     * @param sfsynh
     * @param sfsydh
     * @param sfsyhzs
     * @param request
     * @return
     */
    @RequestMapping("/updateLx")
    @ResponseBody
    public String updateLx(String tjlxmc, String flbm,String sfzylx,String sfsynh,String sfsydh,String sfsyhzs, HttpServletRequest request){
        return clientService.updateLx(tjlxmc,flbm,sfzylx,sfsynh,sfsydh,sfsyhzs,request);
    }

    /**
     * 保存删除类型
     * @param flbm
     * @param request
     * @return
     */
    @RequestMapping("/deleteLx")
    @ResponseBody
    public String deleteLx(String flbm, HttpServletRequest request){
        return clientService.deleteLx(flbm,request);
    }


    /**
     * 获取类型明细
     * @param request
     * @return
     */
    @RequestMapping("/getLxmx")
    @ResponseBody
    public String getLxmx( HttpServletRequest request){
        return clientService.getLxmx(request);
    }

    /**
     * 获取统计明细档案
     * @param flbm
     * @param request
     * @return
     */
    @RequestMapping("/getTjmxda")
    @ResponseBody
    public String getTjmxda(String flbm, HttpServletRequest request){
        return clientService.getTjmxda(flbm,request);
    }

    /**
     * 获取最大分类编码
     * @param flbm
     * @param jb
     * @param request
     * @return
     */
    @RequestMapping("/getMaxtjmx")
    @ResponseBody
    public String getMaxtjmx(String flbm,String jb, HttpServletRequest request) {
        return clientService.getMaxtjmx(flbm,jb,request);
    }

    /**
     * 保存统计明细档案
     * @param flbm
     * @param flmc
     * @param flmx
     * @param jb
     * @param mj
     * @param request
     * @return
     */
    @RequestMapping("/saveTjmxda")
    @ResponseBody
    public String saveTjmxda(String flbm, String flmc, String flmx,String jb,String mj,String dwmc, HttpServletRequest request){
        return clientService.saveTjmxda(flbm,flmc,flmx,jb,mj,dwmc,request);
    }

    /**
     * 删除统计明细档案
     * @param flbm
     * @param jb
     * @param request
     * @return
     */
    @RequestMapping("/deleteTjmxda")
    @ResponseBody
    public String deleteTjmxda(String flbm,String jb, HttpServletRequest request){
        return clientService.deleteTjmxda(flbm,jb,request);
    }

    /**
     * 加载厂商统计明细
     * @param request
     * @return
     */
    @RequestMapping("/loadcstjmx")
    @ResponseBody
    public String loadcstjmx(String khlx,HttpServletRequest request){
        return clientService.loadcstjmx(khlx,request);
    }

    /**
     * 加载客户分类明细具体数量（xxx亩）
     * @param csbm
     * @param request
     * @return
     */
    @RequestMapping("/loadsl")
    @ResponseBody
    public String loadsl(String csbm,String khlx,HttpServletRequest request){
        return clientService.loadsl(csbm,khlx,request);
    }

    /**
     * 加载当前客户类型末级明细的序号和名称
     * @param khlx
     * @param request
     * @return
     */
    @RequestMapping("/loadmjxh")
    @ResponseBody
    public String loadmjxh(String khlx,HttpServletRequest request){
        return clientService.loadmjxh(khlx,request);
    }

    /**
     * 获取补贴基数表格
     * @param khlx

     * @param request
     * @return
     */
    @RequestMapping("/getBtjsTable")
    @ResponseBody
    public String getBtjsTable(String khlx,HttpServletRequest request){
        return clientService.getBtjsTable(khlx,request);
    }

    /**
     * 保存金额
     * @param nhje
     * @param dhje
     * @param hzsje
     * @param request
     * @return
     */
    @RequestMapping("/saveJe")
    @ResponseBody
    public String saveJe(String nhje,String dhje,String hzsje,String nhxh,String dhxh,String hzsxh,HttpServletRequest request){
        return clientService.saveJe(nhje,dhje,hzsje,nhxh,dhxh,hzsxh,request);
    }

    /**
     * 展示补贴基数表格中除种养类型选择的内容
     * @param request
     * @return
     */
    @RequestMapping("/getJyjTable")
    @ResponseBody
    public String getJyjTable(HttpServletRequest request){
        return clientService.getJyjTable(request);
    }

    /**
     * 展示种养类型选择中的数据
     * @param request
     * @return
     */
    @RequestMapping("/getZylx")
    @ResponseBody
    public String getZylx(int jyjId,int state,HttpServletRequest request){
        return clientService.getZylx(jyjId,state,request);
    }

    /**
     * 通过经营季id获取种养类型明细
     * @param index
     * @param request
     * @return
     */
    @RequestMapping("/getZylxByJyjid")
    @ResponseBody
    public String getZylxByJyjid(int index,HttpServletRequest request){
        return clientService.getZylxByJyjid(index,request);
    }

    /**
     * 修改种养类型状态
     * @param jyjId
     * @param flbmItems
     * @param noflbmItems
     * @param request
     * @return
     */
    @RequestMapping("/saveZylxState")
    @ResponseBody
    public String saveZylxState(int jyjId,String flbmItems,String noflbmItems,String khlxItems,String nokhlxItems,HttpServletRequest request){
        return clientService.saveZylxState(jyjId,flbmItems,noflbmItems,khlxItems,nokhlxItems,request);
    }

    /**
     * 保存新增经营季
     * @param f_jyjName
     * @param f_startTime
     * @param f_endTime
     * @param request
     * @return
     */
    @RequestMapping("/saveAddJyj")
    @ResponseBody
    public String saveAddJyj(String f_jyjName,String f_startTime,String f_endTime,HttpServletRequest request){
        return clientService.saveAddJyj(f_jyjName,f_startTime,f_endTime,request);
    }

    /**
     * 保存修改经营季
     * @param f_jyjId
     * @param f_jyjName
     * @param f_startTime
     * @param f_endTime
     * @param request
     * @return
     */
    @RequestMapping("/saveUpdateJyj")
    @ResponseBody
    public String saveUpdateJyj(int f_jyjId,String f_jyjName,String f_startTime,String f_endTime,HttpServletRequest request){
        return clientService.saveUpdateJyj(f_jyjId,f_jyjName,f_startTime,f_endTime,request);
    }

    /**
     * 保存删除经营季
     * @param jyjId
     * @param request
     * @return
     */
    @RequestMapping("/saveDeleteJyj")
    @ResponseBody
    public String saveDeleteJyj(String jyjId,HttpServletRequest request){
        return clientService.saveDeleteJyj(jyjId,request);
    }

    /**
     * 获取厂商设置表
     * @param request
     * @return
     */
    @RequestMapping("/getCsszTable")
    @ResponseBody
    public String getCsszTable(String f_lxbm,HttpServletRequest request){
        return clientService.getCsszTable(f_lxbm,request);
    }

    /**
     * 保存参数
     * @param csbmList
     * @param cszList
     * @param request
     * @return
     */
    @RequestMapping("/saveCs")
    @ResponseBody
    public String saveCs(String csbmList,String cszList,HttpServletRequest request){
        return clientService.saveCs(csbmList,cszList,request);
    }


    /**
     * 获取仓库档案明细
     * @param request
     * @return
     */
    @RequestMapping("/getCkdamx")
    @ResponseBody
    public String getCkdamx( HttpServletRequest request){
        return clientService.getCkdamx(request);
    }

    /**
     * 获取仓库档案
     * @param f_ckbm
     * @param request
     * @return
     */
    @RequestMapping("/getCkda")
    @ResponseBody
    public String getCkda( String f_ckbm,HttpServletRequest request){
        return clientService.getCkda(f_ckbm,request);
    }

    /**
     * 获取最大仓库编码
     * @param ckbm
     * @param jb
     * @param request
     * @return
     */
    @RequestMapping("/getMaxCkda")
    @ResponseBody
    public String getMaxCkda(String ckbm,String jb, HttpServletRequest request) {
        return clientService.getMaxCkda(ckbm,jb,request);
    }

    /**
     * 保存仓库档案
     * @param f_ckbm
     * @param f_ckmc
     * @param f_ckmj
     * @param f_dz
     * @param f_dh
     * @param f_fzr
     * @param f_cksx
     * @param request
     * @return
     */
    @RequestMapping("/saveCkda")
    @ResponseBody
    public String saveCkda(String f_ckbm,String f_ckmc,String f_ckmj,String f_dz,String f_dh,String f_fzr,String f_cksx, HttpServletRequest request) {
        return clientService.saveCkda(f_ckbm,f_ckmc,f_ckmj,f_dz,f_dh,f_fzr,f_cksx,request);
    }

    /**
     * 删除仓库档案
     * @param f_ckbm
     * @param request
     * @return
     */
    @RequestMapping("/deleteCkda")
    @ResponseBody
    public String deleteCkda(String f_ckbm, HttpServletRequest request) {
        return clientService.deleteCkda(f_ckbm,request);
    }


    @RequestMapping("/loadGsxx")
    @ResponseBody
    public String loadGsxx( HttpServletRequest request) {
        return clientService.loadGsxx(request);
    }


    @RequestMapping("/saveGsxx")
    @ResponseBody
    public String saveGsxx( String sjhm,String f_qydz,String f_yzm,String f_xxdz,String f_zykl,String f_yzbm,
                            String f_qrkl,String f_lxdh,String f_jyxkzh,String f_emall,String f_khh,String f_khzh,
                            String f_sh,String f_fr,Float f_zczb,int f_sfls,HttpServletRequest request) {
        String SesYzm=(String) request.getSession().getAttribute("YZM");
        if(!f_yzm.equals(SesYzm)){
            return "411";
        }

        if(!f_zykl.equals(f_qrkl)) {
            return "412";
        }

        return clientService.saveGsxx(sjhm,f_qydz,f_xxdz,f_zykl,f_yzbm,f_qrkl,f_lxdh,f_jyxkzh,f_emall,f_khh,f_khzh,
                f_sh,f_fr,f_zczb,f_sfls,request);
    }
}
