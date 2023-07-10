package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.ApproveService;
import com.infol.nztest.service.StorService;
import com.infol.nztest.util.emay.SMS;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;

@Transactional
@Service
public class ApproveServiceImpl implements ApproveService {
    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getShmx(String shzt) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select sh.*,shlx.f_lxmc as F_LXBMMC from tbShda sh \n" +
                    "left join tbshlxda shlx on sh.f_lxbm = shlx.f_lxbm \n" +
                        "where f_shzt = '"+shzt+"'";
            result = sqlOperator.RunSQL_JSON(sql);
            JSONArray jsons = new JSONArray(result);
            for(int i = 0 ; i<jsons.length() ; i++){
                JSONObject json = jsons.getJSONObject(i);
                String sfls = json.getString("F_SFLS");
                String lxbm = json.getString("F_LXBM");

                if("1".equals(sfls)){
                    json.put("F_SFLS","不连锁");
                }else if("2".equals(sfls)){
                    json.put("F_SFLS","连锁");
                }

                if("1".equals(lxbm)){
                    json.put("F_LXBMMC","农资店");
                }else if("2".equals(lxbm)){
                    json.put("F_LXBMMC","零售超市");
                }else if("3".equals(lxbm)){
                    json.put("F_LXBMMC","水果店");
                }

                jsons.put(i,json);

            }
            result = jsons.toString();
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
    public String SpSh(String shzt,String shbm,String lxbm,String shmc, String yy,String f_sjhm) {

        //创建连接池
        openConnection();
        String result = null;
        try {
            if("1".equals(shzt)){
                String sql = "{call dbo.spCreateDeptTable(?, ?, ?)}";
                String[] ags = new String[]{lxbm,shbm,shmc};
                sqlOperator.executeStoredProcedure(sql,ags);

                sql = "update tbShda set f_shzt = '"+shzt+"' \n" +
                        "where f_Shbm = '"+shbm+"'";
                sqlOperator.ExecSQL(sql);
                SMS.setSingleSms(f_sjhm, "【盈放云平台】 您的开店申请审核已通过，请尽快登录平台进行店铺信息设置！");
            }else{
                String sql = "update tbShda set f_shzt = '"+shzt+"' \n";
                if(!"".equals(yy) && yy != null){
                    sql += ",f_yy = '"+yy+"'";
                }
                sql += "where f_Shbm = '"+shbm+"'";
                sqlOperator.ExecSQL(sql);
                SMS.setSingleSms(f_sjhm, "【盈放云平台】 您的开店申请审核未通过，请登录平台重新修改并申请！");
            }
            result = "ok";
        } catch (Exception e) {
            if("The statement did not return a result set.".equals(e.getMessage())){
                result = "ok";
            }else{
                e.printStackTrace();
            }
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String updateShzt(String shzt, String shbm) {
        //创建连接池
        openConnection();
        String result = null;
        try {
            String sql = "update tbShda set f_shzt = '"+shzt+"' \n" +
                    "where f_Shbm = '"+shbm+"'";
            sqlOperator.ExecSQL(sql);
            result = "ok";
        } catch (Exception e) {
            if("The statement did not return a result set.".equals(e.getMessage())){
                result = "ok";
            }else{
                e.printStackTrace();
            }
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }


}
