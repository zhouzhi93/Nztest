package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import util.Parameter;
import util.UtilTools;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.*;

@Transactional
@Service
public class GainsLossesServiceImpl implements com.infol.nztest.service.GainsLossesService {
    private SqlServerOperator sqlOperator = null;
    private UtilTools ut = new UtilTools();
    private String sljd = null;
    private String jejd = null;
    private String djjd = null;
    private boolean fkc = false;
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

    /**
     * @deprecated 删除指定单据的SQL
     * @param f_djlx
     * @param f_djh
     * @return
     */
    private List delete(String f_djlx,String f_djh,String dwid) {
        StringBuilder sql = new StringBuilder();
        List sqls = new ArrayList();
        //商品损益从表
        sql.append("delete from tb").append(dwid).append("_spsycb ");
        sql.append(" where f_djlx='").append(f_djlx).append("'");
        sql.append(" and f_djh='").append(f_djh).append("'");
        sqls.add(sql.toString());
        sql.setLength(0);
        //商品损益主表
        sql.append("delete from tb").append(dwid).append("_spsyzb ");
        sql.append(" where f_djlx='").append(f_djlx).append("'");
        sql.append(" and f_djh='").append(f_djh).append("'");
        sqls.add(sql.toString());
        sql.setLength(0);
        return sqls;
    }

    /**
     * @deprecated 判断是否已审核
     * @param f_djlx
     * @param f_djh
     * @param dwid
     * @return
     */
    private boolean isPass(String f_djlx,String f_djh,String dwid) throws Exception {
        StringBuilder sql = new StringBuilder();
        sql.append("select isnull(f_state,'0') f_state ");
        sql.append(" from tb").append(dwid).append("_spsyzb ");
        sql.append(" where f_djlx=?");
        sql.append(" and f_djh=?");
        String zt = sqlOperator.queryOneRecorderData(sql.toString(),new String[]{f_djlx,f_djh});
        return zt!=null&&"1".equals(zt);
    }
    private static String retime() {
        Calendar date = new GregorianCalendar();
        return String.valueOf(date.get(Calendar.YEAR)*10000+(date.get(Calendar.MONTH)+1)*100+date.get(Calendar.DATE));

    }

    /**
     * @deprecated 获取最大单据号+1
     * @param f_dwid
     * @param f_djlx
     * @return
     */
    @Override
    public String newBillNo(String f_dwid, String f_djlx) {
        this.openConnection(f_dwid);
        String bm = null;
        try {
            StringBuilder sql = new StringBuilder();
            String rq = this.retime().substring(0,6);
            sql.append("select max(f_djh) f_djh ");
            sql.append(" from tb").append(f_dwid).append("_spsyzb ");
            sql.append(" where f_djh like '").append(rq).append("%'");
            String f_djh = sqlOperator.queryOneRecorderData(sql.toString());
            if (f_djh == null || "".equals(f_djh)) return rq + "0001";
            bm =  ut.bmAddOne(f_djh);
        } catch(Exception e){
        } finally {
            this.sqlOperator.closeConnection();
        }
        return bm;
    }

    /**
     * @deprecated 代入SQL时如果是数值字段必须调这个
     * @param value
     * @return
     */
    private String getNumber(String value) {
        return value==null||"".equals(value.trim())?"0":value;
    }

