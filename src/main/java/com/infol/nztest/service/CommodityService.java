package com.infol.nztest.service;

import javax.servlet.http.HttpServletRequest;

public interface CommodityService {

    String getSpda(String spxx,Integer pageIndex,Integer pageSize,Integer xjbz, HttpServletRequest request);

    String getSpda_total(String spxx,Integer xjbz, HttpServletRequest request);

    //根据商品类别获取商品条码最大值
    String getMaxSptm(String splbbm, HttpServletRequest request);

    String GetSpda(String spxx, HttpServletRequest request);

    String saveSpda(String sptm, String djh, String spmc, String spfl, String ggxh, String jldw, String xsj,
                    String jhj, String jxsl, String xxsl, String scxkz, String ghs, String scqy, String splx, String nybz,
                    String nycpdjz, String nycpbz, String nycpbq, String nycpsms, String nycpzmwjbh,
                    String zhl,String jx,String mbzzl,String mbzzldw,String ppmc,String yxcf,String dx,
                    String yxq,String syfw,HttpServletRequest request);
    String saveBjkc(String sptm,String bjkc,HttpServletRequest request);

    String updateSpda(String sptm, String djh, String spmc, String spfl, String ggxh, String jldw, String xsj,
                      String jhj, String jxsl, String xxsl, String scxkz, String ghs, String scqy, String splx, String nybz,
                      String nycpdjz, String nycpbz, String nycpbq, String nycpsms, String nycpzmwjbh,
                      String zhl,String jx,String mbzzl,String mbzzldw,String ppmc,String yxcf,String dx,String yxq,
                      String syfw,HttpServletRequest request);

    String updateSpTp(String sptm, String sptp,HttpServletRequest request);

    String stopstart(String sptm,Integer xjbz,HttpServletRequest request);

    String removeSpda(String sptm, HttpServletRequest request);

    String getMaxSplbbm(String splbbm, String jb, HttpServletRequest request);

    String getSplb(String splbbm, HttpServletRequest request);

    String getSplbmx(String splbbm, String jb, HttpServletRequest request);

    String saveSplbda(String splbbm, String splbmc, String bz, String jb, HttpServletRequest request);


    String loadDx(HttpServletRequest request);

    String loadSyfw(HttpServletRequest request);
}
