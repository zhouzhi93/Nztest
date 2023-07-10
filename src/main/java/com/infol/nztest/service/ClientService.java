package com.infol.nztest.service;

import javax.servlet.http.HttpServletRequest;

public interface ClientService {

    String updateKhmx(String khbm, String f_khmc, String f_sjhm, String f_sfzh, String f_qydz, String f_xxdz,
                      String f_bzxx, String f_lxr, String cslx, String f_xkzh, HttpServletRequest request,
                      String f_Dz,String f_Khh,String f_Yhkh,String f_Tyxym,String f_Sfjzps,String f_Khlx,String flbms,String sls);

    String AddKhda(String f_khmc, String f_sjhm, String f_sfzh, String f_qydz, String f_xxdz,
                   String f_bzxx, String f_lxr, String cslx, String f_xkzh, HttpServletRequest request);

    String AddKhdaNew(String f_khmc, String f_sjhm, String f_sfzh, String f_qydz,
                      String f_Dz,String f_Khh,String f_Yhkh,String f_Tyxym,String f_Sfjzps,String f_Khlx,
                      String f_bzxx, String f_lxr, String cslx, String f_xkzh, String flbms,String sls,HttpServletRequest request);

    String getKhda(String khxx, String cslx,Integer pageIndex,Integer pageSize, HttpServletRequest request);

    String getKhda_total(String khxx, String cslx, HttpServletRequest request);

    String DeleteKhda(String f_csbm, HttpServletRequest request);

    String getTjlxxx(HttpServletRequest request);

    String queryMaxFlbm(HttpServletRequest request);

    String addlx(String f_tjlxmc, String f_flbm, String f_sfzylx, String f_sfsynh, String f_sfsydh, String f_sfsyhzs, HttpServletRequest request);

    String updateLx(String tjlxmc, String flbm, String sfzylx, String sfsynh, String sfsydh, String sfsyhzs, HttpServletRequest request);

    String deleteLx(String flbm, HttpServletRequest request);

    String getLxmx(HttpServletRequest request);

    String getTjmxda(String flbm, HttpServletRequest request);

    String getMaxtjmx(String flbm, String jb, HttpServletRequest request);

    String saveTjmxda(String flbm, String flmc, String flmx, String jb, String mj,String dwmc, HttpServletRequest request);

    String deleteTjmxda(String flbm,String jb, HttpServletRequest request);

    String loadcstjmx(String khlx,HttpServletRequest request);

    String loadsl(String csbm, String khlx,HttpServletRequest request);

    String loadmjxh(String khlx, HttpServletRequest request);

    String getBtjsTable(String khlx,HttpServletRequest request);

    String saveJe(String nhje, String dhje, String hzsje,String nhxh,String dhxh,String hzsxh, HttpServletRequest request);

    String getJyjTable(HttpServletRequest request);

    String getZylx(int jyjId,int state,HttpServletRequest request);

    String getZylxByJyjid(int index, HttpServletRequest request);

    String saveZylxState(int jyjId,String flbmItems,String noflbmItems,String khlxItems,String nokhlxItems,HttpServletRequest request);

    String saveAddJyj(String f_jyjName, String f_startTime, String f_endTime,  HttpServletRequest request);

    String saveUpdateJyj(int f_jyjId, String f_jyjName, String f_startTime, String f_endTime, HttpServletRequest request);

    String saveDeleteJyj(String jyjId, HttpServletRequest request);

    String getCsszTable(String f_lxbm,HttpServletRequest request);

    String saveCs(String csbmList, String cszList, HttpServletRequest request);

    String getCkdamx(HttpServletRequest request);

    String getCkda(String f_ckbm, HttpServletRequest request);

    String getMaxCkda(String ckbm, String jb, HttpServletRequest request);

    String saveCkda(String f_ckbm, String f_ckmc, String f_ckmj, String f_dz, String f_dh, String f_fzr, String f_cksx, HttpServletRequest request);

    String deleteCkda(String f_ckbm, HttpServletRequest request);

    String loadGsxx(HttpServletRequest request);

    String saveGsxx(String sjhm, String f_qydz, String f_xxdz, String f_zykl, String f_yzbm, String f_qrkl, String f_lxdh, String f_jyxkzh, String f_emall, String f_khh, String f_khzh, String f_sh, String f_fr, Float f_zczb, int f_sfls, HttpServletRequest request);
}
