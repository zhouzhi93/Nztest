package com.infol.nztest.service;

import java.util.List;

public interface LoginService {
    String CheckLogin(String f_sjhm,String f_zykl);
    String CheckLoginApprove(String f_sjhm,String f_zykl);
    String GetZysxbm(String f_zybm,String f_shbm);
    String Regist(String f_sjhm,String f_khmc,String f_zykl,String f_shlx,String f_sfls,String f_qydz,String f_xxdz,String f_yzbm,String f_lxdh,String f_jyxkzh,
                  String f_emall,String f_khh,String f_khzh,String f_sh,String f_fr,String f_zczb);
    String forgetPwd(String f_sjhm,String f_zykl);
    String EditShxx(String f_sjhm,String f_khmc,String f_zykl,String f_shlx,String f_sfls,String f_qydz,String f_xxdz,String f_yzbm,String f_lxdh,String f_jyxkzh,
             String f_emall,String f_khh,String f_khzh,String f_sh,String f_fr,String f_zczb);
    String GetZyqx(String f_zybm, String f_shbm);
    String getShlx();

    String getCssz(String f_shbm);

    String GetSaleBillQX(String f_zybm, String f_shbm);
}
