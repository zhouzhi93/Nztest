package com.infol.nztest.service;

import javax.servlet.http.HttpServletRequest;

public interface ArrearageService {
    String SavaBill(String csbm, String yhje, String jsje, String spxx, String f_zybm, String f_bmbm, String f_zymc, String f_shbm, String f_djbz);
    String GetBillDetail(String khxx, String bmbm, String f_ksrq, String f_jsrq, String f_shbm, String f_zybm);
    String proceeds(String f_djh,String f_bmbm,Double f_qkje,Double f_skje,Double f_syje,HttpServletRequest request);
}
