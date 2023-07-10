package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.AdminClerkService;
import com.infol.nztest.service.ClerkService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import util.MD5;
import util.WordToPinYin;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Transactional
@Service
public class AdminClerkServiceImpl implements AdminClerkService {
    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getZymx(String zybm) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select * from tbhtzyda";
            if(!zybm.equals("") && zybm != null){
                sql+=" where f_Zybm like '%"+zybm+"%' or f_Zymc like '%"+zybm+"%'";
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
    public String addZymx(String zymc, String sjh, String zykl) {
        //创建连接池
        openConnection();

        List<String> sqls = new ArrayList<>();

        String result = null;
        try {
            String sql=" select MAX(f_Zybm) from tbhtzyda";
            String maxBm=sqlOperator.queryOneRecorderData(sql);
            int bmlen=maxBm.length();
            if(maxBm == null || "".equals(maxBm)){
                maxBm = "000000";
            }
            int bm = Integer.parseInt(maxBm)+1;
            String f_zybm=String.valueOf(bm);
            while(f_zybm.length()<bmlen){
                f_zybm = "0" + f_zybm;
            }
            //暂时不加
            //zykl = MD5.MD5(zykl);
            SimpleDateFormat format = new SimpleDateFormat("YYYYmmdd");

            sql = "insert into tbhtzyda(f_Zybm,f_Zymc,f_Zykl) " +
                    "values('"+f_zybm+"','"+zymc+"','"+zykl+"')";

            sqls.add(sql);
            sqlOperator.ExecSql(sqls);
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
    public String removeZymx(String zybm) {
        //创建连接池
        openConnection();

        List<String> sqls = new ArrayList<>();

        String result = null;
        try {
            String sql = "delete from tbhtzyda where f_Zybm = '"+zybm+"'";
            sqls.add(sql);
            result = "ok";
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
    public String updateZymx(String zybm, String zymc, String sjh, String zykl) {
        //创建连接池
        openConnection();

        List<String> sqls = new ArrayList<>();

        if("".equals(zykl) || zykl == null){
            String sql = "select f_Zykl from tbhtzyda where f_Zybm = '"+zybm+"'";
            zykl = sqlOperator.queryOneRecorderData(sql);
        }

        String result = null;
        try {

            String sql = "delete from tbhtzyda where f_Zybm = '"+zybm+"'";
            sqls.add(sql);
            //暂时不加
            //zykl = MD5.MD5(zykl);
            SimpleDateFormat format = new SimpleDateFormat("YYYYmmdd");
            sql = "insert into tbhtzyda(f_Zybm,f_Zymc,f_Zykl) " +
                    "values('"+zybm+"','"+zymc+"','"+zykl+"')";
            sqls.add(sql);

            sqlOperator.ExecSql(sqls);
            result = "ok";
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
