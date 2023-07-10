package com.infol.nztest.service.impl;

import ch.qos.logback.classic.net.SyslogAppender;
import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.LoginService;
import com.infol.nztest.service.StorService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

@Transactional
@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private StorService storService;

    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    public String CheckLogin(String f_sjhm,String f_zykl){
        //创建连接池
        openConnection();
        String result = null;
        try {
            String sql = "select * from tbptzyda zy left join tbshda sh on sh.f_Shbm=zy.f_Shbm  where zy.f_sjh='"+f_sjhm+"'";
            result=sqlOperator.RunSQL_JSON(sql);
            JSONArray jarr= new JSONArray(result);
            JSONObject json = jarr.getJSONObject(0);
            String dz = json.getString("F_DZ");
            Integer s = null;
            if(dz.indexOf("区") == -1){
                s = dz.indexOf("县");
            }else{
                s = dz.indexOf("区");
            }
            String qydz = dz.substring(0,s+1);
            String xxdz = dz.substring(s+1,dz.length());
            json.put("F_QYDZ",qydz);
            json.put("F_XXDZ",xxdz);
            jarr.put(0,json);
            result = jarr.toString();
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

    @Override
    public String CheckLoginApprove(String f_sjhm, String f_zykl) {
        //创建连接池
        openConnection();
        String result = null;
        try {
            String sql = "select * from tbjgzyda where f_dh='"+f_sjhm+"' or f_zybm='"+f_sjhm+"'";
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

    @Override
    public String GetZyqx(String f_zybm,String f_shbm){
        //创建连接池
        openConnection();
        String result = "";
        try {
            String sql = "select f_qxbm from tb"+f_shbm+"_Zyqx where f_zybm='"+f_zybm+"'";
            result=sqlOperator.RunSQL_JSON(sql);
        } catch (Exception e) {
            e.printStackTrace();
            result="err"+e.getMessage();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String getShlx() {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select * from tbshlxda";
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

    /**
     * 获取参数设置
     * @param f_shbm
     * @return
     */
    @Override
    public String getCssz(String f_shbm) {
        //创建连接池
        openConnection();
        String result = "";
        try {
            String sql = "select * from tb"+f_shbm+"_Cssz order by f_px";
            result=sqlOperator.RunSQL_JSON(sql);
        } catch (Exception e) {
            e.printStackTrace();
            result="err"+e.getMessage();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String GetSaleBillQX(String f_zybm, String f_shbm) {
        //创建连接池
        openConnection();

        String result ="";
        try {
            String sql = "select count(*) from tb"+f_shbm+"_Zyqx where f_Zybm='"+f_zybm+"' and f_Qxbm='0104'";
            result =sqlOperator.queryOneRecorderData(sql);
        } catch (Exception e) {
            e.printStackTrace();
            result="err"+e.getMessage();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    public String GetZysxbm(String f_zybm,String f_shbm){
        //创建连接池
        openConnection();
        String result = null;
        try {
            String sql = "select sx.f_bmbm,f_Bmmc,CASE f_yjdz WHEN '' THEN '"+f_shbm+"_'+sx.f_Bmbm+'_02' ELSE f_yjdz END as f_yjdz ," +
                    "CASE f_yjzh WHEN '' THEN '"+f_shbm+"_'+sx.f_Bmbm+'_01' ELSE f_yjzh END as f_yjzh,f_yjmm,f_dkqppbm,f_jhgsbm from tb"+f_shbm+"_zysxbm sx left join tb"+f_shbm+"_Bmda bm on bm.f_Bmbm=sx.f_Bmbm where f_Zybm='"+f_zybm+"'";
            String sxbm=sqlOperator.RunSQL_JSON(sql);
            JSONArray jarr=new JSONArray(sxbm);
            if(jarr.length()<=0){
                sql="select f_bmbm,f_Bmmc,f_jhgsbm from tb"+f_shbm+"_bmda";
                result=sqlOperator.RunSQL_JSON(sql);
            }else{
                result=sxbm;
            }
            //上传所有部门信息
            JSONArray json = new JSONArray(result);
            for(int i = 0 ; i<json.length() ; i++){
                JSONObject temp = json.getJSONObject(i);
                String bmbm = temp.getString("F_BMBM");
                String jhgsbm = temp.getString("F_JHGSBM");
                if(jhgsbm != null && "0".equals(jhgsbm)){
                    storService.responseBmmx(bmbm,f_shbm);
                }
            }
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
    @Override
    @Transactional
    public String Regist(String f_sjhm,String f_khmc,String f_zykl,String f_shlx,String f_sfls,String f_qydz,String f_xxdz,String f_yzbm,String f_lxdh,String f_jyxkzh,
                         String f_emall,String f_khh,String f_khzh,String f_sh,String f_fr,String f_zczb){
        //创建连接池
        openConnection();
        String result = null;
        try {
            String sql = "select count(*) from tbshda where f_sjh='"+f_sjhm+"'";
            int count=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
            if(count>0){
                throw new Exception("该手机号已被注册!");
            }
            sql="select isnull(MAX(f_shbm),'000000') from tbshda";
            String maxBm=sqlOperator.queryOneRecorderData(sql);
            int bmlen=maxBm.length();
            int bm=Integer.parseInt(maxBm)+1;
            String f_shbm=String.valueOf(bm);
            while(f_shbm.length()<bmlen){
                f_shbm = "0" + f_shbm;
            }
            String [] rows=f_qydz.split("\\|");
            String f_qybm="";
            for (int i=1;i<=rows.length;i++)
            {
                if(i==1) {
                    sql = "select f_qybm from tbqyda where f_qymc='" + rows[i - 1] + "' and f_jb='" + Integer.toString(i) + "'";
                }else if(i==2){
                    sql = "select f_qybm from tbqyda where f_qymc='" + rows[i - 1] + "' and f_jb='" + Integer.toString(i) + "' and f_qybm like '"+f_qybm+"%'";
                }else{
                    sql = "select f_qybm from tbqyda where f_qymc='" + rows[i - 1] + "' and f_jb='" + Integer.toString(i) + "' and f_qybm like '"+f_qybm+"%'";
                }
                String  qybm=sqlOperator.queryOneRecorderData(sql);
                if(qybm==null){
                    break;
                }
                f_qybm=qybm;
            }
            if(f_qybm=="")throw new Exception("所选区域暑假异常");
            f_qydz=f_qydz.replace("|","");
            Date day=new Date();
            SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMdd ");
            String f_Xgrq=df1.format(day);
            List<String> sqlList= new ArrayList<>();
            //sql="insert into tbptzyda(f_Zybm,f_Zymc,f_Xgrq,f_Zykl,f_sjh)values('"+f_zybm+"','"+f_khmc+"','"+f_Xgrq+"','"+f_zykl+"','"+f_sjhm+"')";
            sql="insert into tbShda (f_Shbm,f_Shmc,f_lxbm,f_sfls,f_shzt,f_Yb,f_Dz,f_Xxdz,f_Dh,f_jyxkzh,f_Email,f_Khh,f_Zh,f_Sh,f_Fr,f_Zczb,f_Bzj,f_Jgdm,f_sjh,f_mm,f_dqrq,f_qybm)" +
                    "values('"+f_shbm+"','"+f_khmc+"','"+f_shlx+"','"+f_sfls+"','0','"+f_yzbm+"','"+f_qydz+"','"+f_xxdz+"','"+f_lxdh+"','"+f_jyxkzh+"','"+f_emall+"'," +
                    "'"+f_khh+"','"+f_khzh+"','"+f_sh+"','"+f_fr+"','"+f_zczb+"','0','','"+f_sjhm+"','"+f_zykl+"','','"+f_qybm+"')";
            sqlList.add(sql);
            sql="insert into tbptzyda(f_Zybm,f_Zymc,f_Xgrq,f_Zykl,f_sjh,f_shbm)values('"+f_shbm+"01','管理员','"+f_Xgrq+"','"+f_zykl+"','"+f_sjhm+"','"+f_shbm+"')";
            sqlList.add(sql);
            sqlOperator.ExecSql(sqlList);
            result= "ok";
        } catch (Exception e) {
            e.printStackTrace();
            result= e.getMessage();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    @Transactional
    public String forgetPwd(String f_sjhm, String f_zykl) {
        //创建连接池
        openConnection();
        String result = null;
        try {
            List<String> sqlList= new ArrayList<>();
            String sql="update tbShda set f_mm='"+f_zykl+"' where f_sjh='"+f_sjhm+"'";
            sqlList.add(sql);
            sql = "update tbptzyda set f_Zykl='"+f_zykl+"' where f_sjh = '"+f_sjhm+"'";
            sqlList.add(sql);
            sqlOperator.ExecSql(sqlList);
            result= "ok";
        } catch (Exception e) {
            e.printStackTrace();
            result= e.getMessage();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    @Override
    @Transactional
    public String EditShxx(String f_sjhm,String f_khmc,String f_zykl,String f_shlx,String f_sfls,String f_qydz,String f_xxdz,String f_yzbm,String f_lxdh,String f_jyxkzh,
                         String f_emall,String f_khh,String f_khzh,String f_sh,String f_fr,String f_zczb){
        //创建连接池
        openConnection();
        String result = null;
        try {
            String sql = "select count(*) from tbshda where f_sjh='"+f_sjhm+"'";
            int count=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
            if(count<=0){
                throw new Exception("该手机不存在!");
            }
            Date day=new Date();
            SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMdd ");
            String f_Xgrq=df1.format(day);
            //sql="insert into tbptzyda(f_Zybm,f_Zymc,f_Xgrq,f_Zykl,f_sjh)values('"+f_zybm+"','"+f_khmc+"','"+f_Xgrq+"','"+f_zykl+"','"+f_sjhm+"')";
            sql="update tbShda set f_Shmc='"+f_khmc+"',f_lxbm='"+f_shlx+"',f_sfls='"+f_sfls+"',f_shzt='0',f_Yb='"+f_yzbm+"',f_Dz='"+f_qydz+f_xxdz+"'," +
                    "f_Dh='"+f_lxdh+"',f_jyxkzh='"+f_jyxkzh+"',f_Email='"+f_emall+"',f_Khh='"+f_khh+"',f_Zh='"+f_khzh+"',f_Sh='"+f_sh+"',f_Fr='"+f_fr+"',f_Zczb='"+f_zczb+"'" +
                    "  where f_sjh='"+f_sjhm+"'";
            sqlOperator.ExecSQL(sql);
            result= "ok";
        } catch (Exception e) {
            e.printStackTrace();
            result= e.getMessage();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }
}
