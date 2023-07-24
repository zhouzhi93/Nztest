package com.infol.nztest.controller;

import com.infol.nztest.service.LoginService;
import com.infol.nztest.util.emay.SMS;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Random;

@Api(value = "登录注册", tags="登录注册")
@Controller
public class LoginController {
    @Autowired
    private LoginService loginService;
    @RequestMapping("/login")
    public String login(){
        return "login";
    }
    @RequestMapping("/regist")
    public String regist(){
        return "regist";
    }

    @RequestMapping("/registUser")
    @ResponseBody
    @ApiOperation("注册")
    public String Regist(String f_sjhm,String f_khmc,String f_yzm,String f_zykl,String f_qrkl,String f_shlx,String f_sfls,String f_qydz,String f_xxdz,String f_yzbm,String f_lxdh,String f_jyxkzh,
                         String f_emall,String f_khh,String f_khzh,String f_sh,String f_fr,String f_zczb,HttpServletRequest request){
        System.out.println(f_yzm);
        String SesYzm=(String) request.getSession().getAttribute("YZM");
        if(!f_yzm.equals(SesYzm)||SesYzm=="null"){
            return "验证码不正确!";
        }
        if(!f_zykl.equals(f_qrkl))
        {
            return "两次输入的密码不一致!";
        }
        String result=loginService.Regist(f_sjhm,f_khmc,f_zykl,f_shlx,f_sfls,f_qydz,f_xxdz,f_yzbm,f_lxdh,f_jyxkzh,
                f_emall,f_khh,f_khzh,f_sh,f_fr,f_zczb);;
        if(result=="ok") {
            request.getSession().removeAttribute("YZM");
            SMS.setSingleSms(f_sjhm, "【盈放云平台】 您好！您的申请已经提交成功，请等待审核！");
        }
        return result;
    }
    @RequestMapping("/forgetPwd")
    @ResponseBody
    public String forgetPwd(String f_sjhm,String f_yzm,String f_zykl,String f_qrkl,HttpServletRequest request){
        System.out.println(f_yzm);
        String SesYzm=(String) request.getSession().getAttribute("YZM");
        if(!f_yzm.equals(SesYzm)||SesYzm=="null"){
            return "验证码不正确!";
        }
        if(!f_zykl.equals(f_qrkl))
        {
            return "两次输入的密码不一致!";
        }
        String result=loginService.forgetPwd(f_sjhm,f_zykl);
        return result;
    }

    @RequestMapping("/edit")
    public String edit(Model model,HttpServletRequest request){
        String shda=(String) request.getSession().getAttribute("shda_edit");
        model.addAttribute("shda",shda);
        if(shda==null){
            return "/regist";
        }else {
            return "/editApply";
        }
    }

