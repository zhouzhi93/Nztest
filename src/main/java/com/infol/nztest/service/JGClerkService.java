package com.infol.nztest.service;

public interface JGClerkService {

    String getZymx(String zybm);

    String addZymx(String zylx, String zymc, String zykl, String dh, String dwmc, String fgqy);

    String removeZymx(String zybm);

    String updateZymx(String zylx, String zybm, String zymc, String zykl, String dh, String dwmc, String fgqy);

    String getQymx();

    void saveQymx();

}
