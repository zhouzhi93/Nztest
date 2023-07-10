package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import util.*;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import com.infol.nztest.service.PackingService;

@Transactional
@Service
public class PackingServiceImpl implements PackingService{
    private SqlServerOperator sqlOperator = null;
    private UtilTools ut = new UtilTools();
    private String sljd = null;
    private String jejd = null;
    private String djjd = null;
    private boolean fkc = false;
    private String f_gjlx = "2";
    private void openConnection(String f_dwid){//初始化参数及数据库连接(私有方法不释放连接，公有方法必须释放)
        try {
            //if(sqlOperator==null)
                sqlOperator = new SqlServerOperator();

            sljd = String.valueOf(ut.accuracyByType("0",f_dwid));
            jejd = String.valueOf(ut.accuracyByType("1",f_dwid));
            djjd = String.valueOf(ut.accuracyByType("2",f_dwid));
            if(sljd==null||"".equals(sljd)||"NULL".equalsIgnoreCase(sljd))sljd="0";
            if(jejd==null||"".equals(jejd)||"NULL".equalsIgnoreCase(jejd))jejd="2";
            if(djjd==null||"".equals(djjd)||"NULL".equalsIgnoreCase(djjd))djjd="2";
            String cs = ut.findParam(f_dwid, Parameter.SPCKKZ);
            fkc = cs!=null&&!"0".equals(cs);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String GetCsda(String Csbm,String f_shbm){
        this.openConnection(f_shbm);//创建连接池
        String result = null;
        try {
            StringBuilder sql = new StringBuilder();
            sql.append("select f_Csbm,f_Csmc,f_dh,f_jb ");
            sql.append(" from tb").append(f_shbm).append("_csda z");
            sql.append(" where f_cslx='1'");
            if(!"".equals(Csbm)){
                sql.append(" and f_csmc like '%").append(Csbm).append("%'");
            }
            result = sqlOperator.RunSQL_JSON(sql.toString());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    /**
     * @deprecated 获取商品列表
     * @param f_dwid  商户号
     * @param f_bmbm  门店号
     * @param spxx    商品信息
     * @return
     */
    @Override
    public String getSpda(String f_dwid,String f_bmbm,String spxx) {
        StringBuilder sql = new StringBuilder();
        this.openConnection(f_dwid);
        boolean sp = spxx!=null&&!"".equals(spxx.trim());
        sql.append("select z.f_sptm,z.f_spmc,z.f_ggxh,z.f_jldw,z.f_sl,");
        sql.append("cast(isnull(c.f_kcsl,0) as decimal(26,").append(this.sljd).append(")) f_kcsl,");
        sql.append("cast(case when isnull(c.f_xsdj,z.f_xsdj)=0 then z.f_xsdj else isnull(c.f_xsdj,z.f_xsdj) end as decimal(26,").append(this.djjd).append(")) f_xsdj,case when f_sptp = '' then '/image/default.png' else f_sptp end as f_sptp ");
        sql.append(" from tb").append(f_dwid).append("_spda z ");
        sql.append(" left join (select f_sptm,case when sum(f_kcsl)=0 then 0 ");
        sql.append("else sum(f_kcje)/sum(f_kcsl) end f_xsdj,sum(f_kcsl) f_kcsl");//+f_kcsj
        sql.append(" from tb").append(f_dwid).append("_spkc k");
        sql.append(" where k.f_sptm=k.f_sptm and f_kcsl>0");

        if(f_bmbm!=null&&!"".equals(f_bmbm))sql.append(" and f_bmbm='").append(f_bmbm).append("'");
        if(sp){
            sql.append(" and exists(select * from tb").append(f_dwid).append("_spda ");
            sql.append(" where f_sptm=k.f_sptm ");
            sql.append(" and (f_sptm like '"+spxx+"%'");
            sql.append(" or f_spmc like '%"+spxx+"%'))");
        }
        sql.append(" and f_rq=(select max(f_rq) from tb").append(f_dwid).append("_spkc ");
        sql.append(" where f_bmbm=k.f_bmbm and f_sptm=k.f_sptm and f_pch=k.f_pch)");
        sql.append(" group by f_sptm) c on z.f_sptm=c.f_sptm");
        sql.append(" where z.f_sptm=z.f_sptm ");
        sql.append(" and z.f_f_colum1>0");//正常商品
        if(sp){
            sql.append(" and (z.f_sptm like '%"+spxx+"%'");
            sql.append(" or z.f_spmc like '%"+spxx+"%')");
        }
        String result = null;

        try {

            result = sqlOperator.RunSQL_JSON(sql.toString());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlOperator.closeConnection();
        }
        return result;
    }

    /**
     * @deprecated 查询库存
     * @param f_bmbm  部门编码
     * @param f_spbm  商品编码
     * @param f_dwid  单位号
     * @return
     */
    private List findKc(String f_bmbm,String f_spbm,String f_dwid,SqlServerOperator sqlOperator) throws Exception {
        StringBuilder sql = new StringBuilder();
        sql.append("select f_pch,f_sgpch,");
        sql.append("cast(f_kcsl as decimal(26,").append(this.sljd).append(")) f_kcsl,");
        sql.append("cast(f_kcje as decimal(26,").append(this.jejd).append(")) f_kcje,");
        sql.append("cast(f_kcsj as decimal(26,").append(this.jejd).append(")) f_kcsj, ");
        sql.append("cast(abs(f_kcje/f_kcsl) as decimal(26,").append(this.djjd).append(")) f_kcdj  ");
        sql.append(" from tb").append(f_dwid).append("_spkc z ");
        sql.append(" where cast(f_kcsl as decimal(26,6))>0 ");
        sql.append(" and f_bmbm=? and f_sptm=? ");
        sql.append(" and f_rq=(select max(f_rq) from tb").append(f_dwid).append("_spkc ");
        sql.append(" where f_bmbm=z.f_bmbm and f_sptm=z.f_sptm and f_pch=z.f_pch)");
        sql.append(" and f_kcsl>0");
        sql.append(" order by f_pch ");
        return sqlOperator.queryList(sql.toString(),new String[]{f_bmbm,f_spbm});
    }

    /**
     * @deprecated 按批次进行先进先出处理
     * @param kcs  查询出存在库存的列表
     * @param f_sl 数量
     * @param f_dj 单价
     * @param f_je 金额
     * @param f_sj 税金
     * @param pch 批次号
     * @param f_dwid 单位ID
     * @return
     */
    private List apportionCost(List kcs,double f_sl,double f_dj,double f_je,double f_sj,String pch,String f_dwid,SqlServerOperator sqlOperator) {
        List  lst = new ArrayList();
        String[] arr =  null;//pch,sgpch,kcsl,kcje,kcsj,kcdj


        if(f_sl>0) {//正数作为升溢
            //pch = f_shrq+"_"+f_djh+"_J";//损溢单G销售单S
            arr = new String[]{pch,"",String.valueOf(f_sl),String.valueOf(f_je),String.valueOf(f_sj),String.valueOf(f_dj)};
            lst.add(arr);
        } else {//负数值为损耗
            double num = -1*f_sl;
            int sljd = UtilTools.accuracyByType("0",f_dwid);
            int jejd = UtilTools.accuracyByType("1",f_dwid);
            int djjd = UtilTools.accuracyByType("2",f_dwid);
            int s = kcs.size();
            double sl = 0.0d, je = 0.0d, sj=0.0d, dj=0.0d;
            String [] record = null;
            for(int i=0; i<s; i++) {
                arr = (String[])kcs.get(i);
                sl =  ut.parseStringToDouble(arr[2]);

                record = new String[6];
                if(ut.formatDouble(sl,sljd).equals(ut.formatDouble(num,sljd))) {
                    num = 0;
                    record[0] = arr[0];
                    record[1] = arr[1];
                    record[2] = "-"+arr[2];//sl
                    record[3] = "-"+arr[3];//je
                    record[4] = "-"+arr[4];//sj
                    record[5] = arr[5];//dj
                } else if(sl > num) {
                    record = new String[6];
                    record[0] = arr[0];
                    record[1] = arr[1];
                    record[2] = ut.formatDouble(-1*num,sljd);//sl
                    je = ut.parseStringToDouble(arr[3])*num/ut.parseStringToDouble(arr[2]);
                    record[3] = je==0?"0":("-"+ut.formatDouble(je,jejd));//je
                    sj = ut.parseStringToDouble(arr[4])*num/ut.parseStringToDouble(arr[2]);
                    record[4] = sj==0?"0":("-"+ut.formatDouble(sj,jejd));//sj
                    record[5] = arr[5];//dj
                    num = 0;
                } else {//该批次全部
                    record[0] = arr[0];
                    record[1] = arr[1];
                    record[2] = "-"+arr[2];//sl
                    record[3] = "-"+arr[3];//je
                    record[4] = "-"+arr[4];//sj
                    record[5] = arr[5];//dj
                    num -= sl;
                }
                lst.add(record);
                if(num<=0)break;
            }
            if(num>0) {
                if(this.fkc)return null;
            }
        }
        return lst;
    }

    /**
     * @deprecated 删除未审核单据
     * @param f_bmbm
     * @param f_djh
     * @param f_shbm
     * @return
     * @throws Exception
     */
    public String delete(String f_bmbm,String f_djh,String f_shbm) throws Exception {
        if(this.checks(f_bmbm,f_djh,f_shbm))return "该单据已审核不能删除！";
        List sqls = this.delSqls(f_bmbm,f_djh,f_shbm);
        return sqlOperator.execSqls(sqls);
    }

    /**
     * @deprecated 生成删除未审核单据
     * @param f_bmbm
     * @param f_djh
     * @param f_shbm
     * @return
     */
    private List delSqls(String f_bmbm,String f_djh,String f_shbm){
        List sqls = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("delete from tb").append(f_shbm).append("_spgjcb ");
        sql.append(" where f_gjlx=").append(f_gjlx);
        sql.append(" and f_bmbm='").append(f_bmbm).append("'");
        sql.append(" and f_djh='").append(f_djh).append("'");
        sqls.add(sql.toString());
        sql.setLength(0);
        sql.append("delete from tb").append(f_shbm).append("_spgjzb ");
        sql.append(" where f_gjlx=").append(f_gjlx);
        sql.append(" and f_bmbm='").append(f_bmbm).append("'");
        sql.append(" and f_djh='").append(f_djh).append("'");
        sqls.add(sql.toString());
        sql.setLength(0);
        return sqls;
    }

    /**
     * @deprecated 检查该单据是否已审核
     * @param f_bmbm
     * @param f_djh
     * @param f_shbm
     * @return
     */
    private boolean checks(String f_bmbm,String f_djh,String f_shbm) {
        StringBuilder sql = new StringBuilder();
        sql.append("select f_state from tb").append(f_shbm).append("_spgjzb z");
        sql.append(" where f_gjlx=").append(f_gjlx);
        sql.append(" and f_bmbm=? and f_djh=?");
        String state = sqlOperator.queryOneRecorderData(sql.toString(),new String[]{f_bmbm,f_djh});
        return state!=null&&"1".equalsIgnoreCase(state);
    }
    @Override
    public String SavaBill(String f_gysbm,String yhje,String jsje,String spxx,
                           String f_zybm,String f_bmbm,String f_zymc,String f_shbm,
                           String f_djh,String sub)  {
        this.openConnection(f_shbm);//创建连接池
        String result = null;
        try {
            List<String> sqlList= new ArrayList<>();
            StringBuilder sql = new StringBuilder();
            boolean upd = f_djh!=null&&!"".equalsIgnoreCase(f_djh);
            if(upd){
                if(this.checks(f_bmbm,f_djh,f_shbm))return "该单据已审核不能操作！";
                sqlList = this.delSqls(f_bmbm,f_djh,f_shbm);
            } else f_djh=newBillNo(f_shbm,sqlOperator);

            String f_Rzrq=PackingServiceImpl.retime();
            String f_djlx="0";
            String f_ckbm="";
            boolean sh = sub!=null&&"1".equalsIgnoreCase(sub);//是否审核
            String zt = "0";
            String f_shrbm = "";
            String f_shrmc = "";
            if(sh) {
                f_shrbm = f_zybm;
                f_shrmc = f_zymc;
                zt = "1";
            } else if(upd){
                sql.append("select f_zdrbm+','+f_zdrmc from tb").append(f_shbm).append("_spgjzb ");
                sql.append(" where f_gjlx=? and f_bmbm=? and f_djh=?");
                String str = sqlOperator.queryOneRecorderData(sql.toString(),new String[]{f_gjlx,f_bmbm,f_djh});
                sql.setLength(0);
                if(str!=null) {
                    int i = str.indexOf(",");
                    f_zybm = str.substring(0,i);
                    f_zymc = str.substring(i+1);
                }
            }
            sql.append("insert tb").append(f_shbm).append("_Spgjzb(");
            sql.append("f_Gjlx,f_Djh,f_Zdrq,f_Rzrq,f_Zdrbm,f_Zdrmc,f_Zrrbm,");
            sql.append("f_Bmbm,f_Ckbm,f_Gysbm,f_Jyfs,f_Djlx,f_State,f_fhrbm,f_fhrmc)");
            sql.append("values('").append(f_gjlx).append("','").append(f_djh);
            sql.append("','").append(f_Rzrq).append("','").append(f_Rzrq);
            sql.append("','").append(f_zybm).append("','").append(f_zymc);
            sql.append("',").append(f_zybm).append(",'").append(f_bmbm).append("','");
            sql.append(f_ckbm).append("','").append(f_gysbm).append("','0','0','");
            sql.append(zt).append("','").append(f_shrbm).append("','");
            sql.append(f_shrmc).append("')");
            sqlList.add(sql.toString());
            sql.setLength(0);
            JSONArray jarr= new JSONArray(spxx);

            JSONArray spjarr= null;
            JSONObject spJson = null;
            String spRes=null, f_ypzjh=null;
            double f_sl = 0.0,f_gjsl=0.0d,f_gjdj = 0.0d,f_ssje=0.0d,f_sssj=0.0d;
            List kcs = null, per = null,sls = new ArrayList();
            String[] pcs = null;
            int j=0, k=0,dnxh=0;


            String pch = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()).toString();
            for(int i=0;i<jarr.length();i++){
                JSONObject jobj=jarr.getJSONObject(i);
                String f_sptm=jobj.getString("sptm");
                sql.append("select * from tb").append(f_shbm).append("_spda z");//查询税率和药品登记证号
                sql.append(" where f_sptm='").append(f_sptm).append("'");
                sql.append(" and f_f_colum1>0");
                spRes = sqlOperator.RunSQL_JSON(sql.toString());
                sql.setLength(0);
                spjarr = new JSONArray(spRes);
                spJson = spjarr.getJSONObject(0);
                f_sl=Double.parseDouble(spJson.getString("F_SL"));
                f_ypzjh=spJson.getString("F_YPZJH");
                f_gjsl= Double.parseDouble(jobj.getString("gjsl"));
                f_gjdj=Double.parseDouble(jobj.getString("gjdj"));
                f_ssje=f_gjsl*f_gjdj;
                f_sssj = SplitAndRound(f_ssje / (1 + f_sl / 100) * f_sl / 100, 2);//税金
                sls = new ArrayList();

                if(sh) {
                    kcs = this.findKc(f_bmbm, f_sptm, f_shbm,sqlOperator);//pch,sgpch,kcsl,kcje,kcsj
                    //List kcs,String f_sl,String f_dj,String f_je,String f_sj,String f_djh,String f_shrq

                    per = this.apportionCost(kcs, f_gjsl, f_gjdj, f_ssje, f_sssj, pch, f_shbm,sqlOperator);

                    if (per == null) return "库存不够了!";
                    sls.addAll(per);
                } else {
                    pcs = new String[]{"","",String.valueOf(f_gjsl),String.valueOf(f_ssje),String.valueOf(f_sssj),String.valueOf(f_gjdj)};
                    sls.add(pcs);
                }
                j = sls.size();//0pch,1sgpch,2kcsl,3kcje,4kcsj,5kcdj
                for(k=0; k<j; k++) {
                    pcs = (String[]) sls.get(k);
                    sql.append("insert into tb").append(f_shbm).append("_Spgjcb(");
                    sql.append("f_Bmbm,f_Gjlx,f_Djh,f_Dnxh,f_Ckbm,f_Sptm,f_ypzjh,");
                    sql.append("f_Gjsl,f_Gjdj,f_Gjje,f_Gjsj,f_Sl,f_Lsdj,f_Lsje,f_Pch)");
                    sql.append("values('").append(f_bmbm).append("','").append(f_gjlx).append("','");
                    sql.append(f_djh).append("',").append(dnxh++).append(",'").append(f_ckbm);
                    sql.append("','").append(f_sptm).append("','").append(f_ypzjh).append("',");
                    sql.append(pcs[2]).append(",").append(pcs[5]).append(",");
                    sql.append(pcs[3]).append(",").append(pcs[4]).append(",");
                    sql.append(f_sl).append(",").append(pcs[5]).append(",").append(pcs[3]).append(",'");
                    sql.append(pcs[0]).append("')");
                    sqlList.add(sql.toString());
                    sql.setLength(0);
                }
            }
            if(sh) {//先全部涉及商品库存大于零的都拉到当前日期（当前日期已存在不拉）
                sql.append("insert into tb").append(f_shbm).append("_spkc");
                sql.append("(f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj)");
                sql.append(" select ").append(f_Rzrq).append(" f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj");
                sql.append(" from tb").append(f_shbm).append("_spkc z ");
                sql.append(" where z.f_rq!=").append(f_Rzrq);
                sql.append(" and z.f_rq=(select max(f_rq) from tb").append(f_shbm).append("_spkc ");
                sql.append(" where f_bmbm=z.f_bmbm and f_sptm=z.f_sptm and f_pch=z.f_pch) ");
                sql.append(" and f_bmbm='").append(f_bmbm).append("'");
                sql.append(" and cast(f_kcsl as decimal(26,").append(this.sljd).append("))>0");
                sql.append(" and exists(select * from tb").append(f_shbm).append("_spgjcb ");
                sql.append(" where f_gjlx='").append(f_gjlx).append("'");
                sql.append(" and f_djh='").append(f_djh).append("'");
                sql.append(" and f_bmbm='").append(f_bmbm).append("'");
                sql.append(" and f_sptm=z.f_sptm and f_bmbm=z.f_bmbm)");
                sqlList.add(sql.toString());
                sql.setLength(0);
                //更新库存
                sql.append("update tb").append(f_shbm).append("_spkc");
                sql.append(" set f_kcsl=c.f_kcsl+z.f_gjsl,");
                sql.append("f_kcje=c.f_kcje+z.f_gjje,");
                sql.append("f_kcsj=c.f_kcsj+z.f_gjsj ");
                sql.append(" from tb").append(f_shbm).append("_spkc c ");
                sql.append(" inner join tb").append(f_shbm).append("_spgjcb z ");
                sql.append(" on z.f_gjlx='").append(f_gjlx).append("'");
                sql.append(" and z.f_bmbm='").append(f_bmbm).append("'");
                sql.append(" and z.f_djh='").append(f_djh).append("'");
                sql.append(" and c.f_sptm=z.f_sptm and c.f_pch=z.f_pch");
                //sql.append(" and cast(z.f_gjsl as decimal(26,").append(this.sljd).append("))<0");
                sql.append(" where c.f_rq='").append(f_Rzrq).append("'");
                sql.append(" and c.f_bmbm='").append(f_bmbm).append("'");
                sqlList.add(sql.toString());
                sql.setLength(0);

                //插入新增批次
                sql.append("insert into tb").append(f_shbm).append("_spkc");
                sql.append("(f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj)");
                sql.append(" select ").append(f_Rzrq).append(" f_rq,'").append(f_bmbm).append("' f_bmbm,");
                sql.append("c.f_sptm,c.f_pch,c.f_sgpch,c.f_gjsl,f_gjje,f_gjsj");
                sql.append(" from tb").append(f_shbm).append("_spgjcb c ");
                sql.append(" where c.f_gjlx='").append(f_gjlx).append("'");
                sql.append(" and c.f_djh='").append(f_djh).append("'");
                sql.append(" and cast(c.f_gjsl as decimal(26,").append(this.sljd).append("))>0");

                sqlList.add(sql.toString());
                sql.setLength(0);
            }
            sqlOperator.ExecSql(sqlList);
            result="ok";
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }
    @Override
    public String savaPackingManageRecordBill(String czfs,String yhje,String jsje,String spxx,
                           String f_zybm,String f_bmbm,String f_zymc,String f_shbm,
                           String f_djh,String sub)  {
        this.openConnection(f_shbm);//创建连接池
        String result = null;
        try {
            String sqlStr="if not exists(select f_csbm from tb"+f_shbm+"_csda where f_Csbm='000000') insert into tb"+f_shbm+"_csda(f_cslx,f_Csbm,f_Csmc,f_Jb,f_Mj)values('1','000000','客户','1','1')";
            sqlOperator.ExecSQL(sqlStr);//如果不存在000000 默认客户,先插入,以免下面sql执行出现外键关联错误
            List<String> sqlList= new ArrayList<>();
            StringBuilder sql = new StringBuilder();
            boolean upd = f_djh!=null&&!"".equalsIgnoreCase(f_djh);
            if(upd){
                if(this.checks(f_bmbm,f_djh,f_shbm))return "该单据已审核不能操作！";
                sqlList = this.delSqls(f_bmbm,f_djh,f_shbm);
            } else f_djh=newBillNo(f_shbm,sqlOperator);

            String f_Rzrq=PackingServiceImpl.retime();
            String f_djlx="0";
            String f_ckbm="01";
            boolean sh = sub!=null&&"1".equalsIgnoreCase(sub);//是否审核
            String zt = "0";
            String f_shrbm = "";
            String f_shrmc = "";
            String f_gysbm="000000";
            if(sh) {
                f_shrbm = f_zybm;
                f_shrmc = f_zymc;
                zt = "1";
            } else if(upd){
                sql.append("select f_zdrbm+','+f_zdrmc from tb").append(f_shbm).append("_spgjzb ");
                sql.append(" where f_gjlx=? and f_bmbm=? and f_djh=?");
                String str = sqlOperator.queryOneRecorderData(sql.toString(),new String[]{f_gjlx,f_bmbm,f_djh});
                sql.setLength(0);
                if(str!=null) {
                    int i = str.indexOf(",");
                    f_zybm = str.substring(0,i);
                    f_zymc = str.substring(i+1);
                }
            }
            sql.append("insert tb").append(f_shbm).append("_Spgjzb(");
            sql.append("f_Gjlx,f_Djh,f_Zdrq,f_Rzrq,f_Zdrbm,f_Zdrmc,f_Zrrbm,");
            sql.append("f_Bmbm,f_Ckbm,f_Gysbm,f_Jyfs,f_Djlx,f_State,f_fhrbm,F_bzwczfs,f_fhrmc)");
            sql.append("values('").append(f_gjlx).append("','").append(f_djh);
            sql.append("','").append(f_Rzrq).append("','").append(f_Rzrq);
            sql.append("','").append(f_zybm).append("','").append(f_zymc);
            sql.append("',").append(f_zybm).append(",'").append(f_bmbm).append("','");
            sql.append(f_ckbm).append("','").append(f_gysbm).append("','0','0','");
            sql.append(zt).append("','").append(f_shrbm).append("','").append(czfs).append("','");
            sql.append(f_shrmc).append("')");
            sqlList.add(sql.toString());
            sql.setLength(0);
            JSONArray jarr= new JSONArray(spxx);

            JSONArray spjarr= null;
            JSONObject spJson = null;
            String spRes=null, f_ypzjh=null;
            double f_sl = 0.0,f_gjsl=0.0d,f_gjdj = 0.0d,f_ssje=0.0d,f_sssj=0.0d;
            List kcs = null, per = null,sls = new ArrayList();
            String[] pcs = null;
            int j=0, k=0,dnxh=0;


            String pch = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()).toString();
            for(int i=0;i<jarr.length();i++){
                JSONObject jobj=jarr.getJSONObject(i);
                String f_sptm=jobj.getString("sptm");
                sql.append("select * from tb").append(f_shbm).append("_spda z");//查询税率和药品登记证号
                sql.append(" where f_sptm='").append(f_sptm).append("'");
                sql.append(" and f_f_colum1>0");
                spRes = sqlOperator.RunSQL_JSON(sql.toString());
                sql.setLength(0);
                spjarr = new JSONArray(spRes);
                spJson = spjarr.getJSONObject(0);
                f_sl=Double.parseDouble(spJson.getString("F_SL"));
                f_ypzjh=spJson.getString("F_YPZJH");
                f_gjsl= -1*Double.parseDouble(jobj.getString("gjsl"));
                f_gjdj=Double.parseDouble(jobj.getString("gjdj"));
                f_ssje=f_gjsl*f_gjdj;
                f_sssj = SplitAndRound(f_ssje / (1 + f_sl / 100) * f_sl / 100, 2);//税金
                sls = new ArrayList();

                if(sh) {
                    kcs = this.findKc(f_bmbm, f_sptm, f_shbm,sqlOperator);//pch,sgpch,kcsl,kcje,kcsj
                    //List kcs,String f_sl,String f_dj,String f_je,String f_sj,String f_djh,String f_shrq

                    per = this.apportionCost(kcs, f_gjsl, f_gjdj, f_ssje, f_sssj, pch, f_shbm,sqlOperator);

                    if (per == null) return "库存不够了!";
                    sls.addAll(per);
                } else {
                    pcs = new String[]{"","",String.valueOf(f_gjsl),String.valueOf(f_ssje),String.valueOf(f_sssj),String.valueOf(f_gjdj)};
                    sls.add(pcs);
                }
                j = sls.size();//0pch,1sgpch,2kcsl,3kcje,4kcsj,5kcdj
                for(k=0; k<j; k++) {
                    pcs = (String[]) sls.get(k);
                    sql.append("insert into tb").append(f_shbm).append("_Spgjcb(");
                    sql.append("f_Bmbm,f_Gjlx,f_Djh,f_Dnxh,f_Ckbm,f_Sptm,f_ypzjh,");
                    sql.append("f_Gjsl,f_Gjdj,f_Gjje,f_Gjsj,f_Sl,f_Lsdj,f_Lsje,f_Pch)");
                    sql.append("values('").append(f_bmbm).append("','").append(f_gjlx).append("','");
                    sql.append(f_djh).append("',").append(dnxh++).append(",'").append(f_ckbm);
                    sql.append("','").append(f_sptm).append("','").append(f_ypzjh).append("',");
                    sql.append(pcs[2]).append(",").append(pcs[5]).append(",");
                    sql.append(pcs[3]).append(",").append(pcs[4]).append(",");
                    sql.append(f_sl).append(",").append(pcs[5]).append(",").append(pcs[3]).append(",'");
                    sql.append(pcs[0]).append("')");
                    sqlList.add(sql.toString());
                    sql.setLength(0);
                }
            }
            if(sh) {//先全部涉及商品库存大于零的都拉到当前日期（当前日期已存在不拉）
                sql.append("insert into tb").append(f_shbm).append("_spkc");
                sql.append("(f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj)");
                sql.append(" select ").append(f_Rzrq).append(" f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj");
                sql.append(" from tb").append(f_shbm).append("_spkc z ");
                sql.append(" where z.f_rq!=").append(f_Rzrq);
                sql.append(" and z.f_rq=(select max(f_rq) from tb").append(f_shbm).append("_spkc ");
                sql.append(" where f_bmbm=z.f_bmbm and f_sptm=z.f_sptm and f_pch=z.f_pch) ");
                sql.append(" and f_bmbm='").append(f_bmbm).append("'");
                sql.append(" and cast(f_kcsl as decimal(26,").append(this.sljd).append("))>0");
                sql.append(" and exists(select * from tb").append(f_shbm).append("_spgjcb ");
                sql.append(" where f_gjlx='").append(f_gjlx).append("'");
                sql.append(" and f_djh='").append(f_djh).append("'");
                sql.append(" and f_bmbm='").append(f_bmbm).append("'");
                sql.append(" and f_sptm=z.f_sptm and f_bmbm=z.f_bmbm)");
                sqlList.add(sql.toString());
                sql.setLength(0);
                //更新库存
                sql.append("update tb").append(f_shbm).append("_spkc");
                sql.append(" set f_kcsl=c.f_kcsl+z.f_gjsl,");
                sql.append("f_kcje=c.f_kcje+z.f_gjje,");
                sql.append("f_kcsj=c.f_kcsj+z.f_gjsj ");
                sql.append(" from tb").append(f_shbm).append("_spkc c ");
                sql.append(" inner join tb").append(f_shbm).append("_spgjcb z ");
                sql.append(" on z.f_gjlx='").append(f_gjlx).append("'");
                sql.append(" and z.f_bmbm='").append(f_bmbm).append("'");
                sql.append(" and z.f_djh='").append(f_djh).append("'");
                sql.append(" and c.f_sptm=z.f_sptm and c.f_pch=z.f_pch");
                //sql.append(" and cast(z.f_gjsl as decimal(26,").append(this.sljd).append("))<0");
                sql.append(" where c.f_rq='").append(f_Rzrq).append("'");
                sql.append(" and c.f_bmbm='").append(f_bmbm).append("'");
                sqlList.add(sql.toString());
                sql.setLength(0);

                //插入新增批次
                sql.append("insert into tb").append(f_shbm).append("_spkc");
                sql.append("(f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj)");
                sql.append(" select ").append(f_Rzrq).append(" f_rq,'").append(f_bmbm).append("' f_bmbm,");
                sql.append("c.f_sptm,c.f_pch,c.f_sgpch,c.f_gjsl,f_gjje,f_gjsj");
                sql.append(" from tb").append(f_shbm).append("_spgjcb c ");
                sql.append(" where c.f_gjlx='").append(f_gjlx).append("'");
                sql.append(" and c.f_djh='").append(f_djh).append("'");
                sql.append(" and cast(c.f_gjsl as decimal(26,").append(this.sljd).append("))>0");

                sqlList.add(sql.toString());
                sql.setLength(0);
            }
            sqlOperator.ExecSql(sqlList);
            result="ok";
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }
    @Override
    public String GetSpkcBySptm(String f_sptm,String f_shbm){
        //创建连接池
        this.openConnection(f_shbm);

        String result = null;
        try {
            StringBuilder sql = new StringBuilder();
            sql.append("select f_Bmbm,kc.f_Sptm,da.f_Spmc,kc.f_pch,f_Spmc,f_Ggxh,f_Jldw,");
            sql.append("cast(kc.f_kcsl as decimal(20,").append(this.sljd).append(")) f_kcsl,");
            sql.append("cast(kc.f_kcje/kc.f_kcsl as decimal(20,").append(this.djjd).append("))f_kcdj ");
            sql.append(" from tb").append(f_shbm).append("_spkc kc ");
            sql.append(" inner join tb").append(f_shbm).append("_Spda da on da.f_Sptm=kc.f_Sptm");
            sql.append(" where kc.f_Sptm='"+f_sptm+"'");
            sql.append(" and f_Rq=(select MAX(f_rq) from tb").append(f_shbm).append("_spkc ");
            sql.append(" where f_Sptm='").append(f_sptm).append("') and f_kcsl>0");
            result = sqlOperator.RunSQL_JSON(sql.toString());
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }
    @Override
    public  String  GetJhZbxx(String f_gysbm,String f_shbm){
        this.openConnection(f_shbm);//创建连接池
        String result = null;
        try {
            StringBuilder sql = new StringBuilder();
            sql.append("select zb.f_djh,f_zdrmc,f_Rzrq,isnull(kh.f_Csmc,'')f_Csmc ");
            sql.append(" from tb").append(f_shbm).append("_spgjzb zb ");
            sql.append(" inner join tb").append(f_shbm).append("_Csda kh on kh.f_Csbm=zb.f_Gysbm ");
            sql.append(" and kh.f_Cslx='1' ");
            sql.append(" where zb.f_gjlx=").append(f_gjlx);
            if(!"".equals(f_gysbm)){
                sql.append(" and  f_gysbm ='").append(f_gysbm).append("'");
            }
            sql.append(" and exists(select * from tb").append(f_shbm).append("_spgjcb ");
            sql.append(" where f_gjlx=zb.f_gjlx and f_bmbm=zb.f_bmbm and f_djh=zb.f_djh and f_gjsl>0)");
            result = sqlOperator.RunSQL_JSON(sql.toString());
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }
    @Override
    public  String  GetJhcbmx(String f_djh,String f_shbm){
        this.openConnection(f_shbm);//创建连接池
        String result = null;
        try {
            StringBuilder sql = new StringBuilder();
            sql.append("select cb.f_Sptm,f_Spmc,f_jldw,f_Ggxh,f_Pch,");
            sql.append("cast(cb.f_gjdj as decimal(20,").append(this.djjd).append(")) f_Gjdj,");
            sql.append("cast(cb.f_gjsl as decimal(20,").append(this.sljd).append(")) f_Gjsl,");
            sql.append("cast(cb.f_gjje as decimal(20,").append(this.jejd).append(")) f_Gjje ");
            sql.append(" from tb").append(f_shbm).append("_spgjcb cb ");
            sql.append(" inner join tb").append(f_shbm).append("_Spda spda on spda.f_Sptm=cb.f_Sptm ");
            sql.append(" where cb.f_gjlx=").append(f_gjlx);
            sql.append(" and cb.f_Djh='").append(f_djh).append("'");
            result = sqlOperator.RunSQL_JSON(sql.toString());
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }
    @Override
    public String GetBillDetail(String khxx, String bmbm,String f_rq,String f_shbm)    {
        this.openConnection(f_shbm);//创建连接池
        StringBuilder sql = new StringBuilder();
        String result = null;
        try {
            sql.append("select f_Djh,f_Zdrq,f_Zdrbm,f_Zdrmc,f_Bmbm,f_Ckbm,cs.f_Csmc,f_Djbz,");
            sql.append("case f_State when '0' then '未审核' else '已审核' end f_State ");
            sql.append(" from tb").append(f_shbm).append("_Spgjzb zb ");
            sql.append(" inner join tb").append(f_shbm).append("_Csda cs on cs.f_Csbm=zb.f_Gysbm ");
            sql.append(" and cs.f_Cslx='1' ");
            sql.append(" where zb.f_gjlx=").append(f_gjlx);
            sql.append(" and f_zdrq='").append(f_rq).append("' ");
            if(!"".equals(khxx)){
                sql.append(" and cs.f_Csmc like '%").append(khxx).append("%'");
            }
            result = sqlOperator.RunSQL_JSON(sql.toString());
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }
    @Override
    public String GetSpgjDetail(String cxtj,String f_rq,String f_shbm)    {
        this.openConnection(f_shbm);//创建连接池
        StringBuilder sql = new StringBuilder();
        String result = null;
        try {
            sql.append("select zb.f_Djh,zb.f_Rzrq,cb.f_Sptm,f_Spmc,");
            sql.append("f_Ggxh,f_jldw,f_Pch,");
            sql.append("cast(cb.f_gjdj as decimal(20,").append(this.djjd).append(")) f_Gjdj,");
            sql.append("cast(cb.f_gjsl as decimal(20,").append(this.sljd).append(")) f_Gjsl,");
            sql.append("cast(cb.f_gjje as decimal(20,").append(this.jejd).append(")) f_Gjje ");
            sql.append(" from tb").append(f_shbm).append("_Spgjcb cb ");
            sql.append(" inner join tb").append(f_shbm).append("_Spgjzb zb on zb.f_gjlx=cb.f_gjlx and zb.f_bmbm=cb.f_bmbm and zb.f_Djh=cb.f_Djh ");
            sql.append(" inner join tb").append(f_shbm).append("_Spda spda on spda.f_Sptm=cb.f_Sptm ");
            sql.append(" inner join tb").append(f_shbm).append("_Csda kh on kh.f_Csbm=zb.f_Gysbm ");
            sql.append(" and kh.f_Cslx='1' ");
            sql.append(" where zb.f_gjlx=").append(f_gjlx);
            sql.append(" and  zb.f_rzrq='").append(f_rq).append("'");
            if(!"".equals(cxtj)){
                sql.append(" and (kh.f_csmc like '%").append(cxtj).append("%' ");
                sql.append(" or kh.f_csbm like '%").append(cxtj).append("%'");//表结构暂无 客户信息
                sql.append(" or cb.f_sptm like '%").append(cxtj).append("%'");
                sql.append(" or spda.f_spmc like '%").append(cxtj).append("%')");
            }
            result = sqlOperator.RunSQL_JSON(sql.toString());
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }
    /**
     * @deprecated 回收查询
     * @param f_shbm  商户编码
     * @param cxms   0汇总1明细
     * @param f_ksrq  开始日期
     * @param f_jsrq  结束日期
     * @param f_zybm  职员
     * @param  cxtj  查询条件
     * @return
     */
    public String queryDetail(String f_shbm,String cxms,String f_ksrq,String f_jsrq,String f_zybm,String cxtj){
        this.openConnection(f_shbm);//创建连接池
        StringBuilder sql = new StringBuilder();
        String result = null;
        try {
            sql.append("select top 1 * from tb").append(f_shbm).append("_zysxbm z ");
            sql.append(" where f_zybm=?");
            String fg = sqlOperator.queryOneRecorderData(sql.toString(),new String[]{f_zybm});
            sql.setLength(0);
            boolean mx = cxms!=null&&"1".equalsIgnoreCase(cxms);

            sql.append("select zb.f_Djh,zb.f_Zdrq,zb.f_Rzrq,zb.f_Zdrbm,zb.f_Zdrmc,zb.f_Bmbm,zb.f_Djbz,");
            sql.append("isnull((select f_csmc from tb").append(f_shbm).append("_Csda where f_Csbm=zb.f_Gysbm ");
            sql.append(" and f_Cslx='1'),'') f_csmc, ");
            sql.append("case f_State when '0' then '未审核' else '已审核' end f_State ");
            if(mx) {
                sql.append(",cb.f_Sptm,spda.f_Spmc,spda.f_Ggxh,spda.f_jldw,cb.f_Pch,");
                sql.append("cast(cb.f_gjdj as decimal(20,").append(this.djjd).append(")) f_Gjdj,");
                sql.append("cast(cb.f_gjsl as decimal(20,").append(this.sljd).append(")) f_Gjsl,");
                sql.append("cast(cb.f_gjje as decimal(20,").append(this.jejd).append(")) f_Gjje ");
            }
            sql.append(" from tb").append(f_shbm).append("_Spgjzb zb ");
            if(mx) {
                sql.append(" inner join tb").append(f_shbm).append("_Spgjcb cb on zb.f_gjlx=cb.f_gjlx and zb.f_bmbm=cb.f_bmbm and zb.f_Djh=cb.f_Djh ");
                sql.append(" inner join tb").append(f_shbm).append("_Spda spda on spda.f_Sptm=cb.f_Sptm ");
            }
            sql.append(" where zb.f_gjlx=").append(f_gjlx);
            sql.append(" and  zb.f_zdrq between ? and ?");
            if(!"".equals(cxtj)){
                sql.append(" and (kh.f_csmc like '%").append(cxtj).append("%' ");
                if(mx) {
                    sql.append(" or cb.f_sptm like '%").append(cxtj).append("%'");
                    sql.append(" or spda.f_spmc like '%").append(cxtj).append("%'");
                }
                sql.append(" or kh.f_csbm like '%").append(cxtj).append("%')");//表结构暂无 客户信息
            }
            if(fg!=null&&fg.length()>0) {
                sql.append(" and exists(select * from tb").append(f_shbm).append("_zysxbm ");
                sql.append(" where f_zybm='").append(f_zybm).append("'");
                sql.append(" and (f_bmbm=left(zb.f_bmbm,len(f_bmbm))");
                sql.append(" or zb.f_bmbm=left(f_bmbm,len(zb.f_bmbm))))");
            }
            result = sqlOperator.RunSQL_JSON(sql.toString(),new String[]{f_ksrq,f_jsrq});
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String getBrckmc(String brckbm, String f_shbm, String f_zybm) {
        this.openConnection(f_shbm);//创建连接池
        String result = null;

        try {
            String sql = "select f_Bmmc from tb"+f_shbm+"_Bmda where f_Bmbm='"+brckbm+"' and f_bmlx=1";
            result = sqlOperator.queryOneRecorderData(sql);

        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String getBcwd(String f_shbm, String f_zybm) {
        this.openConnection(f_shbm);//创建连接池
        String result = null;

        try {
            String sql = "select f_Bmbm,f_Bmmc from tb"+f_shbm+"_Bmda where f_bmlx=0 order by f_bmbm desc";
            result = sqlOperator.RunSQL_JSON(sql);

        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String bzwbrdBill(String brckbm, String bcwdbm, String spxx,String f_zybm,String f_zymc,String f_shbm) {
        this.openConnection(f_shbm);//创建连接池
        String result = null;
        try {
            List<String> sqlList= new ArrayList<>();
            String sql = "";
            String f_djh = newBillNo(f_shbm,sqlOperator);
            int dnxh = 0;
            String pch = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()).toString();

            String f_Rzrq=PackingServiceImpl.retime();

            sql = "insert tb"+f_shbm+"_Spgjzb(f_Gjlx,f_Djh,f_Zdrq,f_Rzrq,f_Zdrbm,f_Zdrmc,f_Zrrbm,f_Bmbm,f_Ckbm,f_Gysbm,f_Jyfs,f_Djlx,f_State,f_fhrbm,f_fhrmc,f_c_col1,f_bzwczlx)\n" +
                    "values('"+f_gjlx+"','"+f_djh+"','"+f_Rzrq+"','"+f_Rzrq+"','"+f_zybm+"','"+f_zymc+"',"+f_zybm+",'"+bcwdbm+"','','','0','0','1','"+f_zybm+"','"+f_zymc+"','"+brckbm+"','1')";
            sqlList.add(sql);

            JSONArray jarr= new JSONArray(spxx);
            for(int i=0;i<jarr.length();i++){
                JSONObject jobj = jarr.getJSONObject(i);
                String f_sptm = jobj.getString("sptm");//商品条码

                sql = "select * from tb"+f_shbm+"_spda z\n" +
                        " where f_sptm='"+f_sptm+"' and f_f_colum1=1";
                String spda = sqlOperator.RunSQL_JSON(sql);
                JSONObject spobj = new JSONArray(spda).getJSONObject(0);
                double f_sl=Double.parseDouble(spobj.getString("F_SL"));
                String f_ypzjh=spobj.getString("F_YPZJH");
                double f_gjdj = Double.parseDouble(jobj.getString("gjdj"));//购进单价
                double f_gjsl = Double.parseDouble(jobj.getString("gjsl"));//购进数量
                double f_gjje = f_gjdj*f_gjsl;//购进金额
                double f_gjsj = SplitAndRound(f_gjje / (1 + f_sl / 100) * f_sl / 100, 2);//税金

                //判断库存是否充足
                sql = "select SUM(spkc.f_kcsl) from tb"+f_shbm+"_spkc spkc\n" +
                        "left join tb"+f_shbm+"_spgjcb cb on spkc.f_Bmbm=cb.f_Bmbm and cb.f_Sptm=spkc.f_Sptm and cb.f_Pch=spkc.f_pch and cb.f_Gjlx='"+f_gjlx+"' \n" +
                        "where spkc.f_Bmbm='"+bcwdbm+"' and spkc.f_Sptm='"+f_sptm+"' and cb.f_Gjlx='"+f_gjlx+"' and spkc.f_kcsl>0";
                String f_zkcsl = sqlOperator.queryOneRecorderData(sql);
                if (f_zkcsl == null){
                    //没有库存记录
                    result = "410";
                    return result;
                }else {
                    double zkcsl = Double.parseDouble(f_zkcsl);
                    if (zkcsl < f_gjsl){
                        //库存数量小于购进数量
                        result = "410";
                        return result;
                    }else {
                        //从表插入拨入仓库数据
                        sql = "insert into tb"+f_shbm+"_Spgjcb(f_Bmbm,f_Gjlx,f_Djh,f_Dnxh,f_Ckbm,f_Sptm,f_ypzjh,f_Gjsl,f_Gjdj,f_Gjje,f_Gjsj,f_Sl,f_Lsdj,f_Lsje,f_Pch,f_c_col1,f_bzwjcklx)\n" +
                                "values('"+brckbm+"','"+f_gjlx+"','"+f_djh+"','"+dnxh+++"','','"+f_sptm+"','"+f_ypzjh+"',"+f_gjsl+","+f_gjdj+","+f_gjje+","+f_gjsj+","+f_sl+","+f_gjdj+","+f_gjje+",'"+pch+"','"+bcwdbm+"','1')";
                        sqlList.add(sql);

                        //从表插入拨出网点负的数据
                        double gjsl = -1 * f_gjsl;
                        double gjdj = -1 * f_gjdj;
                        double gjje = -1 * f_gjje;
                        double gjsj = -1 * f_gjsj;
                        sql = "insert into tb"+f_shbm+"_Spgjcb(f_Bmbm,f_Gjlx,f_Djh,f_Dnxh,f_Ckbm,f_Sptm,f_ypzjh,f_Gjsl,f_Gjdj,f_Gjje,f_Gjsj,f_Sl,f_Lsdj,f_Lsje,f_Pch,f_c_col1,f_bzwjcklx)\n" +
                                "values('"+bcwdbm+"','"+f_gjlx+"','"+f_djh+"','"+dnxh+++"','','"+f_sptm+"','"+f_ypzjh+"',"+gjsl+","+gjdj+","+gjje+","+gjsj+","+-1*f_sl+","+gjdj+","+gjje+",'"+pch+"','"+brckbm+"','2')";
                        sqlList.add(sql);

                        //拨入仓库
                        sql = "insert into tb"+f_shbm+"_spkc(f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj) \n" +
                                "\tselect "+f_Rzrq+" f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj \n" +
                                "\tfrom tb"+f_shbm+"_spkc z  \n" +
                                "\twhere z.f_rq!="+f_Rzrq+" \n" +
                                "\tand z.f_rq=(select max(f_rq) from tb"+f_shbm+"_spkc  where f_bmbm=z.f_bmbm and f_sptm=z.f_sptm and f_pch=z.f_pch)  \n" +
                                "\tand f_bmbm='"+brckbm+"' \n" +
                                "\tand cast(f_kcsl as decimal(26,"+this.sljd+"))>0 \n" +
                                "\tand exists(select * from tb"+f_shbm+"_spgjcb  where f_gjlx='"+f_gjlx+"' and f_djh='"+f_djh+"' and f_bmbm='"+brckbm+"' and f_sptm=z.f_sptm and f_bmbm=z.f_bmbm)";
                        sqlList.add(sql);
                        //拨出网点
                        sql = "insert into tb"+f_shbm+"_spkc(f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj) \n" +
                                "\tselect "+f_Rzrq+" f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj \n" +
                                "\tfrom tb"+f_shbm+"_spkc z  \n" +
                                "\twhere z.f_rq!="+f_Rzrq+" \n" +
                                "\tand z.f_rq=(select max(f_rq) from tb"+f_shbm+"_spkc  where f_bmbm=z.f_bmbm and f_sptm=z.f_sptm and f_pch=z.f_pch)  \n" +
                                "\tand f_bmbm='"+bcwdbm+"' \n" +
                                "\tand cast(f_kcsl as decimal(26,"+this.sljd+"))>0 \n" +
                                "\tand exists(select * from tb"+f_shbm+"_spgjcb  where f_gjlx='"+f_gjlx+"' and f_djh='"+f_djh+"' and f_bmbm='"+bcwdbm+"' and f_sptm=z.f_sptm and f_bmbm=z.f_bmbm)";
                        sqlList.add(sql);

                        //拨入仓库操作
                        sql = "insert into tb"+f_shbm+"_spkc(f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj)\n" +
                                "values('"+f_Rzrq+"','"+brckbm+"','"+f_sptm+"','"+pch+"','','"+f_gjsl+"','"+f_gjje+"','"+f_gjsj+"');";
                        sqlList.add(sql);

                        //拨出网点操作
                        sql = "select spkc.* from tb"+f_shbm+"_spkc spkc\n" +
                                "left join tb"+f_shbm+"_spgjcb cb on spkc.f_Bmbm=cb.f_Bmbm and cb.f_Sptm=spkc.f_Sptm and cb.f_Pch=spkc.f_pch and cb.f_Gjlx='"+f_gjlx+"' \n" +
                                "where spkc.f_Bmbm='"+bcwdbm+"' and spkc.f_Sptm='"+f_sptm+"' and cb.f_Gjlx='"+f_gjlx+"' and spkc.f_kcsl>0 \n" +
                                "order by spkc.f_pch";
                        String spkcResult = sqlOperator.RunSQL_JSON(sql);
                        JSONArray spkcJarr = new JSONArray(spkcResult);
                        double tempGjsl = f_gjsl;
                        double tempGjje = f_gjje;
                        double tempGjsj = f_gjsj;
                        for (int h = 0; h < spkcJarr.length(); h++){
                            double spkcsl = Double.parseDouble(spkcJarr.getJSONObject(h).getString("F_KCSL"));
                            double spkcje = Double.parseDouble(spkcJarr.getJSONObject(h).getString("F_KCJE"));
                            double spkcsj = Double.parseDouble(spkcJarr.getJSONObject(h).getString("F_KCSJ"));
                            String spPch = spkcJarr.getJSONObject(h).getString("F_PCH");
                            if (spkcsl > tempGjsl){
                                double sysl = spkcsl-tempGjsl;
                                double syje = spkcje-tempGjje;
                                double sysj = spkcsj-tempGjsj;
                                //单批次扣除，该批次库存数量大于购进数量，直接当批次扣除
                                sql = "update tb"+f_shbm+"_spkc set f_kcsl="+sysl+",f_kcje="+syje+",f_kcsj="+sysj+" \n" +
                                        "where f_rq='"+f_Rzrq+"' and f_bmbm='"+bcwdbm+"' and f_Sptm='"+f_sptm+"' and f_pch="+spPch+"";
                                sqlList.add(sql);
                                break;
                            }else {
                                //多批次扣除，只清零当批次
                                sql = "update tb"+f_shbm+"_spkc set f_kcsl="+0+",f_kcje="+0+",f_kcsj="+0+"\n" +
                                        "where f_rq='"+f_Rzrq+"' and f_bmbm='"+bcwdbm+"' and f_Sptm='"+f_sptm+"' and f_pch="+spPch+"";
                                sqlList.add(sql);
                                tempGjsl -= spkcsl;
                                tempGjje -= spkcje;
                                tempGjsj -= spkcsj;
                            }
                        }
                    }
                }
            }
            sqlOperator.ExecSql(sqlList);
            result="ok";
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String getBcckmc(String bcckbm, String f_shbm, String f_zybm) {
        this.openConnection(f_shbm);//创建连接池
        String result = null;

        try {
            String sql = "select f_Bmmc from tb"+f_shbm+"_Bmda where f_Bmbm='"+bcckbm+"' and f_bmlx=1";
            result = sqlOperator.queryOneRecorderData(sql);

        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String getBrdw(String bcdwbm,String f_shbm, String f_zybm) {
        this.openConnection(f_shbm);//创建连接池
        String result = null;

        try {
            String sql = "select f_Bmbm,f_Bmmc from tb"+f_shbm+"_Bmda where f_Bmbm='"+bcdwbm+"' and f_bmlx=1";
            result = sqlOperator.RunSQL_JSON(sql);

        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String bzwbcdBill(String bcckbm, String brdwbm, String spxx, String f_zybm, String f_zymc, String f_shbm) {
        this.openConnection(f_shbm);//创建连接池
        String result = null;
        try {
            List<String> sqlList= new ArrayList<>();
            String sql = "";
            String f_djh = newBillNo(f_shbm,sqlOperator);
            int dnxh = 0;
            String pch = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()).toString();

            String f_Rzrq=PackingServiceImpl.retime();

            sql = "insert tb"+f_shbm+"_Spgjzb(f_Gjlx,f_Djh,f_Zdrq,f_Rzrq,f_Zdrbm,f_Zdrmc,f_Zrrbm,f_Bmbm,f_Ckbm,f_Gysbm,f_Jyfs,f_Djlx,f_State,f_fhrbm,f_fhrmc,f_c_col1,f_bzwczlx)\n" +
                    "values('"+f_gjlx+"','"+f_djh+"','"+f_Rzrq+"','"+f_Rzrq+"','"+f_zybm+"','"+f_zymc+"',"+f_zybm+",'"+bcckbm+"','','','0','0','1','"+f_zybm+"','"+f_zymc+"','"+brdwbm+"','2')";
            sqlList.add(sql);

            JSONArray jarr= new JSONArray(spxx);
            for(int i=0;i<jarr.length();i++){
                JSONObject jobj = jarr.getJSONObject(i);
                String f_sptm = jobj.getString("sptm");//商品条码

                sql = "select * from tb"+f_shbm+"_spda z\n" +
                        " where f_sptm='"+f_sptm+"' and f_f_colum1=1";
                String spda = sqlOperator.RunSQL_JSON(sql);
                JSONObject spobj = new JSONArray(spda).getJSONObject(0);
                double f_sl=Double.parseDouble(spobj.getString("F_SL"));
                String f_ypzjh=spobj.getString("F_YPZJH");
                double f_gjdj = Double.parseDouble(jobj.getString("gjdj"));//购进单价
                double f_gjsl = Double.parseDouble(jobj.getString("gjsl"));//购进数量
                double f_gjje = f_gjdj*f_gjsl;//购进金额
                double f_gjsj = SplitAndRound(f_gjje / (1 + f_sl / 100) * f_sl / 100, 2);//税金

                //判断库存是否充足
                sql = "select SUM(spkc.f_kcsl) from tb"+f_shbm+"_spkc spkc\n" +
                        "left join tb"+f_shbm+"_spgjcb cb on spkc.f_Bmbm=cb.f_Bmbm and cb.f_Sptm=spkc.f_Sptm and cb.f_Pch=spkc.f_pch and cb.f_Gjlx='"+f_gjlx+"' \n" +
                        "where spkc.f_Bmbm='"+bcckbm+"' and spkc.f_Sptm='"+f_sptm+"' and cb.f_Gjlx='"+f_gjlx+"' and spkc.f_kcsl>0";
                String f_zkcsl = sqlOperator.queryOneRecorderData(sql);
                if (f_zkcsl == null){
                    //没有库存记录
                    result = "410";
                    return result;
                }else {
                    double zkcsl = Double.parseDouble(f_zkcsl);
                    if (zkcsl < f_gjsl){
                        //库存数量小于购进数量
                        result = "410";
                        return result;
                    }else {
                        //从表插入拨入单位数据
                        sql = "insert into tb"+f_shbm+"_Spgjcb(f_Bmbm,f_Gjlx,f_Djh,f_Dnxh,f_Ckbm,f_Sptm,f_ypzjh,f_Gjsl,f_Gjdj,f_Gjje,f_Gjsj,f_Sl,f_Lsdj,f_Lsje,f_Pch,f_c_col1,f_bzwjcklx)\n" +
                                "values('"+brdwbm+"','"+f_gjlx+"','"+f_djh+"','"+dnxh+++"','','"+f_sptm+"','"+f_ypzjh+"',"+f_gjsl+","+f_gjdj+","+f_gjje+","+f_gjsj+","+f_sl+","+f_gjdj+","+f_gjje+",'"+pch+"','"+bcckbm+"','1')";
                        sqlList.add(sql);

                        //从表插入拨出网点负的数据
                        double gjsl = -1 * f_gjsl;
                        double gjdj = -1 * f_gjdj;
                        double gjje = -1 * f_gjje;
                        double gjsj = -1 * f_gjsj;
                        sql = "insert into tb"+f_shbm+"_Spgjcb(f_Bmbm,f_Gjlx,f_Djh,f_Dnxh,f_Ckbm,f_Sptm,f_ypzjh,f_Gjsl,f_Gjdj,f_Gjje,f_Gjsj,f_Sl,f_Lsdj,f_Lsje,f_Pch,f_c_col1,f_bzwjcklx)\n" +
                                "values('"+bcckbm+"','"+f_gjlx+"','"+f_djh+"','"+dnxh+++"','','"+f_sptm+"','"+f_ypzjh+"',"+gjsl+","+gjdj+","+gjje+","+gjsj+","+-1*f_sl+","+gjdj+","+gjje+",'"+pch+"','"+brdwbm+"','2')";
                        sqlList.add(sql);

                        //拨入单位
                        sql = "insert into tb"+f_shbm+"_spkc(f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj) \n" +
                                "\tselect "+f_Rzrq+" f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj \n" +
                                "\tfrom tb"+f_shbm+"_spkc z  \n" +
                                "\twhere z.f_rq!="+f_Rzrq+" \n" +
                                "\tand z.f_rq=(select max(f_rq) from tb"+f_shbm+"_spkc  where f_bmbm=z.f_bmbm and f_sptm=z.f_sptm and f_pch=z.f_pch)  \n" +
                                "\tand f_bmbm='"+brdwbm+"' \n" +
                                "\tand cast(f_kcsl as decimal(26,"+this.sljd+"))>0 \n" +
                                "\tand exists(select * from tb"+f_shbm+"_spgjcb  where f_gjlx='"+f_gjlx+"' and f_djh='"+f_djh+"' and f_bmbm='"+brdwbm+"' and f_sptm=z.f_sptm and f_bmbm=z.f_bmbm)";
                        sqlList.add(sql);
                        //拨出仓库
                        sql = "insert into tb"+f_shbm+"_spkc(f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj) \n" +
                                "\tselect "+f_Rzrq+" f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj \n" +
                                "\tfrom tb"+f_shbm+"_spkc z  \n" +
                                "\twhere z.f_rq!="+f_Rzrq+" \n" +
                                "\tand z.f_rq=(select max(f_rq) from tb"+f_shbm+"_spkc  where f_bmbm=z.f_bmbm and f_sptm=z.f_sptm and f_pch=z.f_pch)  \n" +
                                "\tand f_bmbm='"+bcckbm+"' \n" +
                                "\tand cast(f_kcsl as decimal(26,"+this.sljd+"))>0 \n" +
                                "\tand exists(select * from tb"+f_shbm+"_spgjcb  where f_gjlx='"+f_gjlx+"' and f_djh='"+f_djh+"' and f_bmbm='"+bcckbm+"' and f_sptm=z.f_sptm and f_bmbm=z.f_bmbm)";
                        sqlList.add(sql);

                        //拨入仓库操作
                        sql = "insert into tb"+f_shbm+"_spkc(f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj)\n" +
                                "values('"+f_Rzrq+"','"+brdwbm+"','"+f_sptm+"','"+pch+"','','"+f_gjsl+"','"+f_gjje+"','"+f_gjsj+"');";
                        sqlList.add(sql);

                        //拨出网点操作
                        sql = "select spkc.* from tb"+f_shbm+"_spkc spkc\n" +
                                "left join tb"+f_shbm+"_spgjcb cb on spkc.f_Bmbm=cb.f_Bmbm and cb.f_Sptm=spkc.f_Sptm and cb.f_Pch=spkc.f_pch and cb.f_Gjlx='"+f_gjlx+"' \n" +
                                "where spkc.f_Bmbm='"+bcckbm+"' and spkc.f_Sptm='"+f_sptm+"' and cb.f_Gjlx='"+f_gjlx+"' and spkc.f_kcsl>0 \n" +
                                "order by spkc.f_pch";
                        String spkcResult = sqlOperator.RunSQL_JSON(sql);
                        JSONArray spkcJarr = new JSONArray(spkcResult);
                        double tempGjsl = f_gjsl;
                        double tempGjje = f_gjje;
                        double tempGjsj = f_gjsj;
                        for (int h = 0; h < spkcJarr.length(); h++){
                            double spkcsl = Double.parseDouble(spkcJarr.getJSONObject(h).getString("F_KCSL"));
                            double spkcje = Double.parseDouble(spkcJarr.getJSONObject(h).getString("F_KCJE"));
                            double spkcsj = Double.parseDouble(spkcJarr.getJSONObject(h).getString("F_KCSJ"));
                            String spPch = spkcJarr.getJSONObject(h).getString("F_PCH");
                            if (spkcsl > tempGjsl){
                                double sysl = spkcsl-tempGjsl;
                                double syje = spkcje-tempGjje;
                                double sysj = spkcsj-tempGjsj;
                                //单批次扣除，该批次库存数量大于购进数量，直接当批次扣除
                                sql = "update tb"+f_shbm+"_spkc set f_kcsl="+sysl+",f_kcje="+syje+",f_kcsj="+sysj+" \n" +
                                        "where f_rq='"+f_Rzrq+"' and f_bmbm='"+bcckbm+"' and f_Sptm='"+f_sptm+"' and f_pch="+spPch+"";
                                sqlList.add(sql);
                                break;
                            }else {
                                //多批次扣除，只清零当批次
                                sql = "update tb"+f_shbm+"_spkc set f_kcsl="+0+",f_kcje="+0+",f_kcsj="+0+"\n" +
                                        "where f_rq='"+f_Rzrq+"' and f_bmbm='"+bcckbm+"' and f_Sptm='"+f_sptm+"' and f_pch="+spPch+"";
                                sqlList.add(sql);
                                tempGjsl -= spkcsl;
                                tempGjje -= spkcje;
                                tempGjsj -= spkcsj;
                            }
                        }
                    }
                }
            }
            sqlOperator.ExecSql(sqlList);
            result="ok";
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String hzcx(String cxtj, String f_ksrq, String f_jsrq, String f_shbm, String f_zybm) {
        this.openConnection(f_shbm);//创建连接池
        String sql = "";
        String result = null;
        try {
            sql = "select zb.f_Zdrq,zb.f_Bmbm,bm.f_Bmmc,zb.f_Zdrbm,zb.f_Zdrmc,zb.f_Djbz,zb.f_State,zb.f_Djh\n" +
                    "from tb"+f_shbm+"_Spgjzb zb\n" +
                    "left join tb"+f_shbm+"_bmda bm on bm.f_bmbm=zb.f_Bmbm\n" +
                    "where zb.f_Gjlx=2 and zb.F_bzwczlx=1\n"+
                    "and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'";
            if (cxtj != null && !cxtj.equals("")){
                sql += "and bm.f_Bmmc like '%"+cxtj+"%'";
            }
            result = sqlOperator.RunSQL_JSON(sql);
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String mxcx(String cxtj, String f_ksrq, String f_jsrq, String f_shbm, String f_zybm) {
        this.openConnection(f_shbm);//创建连接池
        String sql = "";
        String result = null;
        try {
            sql = "select cb.f_Djh,zb.f_Rzrq,cb.f_Sptm,sp.f_Spmc,sp.f_Ggxh,sp.f_Jldw,\n" +
                    "Convert(decimal(18,2),cb.f_Gjdj) f_Gjdj,\n" +
                    "Convert(decimal(18,2),cb.f_Gjsl) f_Gjsl,\n" +
                    "Convert(decimal(18,2),cb.f_Gjje) f_Gjje\n" +
                    "from tb"+f_shbm+"_Spgjcb cb \n" +
                    "left join tb"+f_shbm+"_Spgjzb zb on zb.f_Djh=cb.f_Djh \n" +
                    "left join tb"+f_shbm+"_Spda sp on sp.f_Sptm=cb.f_Sptm\n" +
                    "where cb.f_Gjlx=2 and zb.f_bzwczlx=1 and cb.f_bzwjcklx=2\n" +
                    "and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'";
            if (cxtj != null && !cxtj.equals("")){
                sql += "and sp.f_Spmc like '%"+cxtj+"%'";
            }
            result = sqlOperator.RunSQL_JSON(sql);
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String queryDjxq(String f_djh,String f_bmbm, String f_shbm) {
        this.openConnection(f_shbm);//创建连接池
        String result = null;
        String sql = "";
        try {
            sql = "select cb.f_Sptm,spda.f_Spmc,spda.f_jldw,spda.f_Ggxh,cb.f_Pch,\n" +
                    "Convert(decimal(18,2),cb.f_Gjdj) f_Gjdj,\n" +
                    "Convert(decimal(18,2),cb.f_Gjsl) f_Gjsl,\n" +
                    "Convert(decimal(18,2),cb.f_Gjje) f_Gjje\n" +
                    "from tb"+f_shbm+"_spgjcb cb\n" +
                    "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm\n" +
                    "where cb.f_Gjlx=2  and cb.f_Djh='"+f_djh+"' and cb.f_Bmbm='"+f_bmbm+"'";
            result = sqlOperator.RunSQL_JSON(sql);
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String bcdhzcx(String cxtj, String f_ksrq, String f_jsrq, String f_shbm, String f_zybm) {
        this.openConnection(f_shbm);//创建连接池
        String sql = "";
        String result = null;
        try {
            sql = "select zb.f_Zdrq,zb.f_Bmbm,bm.f_Bmmc,zb.f_Zdrbm,zb.f_Zdrmc,zb.f_Djbz,zb.f_State,zb.f_Djh\n" +
                    "from tb"+f_shbm+"_Spgjzb zb\n" +
                    "left join tb"+f_shbm+"_bmda bm on bm.f_bmbm=zb.f_Bmbm\n" +
                    "where zb.f_Gjlx=2 and zb.F_bzwczlx=2\n"+
                    "and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'";
            if (cxtj != null && !cxtj.equals("")){
                sql += "and bm.f_Bmmc like '%"+cxtj+"%'";
            }
            result = sqlOperator.RunSQL_JSON(sql);
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String bcdmxcx(String cxtj, String f_ksrq, String f_jsrq, String f_shbm, String f_zybm) {
        this.openConnection(f_shbm);//创建连接池
        String sql = "";
        String result = null;
        try {
            sql = "select cb.f_Djh,zb.f_Rzrq,cb.f_Sptm,sp.f_Spmc,sp.f_Ggxh,sp.f_Jldw,\n" +
                    "Convert(decimal(18,2),cb.f_Gjdj) f_Gjdj,\n" +
                    "Convert(decimal(18,2),cb.f_Gjsl) f_Gjsl,\n" +
                    "Convert(decimal(18,2),cb.f_Gjje) f_Gjje\n" +
                    "from tb"+f_shbm+"_Spgjcb cb \n" +
                    "left join tb"+f_shbm+"_Spgjzb zb on zb.f_Djh=cb.f_Djh \n" +
                    "left join tb"+f_shbm+"_Spda sp on sp.f_Sptm=cb.f_Sptm\n" +
                    "where cb.f_Gjlx=2 and zb.f_bzwczlx=2 and cb.f_bzwjcklx=1\n" +
                    "and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'";
            if (cxtj != null && !cxtj.equals("")){
                sql += "and sp.f_Spmc like '%"+cxtj+"%'";
            }
            result = sqlOperator.RunSQL_JSON(sql);
        } catch (Exception e) {
            result=e.getMessage();
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    //double 四舍五入;
    public double SplitAndRound(double a, int n) {
        a = a * Math.pow(10, n);
        return (Math.round(a)) / (Math.pow(10, n));
    }
    /**
     * @deprecated 获取最大单据号+1
     * @param f_shbm
     * @param
     * @return
     */
    public String newBillNo(String f_shbm,SqlServerOperator sqlser) {
        boolean free = sqlser==null;
        String bm = null;
        try {
            StringBuilder sql = new StringBuilder();
            String rq = this.retime().substring(0,6);
            sql.append("select max(f_djh) f_djh ");
            sql.append(" from tb").append(f_shbm).append("_spgjzb ");
            sql.append(" where f_djh like '").append(rq).append("%'");
            sql.append(" and f_gjlx=").append(f_gjlx);
            if(free)sqlser = new SqlServerOperator(f_shbm);
            String f_djh = sqlser.queryOneRecorderData(sql.toString());
            if (f_djh == null || "".equals(f_djh)) return rq + "0001";
            bm =  new UtilTools().bmAddOne(f_djh);
        } catch(Exception e){
        } finally {
            if(free)sqlser.closeConnection();
        }
        return bm;
    }
    private static String retime() {
        Calendar date = new GregorianCalendar();
        return String.valueOf(date.get(Calendar.YEAR)*10000+(date.get(Calendar.MONTH)+1)*100+date.get(Calendar.DATE));

    }

    /**
     * @deprecated 查询分管门店
     * @param f_shbm
     * @param f_zybm
     * @param f_bmbm
     * @return
     * @throws Exception
     */
    public String depts(String f_shbm,String f_zybm,String f_bmbm ){
        StringBuilder sql = new StringBuilder();
        this.openConnection(f_shbm);
        sql.append("select top 1 * from tb").append(f_shbm).append("_zysxbm z ");
        sql.append(" where f_zybm=?");
        String fg = sqlOperator.queryOneRecorderData(sql.toString(),new String[]{f_zybm});
        sql.setLength(0);

        sql.append("select f_bmbm+','+f_bmmc from tb").append(f_shbm).append("_bmda z ");
        sql.append(" where z.f_bmbm=z.f_bmbm");
        if(f_bmbm!=null) {
            if("".equalsIgnoreCase(f_bmbm)) {
                //sql.append(" and z.f_jb=1");
            } else {
                /*sql.append(" and exists(select * from tb").append(f_shbm).append("_bmda ");
                sql.append(" where f_bmbm='").append(f_bmbm).append("'");
                sql.append(" and f_bmbm=left(z.f_bmbm,len(f_bmbm))");
                sql.append(" and f_jb=z.f_jb-1)");*/
                sql.append(" and (z.f_bmbm like '%").append(f_bmbm).append("%'");
                sql.append(" or z.f_bmmc like '%").append(f_bmbm).append("%'");
            }
        } //else sql.append(" and z.f_mj=1 ");
        if(fg!=null&&fg.length()>0){
            sql.append(" and exists(select * from tb").append(f_shbm).append("_zysxbm ");
            sql.append(" where f_zybm='").append(f_zybm).append("'");
            sql.append(" and (f_bmbm=left(z.f_bmbm,len(f_bmbm))");
            sql.append(" or z.f_bmbm=left(f_bmbm,len(z.f_bmbm))))");
        }
        List lst = null;
        try {
            lst = sqlOperator.queryOneColumnData(sql.toString());
        } catch(Exception e){

        }
        //System.out.println(sql.toString());
        int s = lst.size();
        sql.setLength(0);
        //System.out.println("s===="+s);
        for(int i=0; i<s; i++) {
            if(i>0)sql.append(";");
            sql.append((String)lst.get(i));

        }
        sqlOperator.closeConnection();
        return sql.toString();
    }
    public static void main(String[] args) throws Exception {
        PackingServiceImpl dao = new PackingServiceImpl();

        //System.out.println(new java.util.Calendar().toString());
        String f_shbm = "10";
        String cxms = "0";
        String f_ksrq = "20180801";
        String f_jsrq = "20180810";
        String f_zybm = "1001";
        String cxtj="";
        String result = dao.queryDetail(f_shbm,cxms,f_ksrq,f_jsrq,f_zybm,cxtj);
        System.out.println(result);
    }

}
