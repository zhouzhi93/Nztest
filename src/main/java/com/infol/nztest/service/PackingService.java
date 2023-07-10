package com.infol.nztest.service;

import com.infol.nztest.dao.SqlServerOperator;

public interface PackingService {
    public String GetCsda(String Csbm, String f_shbm);
    public String getSpda(String f_dwid, String f_bmbm, String spxx);
    public String SavaBill(String f_gysbm, String yhje, String jsje, String spxx,
                           String f_zybm, String f_bmbm, String f_zymc, String f_shbm, String f_djh, String sub);
    public String savaPackingManageRecordBill(String czfs, String yhje, String jsje, String spxx,
                           String f_zybm, String f_bmbm, String f_zymc, String f_shbm, String f_djh, String sub);
    public String GetSpkcBySptm(String f_sptm, String f_shbm);

    public  String  GetJhZbxx(String f_gysbm, String f_shbm);

    public  String  GetJhcbmx(String f_djh, String f_shbm);

    public String GetBillDetail(String khxx, String bmbm, String f_rq, String f_shbm);

    public String GetSpgjDetail(String cxtj, String f_rq, String f_shbm);
    //double 四舍五入;
    public double SplitAndRound(double a, int n);
    /**
     * @deprecated 获取最大单据号+1
     * @param f_shbm
     * @param
     * @return
     */
    public String newBillNo(String f_shbm, SqlServerOperator sqlser);
    /**
     * @deprecated 删除未审核单据
     * @param f_bmbm
     * @param f_djh
     * @param f_shbm
     * @return
     * @throws Exception
     */
    public String delete(String f_bmbm, String f_djh, String f_shbm)throws Exception;
    /**
     * @deprecated 查询分管门店
     * @param f_shbm
     * @param f_zybm
     * @param f_bmbm
     * @return
     * @throws Exception
     */
    public String depts(String f_shbm, String f_zybm, String f_bmbm);

    /**
     * @deprecated 回收查询
     * @param f_shbm
     * @param cxms
     * @param f_ksrq
     * @param f_jsrq
     * @param f_zybm
     * @param cxtj
     * @return
     */
    public String queryDetail(String f_shbm, String cxms, String f_ksrq, String f_jsrq, String f_zybm, String cxtj);

    String getBrckmc(String brckbm, String f_shbm, String f_zybm);

    String getBcwd(String f_shbm, String f_zybm);

    String bzwbrdBill(String brckbm, String bcwdbm, String spxx,String f_zybm,String f_zymc,String f_shbm);

    String getBcckmc(String bcckbm, String f_shbm, String f_zybm);

    String getBrdw(String bcdwbm,String f_shbm, String f_zybm);

    String bzwbcdBill(String bcckbm, String brdwbm, String spxx, String f_zybm, String f_zymc, String f_shbm);

    String hzcx(String cxtj, String f_ksrq, String f_jsrq, String f_shbm, String f_zybm);

    String mxcx(String cxtj, String f_ksrq, String f_jsrq, String f_shbm, String f_zybm);

    String queryDjxq(String f_djh,String f_bmbm, String f_shbm);

    String bcdhzcx(String cxtj, String f_ksrq, String f_jsrq, String f_shbm, String f_zybm);

    String bcdmxcx(String cxtj, String f_ksrq, String f_jsrq, String f_shbm, String f_zybm);
}
