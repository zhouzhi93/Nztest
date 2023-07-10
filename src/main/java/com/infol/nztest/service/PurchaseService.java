package com.infol.nztest.service;

import javax.servlet.http.HttpServletRequest;

public interface PurchaseService {
    String GetSpda(String spxx,String f_shbm);
    String GetCsda(String csbm,String f_shbm);
    String AddCsda(String f_csmc,String f_sjhm,String f_xxdz,String f_shbm);
    String SavaBill(String csbm,String yhje,String jsje,String spxx,String f_zybm,String f_bmbm,String f_zymc,String f_shbm,String f_djbz);
    String GetBillDetail(String khxx, String bmbm,String f_ksrq,String f_jsrq,String f_shbm,String f_zybm);
    String  GetJhZbxx(String f_gysbm,String f_shbm,String f_bmbm,String f_spxx);
    String  GetJhcbmx(String data,String f_shbm);
    String SavaBill_refund(String f_ydjh,String f_gysbm,String yhje,String jsje,String spxx,String f_zybm,String f_bmbm,String f_zymc,String f_shbm);
    String GetSpkcBySptm(String f_sptm,String f_shbm,String f_bmbm);
    String GetSpgjDetail(String cxtj,String f_ksrq,String f_jsrq,String f_shbm,String f_zybm);

    String loadCkxx(HttpServletRequest request);

    String showDetail(String f_djh, String f_shbm);
}
