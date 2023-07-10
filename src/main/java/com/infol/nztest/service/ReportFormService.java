package com.infol.nztest.service;

import javax.servlet.http.HttpServletRequest;

public interface ReportFormService {

    String loadBm(String f_shbm,String f_zybm);

    String loadZhjxc(String bmbm, String ksrq, String jsrq, String spflbm, String sptm, Integer pageIndex, Integer pageSize, HttpServletRequest request);

    String loadCk(HttpServletRequest request);

    String loadCrkcx(String bmbm, String ckbm, String ksrq, String jsrq, String spflbm, String sptm, Integer pageIndex, Integer pageSize, HttpServletRequest request);

    String showDetail(String sptm, String bmbm, String ckbm, String ksrq, String jsrq, String spflbm, HttpServletRequest request);

    String loadXsj(String f_shbm);

    String getZylx(String f_khlx,String jyjId,String f_shbm);

    String loadJxsbb(String jyjId, Integer pageIndex, Integer pageSize, HttpServletRequest request);
}
