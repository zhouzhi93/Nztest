package com.infol.nztest.service;

import java.util.HashMap;
import java.util.List;

public interface GainsLossesService {
    /**
     * @deprecated 获取最大单据号+1
     * @param f_dwid
     * @param f_djlx
     * @return
     */
    String newBillNo(String f_dwid, String f_djlx);

    /*     select f_bmbm,f_ckbm,f_djh,f_djlx,f_dnxh,f_sptm,f_ypzjh,f_jldwlx,f_sysl,f_sydj,f_syje,f_sysj,f_sl,f_lsdj,f_lsje,f_syyybm,f_js,f_sgpch,f_pch,f_splx,f_zhjj from tb10_Spsycb
         select f_djh,f_zdrq,f_rzrq,f_zdrbm,f_zdrmc,f_fhrbm,f_fhrmc,f_bmbm,f_ckbm,f_djlx,f_state,f_zzzt from tb10_Spsyzb
    */
    String savebill(HashMap datas);

    /**
     * @deprecated  查询
     * @param f_cxms
     * @param f_ksrq  如果是单据明细查询f_ksrq和f_jsrq全部取制单日期
     * @param f_jsrq
     * @param f_dwid
     * @param f_zybm
     * @param f_bmbm
     * @param f_spbm
     * @param f_djlx  单据类型
     * @param f_djh   单据号，只在单据明细查询时出现
     * @return
     */
    List query(String f_cxms, String f_ksrq, String f_jsrq, String f_dwid, String f_zybm,
               String f_bmbm, String f_spbm, String f_djlx, String f_djh);
    /**
     * @deprecated 获取商品列表
     * @param f_dwid  商户号
     * @param f_bmbm  门店号
     * @param spxx    商品信息
     * @return
     */
    public String getSpda(String f_dwid, String f_bmbm, String spxx);

    /**
     * @deprecated 获取可见门店
     * @param f_dwid
     * @param f_zybm
     * @return
     */
    public String getDept(String f_dwid, String f_zybm);
    /**
     * @deprecated 查询分管门店
     * @param f_shbm
     * @param f_zybm
     * @param f_bmbm
     * @return
     * @throws Exception
     */
    public String depts(String f_shbm, String f_zybm, String f_bmbm);
}
