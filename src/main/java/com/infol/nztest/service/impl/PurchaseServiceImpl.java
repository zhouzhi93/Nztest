package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.PurchaseService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import util.UtilTools;

import javax.servlet.http.HttpServletRequest;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.*;

@Transactional
@Service
public class PurchaseServiceImpl implements PurchaseService{
    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    public String GetCsda(String Csbm,String f_shbm){
//创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select f_Csbm,f_Csmc,f_dh,f_jb from tb"+f_shbm+"_csda where f_cslx='0'";
            if(!Csbm.equals("")){
                sql+=" and f_csmc like '%"+Csbm+"%'";
            }
            result = sqlOperator.RunSQL_JSON(sql);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }
    @Override
    public String GetSpda(String spxx,String f_shbm) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select sp.f_sptm,f_spmc,f_ggxh,f_jldw,convert(decimal(18,2),f_xsdj)f_xsdj,convert(decimal(18,2),sp.f_zhjj)f_zhjj,case when f_sptp = '' then '/image/default.png' else f_sptp end as f_sptp,isnull(gysdz.f_Gysbm,'') f_Gysbm,cs.f_Csmc as f_Gysmc from tb"+f_shbm+"_spda sp " +
                    "left join tb"+f_shbm+"_Gysdz gysdz on gysdz.f_Sptm = sp.f_Sptm \n" +
                    "left join tb"+f_shbm+"_Csda cs on gysdz.f_Gysbm = cs.f_Csbm and cs.f_Cslx = '0' "+
                    " where f_f_colum1=0 and f_xjbz = '0' ";
            if(!spxx.equals("")){
                sql+=" and (sp.f_sptm like '%"+spxx+"%' or sp.f_spmc like '%"+spxx+"%' or sp.f_c_colum3 like '%"+spxx+"%') ";
            }
            sql += " order by f_sptm";
            result = sqlOperator.RunSQL_JSON(sql);
            JSONArray json = new JSONArray(result);
            for(int i = 0 ; i<json.length() ; i++){
                JSONObject json1 = json.getJSONObject(i);
                String sptm1 = json1.getString("F_SPTM");
                for(int j = i+1 ; j<json.length() ; j++){
                    JSONObject json2 = json.getJSONObject(j);
                    String sptm2 = json2.getString("F_SPTM");
                    if(sptm1.equals(sptm2)){
                        String f_gysbm = json2.getString("F_GYSBM");
                        String f_gysmc = json2.getString("F_GYSMC");
                        json1.put("F_GYSBM",f_gysbm);
                        json1.put("F_GYSMC",f_gysmc);
                        json.put(i,json1);
                        json.remove(j);
                        j--;
                    }
                }
            }
            result = json.toString();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }
    @Override
    public String AddCsda(String f_csmc,String f_sjhm,String f_xxdz,String f_shbm) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql=" select isnull(MAX(f_csbm),'000000') from tb"+f_shbm+"_Csda";
            String maxBm=sqlOperator.queryOneRecorderData(sql);
            int bmlen=maxBm.length();
            int bm=Integer.parseInt(maxBm)+1;
            String f_csbm=String.valueOf(bm);
            while(f_csbm.length()<bmlen){
                f_csbm = "0" + f_csbm;
            }
            sql = "insert into tb"+f_shbm+"_csda(f_cslx,f_Csbm,f_Csmc,f_dh,f_jb,f_dz)values('0','"+f_csbm+"','"+f_csmc+"','"+f_sjhm+"','1','"+f_xxdz+"')";
            sqlOperator.ExecSQL(sql);
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
    @Transactional
    public String SavaBill(String f_gysbm,String yhje,String jsje,String spxx,String f_zybm,String f_bmbm,String f_zymc,String f_shbm,String f_djbz)
    {
        //创建连接池
        openConnection();
        String result = null;
        try {
            String sql="";
            String f_djh=newBillNo(f_shbm,sqlOperator);
            Date day=new Date();
            SimpleDateFormat df = new SimpleDateFormat("HHmmss");
            String f_Xssj=df.format(day);
            SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMdd");
            String f_Rzrq=df1.format(day);
            String f_Zfbz="1";
            String f_djlx="0";
            //String f_ckbm="01";
            List<String> sqlList= new ArrayList<>();

            sql = "insert tb"+f_shbm+"_Spgjzb(f_Gjlx,f_Djh,f_Zdrq,f_Rzrq,f_Zdrbm,f_Zdrmc,f_Zrrbm,f_Bmbm,f_Ckbm,f_djbz,f_Gysbm,f_Jyfs,f_Djlx,f_State)\n" +
                    "values('0','"+f_djh+"','"+f_Rzrq+"','"+f_Rzrq+"','"+f_zybm+"','"+f_zymc+"',"+f_zybm+",'"+f_bmbm+"','','"+f_djbz+"','"+f_gysbm+"','0','0','1')";
            sqlList.add(sql);

            String f_pch=f_Rzrq+f_Xssj;
            JSONArray jarr= new JSONArray(spxx);
            for(int i=0;i<jarr.length();i++){
                JSONObject jobj=jarr.getJSONObject(i);
                String f_sptm=jobj.getString("sptm");
                String f_sgpch=jobj.getString("sgpch");//手工批次号
                String f_ckbm=jobj.getString("ckbm");//获取仓库编码

                if (f_ckbm.equals("undefined")){
                    f_ckbm = "001";
                }

                sql="select * from tb"+f_shbm+"_spda where f_sptm='"+f_sptm+"' and f_f_colum1=0";
                String spRes=sqlOperator.RunSQL_JSON(sql);
                JSONArray spjarr=new JSONArray(spRes);
                JSONObject spJson=spjarr.getJSONObject(0);
                double f_sl=Double.parseDouble(spJson.getString("F_SL"));
                String f_ypzjh=spJson.getString("F_YPZJH");
                double f_gjsl= Double.parseDouble(jobj.getString("gjsl"));
                double f_gjdj=Double.parseDouble(jobj.getString("gjdj"));
                double f_ssje=f_gjsl*f_gjdj;
                double f_sssj = SplitAndRound(f_ssje / (1 + f_sl / 100) * f_sl / 100, 2);//税金
                sql="select count(*) from tb"+f_shbm+"_spkc where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"'";
                int count=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                if(count<=0) {//当天没有库存数据,需要结算到当天
                    sql = "insert into tb"+f_shbm+"_spkc\n" +
                            "select '" + f_Rzrq + "',f_Bmbm,f_Sptm,f_pch,f_Sgpch,f_kcsl,f_kcje,f_kcsj from " +
                            "tb"+f_shbm+"_spkc where f_Sptm='" + f_sptm + "' and f_Rq=(select MAX(f_Rq) from tb"+f_shbm+"_spkc where f_Sptm='" + f_sptm + "') and f_kcsl>0";
                    sqlOperator.ExecSQL(sql);//结转库存到当天
                }

                sql="select count(*) from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"'and f_ckbm='"+f_ckbm+"'";
                int count1=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                if(count1<=0) {//当天没有库存数据,需要结算到当天
                    sql = "insert into tb"+f_shbm+"_cksjb\n" +
                            "select '" + f_Rzrq + "',f_Bmbm,f_Sptm,f_pch,f_Sgpch,f_kcsl,f_kcje,f_kcsj,f_ckbm from " +
                            "tb"+f_shbm+"_cksjb where f_Sptm='" + f_sptm + "' and f_ckbm='"+f_ckbm+"' and f_Rq=(select MAX(f_Rq) from tb"+f_shbm+"_cksjb where f_Sptm='" + f_sptm + "' and f_ckbm='"+f_ckbm+"') and f_kcsl>0";
                    sqlOperator.ExecSQL(sql);//结转库存到当天
                }

                sql="insert into tb"+f_shbm+"_Spgjcb(f_Bmbm,f_Gjlx,f_Djh,f_Dnxh,f_Ckbm,f_Sptm,f_ypzjh,f_Gjsl,f_Gjdj,f_Gjje,f_Gjsj,f_Sl,f_Lsdj,f_Lsje,f_Pch,f_sgpch)\n" +
                        "values('"+f_bmbm+"','0','"+f_djh+"','"+Integer.toString(i)+"','"+f_ckbm+"','"+f_sptm+"'," +
                        "'"+f_ypzjh+"','"+f_gjsl+"','"+f_gjdj+"',"+f_ssje+",'"+f_sssj+"','"+f_sl+"','"+f_gjdj+"','0','"+f_pch+"','"+f_sgpch+"')";
                sqlList.add(sql);
                sql="insert into tb"+f_shbm+"_spkc(f_Rq,f_Bmbm,f_Sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj)" +
                        "values('"+f_Rzrq+"','"+f_bmbm+"','"+f_sptm+"','"+f_pch+"','"+f_sgpch+"','"+f_gjsl+"','"+f_ssje+"','"+f_sssj+"')";
                sqlList.add(sql);
                sql="insert into tb"+f_shbm+"_cksjb(f_Rq,f_Bmbm,f_Sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj,f_ckbm)" +
                        "values('"+f_Rzrq+"','"+f_bmbm+"','"+f_sptm+"','"+f_pch+"','"+f_sgpch+"','"+f_gjsl+"','"+f_ssje+"','"+f_sssj+"','"+f_ckbm+"')";
                sqlList.add(sql);
            }
            sqlOperator.ExecSql(sqlList);
            result="ok|"+f_djh;
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
    @Transactional
    public String SavaBill_refund(String f_ydjh,String f_gysbm,String yhje,String jsje,String spxx,String f_zybm,String f_bmbm,String f_zymc,String f_shbm)
    {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql="";
            String f_djh=newBillNo(f_shbm,sqlOperator);
            Date day=new Date();
            SimpleDateFormat df = new SimpleDateFormat("HHmmss");
            String f_Xssj=df.format(day);
            SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMdd");
            String f_Rzrq=df1.format(day);
            String f_Zfbz="1";
            String f_djlx="0";
            //String f_ckbm="01";

            List<String> sqlList= new ArrayList<>();

            sql = "insert tb"+f_shbm+"_Spgjzb(f_Gjlx,f_Djh,f_Ydjh,f_Zdrq,f_Rzrq,f_Zdrbm,f_Zdrmc,f_Zrrbm,f_Bmbm,f_Ckbm,f_Gysbm,f_Jyfs,f_Djlx,f_State)\n" +
                    "values('0','"+f_djh+"','"+f_ydjh+"','"+f_Rzrq+"','"+f_Rzrq+"','"+f_zybm+"','"+f_zymc+"','"+f_zybm+"','"+f_bmbm+"','','"+f_gysbm+"','0','0','1')";
            sqlList.add(sql);

            JSONArray jarr= new JSONArray(spxx);
            for(int i=0;i<jarr.length();i++){
                JSONObject jobj=jarr.getJSONObject(i);
                String f_sptm=jobj.getString("sptm");
                String f_ckbm=jobj.getString("ckbm");
                if (f_ckbm == null || f_ckbm.equals("")){
                    f_ckbm = "001";
                }
                sql="select * from tb"+f_shbm+"_spda where f_sptm='"+f_sptm+"' and f_f_colum1=0";
                String spRes=sqlOperator.RunSQL_JSON(sql);
                JSONArray spjarr=new JSONArray(spRes);
                JSONObject spJson=spjarr.getJSONObject(0);
                double f_sl=Double.parseDouble(spJson.getString("F_SL"));
                String f_ypzjh=spJson.getString("F_YPZJH");

                sql="select count(*) from tb"+f_shbm+"_spkc where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"'";
                int count=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                if(count<=0) {//当天没有库存数据,需要结算到当天
                    sql = "insert into tb"+f_shbm+"_spkc\n" +
                            "select '" + f_Rzrq + "',f_Bmbm,f_Sptm,f_pch,f_Sgpch,f_kcsl,f_kcje,f_kcsj from " +
                            "tb"+f_shbm+"_spkc where f_Sptm='" + f_sptm + "' and f_Rq=(select MAX(f_Rq) from tb"+f_shbm+"_spkc where f_Sptm='" + f_sptm + "') and f_kcsl>0";
                    sqlOperator.ExecSQL(sql);//结转库存到当天spkc
                }

                sql="select count(*) from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"'and f_ckbm='"+f_ckbm+"'";
                int count1=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                if(count1<=0) {//当天没有库存数据,需要结算到当天
                    sql = "insert into tb"+f_shbm+"_cksjb\n" +
                            "select '" + f_Rzrq + "',f_Bmbm,f_Sptm,f_pch,f_Sgpch,f_kcsl,f_kcje,f_kcsj,f_ckbm from " +
                            "tb"+f_shbm+"_cksjb where f_Sptm='" + f_sptm + "' and f_ckbm='"+f_ckbm+"' and f_Rq=(select MAX(f_Rq) from tb"+f_shbm+"_cksjb where f_Sptm='" + f_sptm + "') and f_kcsl>0";
                    sqlOperator.ExecSQL(sql);//结转库存到当天
                }


                String f_pch=jobj.getString("pch");
                String f_sgpch=jobj.getString("sgpch");
                double f_gjsl= Double.parseDouble(jobj.getString("gjsl"));
                double f_gjdj=Double.parseDouble(jobj.getString("gjdj"));
                double f_ssje=f_gjsl*f_gjdj;
                double f_sssj = SplitAndRound(f_ssje / (1 + f_sl / 100) * f_sl / 100, 2);//税金

                sql = "select isnull(SUM(f_kcsl),0) from tb"+f_shbm+"_spkc kc where f_Sptm='" + f_sptm + "' and f_pch='" + f_pch + "' and f_rq='"+f_Rzrq+"'";
                double f_kcsl = Double.parseDouble(sqlOperator.queryOneRecorderData(sql));//实时库存
                if (f_kcsl < f_gjsl) {
                    throw new Exception("退货失败，退货数量大于该批次库存数量");
                }
                sql="select * from tb"+f_shbm+"_spkc kc where f_Sptm='" + f_sptm + "' and f_pch='"+f_pch+"' and f_rq='"+f_Rzrq+"'";
                double f_kcdj=0;
                ResultSet rsKc=sqlOperator.RunSQLToResSet(sql);
                if (rsKc.next()) {
                    double pckc = Double.parseDouble(rsKc.getString("f_kcsl"));//批次库存
                    double f_kcje = Double.parseDouble(rsKc.getString("f_kcje"));//库存金额
                    f_kcdj= f_kcje / pckc;
                }


                sql="insert into tb"+f_shbm+"_Spgjcb(f_Bmbm,f_Gjlx,f_Djh,f_Dnxh,f_Ckbm,f_Sptm,f_ypzjh,f_Gjsl,f_Gjdj,f_Gjje,f_Gjsj,f_Sl,f_Lsdj,f_Lsje,f_Pch,f_Sgpch)\n" +
                        "values('"+f_bmbm+"','0','"+f_djh+"','"+Integer.toString(i)+"','"+f_ckbm+"','"+f_sptm+"'," +
                        "'"+f_ypzjh+"','"+(-1*f_gjsl)+"','"+(-1*f_gjdj)+"',"+(-1*f_ssje)+",'"+f_sssj+"','"+f_sl+"','"+f_gjdj+"','0','"+f_pch+"','"+f_sgpch+"')";
                sqlList.add(sql);
                sql="update tb"+f_shbm+"_spkc set f_kcsl=f_kcsl-'"+f_gjsl+"',f_kcje=f_kcje-'"+f_kcdj*f_gjsl+"',f_kcsj=f_kcsj-'"+f_sssj+"' where f_pch='"+f_pch+"' and f_sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"'";
                sqlList.add(sql);
                sql="update tb"+f_shbm+"_cksjb set f_kcsl=f_kcsl-'"+f_gjsl+"',f_kcje=f_kcje-'"+f_kcdj*f_gjsl+"',f_kcsj=f_kcsj-'"+f_sssj+"' where f_pch='"+f_pch+"' and f_sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"' and f_ckbm='"+f_ckbm+"'";
                sqlList.add(sql);
            }
            sqlOperator.ExecSql(sqlList);
            result="ok|"+f_djh;
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
    public String GetSpkcBySptm(String f_sptm,String f_shbm,String f_bmbm){
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select f_Bmbm,kc.f_Sptm,da.f_Spmc,kc.f_pch,f_kcsl,round(f_kcje/f_kcsl,2)f_kcdj,f_Spmc,f_Ggxh,f_Jldw from tb"+f_shbm+"_spkc kc left join tb"+f_shbm+"_Spda da on da.f_Sptm=kc.f_Sptm" +
                    " where kc.f_Sptm='"+f_sptm+"' and f_Rq=(select MAX(f_rq) from tb"+f_shbm+"_spkc where f_Sptm='"+f_sptm+"') and f_kcsl>0 and f_bmbm='"+f_bmbm+"'";
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
    public  String  GetJhZbxx(String f_gysbm,String f_shbm,String f_bmbm,String f_spxx){
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select zb.f_djh,cb.f_Dnxh,sp.f_Spmc,sp.f_Ggxh,sp.f_Jldw,f_zdrmc,f_Rzrq,isnull(kh.f_Csmc,'')f_Csmc,f_Gjsl,f_Gjje from tb"+f_shbm+"_spgjzb zb " +
                    "inner join tb"+f_shbm+"_spgjcb cb on cb.f_Djh = zb.f_Djh and cb.f_gjsl>0" +
                    "left join tb"+f_shbm+"_Csda kh on kh.f_Csbm=zb.f_Gysbm  and kh.f_Cslx='0' " +
                    "left join tb"+f_shbm+"_Spda sp on cb.f_Sptm = sp.f_Sptm where 1=1 \n";
            if(!f_gysbm.equals("")){
                sql+=" and zb.f_gysbm ='"+f_gysbm+"' and zb.f_bmbm='"+f_bmbm+"'";
            }
            if(f_spxx != null && !"".equals(f_spxx)){
                sql+=" and (sp.f_Spmc like '%"+f_spxx+"%' or sp.f_c_colum3 like '%"+f_spxx+"%') ";
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
    public  String  GetJhcbmx(String data,String f_shbm){
        //创建连接池
        openConnection();

        String result = null;
        StringBuffer sqls = new StringBuffer();
        try {
            String[] spdjs = data.split("/");
            for (int i= 0 ; i<spdjs.length;i++){
                String[] djmx = spdjs[i].split(",");
                String sql = "select cb.f_Sptm,f_Spmc,f_Gjdj,f_Gjsl,f_Ggxh,f_jldw,f_Gjje,f_Pch,f_Sgpch,f_Ckbm from tb"+f_shbm+"_spgjcb cb \n" +
                        "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm where f_Djh='"+djmx[0]+"' and cb.f_Dnxh = '"+djmx[1]+"' and spda.f_f_colum1='0'" +
                        "union all ";
                sqls.append(sql);
            }
            result = sqlOperator.RunSQL_JSON(sqls.substring(0,sqls.length()-10));
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
    public String GetBillDetail(String khxx, String bmbm,String f_ksrq,String f_jsrq,String f_shbm,String f_zybm)
    {
//创建连接池
        openConnection();

        String result = null;
        try {
            String zysxbm=GetZysxbmByZybm(f_zybm,f_shbm,sqlOperator);
            String sql = "select f_Djh,f_Zdrq,f_Zdrbm,f_Zdrmc,f_Bmbm,f_Ckbm,cs.f_Csmc,f_Djbz,(case f_State when '0' then'未审核'when '1' then '已审核'end)f_State " +
                    "from tb"+f_shbm+"_Spgjzb zb left join tb"+f_shbm+"_Csda cs on cs.f_Csbm=zb.f_Gysbm " +
                    "where f_zdrq between '"+f_ksrq+"' and '"+f_jsrq+"' ";
            if(!khxx.equals("")){
               sql+=" and (cs.f_Csmc like '%"+khxx+"%' or cs.f_Zjf like '%"+khxx+"%')";
            }
            if(!zysxbm.equals("")){
                sql+=" and f_bmbm in("+zysxbm+")";
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
    public String GetSpgjDetail(String cxtj,String f_ksrq,String f_jsrq,String f_shbm,String f_zybm)
    {
//创建连接池
        openConnection();

        String result = null;
        try {
            String zysxbm=GetZysxbmByZybm(f_zybm,f_shbm,sqlOperator);
            String sql = "select zb.f_Djh,zb.f_Rzrq,cb.f_Sptm,f_Spmc,f_Gjdj,f_Gjsl,f_Ggxh,f_jldw,ROUND(f_Gjje,2) f_Gjje,f_Pch,f_sgpch,f_nybz,case f_nybz when '0' then '禁限农药' else '非禁限农药' end as F_NYBZMC  " +
                    "from tb"+f_shbm+"_Spgjcb cb " +
                    "left join tb"+f_shbm+"_Spgjzb zb on zb.f_Djh=cb.f_Djh " +
                    "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm " +
                    "left join tb"+f_shbm+"_Csda kh on kh.f_Csbm=zb.f_Gysbm where zb.f_rzrq between '"+f_ksrq+"' and '"+f_jsrq+"' and spda.f_f_colum1='0' ";
            if(!cxtj.equals("")){
                sql+=" and kh.f_csmc like '%"+cxtj+"%' or kh.f_csbm like '%"+cxtj+"%'";//表结构暂无 客户信息
                sql+=" and cb.f_sptm like '%"+cxtj+"%' or f_spmc like '%"+cxtj +"%'";
            }
            if(!zysxbm.equals("")){
                sql+=" and zb.f_bmbm in("+zysxbm+")";
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
    public String loadCkxx(HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String sql = "";
        String result = null;
        try {
            sql = "select * from tb"+f_shbm+"_ckdawh order by f_ckbm";
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
    public String showDetail(String f_djh, String f_shbm) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select cb.f_Sptm,f_Spmc,f_Gjdj,f_Gjsl,f_Ggxh,f_jldw,f_Gjje,f_Pch,f_Sgpch,f_Ckbm from tb"+f_shbm+"_spgjcb cb \n" +
                    "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm where f_Djh='"+f_djh+"' and spda.f_f_colum1='0'";
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
        String bm = null;
        UtilTools ut = new UtilTools();
        try {
            StringBuilder sql = new StringBuilder();
            String rq = this.retime().substring(0,6);
            sql.append("select max(f_djh) f_djh ");
            sql.append(" from tb").append(f_shbm).append("_spgjzb ");
            sql.append(" where f_djh like '").append(rq).append("%'");
            String f_djh = sqlser.queryOneRecorderData(sql.toString());
            if (f_djh == null || "".equals(f_djh)) return rq + "0001";
            bm =  ut.bmAddOne(f_djh);
        } catch(Exception e){
        } finally {
//            this.sqlOperator.closeConnection();
        }
        return bm;
    }
    private static String retime() {
        Calendar date = new GregorianCalendar();
        return String.valueOf(date.get(Calendar.YEAR)*10000+(date.get(Calendar.MONTH)+1)*100+date.get(Calendar.DATE));

    }
    /**
    *职员所辖部门编码
    */
    private String GetZysxbmByZybm(String f_zybm,String f_shbm,SqlServerOperator sqlOperator) {
        String result = "";
        try {
            String sql = "select f_bmbm from tb"+f_shbm+"_zysxbm where f_Zybm='"+f_zybm+"'";
            ResultSet rs = sqlOperator.RunSQLToResSet(sql);
            while (rs.next()){
                if(result==""){
                    result="'"+rs.getString("f_bmbm")+"'";
                }else{
                    result+=",'"+rs.getString("f_bmbm")+"'";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  result;
    }
}