    /**
     * @deprecated 查询库存
     * @param f_bmbm  部门编码
     * @param f_spbm  商品编码
     * @param f_dwid  单位号
     * @return
     */
    private List findKc(String f_bmbm,String f_spbm,String f_dwid) throws Exception {
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
     * @param f_dwid 单位ID
     * @return
     */
    private List apportionCost(List kcs,String f_sl,String f_dj,String f_je,String f_sj,String pch,String f_dwid) {
        List  lst = new ArrayList();
        String[] arr =  null;//pch,sgpch,kcsl,kcje,kcsj,kcdj
        //String pch = null;

        if(!f_sl.startsWith("-")) {//正数作为升溢
            //pch = f_shrq+"_"+f_djh+"_g";//损溢单G销售单S
            arr = new String[]{pch,"",f_sl,f_je,f_sj,f_dj};
            lst.add(arr);
        } else {//负数值为损耗
            double num = UtilTools.parseStringToDouble(f_sl.substring(1));
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
                //if(this.fkc)
                    return null;
            }
        }
        return lst;
    }
    /*     select f_bmbm,f_ckbm,f_djh,f_djlx,f_dnxh,f_sptm,f_ypzjh,f_jldwlx,f_sysl,f_sydj,f_syje,f_sysj,f_sl,f_lsdj,f_lsje,f_syyybm,f_js,f_sgpch,f_pch,f_splx,f_zhjj from tb10_Spsycb
     select f_djh,f_zdrq,f_rzrq,f_zdrbm,f_zdrmc,f_fhrbm,f_fhrmc,f_bmbm,f_ckbm,f_djlx,f_state,f_zzzt from tb10_Spsyzb
*/
    @Override
    public synchronized String savebill(HashMap datas) {
        String f_dwid = (String)datas.get("f_dwid");
        String f_djlx = (String)datas.get("f_djlx");
        String f_djh = (String)datas.get("f_djh");
        String f_zdrq = (String)datas.get("f_zdrq");
        String f_bmbm = (String)datas.get("f_bmbm");
        String sub = (String)datas.get("sub");
        String spxx = (String)datas.get("spxx");
        String f_zdrbm = (String)datas.get("f_zdrbm");
        String f_zdrmc = (String)datas.get("f_zdrmc");
        String f_zybm = (String)datas.get("f_zybm");
        String f_fhrbm = null;
        String f_fhrmc = null;
        String f_ckbm = "";
        int f_sylx = 0;

        StringBuilder sql = new StringBuilder();
        List sqls = new ArrayList();
        String msg = null;
        boolean upd = false;
        boolean sh = false;
        try {
            //如果对保存单据进行审核
            if (f_djh == null || "".equals(f_djh)) {
                f_djh = this.newBillNo(f_dwid,f_djlx);
                f_zdrq = this.retime();
            } else {
                if(this.isPass(f_djlx,f_djh,f_dwid)) {
                    return "该单据已审核不能再操作了！";
                }
                upd = true;
                sqls.addAll(this.delete(f_djlx, f_djh, f_dwid));
            }
            sh = sub!=null&&"1".equals(sub);
            String f_rzrq = null;
            String f_state = null;
            this.openConnection(f_dwid);
            if(sh) {
                f_rzrq = this.retime();
                f_state = "1";
                f_fhrbm = f_zybm;
                f_fhrmc = sqlOperator.queryOneRecorderData("select f_zymc from tb"+f_dwid+"_zyda where f_zybm=?",new String[]{f_zybm});
            } else {
                f_rzrq = "";
                f_state = "0";
                f_fhrbm = "";
                f_fhrmc = "";
            }

            //从表保存SQL
            String[] arr = spxx.split(";");
            int s = arr.length;
            String str = null;
            //String spbm=null,ckbm=null,sptm=null,ypzjh=null,jldwlx=null,syyybm=null,sgpch=null,pch=null,splx=null;
            //String sysl=null,sydj=null,syje=null,sysj=null,sl=null,lsdj=null,lsje=null,js=null,zhjj=null;

            String[] info = null;
            int j = -1 , dnxh = 0;
            List kcs = null;
            List sls = null;
            String[] pcs = null;
            int k=0;
            List per = new ArrayList();
            String pch = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new Date()).toString();
            for(int i = 0; i < s; i++) {
                if(arr[i]==null||"".equals(arr[i].trim()))continue;
                str = arr[i];
                info = new String[30];
                k=0;
                while((j = str.indexOf(","))!=-1) {
                    info[k++] = str.substring(0,j);
                    str = str.substring(j+1);
                }
                info[k++] = str;
                if(k < 15) continue;

                f_ckbm=info[0];//仓库编码
                if (f_ckbm.equals("undefined")){
                    f_ckbm = "001";
                }
                //主表保存SQL
                sql.append("insert into tb").append(f_dwid).append("_spsyzb");
                sql.append("(f_djh,f_zdrq,f_rzrq,f_zdrbm,f_zdrmc,f_fhrbm,f_fhrmc,");
                sql.append("f_bmbm,f_ckbm,f_djlx,f_state,f_zzzt,f_c_col1)");
                sql.append(" values('").append(f_djh).append("','").append(f_zdrq);
                sql.append("','").append(f_rzrq).append("','").append(f_zdrbm);
                sql.append("','").append(f_zdrmc).append("','").append(f_fhrbm);
                sql.append("','").append(f_fhrmc).append("','").append(f_bmbm);
                sql.append("','").append(f_ckbm);
                sql.append("','").append(f_djlx).append("','").append(f_state);
                sql.append("','0',convert(varchar(19),getdate(),121))");
                sqls.add(sql.toString());
                sql.setLength(0);

                sls = new ArrayList();
                if(sh) {//如果是损并且是审核//&&info[4].startsWith("-")
                    //进行先进先出：批次组成 日期_单据号_类型
                    kcs = this.findKc(f_bmbm,info[1],f_dwid);//pch,sgpch,kcsl,kcje,kcsj
                    per = this.apportionCost(kcs,info[4],info[5],info[6],info[7],pch,f_dwid);

                    if(per==null)return "库存不够了!";
                    sls.addAll(per);
                } else {
                    //pch = f_shrq+"_"+f_djh+"_g";//损溢单G销售单S
                    pcs = new String[]{"","",info[4],info[6],info[7],info[5]};
                    sls.add(pcs);
                }
                j = sls.size();//0f_ckbm,1f_sptm,2f_ypzjh,3f_jldwlx,4f_sysl,5f_sydj,6f_syje,7f_sysj,8f_sl,9f_lsdj,10f_lsje,11f_syyybm,12f_js,13f_splx,14f_zhjj,15f_sgpch
                for(k=0; k<j; k++) {
                    pcs = (String[])sls.get(k);
                    Float sysl = Float.valueOf(this.getNumber(pcs[2]));
                    if (sysl > 0){
                        f_sylx = 1;
                    } else if (sysl < 0) {
                        f_sylx = 2;
                    }
                    sql.append("insert into tb").append(f_dwid).append("_spsycb");
                    sql.append("(f_djlx,f_djh,f_bmbm,f_dnxh,f_ckbm,f_sptm,f_ypzjh,f_jldwlx,");
                    sql.append("f_sysl,f_sydj,f_syje,f_sysj,f_sl,f_lsdj,f_lsje,f_syyybm,");
                    sql.append("f_js,f_splx,f_zhjj,f_sgpch,f_pch,f_sylx)");
                    sql.append(" values('").append(f_djlx).append("','").append(f_djh);
                    sql.append("','").append(f_bmbm).append("','").append(dnxh++);
                    sql.append("','").append(f_ckbm).append("','").append(info[1]);//0f_ckbm,1f_sptm
                    sql.append("','").append(info[2]).append("','").append(info[3]);//2f_ypzjh,3f_jldwlx
                    sql.append("',").append(this.getNumber(pcs[2])).append(",").append(this.getNumber(pcs[5]));//4f_sysl,5f_sydj,
                    sql.append(",").append(this.getNumber(pcs[3])).append(",").append(this.getNumber(pcs[4]));//6f_syje,7f_sysj
                    sql.append(",").append(this.getNumber(info[8])).append(",").append(this.getNumber(pcs[5]));//8f_sl,9f_lsdj
                    sql.append(",").append(this.getNumber(pcs[3])).append(",'").append(info[11]);//10f_lsje,11f_syyybm
                    sql.append("',").append(info[12]).append(",'").append(info[13]);//12f_js,13f_splx
                    sql.append("',").append(info[14]).append(",'").append(pcs[1]);//14f_zhjj,15f_sgpch
                    sql.append("','").append(pcs[0]).append("','").append(f_sylx).append("')");//16f_pch
                    sqls.add(sql.toString());
                    sql.setLength(0);
                }
            }
            if(sh) {
                //商品库存表
                //先全部涉及商品库存大于零的都拉到当前日期（当前日期已存在不拉）
                sql.append("insert into tb").append(f_dwid).append("_spkc");
                sql.append("(f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj)");
                sql.append(" select ").append(f_rzrq).append(" f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj");
                sql.append(" from tb").append(f_dwid).append("_spkc z ");
                sql.append(" where z.f_rq!=").append(f_rzrq);
                sql.append(" and z.f_rq=(select max(f_rq) from tb").append(f_dwid).append("_spkc ");
                sql.append(" where f_bmbm=z.f_bmbm and f_sptm=z.f_sptm and f_pch=z.f_pch) ");
                sql.append(" and f_bmbm='").append(f_bmbm).append("'");
                sql.append(" and cast(f_kcsl as decimal(26,").append(this.sljd).append("))>0");
                sql.append(" and exists(select * from tb").append(f_dwid).append("_spsycb ");
                sql.append(" where f_djlx='").append(f_djlx).append("'");
                sql.append(" and f_djh='").append(f_djh).append("'");
                sql.append(" and f_bmbm='").append(f_bmbm).append("'");
                sql.append(" and f_sptm=z.f_sptm and f_bmbm=z.f_bmbm)");
                sqls.add(sql.toString());
                sql.setLength(0);
                //更新库存
                sql.append("update tb").append(f_dwid).append("_spkc");
                sql.append(" set f_kcsl=c.f_kcsl+z.f_sysl,");
                sql.append("f_kcje=c.f_kcje+z.f_syje,");
                sql.append("f_kcsj=c.f_kcsj+z.f_sysj ");
                sql.append(" from tb").append(f_dwid).append("_spkc c ");
                sql.append(" inner join tb").append(f_dwid).append("_spsycb z ");
                sql.append(" on z.f_djlx='").append(f_djlx).append("'");
                sql.append(" and z.f_bmbm='").append(f_bmbm).append("'");
                sql.append(" and z.f_djh='").append(f_djh).append("'");
                sql.append(" and c.f_sptm=z.f_sptm and c.f_pch=z.f_pch");
                sql.append(" and cast(z.f_sysl as decimal(26,").append(this.sljd).append("))<0");
                sql.append(" where c.f_rq='").append(f_rzrq).append("'");
                sql.append(" and c.f_bmbm='").append(f_bmbm).append("'");
                sqls.add(sql.toString());
                sql.setLength(0);

                //插入新增批次
                sql.append("insert into tb").append(f_dwid).append("_spkc");
                sql.append("(f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj)");
                sql.append(" select ").append(f_rzrq).append(" f_rq,'").append(f_bmbm).append("' f_bmbm,");
                sql.append("c.f_sptm,c.f_pch,c.f_sgpch,c.f_sysl,f_syje,f_sysj");
                sql.append(" from tb").append(f_dwid).append("_spsycb c ");
                sql.append(" where c.f_djlx='").append(f_djlx).append("'");
                sql.append(" and c.f_djh='").append(f_djh).append("'");
                sql.append(" and cast(c.f_sysl as decimal(26,").append(this.sljd).append("))>0");
                /*sql.append(" and not exists(select * from tb").append(f_dwid).append("_spkc ");
                sql.append(" where f_rq=").append(f_rzrq);
                sql.append(" and f_bmbm='").append(f_bmbm).append(" and f_sptm=c.f_sptm and f_pch=c.f_pch) ");*/
                sqls.add(sql.toString());
                sql.setLength(0);


                //仓库数据表
                //先全部涉及商品库存大于零的都拉到当前日期（当前日期已存在不拉）
                sql.append("insert into tb").append(f_dwid).append("_cksjb");
                sql.append("(f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj,f_ckbm)");
                sql.append(" select ").append(f_rzrq).append(" f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj,f_ckbm");
                sql.append(" from tb").append(f_dwid).append("_cksjb z ");
                sql.append(" where z.f_rq!=").append(f_rzrq);
                sql.append(" and z.f_rq=(select max(f_rq) from tb").append(f_dwid).append("_cksjb ");
                sql.append(" where f_bmbm=z.f_bmbm and f_sptm=z.f_sptm and f_pch=z.f_pch and f_ckbm=z.f_ckbm) ");
                sql.append(" and f_bmbm='").append(f_bmbm).append("'");
                sql.append(" and f_ckbm='").append(f_ckbm).append("'");
                sql.append(" and cast(f_kcsl as decimal(26,").append(this.sljd).append("))>0");
                sql.append(" and exists(select * from tb").append(f_dwid).append("_spsycb ");
                sql.append(" where f_djlx='").append(f_djlx).append("'");
                sql.append(" and f_djh='").append(f_djh).append("'");
                sql.append(" and f_bmbm='").append(f_bmbm).append("'");
                sql.append(" and f_ckbm='").append(f_ckbm).append("'");
                sql.append(" and f_sptm=z.f_sptm and f_bmbm=z.f_bmbm)");
                sqls.add(sql.toString());
                sql.setLength(0);

                //更新库存
                sql.append("update tb").append(f_dwid).append("_cksjb");
                sql.append(" set f_kcsl=c.f_kcsl+z.f_sysl,");
                sql.append("f_kcje=c.f_kcje+z.f_syje,");
                sql.append("f_kcsj=c.f_kcsj+z.f_sysj ");
                sql.append(" from tb").append(f_dwid).append("_cksjb c ");
                sql.append(" inner join tb").append(f_dwid).append("_spsycb z ");
                sql.append(" on z.f_djlx='").append(f_djlx).append("'");
                sql.append(" and z.f_bmbm='").append(f_bmbm).append("'");
                sql.append(" and z.f_djh='").append(f_djh).append("'");
                sql.append(" and c.f_sptm=z.f_sptm and c.f_pch=z.f_pch and c.f_ckbm=z.f_Ckbm");
                sql.append(" and cast(z.f_sysl as decimal(26,").append(this.sljd).append("))<0");
                sql.append(" where c.f_rq='").append(f_rzrq).append("'");
                sql.append(" and c.f_bmbm='").append(f_bmbm).append("'");
                sqls.add(sql.toString());
                sql.setLength(0);

                //插入新增批次
                sql.append("insert into tb").append(f_dwid).append("_cksjb");
                sql.append("(f_rq,f_bmbm,f_sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj,f_ckbm)");
                sql.append(" select ").append(f_rzrq).append(" f_rq,'").append(f_bmbm).append("' f_bmbm,");
                sql.append("c.f_sptm,c.f_pch,c.f_sgpch,c.f_sysl,f_syje,f_sysj,f_Ckbm");
                sql.append(" from tb").append(f_dwid).append("_spsycb c ");
                sql.append(" where c.f_djlx='").append(f_djlx).append("'");
                sql.append(" and c.f_djh='").append(f_djh).append("'");
                sql.append(" and cast(c.f_sysl as decimal(26,").append(this.sljd).append("))>0");
                sqls.add(sql.toString());
                sql.setLength(0);
            }

            msg = sqlOperator.execSqls(sqls);
        } catch(Exception e){
            System.out.println(e.getMessage());
            msg = "程序异常出错";
        }
        this.sqlOperator.closeConnection();
        if(msg.indexOf("成功")!=-1){
            sql.append(upd?"修改":"保存");
            if(sh)sql.append("并审核");
            sql.append("成功!");
            if(!upd)sql.append("单据号:").append(f_djh);
            msg=sql.toString();
        }
        return msg;
    }

    /**
     * @deprecated  生成条件SQL
     * @param value
     * @param key
     * @return
     */
    private String condition(String value,String key) {
        if(value==null||"".equals(value))return "";
        String[] arr = value.split(",");
        int s = arr.length;
        StringBuilder sql = new StringBuilder();
        if(s>1)sql.append(" and (");
        else return sql.append(" and ").append(key).append(" like '").append(value).append("%'").toString();
        for(int i=0; i<s; i++) {
            if(arr[i]==null||"".equals(arr[i].trim()))continue;
            if(i>0)sql.append(" or ");
            sql.append(key).append(" like '").append(arr[i]).append("%'");
        }
        if(s>1)sql.append(") ");
        return sql.toString();
    }

    /**
     * @deprecated 判断是否存在分管
     * @param f_dwid
     * @param f_zybm
     * @return
     */
    private boolean hasDept(String f_dwid,String f_zybm) {
        StringBuilder sql = new StringBuilder();
        sql.append("select count(*) from tb").append(f_dwid).append("_zysxbm where f_zybm=?");
        boolean has = false;
        //this.openConnection(f_dwid);
        try {
            String sl = sqlOperator.queryOneRecorderData(sql.toString(), new String[]{f_zybm});
            has =  sl != null && !"".equals(sl) && !"0".equals(sl);
        } catch (Exception e){

        } finally {
            //sqlOperator.closeConnection();
        }
        return has;
    }

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
    @Override
    public List query(String f_cxms,String f_ksrq, String f_jsrq, String f_dwid, String f_zybm,
                      String f_bmbm, String f_spbm, String f_djlx, String f_djh){
        StringBuilder sql = new StringBuilder();
        this.openConnection(f_dwid);

        sql.append("select z.f_djlx,z.f_djh,z.f_bmbm,z.f_zdrq,z.f_rzrq,z.f_zdrmc,z.f_fhrmc,");
        sql.append("case when z.f_state='1' then '已审核' else '已保存' end f_state,");
        sql.append("isnull((select f_bmmc from tb").append(f_dwid).append("_bmda where f_bmbm=z.f_bmbm),'') f_bmmc,");
        sql.append("c.f_sptm,s.f_spmc,s.f_spcd,s.f_ggxh,");
        sql.append("cast(c.f_sysl as decimal(26,").append(this.sljd).append(")) f_sysl,");
        sql.append("cast(c.f_syje as decimal(26,").append(this.jejd).append(")) f_syje,");
        sql.append("cast(c.f_sysj as decimal(26,").append(this.jejd).append(")) f_sysj,");
        sql.append("cast(c.f_syje/case when c.f_sysl=0 then 1 else c.f_sysl end as decimal(26,").append(this.djjd).append(")) f_sydj,");
        sql.append("cast(c.f_lsje as decimal(26,").append(this.jejd).append(")) f_lsje,");
        sql.append("cast(c.f_lsje/case when c.f_sysl=0 then 1 else c.f_sysl end as decimal(26,").append(this.djjd).append(")) f_lsdj,");
        sql.append("cast(c.f_zhjj as decimal(26,").append(this.djjd).append(")) f_zhjj,");
        sql.append("c.f_pch,c.f_sgpch,c.f_splx ");
        sql.append(" from tb").append(f_dwid).append("_spsyzb z ");
        sql.append(" inner join tb").append(f_dwid).append("_spsycb c ");
        sql.append(" on z.f_djlx=c.f_djlx and z.f_bmbm=c.f_bmbm and z.f_djh=c.f_djh");
        sql.append(" inner join tb").append(f_dwid).append("_spda s on s.f_sptm=c.f_sptm ");
        sql.append(" where z.f_djlx=? and z.f_zdrq between ? and ? ");
        int s = 3;
        boolean dj = f_djh!=null&&!"".equals(f_djh);
        boolean bm = false;
        if(dj) {
            s++;
            sql.append(" and z.f_djh=?");
        }
        sql.append(this.condition(f_bmbm,"z.f_bmbm"));
        sql.append(this.condition(f_spbm,"c.f_spbm"));
        if(this.hasDept(f_dwid,f_zybm)){
            sql.append(" and exists(select * from tb").append(f_dwid).append("_zysxbm ");
            sql.append(" where f_zybm=? and z.f_bmbm like f_bmbm+'%')");
            bm=true;
            s++;
        }
        String[] args = new String[s];
        args[0] = f_djlx;
        args[1] = f_ksrq;
        args[2] = f_jsrq;
        if(dj)args[3] =  f_djh;
        if(bm)args[dj?4:3] = f_zybm;
        if("0".equals(f_cxms)) {//汇总查询
            String body = sql.toString();
            sql.setLength(0);
            sql.append("select f_djlx,f_djh,f_bmbm,f_zdrq,f_rzrq,f_zdrmc,f_fhrmc,f_state,");
            sql.append("cast(sum(f_sysl) as decimal(26,").append(this.sljd).append(")) f_sysl,");
            sql.append("cast(sum(f_syje) as decimal(26,").append(this.jejd).append(")) f_syje,");
            sql.append("cast(sum(f_sysj) as decimal(26,").append(this.jejd).append(")) f_sysj ");
            sql.append(" from ( ").append(body).append(") h ");
            sql.append(" group by f_djlx,f_bmbm,f_djh,f_zdrq,f_rzrq,f_zdrmc,f_fhrmc,f_state ");
            sql.append(" order by f_djlx,f_bmbm,f_djh");
        } else {//明细查询
            sql.append("  order by z.f_djlx,z.f_djh,z.f_bmbm,c.f_sptm");
        }

        List lst = this.sqlOperator.queryList(sql.toString(),args);
        this.sqlOperator.closeConnection();
        return lst;
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
        sql.append("cast(case when isnull(c.f_xsdj,z.f_xsdj)=0 then z.f_xsdj else isnull(c.f_xsdj,z.f_xsdj) end as decimal(26,").append(this.djjd).append(")) f_xsdj,f_sptp ");
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
        sql.append(" and z.f_f_colum1=0 and z.f_xjbz = '0' ");//正常商品
        if(sp){
            sql.append(" and (z.f_sptm like '%"+spxx+"%'");
            sql.append(" or z.f_spmc like '%"+spxx+"%' or z.f_c_colum3 like '%"+spxx+"%')");
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
     * @deprecated 获取可见门店
     * @param f_dwid
     * @param f_zybm
     * @return
     */
    @Override
    public String getDept(String f_dwid,String f_zybm){
        this.openConnection(f_dwid);
        StringBuilder sql = new StringBuilder();
        //select f_bmbm,f_bmmc,f_zjf from tb10_bmda z where z.f_bmbm=z.f_bmbm
        //select f_bmbm from tb10_zysxbm where f_zybm='' order by f_xh
        //判断是否分管
        sql.append("select count(*) sl from tb").append(f_dwid).append("_zysxbm z ");
        sql.append(" where z.f_zybm=?");
        String sl = sqlOperator.queryOneRecorderData(sql.toString(),new String[]{f_zybm});
        sql.setLength(0);

        sql.append("select z.f_bmbm,z.f_bmmc,z.f_zjf ");
        sql.append(" from tb").append(f_dwid).append("_bmda z ");
        sql.append(" where z.f_bmbm=z.f_bmbm ");
        if(sl!=null&&!"".equals(sl)&&!"0".equals(sl)) {
            sql.append(" and exists(select * from tb").append(f_dwid).append("_zysxbm");
            sql.append(" where f_zybm='").append(f_zybm).append("'");
            sql.append(" and f_bmbm=left(z.f_bmbm,len(f_bmbm)))");
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
        GainsLossesServiceImpl dao = new GainsLossesServiceImpl();

        //System.out.println(new java.util.Calendar().toString());

        System.out.println(dao.retime());
    }

}
