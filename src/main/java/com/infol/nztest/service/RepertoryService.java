package com.infol.nztest.service;

import javax.servlet.http.HttpServletRequest;

public interface RepertoryService {


    String getKctzs(String kcrq, String spmc, String djh, String sptm, String gysbm, String gysmc,
                    Integer pageIndex,Integer pageSize,HttpServletRequest request);

    String getKctzs_total(String kcrq, String spmc, String djh, String sptm, String gysbm, String gysmc,
                    HttpServletRequest request);

    String getKctzsBj(HttpServletRequest request);

    String getKcpcmx(String kcrq, String sptm, HttpServletRequest request);

    String getQxxx(int f_JB, String f_Qxbm,HttpServletRequest request);

    String savecd(String yjcd, String ejcd, String newcd,HttpServletRequest request);

    String SavaBill(String yhje, String jsje, String spxx, String f_zybm, String f_bmbm, String f_zymc, String f_shbm,String ycckbm,String yrckbm);

    String loadBm(HttpServletRequest request);

    String loadCk(HttpServletRequest request);

    String loadSp(HttpServletRequest request);

    String loadGys(HttpServletRequest request);

    String loadCkbb(String kcrq, String f_bmbm, String f_ckbm, String sptm, String gysbm, Integer pageIndex, Integer pageSize, HttpServletRequest request);
}
