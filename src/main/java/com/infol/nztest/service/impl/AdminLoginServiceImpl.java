package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.AdminLoginService;
import com.infol.nztest.service.LoginService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Transactional
@Service
public class AdminLoginServiceImpl implements AdminLoginService {
    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    public String CheckLogin(String f_Zybm,String f_sjhm){
        //创建连接池
        openConnection();
        String result = null;
        try {
            String sql = "select * from tbjgzyda  where f_dh='"+f_Zybm+"' or f_zybm='"+f_Zybm+"'";
              result=sqlOperator.RunSQL_JSON(sql);
        } catch (Exception e) {
            e.printStackTrace();
            result= "err"+e.getMessage();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }
}
