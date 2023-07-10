package com.infol.nztest.service;

import javax.servlet.http.HttpServletRequest;

public interface AdminClerkService {

    String getZymx(String zybm);

    String addZymx(String zymc, String sjh, String zykl);

    String removeZymx(String zybm);

    String updateZymx(String zybm, String zymc, String sjh, String zykl);

}