    /**
     * 验证登录
     * @param f_sjhm
     * @param f_zykl
     * @param request
     * @return
     */
    @RequestMapping("/checkLogin")
    @ResponseBody
    public String checkLogin(String f_sjhm,String f_zykl,HttpServletRequest request) {
        String result="";
        try
        {
            result=loginService.CheckLogin(f_sjhm,f_zykl);
            if (result.startsWith("err")) {
                throw new Exception(result.replace("err",""));
            }else {
                JSONArray jarr= new JSONArray(result);
                String f_zybm="",f_bmbm="",f_zymc="",f_shbm="",f_lxbm="",f_shmc="";
                if(jarr.length()>=1){
                    JSONObject json = jarr.getJSONObject(0);
                    String dbzykl = json.getString("F_ZYKL");
                    if (!dbzykl.equals(f_zykl)) {
                        throw new Exception("密码不正确!");
                    }
                    String shzt=json.getString("F_SHZT");
                    switch (shzt){
                        case "0":
                            //request.getSession().setAttribute("shda_edit",json.toString());
                            throw new Exception("申请尚未审核!");
                        case "1":
                            f_zybm=json.getString("F_ZYBM");
                            f_zymc=json.getString("F_ZYMC");
                            f_shbm=json.getString("F_SHBM");
                            f_shmc=json.getString("F_SHMC");
                            f_lxbm=json.getString("F_LXBM");
                            break;
                        case "2":
                            request.getSession().setAttribute("shda_edit",json.toString());
                            throw new Exception("申请审核失败!");
                        case "3":
                            throw new Exception("该商户已停用!");
                            default:
                                throw new Exception("商户状态异常!");
                    }
                }else {
                    throw new Exception("帐号不存在!");
                }
                String zyqxlist=loginService.GetZyqx(f_zybm,f_shbm);
                request.getSession().setAttribute("zyqxlist",zyqxlist);
                request.getSession().setAttribute("f_sjhm",f_sjhm);
                request.getSession().setAttribute("f_zybm",f_zybm);
                request.getSession().setAttribute("f_zymc",f_zymc);
                request.getSession().setAttribute("f_shbm",f_shbm);
                request.getSession().setAttribute("f_zymc",f_zymc);
                request.getSession().setAttribute("f_lxbm",f_lxbm);
                request.getSession().setAttribute("f_shmc",f_shmc);

                //添加参数设置到session
                String csszList = loginService.getCssz(f_shbm);
                JSONArray csszJarr = new JSONArray(csszList);
                String f_title = csszJarr.getJSONObject(0).getString("F_CSZ");//主标题
                String f_xTitle = csszJarr.getJSONObject(1).getString("F_CSZ");//小标题
                String f_cTitle = csszJarr.getJSONObject(2).getString("F_CSZ");//次标题
                String f_brcdmrck = csszJarr.getJSONObject(13).getString("F_CSZ");//拨入(出)单默认仓库
                String f_bcdmrbrdw = csszJarr.getJSONObject(15).getString("F_CSZ");//拨出单默认拨入单位
                String f_qyck = csszJarr.getJSONObject(20).getString("F_CSZ");//启用仓库
                String f_dlxsxsd = csszJarr.getJSONObject(21).getString("F_CSZ");//登录显示销售单
                String f_jdxsdts = csszJarr.getJSONObject(22).getString("F_CSZ");//豇豆销售单提示
                String f_qygmxe = csszJarr.getJSONObject(29).getString("F_CSZ");//启用购买限额


                request.getSession().setAttribute("csszList",csszList);
                request.getSession().setAttribute("f_title",f_title);
                request.getSession().setAttribute("f_xTitle",f_xTitle);
                request.getSession().setAttribute("f_cTitle",f_cTitle);
                request.getSession().setAttribute("f_brcdmrck",f_brcdmrck);
                request.getSession().setAttribute("f_bcdmrbrdw",f_bcdmrbrdw);
                request.getSession().setAttribute("f_qyck",f_qyck);
                request.getSession().setAttribute("f_dlxsxsd",f_dlxsxsd);
                request.getSession().setAttribute("f_jdxsdts",f_jdxsdts);
                request.getSession().setAttribute("f_qygmxe",f_qygmxe);

                int qxCount = Integer.parseInt(loginService.GetSaleBillQX(f_zybm,f_shbm));
                if (qxCount > 0 && f_dlxsxsd.equals("1")){
                    result = "gotoSalesBill";
                }else {
                    result = "ok";
                }
            }
        }
        catch (Exception e)
        {
            result=e.getMessage();
        }
        return result;
    }
    @RequestMapping("/signout")
    @ResponseBody
    public String signout(HttpServletRequest request){
        request.getSession().removeAttribute("f_sjhm");
        request.getSession().removeAttribute("f_zybm");
        request.getSession().removeAttribute("f_bmbm");
        request.getSession().removeAttribute("f_zymc");
        request.getSession().removeAttribute("f_shbm");
        request.getSession().removeAttribute("f_zymc");
        return "ok";
    }
    @RequestMapping("/editshxx")
    @ResponseBody
    public String EditShxx(String f_sjhm,String f_khmc,String f_yzm,String f_zykl,String f_qrkl,String f_shlx,String f_sfls,String f_qydz,String f_xxdz,String f_yzbm,String f_lxdh,String f_jyxkzh,
                         String f_emall,String f_khh,String f_khzh,String f_sh,String f_fr,String f_zczb,HttpServletRequest request){
        String result=loginService.EditShxx(f_sjhm,f_khmc,f_zykl,f_shlx,f_sfls,f_qydz,f_xxdz,f_yzbm,f_lxdh,f_jyxkzh,
                f_emall,f_khh,f_khzh,f_sh,f_fr,f_zczb);;
        return result;
    }
    @RequestMapping("/SendMsg")
    @ResponseBody
    public String SendMsg(String f_sjhm,HttpServletRequest request) {
        try {
            String code= GerRandCode(4);
            System.out.println(code);
            String content = "【盈放云平台】您的验证码是：" +code;
            boolean res= SMS.setSingleSms(f_sjhm, content);
            if(res){
                request.getSession().setAttribute("YZM",code);
                return "ok";
            }else{
                throw new Exception("平台返回失败!");
            }

        }catch (Exception ex){
            return "发送失败:"+ex.getMessage();
        }
    }

    @RequestMapping("/getShlx")
    @ResponseBody
    public String getShlx( HttpServletRequest request){
        return loginService.getShlx();
    }


    private String GerRandCode(int codeLen){
        Random random = new Random();
        String result="";
        for (int i=0;i<codeLen;i++)
        {
            result+=random.nextInt(10);
        }
        return result;
    }
}
