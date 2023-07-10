package com.infol.nztest.service;

import javax.servlet.http.HttpServletRequest;

public interface StorService {

    String getBmmx(String bmxx, HttpServletRequest request);

    String getBmmxAll();

    String addBmmx(String bmmc, String yb, String dz, String dh, String cz, String email, String khh, String zh,
                   String sh, String fr, String tybz, String jwd, String jyxkzh, String jyfzrq, String jysxrq, String jyxkztp,
                   String jwjg, String hfzm, String xsjg, String scxkzh, String scfzrq, String scsxrq, String scxkztp, String zxbz,
                   String aqbz, String hbdj, String xxqy,
                   String dkqppbm,String yjdz,String yjmm,String yjzh,String jhgsbm,HttpServletRequest request);

    String removeBmmx(String bmbm, HttpServletRequest request);

    String updateBmmx(String bmbm, String bmmc, String yb, String dz, String dh, String cz, String email, String khh,
                      String zh, String sh, String fr, String tybz, String jwd, String jyxkzh, String jyfzrq, String jysxrq, String jyxkztp,
                      String jwjg, String hfzm, String xsjg, String scxkzh, String scfzrq, String scsxrq, String scxkztp, String zxbz,
                      String aqbz, String hbdj, String xxqy,
                      String dkqppbm,String yjdz,String yjmm,String yjzh,String jhgsbm,HttpServletRequest request);

    String getJhgsda(HttpServletRequest request);

    String getDkqppda(HttpServletRequest request);

    void responseBmmx(String bmbm,String shbm);

}
