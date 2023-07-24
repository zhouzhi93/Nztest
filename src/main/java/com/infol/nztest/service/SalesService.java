package com.infol.nztest.service;

import javax.servlet.http.HttpServletRequest;

public interface SalesService {
    String GetSpda(String spxx,String f_shbm);
    String GetSpda_PD(String pd,String f_shbm,String type);
    String GetKhda(String khxx,String identity,String f_shbm);
    String AddKhda(String f_khmc,String f_sjhm,String f_sfzh,String f_bzxx,String f_xxdz,String f_shbm);
    String SavaBill(String khbm,String yhje,String jsje,String spxx,String f_zybm,String f_bmbm,String f_zymc,String f_shbm,
                    String redio,String catalogue,String jhgsbm,Integer zfbz);
    String GetBillDetail(String khxx, String bmbm,String f_ksrq,String f_jsrq,String f_shbm,String f_zybm);
    String GetSaleZbxx(String khxx,String f_shbm,String f_bmbm,String f_spxx);
    String GetSalecbmx(String data,String f_shbm);
    String SavaBill_refund(String khbm,String yhje,String jsje,String spxx,String f_zybm,String f_bmbm,String f_zymc,String f_shbm);
    String GetSalesDetail(String cxtj,String f_ksrq,String f_jsrq,String f_shbm,String f_zybm);
    String GetSalesDetailByDjh(String djh,String f_shbm,String f_zybm);
    String GetWxsp(String f_zybm,String f_shbm,String f_djlx);
    String getSaleAll();

    String getkhxx(String khbm, String f_shbm);

    String loadLsxsd(String khbm,String f_djh,String zdrq, String f_shbm);

    String firstXsd(String khbm, String f_shbm);

    String finallyXsd(String khbm, String f_shbm);

    String afterXsd(String khbm, String f_djh, String zdrq, String f_shbm);

    String GetKhdaByCsbm(String f_csbm, String cslx, HttpServletRequest request);

    String getJdrqqj(String khbm, String rq, HttpServletRequest request);

    String GetBillDetailByKhbm(String khbm, String cxtj, String f_bmbm, String f_ksrq, String f_jsrq, String f_shbm, String f_zybm);

    String GetSalesDetailByKhbm(String khbm, String searchSpxx, String f_ksrq, String f_jsrq, String f_shbm, String f_zybm);

    String getXsdXq(String f_djh, String f_shbm);

    String sfsyjd(String sptms, String f_shbm);

    String queryByJxny(String f_jxxz, String f_ksrq, String f_jsrq, String f_bmbm, String f_shbm, String f_zybm);

    String queryBySyzw(String f_syzw, String f_ksrq, String f_jsrq, String f_bmbm, String f_shbm, String f_zybm);
}
