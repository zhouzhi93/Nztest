package com.infol.nztest.service;

public interface AllotService {

    String SavaBill(String f_dcbmbm,String f_drbmbm,String yhje,String jsje,String spxx,String f_shbm,String f_zybm,String f_zymc,Integer dblx);
    String GetBillDetail(String cxtj, String bmbm, String f_ksrq, String f_jsrq, String f_shbm, String f_zybm);

    String GetSpzyDetail(String cxtj,String f_ksrq,String f_jsrq,String f_shbm,String f_zybm);
    String  GetZyHzcbmx(String f_djh,String f_shbm);

    String GetSpkccbdj(Integer f_xssl,String f_sptm,String f_dcbmbm, String f_shbm);

}
