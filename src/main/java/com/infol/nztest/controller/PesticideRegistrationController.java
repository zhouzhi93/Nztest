package com.infol.nztest.controller;

import com.infol.nztest.service.PesticideRegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/registration")
public class PesticideRegistrationController {
    @Autowired
    private  PesticideRegistrationService pesticideRegistrationService;

    @RequestMapping("/PesticideUseRegistration")
    public String pesticideUseRegistration(Model model){
        return "/registration/PesticideUseRegistration";
    }

    @RequestMapping("/GetKhda")
    @ResponseBody
    public  String Getkhda(String f_sfzh,String f_dh)
    {
        return pesticideRegistrationService.GetKhda(f_sfzh,f_dh);
    }

    @RequestMapping("/saleZbxx")
    @ResponseBody
    public String saleZbxx(String f_cxtj,String f_khbm,String f_shbm,String f_nybz) {
        String result = "";
        result = pesticideRegistrationService.GetSaleZbxx(f_cxtj,f_shbm,f_khbm,f_nybz);
        return result;
    }

    /**
     * 保存农药登记
     * @param splist
     * @return
     */
    @RequestMapping("/SavaNydj")
    @ResponseBody
    public String SavaNydj(String splist) {
        String result = "";
        System.out.println(splist);
        result = pesticideRegistrationService.SavaNydj(splist);
        return result;
    }
}
