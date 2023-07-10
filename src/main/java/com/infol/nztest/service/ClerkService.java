package com.infol.nztest.service;

import javax.servlet.http.HttpServletRequest;

public interface ClerkService {

    String getZymx(String zybm, HttpServletRequest request);

    String addZymx(String zymc, String sjh, String zyqx, String zykl, String sxbm,String zyjs, HttpServletRequest request);

    String removeZymx(String zybm, HttpServletRequest request);

    String updateZymx(String zybm, String zymc, String sjh, String zyqx, String zykl, String sxbm,String zyjs, HttpServletRequest request);

    String getZyqx(String zybm,String qxxx,HttpServletRequest request);

}
