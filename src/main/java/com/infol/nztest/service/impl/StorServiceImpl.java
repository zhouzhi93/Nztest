package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.StorService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import util.HttpUtil;
import util.WordToPinYin;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.sql.ResultSet;
import java.util.*;

@Transactional
@Service
public class StorServiceImpl implements StorService {
    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getBmmx(String bmxx, HttpServletRequest request) {
        //创建连接池
        openConnection();

        //获取商户编码
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            //查询编码档案表，根据部门编码或部门名称或助记符
            String sql = "select * from tb"+f_shbm+"_Bmda where f_bmlx='0'";
            if(!bmxx.equals("") && bmxx != null){
                sql+=" and f_Bmbm like '%"+bmxx+"%' or f_Bmmc like '%"+bmxx+"%'  or f_Zjf like '%"+bmxx+"%'";
            }
            sql += " order by f_bmbm desc";
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
    public String getBmmxAll() {
        //创建连接池
        openConnection();

        String result = null;
        try {

            String sql="select * from tbshda where f_shzt='1'";

            ResultSet rs=sqlOperator.RunSQLToResSet(sql);
            sql="";
            while(rs.next()){
                String fgsh=(String) rs.getString("f_shbm");

                String sqlsub = "select '"+fgsh+"_'+f_Bmbm as code,f_Bmmc as name,f_jwd as position,f_Fr as owner,f_Dh as contact " +
                        "from tb"+fgsh+"_Bmda where f_sczt != 1" ;

                if(sql.equals("")){
                    sql=sqlsub;
                }else
                {
                    sql+=" union all ";
                    sql+=  sqlsub;
                }
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
    public String addBmmx(String bmmc, String yb, String dz, String dh,String cz,String email,String khh,String zh,
                          String sh,String fr,String tybz,String jwd,String jyxkzh, String jyfzrq, String jysxrq, String jyxkztp,
                          String jwjg,String hfzm,String xsjg, String scxkzh,String scfzrq,String scsxrq,String scxkztp,String zxbz,
                          String aqbz,String hbdj,String xxqy,
                          String dkqppbm,String yjdz,String yjmm,String yjzh,String jhgsbm,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        List<String> sqls = new ArrayList<>();

        if(jyfzrq != null && !"".equals(jyfzrq)){
            jyfzrq = jyfzrq.substring(0,4)+jyfzrq.substring(5,7)+jyfzrq.substring(8,10);
        }

        if(jysxrq != null && !"".equals(jysxrq)){
            jysxrq = jysxrq.substring(0,4)+jysxrq.substring(5,7)+jysxrq.substring(8,10);
        }

        if(scfzrq != null && !"".equals(scfzrq)){
            scfzrq = scfzrq.substring(0,4)+scfzrq.substring(5,7)+scfzrq.substring(8,10);
        }

        if(scsxrq != null && !"".equals(scsxrq)){
            scsxrq = scsxrq.substring(0,4)+scsxrq.substring(5,7)+scsxrq.substring(8,10);
        }

        if(jyxkztp != null && !"".equals(jyxkztp)){
            jyxkztp = request.getRequestURL().toString().replace(request.getRequestURI(),"")+jyxkztp;
        }

        if(hfzm != null && !"".equals(hfzm)){
            hfzm = request.getRequestURL().toString().replace(request.getRequestURI(),"")+hfzm;
        }

        if(scxkztp != null && !"".equals(scxkztp)){
            scxkztp = request.getRequestURL().toString().replace(request.getRequestURI(),"")+scxkztp;
        }

        String result = null;
        try {
            String sql=" select MAX(f_Bmbm) from tb"+f_shbm+"_Bmda \n" +
                    "where f_bmlx=0 \n" +
                    "and LEN(f_Bmbm)=(select MAX(LEN(f_Bmbm)) from tb"+f_shbm+"_Bmda where f_bmlx=0)";
            String maxBm=sqlOperator.queryOneRecorderData(sql);
            int bmlen=4;
            int bm=Integer.parseInt(maxBm)+1;
            String f_Bmbm=String.valueOf(bm);
            while(f_Bmbm.length()<bmlen){
                f_Bmbm = "0" + f_Bmbm;
            }
            String zjf = WordToPinYin.converterToFirstSpell(bmmc);
            sql = "insert into tb"+f_shbm+"_Bmda(f_Bmbm,f_Bmmc,f_Zjf,f_Yb,f_Dz,f_Dh,f_Cz,f_Email,f_Khh,f_Zh,f_Sh,f_Fr,f_Tybz,f_jwd,f_jyxkzh,f_fzrq,f_zjyxrq,f_jyxk," +
                    "f_sfjwjg,f_cphfzm,f_slxsjgsm,f_scxkzbh,f_scxkzfzrq,f_scxkzsxrq,f_scxkz,f_sczxbz,f_scaqbz,f_schbbz,f_xxqy,f_dkqppbm,f_yjdz,f_yjmm,f_yjzh,f_jhgsbm) " +
                    "values('"+f_Bmbm+"','"+bmmc+"','"+zjf+"','"+yb+"','"+dz+"','"+dh+"','"+cz+"','"+email+"','"+khh+"','"+zh+"','"+sh+"','"+fr+"','"+tybz+"','"+jwd+"',"+
                    "'"+jyxkzh+"','"+jyfzrq+"','"+jysxrq+"','"+jyxkztp+"','"+jwjg+"','"+hfzm+"','"+xsjg+"','"+scxkzh+"'," +
                    "'"+scfzrq+"','"+scsxrq+"','"+scxkztp+"','"+zxbz+"','"+aqbz+"','"+hbdj+"','"+xxqy+"','"+dkqppbm+"','"+yjdz+"','"+yjmm+"','"+yjzh+"','"+jhgsbm+"')";
            sqls.add(sql);

            sqlOperator.ExecSql(sqls);
            result="ok";
            if("0".equals(jhgsbm)){
                responseBmmx(f_Bmbm,f_shbm);
            }
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
    public void responseBmmx(String bmbm,String shbm){
        //创建连接池
        openConnection();
        try {
            HttpUtil util = new HttpUtil();
            Map<String, String> map = new HashMap<String, String>();
            List<String> sqls = new ArrayList<>();
            String sqlsub = "select '"+shbm+"_'+f_Bmbm as code,f_Bmmc as name,f_jwd as position,f_Fr as owner,f_Dh as contact," +
                    "CASE f_yjdz WHEN '' THEN '"+shbm+"_'+f_Bmbm+'_02' ELSE f_yjdz END as cardReaderSerial,dkq.f_dkqppmc as cardReaderName," +
                    "CASE f_yjzh WHEN '' THEN '"+shbm+"_'+f_Bmbm+'_01' ELSE f_yjzh END as cameraSerial " +
                    "from tb"+shbm+"_Bmda bm " +
                    "left join tbdkqppda dkq on bm.f_dkqppbm = dkq.f_dkqppbm " +
                    "where (1 = 1)" ;
            if(!bmbm.equals("") && bmbm != null){
                sqlsub+=" and f_Bmbm = '"+bmbm+"'";
            }
            String result = sqlOperator.RunSQL_JSONNoToCase(sqlsub);
            if(!result.isEmpty()){
                JSONArray json = new JSONArray(result);
                for(int i = 0 ; i<json.length() ; i++){
                    JSONObject temp = json.getJSONObject(i);
                    Iterator j = temp.keys();
                    while (j.hasNext()){
                        String key = j.next().toString();
                        String value = temp.getString(key);
                        map.put(key.trim(),value);
                    }
                    Boolean base = util.department(map);
                    if(base){
                        String sql = "update tb"+shbm+"_Bmda set f_sczt = 1 " +
                                "where f_Bmbm = '"+bmbm+"'";
                        sqls.add(sql);
                        sqlOperator.ExecSql(sqls);
                    }
                    System.out.println(map.toString());
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    @Override
    public String removeBmmx(String bmbm, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        List<String> sqls = new ArrayList<>();

        String result = null;
        try {
            String sql = "delete from tb"+f_shbm+"_Bmda where f_Bmbm = '"+bmbm+"'";
            sqls.add(sql);
            sql = "delete from tb"+f_shbm+"_zysxbm where f_Bmbm = '"+bmbm+"'";
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

    @Override
    public String updateBmmx(String bmbm,String bmmc, String yb, String dz, String dh,String cz,
                             String email,String khh,String zh,String sh,String fr,String tybz,String jwd,
                             String jyxkzh, String jyfzrq, String jysxrq, String jyxkztp, String jwjg,String hfzm,
                             String xsjg, String scxkzh,String scfzrq,String scsxrq,String scxkztp,String zxbz,
                             String aqbz,String hbdj,String xxqy,
                             String dkqppbm,String yjdz,String yjmm,String yjzh,String jhgsbm,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        List<String> sqls = new ArrayList<>();

        if(jyfzrq != null && !"".equals(jyfzrq)){
            jyfzrq = jyfzrq.substring(0,4)+jyfzrq.substring(5,7)+jyfzrq.substring(8,10);
        }

        if(jysxrq != null && !"".equals(jysxrq)){
            jysxrq = jysxrq.substring(0,4)+jysxrq.substring(5,7)+jysxrq.substring(8,10);
        }

        if(scfzrq != null && !"".equals(scfzrq)){
            scfzrq = scfzrq.substring(0,4)+scfzrq.substring(5,7)+scfzrq.substring(8,10);
        }

        if(scsxrq != null && !"".equals(scsxrq)){
            scsxrq = scsxrq.substring(0,4)+scsxrq.substring(5,7)+scsxrq.substring(8,10);
        }

        if(jyxkztp != null && !"".equals(jyxkztp)){
            jyxkztp = request.getRequestURL().toString().replace(request.getRequestURI(),"")+jyxkztp;
        }

        if(hfzm != null && !"".equals(hfzm)){
            hfzm = request.getRequestURL().toString().replace(request.getRequestURI(),"")+hfzm;
        }

        if(scxkztp != null && !"".equals(scxkztp)){
            scxkztp = request.getRequestURL().toString().replace(request.getRequestURI(),"")+scxkztp;
        }

        String result = null;
        try {
            String zjf = WordToPinYin.converterToFirstSpell(bmmc);
            String sql = "update tb"+f_shbm+"_Bmda set ";
            if(bmmc != null){
                sql += "f_Bmmc = '"+bmmc+"',";
            }
            if(zjf != null){
                sql += "f_Zjf = '"+zjf+"',";
            }
            if(yb != null){
                sql += "f_Yb = '"+yb+"',";
            }
            if(dz != null){
                sql += "f_Dz = '"+dz+"',";
            }
            if(dh != null){
                sql += "f_Dh = '"+dh+"',";
            }
            if(cz != null){
                sql += "f_Cz = '"+cz+"',";
            }
            if(email != null){
                sql += "f_Email = '"+email+"',";
            }
            if(khh != null){
                sql += "f_Khh = '"+khh+"',";
            }
            if(zh != null){
                sql += "f_Zh = '"+zh+"',";
            }
            if(sh != null){
                sql += "f_Sh = '"+sh+"',";
            }
            if(fr != null){
                sql += "f_Fr = '"+fr+"',";
            }
            if(tybz != null){
                sql += "f_Tybz = '"+tybz+"',";
            }
            if(jwd != null){
                sql += "f_jwd = '"+jwd+"',";
            }
            if(jyxkzh != null){
                sql += "f_jyxkzh = '"+jyxkzh+"',";
            }
            if(jyfzrq != null){
                sql += "f_fzrq = '"+jyfzrq+"',";
            }
            if(jysxrq != null){
                sql += "f_zjyxrq = '"+jysxrq+"',";
            }
            if(jyxkztp != null){
                sql += "f_jyxk = '"+jyxkztp+"',";
            }
            if(jwjg != null){
                sql += "f_sfjwjg = '"+jwjg+"',";
            }
            if(hfzm != null){
                sql += "f_cphfzm = '"+hfzm+"',";
            }
            if(xsjg != null){
                sql += "f_slxsjgsm = '"+xsjg+"',";
            }
            if(scxkzh != null){
                sql += "f_scxkzbh = '"+scxkzh+"',";
            }
            if(scfzrq != null){
                sql += "f_scxkzfzrq = '"+scfzrq+"',";
            }
            if(scsxrq != null){
                sql += "f_scxkzsxrq = '"+scsxrq+"',";
            }
            if(scxkztp != null){
                sql += "f_scxkz = '"+scxkztp+"',";
            }
            if(zxbz != null){
                sql += "f_sczxbz = '"+zxbz+"',";
            }
            if(aqbz != null){
                sql += "f_scaqbz = '"+aqbz+"',";
            }
            if(hbdj != null){
                sql += "f_schbbz = '"+hbdj+"',";
            }
            if(xxqy != null){
                sql += "f_xxqy = '"+xxqy+"',";
            }
            if(dkqppbm != null){
                sql += "f_dkqppbm = '"+dkqppbm+"',";
            }
            if(yjdz != null){
                sql += "f_yjdz = '"+yjdz+"',";
            }
            if(yjzh != null){
                sql += "f_yjzh = '"+yjzh+"',";
            }
            if(yjmm != null ){
                sql += "f_yjmm = '"+yjmm+"',";
            }
            if(jhgsbm != null){
                sql += "f_jhgsbm = '"+jhgsbm+"',";
            }
            sql = sql.substring(0,sql.length()-1);
            sql += " where f_Bmbm = '"+bmbm+"'";
            sqls.add(sql);
            sqlOperator.ExecSql(sqls);
            if("0".equals(jhgsbm)){
                responseBmmx(bmbm,f_shbm);
            }

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
    public String getJhgsda(HttpServletRequest request) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select * from tbjhgsda ";
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
    public String getDkqppda(HttpServletRequest request) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select * from tbdkqppda ";
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
