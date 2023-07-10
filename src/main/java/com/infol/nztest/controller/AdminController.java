package com.infol.nztest.controller;

import com.infol.nztest.service.AdminLoginService;
import com.infol.nztest.service.LoginService;
import com.infol.nztest.util.emay.SMS;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Random;

@Controller
@RequestMapping("/manage")
public class AdminController {
    @Autowired
    private AdminLoginService loginService;

    @RequestMapping("/gotoAdminLogin")
    public String gotoAdminLogin(){
        return "/admin/adminlogin";
    }

    @RequestMapping("/gotoAdminIndex")
    public String gotoAdminIndex(){
        return "/admin/adminIndex";
    }

    @RequestMapping("/checkLogin")
    @ResponseBody
    public String checkLogin(String f_zybm,String f_zykl,HttpServletRequest request) {
        String result="";
        try
        {
            result=loginService.CheckLogin(f_zybm,f_zykl);
            if (result.startsWith("err")) {
                throw new Exception(result.replace("err",""));
            }else {
                JSONArray jarr= new JSONArray(result);
                String f_zymc="";
                if(jarr.length()>=1){
                    JSONObject json = jarr.getJSONObject(0);
                    f_zymc=json.getString("F_ZYMC");
                }else {
                    throw new Exception("帐号不存在!");
                }
                request.getSession().setAttribute("f_zybm",f_zybm);
                request.getSession().setAttribute("f_zymc",f_zymc);
                request.getSession().setAttribute("glf_zybm",f_zybm);
                request.getSession().setAttribute("glf_zymc",f_zymc);
                result="ok";
            }
        }
        catch (Exception e)
        {
            result=e.getMessage();
        }
        return result;
    }

}
