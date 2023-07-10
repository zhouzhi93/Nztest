package com.infol.nztest.service;

import javax.servlet.http.HttpServletRequest;

public interface SalesParameterService {

    String getXstzs(String ksrq, String jsrq, String spmc, String djh, String sptm, String khbm, String khmc, String qybm,
                    Integer pageIndex,Integer pageSize,HttpServletRequest request);

    String getXstzs_total(String ksrq, String jsrq, String spmc, String djh, String sptm, String khbm, String khmc, String qybm,
                    HttpServletRequest request);

    String getCjtzs(String ksrq, String jsrq, String spmc, String djh, String sptm, String gysbm, String gysmc, String qybm,
                    Integer pageIndex,Integer pageSize, HttpServletRequest request);

    String getCjtzs_total(String ksrq, String jsrq, String spmc, String djh, String sptm, String gysbm,
                          String gysmc, String qybm,HttpServletRequest request);

}
