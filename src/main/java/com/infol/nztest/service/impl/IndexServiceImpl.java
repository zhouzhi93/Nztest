package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.IndexService;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

@Transactional
@Service
public class IndexServiceImpl implements IndexService {

    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String Hello() {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select count(*) from tbShda";
            result = sqlOperator.queryOneRecorderData(sql);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }
    public String IndexTongji(String f_shbm)
    {
        //创建连接池
        openConnection();
        String result = null;
        try {
            Date day=new Date();
            SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMdd");
            String f_Rzrq=df1.format(day);
            String sql = "select isnull(convert(decimal(18,2),SUM(isnull(cb.f_Ssje,0))),0)f_ssje," +
                    "isnull(convert(decimal(18,2),SUM(isnull(cb.f_wscb,0))),0)f_wscb," +
                    "isnull(convert(decimal(18,2),SUM(isnull(cb.f_wsml,0))),0)f_wsml from tb"+f_shbm+"_Xsmxcb cb " +
                    "left join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh=cb.f_Djh where f_Rzrq='"+f_Rzrq+"'";
            ResultSet rsXs=sqlOperator.RunSQLToResSet(sql);
            String jrxs="",jrcb="",jrml="",jrjh;
            if(rsXs.next()){
                jrxs=rsXs.getString("f_Ssje");
                jrcb=rsXs.getString("f_wscb");
                jrml=rsXs.getString("f_wsml");
            }
            JSONObject jsonObject= new JSONObject();
            jsonObject.put("jrxs",jrxs);
            jsonObject.put("jrcb",jrcb);
            jsonObject.put("jrml",jrml);
            sql="select isnull(convert(decimal(18,2),SUM(isnull(cb.f_Gjje,0))),0)f_gjje from tb"+f_shbm+"_Spgjcb cb left join tb"+f_shbm+"_Spgjzb zb on zb.f_Djh=cb.f_Djh where f_Rzrq='"+f_Rzrq+"'";
            jrjh=sqlOperator.queryOneRecorderData(sql);
            jsonObject.put("jrjh",jrjh);
            //本月
            f_Rzrq=f_Rzrq.substring(0,6)+"01";
            sql = "select isnull(convert(decimal(18,2),SUM(isnull(cb.f_Ssje,0))),0)f_ssje," +
                    "isnull(convert(decimal(18,2),SUM(isnull(cb.f_wscb,0))),0)f_wscb," +
                    "isnull(convert(decimal(18,2),SUM(isnull(cb.f_wsml,0))),0)f_wsml from tb"+f_shbm+"_Xsmxcb cb " +
                    "left join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh=cb.f_Djh where f_Rzrq>='"+f_Rzrq+"'";
            rsXs=sqlOperator.RunSQLToResSet(sql);
            String byxs="",bycb="",byml="",byjh;
            if(rsXs.next()){
                byxs=rsXs.getString("f_Ssje");
                bycb=rsXs.getString("f_wscb");
                byml=rsXs.getString("f_wsml");
            }
            jsonObject.put("byxs",byxs);
            jsonObject.put("bycb",bycb);
            jsonObject.put("byml",byml);
            sql="select isnull(convert(decimal(18,2),SUM(isnull(cb.f_Gjje,0))),0)f_gjje from tb"+f_shbm+"_Spgjcb cb left join tb"+f_shbm+"_Spgjzb zb on zb.f_Djh=cb.f_Djh where f_Rzrq>='"+f_Rzrq+"'";
            byjh=sqlOperator.queryOneRecorderData(sql);
            jsonObject.put("byjh",byjh);
            //上月
            SimpleDateFormat dfny = new SimpleDateFormat("yyyyMM");
            Calendar c = Calendar.getInstance();
            c.setTime(new Date());
            c.add(Calendar.MONTH, -1);
            Date m = c.getTime();
            f_Rzrq = dfny.format(m);
            sql = "select isnull(convert(decimal(18,2),SUM(isnull(cb.f_Ssje,0))),0)f_ssje," +
                    "isnull(convert(decimal(18,2),SUM(isnull(cb.f_wscb,0))),0)f_wscb," +
                    "isnull(convert(decimal(18,2),SUM(isnull(cb.f_wsml,0))),0)f_wsml from tb"+f_shbm+"_Xsmxcb cb " +
                    "left join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh=cb.f_Djh where f_Rzrq like'"+f_Rzrq+"%'";
            rsXs=sqlOperator.RunSQLToResSet(sql);
            String syxs="",sycb="",syml="",syjh;
            if(rsXs.next()){
                syxs=rsXs.getString("f_Ssje");
                sycb=rsXs.getString("f_wscb");
                syml=rsXs.getString("f_wsml");
            }
            jsonObject.put("syxs",syxs);
            jsonObject.put("sycb",sycb);
            jsonObject.put("syml",syml);
            sql="select isnull(convert(decimal(18,2),SUM(isnull(cb.f_Gjje,0))),0)f_gjje from tb"+f_shbm+"_Spgjcb cb left join tb"+f_shbm+"_Spgjzb zb on zb.f_Djh=cb.f_Djh where f_Rzrq like'"+f_Rzrq+"%'";
            syjh=sqlOperator.queryOneRecorderData(sql);
            jsonObject.put("syjh",syjh);

            //本年
            SimpleDateFormat dfbn = new SimpleDateFormat("yyyy");
            f_Rzrq = dfbn.format(day);
            sql = "select isnull(convert(decimal(18,2),SUM(isnull(cb.f_Ssje,0))),0)f_ssje," +
                    "isnull(convert(decimal(18,2),SUM(isnull(cb.f_wscb,0))),0)f_wscb," +
                    "isnull(convert(decimal(18,2),SUM(isnull(cb.f_wsml,0))),0)f_wsml from tb"+f_shbm+"_Xsmxcb cb " +
                    "left join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh=cb.f_Djh where f_Rzrq like'"+f_Rzrq+"%'";
            rsXs=sqlOperator.RunSQLToResSet(sql);
            String bnxs="",bncb="",bnml="",bnjh;
            if(rsXs.next()){
                bnxs=rsXs.getString("f_Ssje");
                bncb=rsXs.getString("f_wscb");
                bnml=rsXs.getString("f_wsml");
            }
            jsonObject.put("bnxs",bnxs);
            jsonObject.put("bncb",bncb);
            jsonObject.put("bnml",bnml);
            sql="select isnull(convert(decimal(18,2),SUM(isnull(cb.f_Gjje,0))),0)f_gjje from tb"+f_shbm+"_Spgjcb cb left join tb"+f_shbm+"_Spgjzb zb on zb.f_Djh=cb.f_Djh where f_Rzrq like'"+f_Rzrq+"%'";
            bnjh=sqlOperator.queryOneRecorderData(sql);
            jsonObject.put("bnjh",bnjh);
            //上年
            c.setTime(new Date());
            c.add(Calendar.YEAR, -1);
            Date y = c.getTime();
            f_Rzrq = dfbn.format(y);
            sql = "select isnull(convert(decimal(18,2),SUM(isnull(cb.f_Ssje,0))),0)f_ssje," +
                    "isnull(convert(decimal(18,2),SUM(isnull(cb.f_wscb,0))),0)f_wscb," +
                    "isnull(convert(decimal(18,2),SUM(isnull(cb.f_wsml,0))),0)f_wsml from tb"+f_shbm+"_Xsmxcb cb " +
                    "left join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh=cb.f_Djh where f_Rzrq like'"+f_Rzrq+"%'";
            rsXs=sqlOperator.RunSQLToResSet(sql);
            String snxs="",sncb="",snml="",snjh="";
            if(rsXs.next()){
                snxs=rsXs.getString("f_Ssje");
                sncb=rsXs.getString("f_wscb");
                snml=rsXs.getString("f_wsml");
            }
            jsonObject.put("snxs",snxs);
            jsonObject.put("sncb",sncb);
            jsonObject.put("snml",snml);
            sql="select isnull(convert(decimal(18,2),SUM(isnull(cb.f_Gjje,0))),0)f_gjje from tb"+f_shbm+"_Spgjcb cb left join tb"+f_shbm+"_Spgjzb zb on zb.f_Djh=cb.f_Djh where f_Rzrq like'"+f_Rzrq+"%'";
            snjh=sqlOperator.queryOneRecorderData(sql);
            jsonObject.put("snjh",snjh);
            result = jsonObject.toString();
            result = jsonObject.toString();
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
    public String GetMsg(){
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select top 10 * from tbjgmsg order by f_xh desc";
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
}
