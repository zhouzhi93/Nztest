package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.ClientService;
import org.json.JSONArray;
import org.json.JSONObject;
import util.Node;
import util.NodeUtil;
import util.WordToPinYin;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Transactional
@Service
public class ClientServiceImpl implements ClientService {
    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String updateKhmx(String f_csbm,String f_khmc, String f_sjhm, String f_sfzh,
                             String f_qydz, String f_xxdz, String f_bzxx,String f_lxr,String cslx,String f_xkzh,HttpServletRequest request,
                             String f_Dz,String f_Khh,String f_Yhkh,String f_Tyxym,String f_Sfjzps,String f_Khlx,String flbms,String sls) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            List sqls = new ArrayList<>();
            String sql="";
            String zjf = WordToPinYin.converterToFirstSpell(f_khmc);
            //厂商类型 0供应商 1客户 2生产厂商
            if("1".equals(cslx)){
                if (f_Sfjzps == null || f_Sfjzps.equals("") || f_Khlx == null || f_Khlx.equals("")){
                    sql="update tb"+f_shbm+"_csda set f_cslx='"+cslx+"',f_Csmc='"+f_khmc+"',f_Zjf='"+zjf+"'," +
                            "f_dh='"+f_sjhm+"',f_sfzh='"+f_sfzh+"',f_qybm='"+f_qydz+"',f_jb='1',f_Bzxx='"+f_bzxx+"',f_Scxkzh='"+f_xkzh+"'" +
                            "f_Dz='"+f_Dz+"',f_Khh='"+f_Khh+"',f_Yhkh='"+f_Yhkh+"',f_Tyxym='"+f_Tyxym+"'," +
                            "where f_Csbm = '"+f_csbm+"' and f_Cslx = '"+cslx+"'";
                    sqls.add(sql);
                }else {
                    //常熟、江阴、太仓版
                    sql="update tb"+f_shbm+"_csda set f_cslx='"+cslx+"',f_Csmc='"+f_khmc+"',f_Zjf='"+zjf+"'," +
                            "f_dh='"+f_sjhm+"',f_sfzh='"+f_sfzh+"',f_qybm='"+f_qydz+"',f_jb='1',f_Bzxx='"+f_bzxx+"',f_Scxkzh='"+f_xkzh+"'," +
                            "f_Dz='"+f_Dz+"',f_Khh='"+f_Khh+"',f_Yhkh='"+f_Yhkh+"',f_Tyxym='"+f_Tyxym+"',f_Sfjzps='"+f_Sfjzps+"',f_Khlx='"+f_Khlx+"'" +
                            "where f_Csbm = '"+f_csbm+"' and f_Cslx = '"+cslx+"'";
                    sqls.add(sql);
                    //判断客户类型是农户、大户还是合作社
                    String flbm = "";
                    String khlx = "";
                    if (f_Khlx.equals("0")){
                        khlx = "f_sfsynh";
                    } else if (f_Khlx.equals("1")){
                        khlx = "f_sfsydh";
                    } else if (f_Khlx.equals("2")){
                        khlx = "f_sfsyhzs";
                    }
                    //厂商统计明细对照表插数据
                    sql = "select tjmx.f_flbm,tjmx.f_flmc\n" +
                            "from tb"+f_shbm+"_tjmxwh tjmx \n" +
                            "left join tb"+f_shbm+"_tjlxwh tjlx on tjmx.f_flbm like tjlx.f_flbm+'%'\n" +
                            "where tjmx.f_mj = '1' and "+khlx+" = '1'";
                    String flbmList = sqlOperator.RunSQL_JSON(sql);
                    JSONArray flbmJson = new JSONArray(flbmList);


                    //判断对照表中有没有数据，有的话修改，没有插入
                    sql = "select * from tb"+f_shbm+"_cstjmxdzb where f_Csbm='"+f_csbm+"'";
                    String cstjmxResult = sqlOperator.RunSQL_JSON(sql);
                    if (cstjmxResult == null || cstjmxResult.equals("") || cstjmxResult.equals("[]")){
                        //插入厂商统计明细对照表
                        for (int i = 0; i < flbmJson.length(); i++){
                            flbm = flbmJson.getJSONObject(i).getString("F_FLBM");
                            sql = "insert into tb"+f_shbm+"_cstjmxdzb(f_Csbm,f_flbm)values('"+f_csbm+"','"+flbm+"')";
                            sqls.add(sql);
                        }
                    }else {
                        sql = "delete tb"+f_shbm+"_cstjmxdzb where f_Csbm='"+f_csbm+"'";
                        sqls.add(sql);
                        for (int i = 0; i < flbmJson.length(); i++){
                            flbm = flbmJson.getJSONObject(i).getString("F_FLBM");
                            sql = "insert into tb"+f_shbm+"_cstjmxdzb(f_Csbm,f_flbm)values('"+f_csbm+"','"+flbm+"')";
                            sqls.add(sql);
                        }
                    }

                    if (flbms != null && !flbms.equals("") && sls != null && !sls.equals("")){
                        //修改数量
                        String[] flbmsList = flbms.split(",");
                        String[] slsList = sls.split(",");
                        for (int i = 0; i < flbmsList.length; i++){
                            String f_flbm = flbmsList[i];
                            float sl = Float.parseFloat(slsList[i]);
                            sql = "update tb"+f_shbm+"_cstjmxdzb set f_sl='"+sl+"' where f_flbm='"+f_flbm+"' and f_Csbm='"+f_csbm+"'";
                            sqls.add(sql);
                        }
                    }
                }
            }else if("0".equals(cslx)){
                sql="update tb"+f_shbm+"_csda set f_cslx='"+cslx+"',f_Csmc='"+f_khmc+"',f_Zjf='"+zjf+"'," +
                        "f_dh='"+f_sjhm+"',f_Lxr='"+f_lxr+"',f_qybm='"+f_qydz+"',f_jb='1',f_dz='"+f_xxdz+"',f_Bzxx='"+f_bzxx+"',f_Scxkzh='"+f_xkzh+"' where f_Csbm = '"+f_csbm+"' and f_Cslx = '"+cslx+"'";
                sqls.add(sql);
            }
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
    public String AddKhda(String f_khmc, String f_sjhm, String f_sfzh, String f_qydz, String f_xxdz,
                          String f_bzxx,String f_lxr,String cslx,String f_xkzh,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        List<String> sqls = new ArrayList<>();
        String result = null;
        try {
            String sql=" select MAX(f_csbm) from tb"+f_shbm+"_Csda";
            String maxBm=sqlOperator.queryOneRecorderData(sql);
            int bmlen=6;
            if(maxBm == null || "".equals(maxBm)){
                maxBm = "000000";
            }
            int bm=Integer.parseInt(maxBm)+1;
            String f_csbm=String.valueOf(bm);
            while(f_csbm.length()<bmlen){
                f_csbm = "0" + f_csbm;
            }
            String zjf = WordToPinYin.converterToFirstSpell(f_khmc);
            if("1".equals(cslx)){
                sql = "insert into tb"+f_shbm+"_csda(f_cslx,f_Csbm,f_Csmc,f_Zjf,f_dh,f_sfzh,f_qybm,f_jb,f_dz,f_Bzxx,f_Scxkzh)values" +
                        "('"+cslx+"','"+f_csbm+"','"+f_khmc+"','"+zjf+"','"+f_sjhm+"','"+f_sfzh+"','"+f_qydz+"','1','"+f_xxdz+"','"+f_bzxx+"','"+f_xkzh+"')";
            }else if("0".equals(cslx)){
                sql = "insert into tb"+f_shbm+"_csda(f_cslx,f_Csbm,f_Csmc,f_Zjf,f_dh,f_Lxr,f_qybm,f_jb,f_dz,f_Bzxx,f_Scxkzh)values" +
                        "('"+cslx+"','"+f_csbm+"','"+f_khmc+"','"+zjf+"','"+f_sjhm+"','"+f_lxr+"','"+f_qydz+"','1','"+f_xxdz+"','"+f_bzxx+"','"+f_xkzh+"')";
            }

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
    public String AddKhdaNew(String f_khmc, String f_sjhm, String f_sfzh, String f_qydz,
                             String f_Dz,String f_Khh,String f_Yhkh,String f_Tyxym,String f_Sfjzps,String f_Khlx,
                             String f_bzxx,String f_lxr,String cslx,String f_xkzh,String flbms,String sls,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        List<String> sqls = new ArrayList<>();
        String result = null;
        try {
            String sql=" select MAX(f_csbm) from tb"+f_shbm+"_Csda";
            String maxBm=sqlOperator.queryOneRecorderData(sql);
            int bmlen=6;
            if(maxBm == null || "".equals(maxBm)){
                maxBm = "000000";
            }
            int bm=Integer.parseInt(maxBm)+1;
            String f_csbm=String.valueOf(bm);
            while(f_csbm.length()<bmlen){
                f_csbm = "0" + f_csbm;
            }
            String zjf = WordToPinYin.converterToFirstSpell(f_khmc);
            //客户
            if("1".equals(cslx)){   //其它版
                if (f_Sfjzps == null || f_Sfjzps.equals("") || f_Khlx == null || f_Khlx.equals("")){
                    //厂商档案插数据
                    sql = "insert into tb"+f_shbm+"_csda(f_cslx,f_Csbm,f_Csmc,f_Zjf,f_dh,f_sfzh,f_qybm,f_jb,f_Bzxx,f_Scxkzh,f_Dz,f_Khh,f_Yhkh,f_Tyxym,\n" +
                            "f_Yzbm,f_Cz,f_Http,f_Email,f_Zh,f_Sh,f_Zczb,f_Fr,f_Lxr,f_Lx,f_Mj,f_Jzzq,f_Xydj,f_Yyzzdqr,f_Swdjdqr,f_Wsykdqr,\n" +
                            "f_Jszq,f_Dj,f_yfk,f_Sfqy,f_c_col1,f_c_col2,f_c_col3,f_f_col1,f_f_col2,f_f_col3)values" +
                            "('"+cslx+"','"+f_csbm+"','"+f_khmc+"','"+zjf+"','"+f_sjhm+"','"+f_sfzh+"','"+f_qydz+"','1','"+f_bzxx+"','"+f_xkzh+"','"+f_Dz+"','"+f_Khh+"','"+f_Yhkh+"','"+f_Tyxym+"',\n" +
                            "'','','','','','',0,'','',0,1,30,'','','','','','',0,1,'','','',0,0,0)";
                    sqls.add(sql);
                }else {     //常熟、江阴、太仓版
                    //厂商档案插数据
                    sql = "insert into tb"+f_shbm+"_csda(f_cslx,f_Csbm,f_Csmc,f_Zjf,f_dh,f_sfzh,f_qybm,f_jb,f_Bzxx,f_Scxkzh,f_Dz,f_Khh,f_Yhkh,f_Tyxym,f_Sfjzps,f_Khlx,\n" +
                            "f_Yzbm,f_Cz,f_Http,f_Email,f_Zh,f_Sh,f_Zczb,f_Fr,f_Lxr,f_Lx,f_Mj,f_Jzzq,f_Xydj,f_Yyzzdqr,f_Swdjdqr,f_Wsykdqr,\n" +
                            "f_Jszq,f_Dj,f_yfk,f_Sfqy,f_c_col1,f_c_col2,f_c_col3,f_f_col1,f_f_col2,f_f_col3)values" +
                            "('"+cslx+"','"+f_csbm+"','"+f_khmc+"','"+zjf+"','"+f_sjhm+"','"+f_sfzh+"','"+f_qydz+"','1','"+f_bzxx+"','"+f_xkzh+"','"+f_Dz+"','"+f_Khh+"','"+f_Yhkh+"','"+f_Tyxym+"','"+f_Sfjzps+"','"+f_Khlx+"',\n" +
                            "'','','','','','',0,'','',0,1,30,'','','','','','',0,1,'','','',0,0,0)";
                    sqls.add(sql);
                    //判断客户类型是农户、大户还是合作社
                    String flbm = "";
                    String khlx = "";
                    if (f_Khlx.equals("0")){
                        khlx = "f_sfsynh";
                    } else if (f_Khlx.equals("1")){
                        khlx = "f_sfsydh";
                    } else if (f_Khlx.equals("2")){
                        khlx = "f_sfsyhzs";
                    }
                    //厂商统计明细对照表插数据
                    sql = "select tjmx.f_flbm,tjmx.f_flmc\n" +
                            "from tb"+f_shbm+"_tjmxwh tjmx \n" +
                            "left join tb"+f_shbm+"_tjlxwh tjlx on tjmx.f_flbm like tjlx.f_flbm+'%'\n" +
                            "where tjmx.f_mj = '1' and "+khlx+" = '1'";
                    String flbmList = sqlOperator.RunSQL_JSON(sql);
                    JSONArray flbmJson = new JSONArray(flbmList);
                    for (int i = 0; i < flbmJson.length(); i++){
                        flbm = flbmJson.getJSONObject(i).getString("F_FLBM");
                        sql = "insert into tb"+f_shbm+"_cstjmxdzb(f_Csbm,f_flbm)values('"+f_csbm+"','"+flbm+"')";
                        sqls.add(sql);
                    }

                    if (flbms != null && !flbms.equals("") && sls != null && !sls.equals("")){
                        //修改数量
                        String[] flbmsList = flbms.split(",");
                        String[] slsList = sls.split(",");
                        for (int i = 0; i < flbmsList.length; i++){
                            String f_flbm = flbmsList[i];
                            int sl = Integer.parseInt(slsList[i]);
                            sql = "update tb"+f_shbm+"_cstjmxdzb set f_sl='"+sl+"' where f_flbm='"+f_flbm+"' and f_Csbm='"+f_csbm+"'";
                            sqls.add(sql);
                        }
                    }
                }
            }else if("0".equals(cslx)){ //供应商
                sql = "insert into tb"+f_shbm+"_csda(f_cslx,f_Csbm,f_Csmc,f_Zjf,f_dh,f_Lxr,f_qybm,f_jb,f_Bzxx,f_Scxkzh)values" +
                        "('"+cslx+"','"+f_csbm+"','"+f_khmc+"','"+zjf+"','"+f_sjhm+"','"+f_lxr+"','"+f_qydz+"','1','"+f_bzxx+"','"+f_xkzh+"')";
                sqls.add(sql);
            }
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
    public String getKhda(String khxx,String cslx,Integer pageIndex,Integer pageSize,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            //查厂商档案
            String sql = "select shda.f_lxbm,csda.f_Csbm,csda.f_Csmc,csda.f_dh,csda.f_sfzh,csda.f_qybm,csda.f_Bzxx,csda.f_Dz,csda.f_Lxr,csda.f_jb,csda.f_Scxkzh,csda.f_Khh,csda.f_Yhkh,csda.f_Tyxym,csda.f_Sfjzps,csda.f_Khlx \n" +
                    "from tb"+f_shbm+"_csda csda\n" +
                    "left join tbShda shda on shda.f_shbm='"+f_shbm+"'";
            if(!"".equals(cslx)){
                sql += " where f_Cslx = '"+cslx+"'";
                if(!khxx.equals("")){
                    sql+=" and (f_csmc like '%"+khxx+"%' or f_csbm like '%"+khxx+"%' or csda.f_Zjf like '%"+khxx+"%')";
                }
            }
            if(pageIndex != null && pageSize != null){
                int start = (pageIndex - 1) * pageSize + 1;
                int end = pageIndex * pageSize;
                String fySql="select * from (select ROW_NUMBER()over (order by f_Csmc) as rowno,* from ( ";
                fySql+=sql;
                fySql+=" )p)m where rowno>="+Integer.toString(start)+" and rowno<="+Integer.toString(end);
                result = sqlOperator.RunSQL_JSON(fySql);
            }else{
                result = sqlOperator.RunSQL_JSON(sql);
            }
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
    public String getKhda_total(String khxx, String cslx, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "select COUNT(*) from tb"+f_shbm+"_csda";
            if(!"".equals(cslx)){
                sql += " where f_Cslx = '"+cslx+"'";
                if(!khxx.equals("")){
                    sql+=" and (f_csmc like '%"+khxx+"%' or f_csbm like '%"+khxx+"%' or f_Zjf like '%"+khxx+"%')";
                }
            }

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

    public String DeleteKhda(String f_csbm, HttpServletRequest request){
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        List sqls = new ArrayList<>();
        String sql= "";
        String result = null;
        try {
            sql="delete from tb"+f_shbm+"_csda where f_Csbm='"+f_csbm+"'";
            sqls.add(sql);
            sql="delete from tb"+f_shbm+"_cstjmxdzb where f_Csbm='"+f_csbm+"'";
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

    /**
     * 获取统计类型信息
     * @param request
     * @return
     */
    public String getTjlxxx(HttpServletRequest request){
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql="select * from tb"+f_shbm+"_tjlxwh order by f_flbm";
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

    /**
     * 查询最大角色编码+1
     * @param request
     * @return
     */
    public String queryMaxFlbm(HttpServletRequest request){
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;

        try {
            String sql = "select max(f_flbm) from tb"+f_shbm+"_tjlxwh";
            result = sqlOperator.queryOneRecorderData(sql);

            if (result == null){
                result = "001";
            }else{
                result = String.format("%3d",Integer.parseInt(result)+1).replace(" ","0");
            }
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return result;
    }

    /**
     * 保存新增类型
     * @param f_tjlxmc
     * @param f_flbm
     * @param f_sfzylx
     * @param f_sfsynh
     * @param f_sfsydh
     * @param f_sfsyhzs
     * @param request
     * @return
     */
    public String addlx(String f_tjlxmc, String f_flbm, String f_sfzylx, String f_sfsynh, String f_sfsydh, String f_sfsyhzs, HttpServletRequest request){
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            List sqls = new ArrayList<>();
            String sql = "";

            if("".equals(f_tjlxmc) || f_tjlxmc == null || "".equals(f_sfzylx) || f_sfzylx == null || "".equals(f_sfsynh) || f_sfsynh == null|| "".equals(f_sfsydh) || f_sfsydh == null|| "".equals(f_sfsyhzs) || f_sfsyhzs == null){
                System.out.println("新增类型信息不能为空！");
                return "405";
            } else {
                sql = "insert into tb"+f_shbm+"_tjlxwh(f_tjlxmc,f_flbm,f_sfzylx,f_sfsynh,f_sfsydh,f_sfsyhzs) values('"+f_tjlxmc+"','"+f_flbm+"','0','"+f_sfsynh+"','"+f_sfsydh+"','"+f_sfsyhzs+"');";
                sqls.add(sql);
                sql = "insert into tb"+f_shbm+"_tjmxwh(f_flbm,f_flmc,f_flmx,f_jb,f_mj)values('"+f_flbm+"','"+f_tjlxmc+"','0','1','1')";
                sqls.add(sql);

                if (f_sfsynh.equals("1")){
                    //查询厂商编码
                    sql = "select f_Csbm from tb"+f_shbm+"_csda where f_Khlx='0'";
                    String csbmList = sqlOperator.RunSQL_JSON(sql);
                    JSONArray csbmJarr = new JSONArray(csbmList);
                    for (int i = 0; i < csbmJarr.length(); i++){
                        JSONObject csbmObj = csbmJarr.getJSONObject(i);
                        String csbm = csbmObj.getString("F_CSBM");
                        sql ="insert into tb"+f_shbm+"_cstjmxdzb(f_Csbm,f_flbm)values('"+csbm+"','"+f_flbm+"')";
                        sqls.add(sql);
                    }

                    if (f_sfzylx.equals("1")){
                        sql = "select * from tb"+f_shbm+"_tjlxwh where f_sfzylx='1' and f_sfsynh='1'";
                        String tjlx = sqlOperator.RunSQL_JSON(sql);
                        if (tjlx == null || tjlx.equals("") || tjlx.equals("[]")){
                            //将是否种养类型改为1
                            sql = "update tb"+f_shbm+"_tjlxwh set f_sfzylx='1' where f_flbm='"+f_flbm+"'";
                            sqls.add(sql);
                        }else {
                            return "408";
                        }
                    }
                }
                if (f_sfsydh.equals("1")){
                    //查询厂商编码
                    sql = "select f_Csbm from tb"+f_shbm+"_csda where f_Khlx='1'";
                    String csbmList = sqlOperator.RunSQL_JSON(sql);
                    JSONArray csbmJarr = new JSONArray(csbmList);
                    for (int i = 0; i < csbmJarr.length(); i++){
                        JSONObject csbmObj = csbmJarr.getJSONObject(i);
                        String csbm = csbmObj.getString("F_CSBM");
                        sql ="insert into tb"+f_shbm+"_cstjmxdzb(f_Csbm,f_flbm)values('"+csbm+"','"+f_flbm+"')";
                        sqls.add(sql);
                    }

                    if (f_sfzylx.equals("1")){
                        sql = "select * from tb"+f_shbm+"_tjlxwh where f_sfzylx='1' and f_sfsydh='1'";
                        String tjlx = sqlOperator.RunSQL_JSON(sql);
                        if (tjlx == null || tjlx.equals("") || tjlx.equals("[]")){
                            sql = "update tb"+f_shbm+"_tjlxwh set f_sfzylx='1' where f_flbm='"+f_flbm+"'";
                            sqls.add(sql);
                        }else {
                            return "408";
                        }
                    }
                }
                if (f_sfsyhzs.equals("1")){
                    //查询厂商编码
                    sql = "select f_Csbm from tb"+f_shbm+"_csda where f_Khlx='2'";
                    String csbmList = sqlOperator.RunSQL_JSON(sql);
                    JSONArray csbmJarr = new JSONArray(csbmList);
                    for (int i = 0; i < csbmJarr.length(); i++){
                        JSONObject csbmObj = csbmJarr.getJSONObject(i);
                        String csbm = csbmObj.getString("F_CSBM");
                        sql ="insert into tb"+f_shbm+"_cstjmxdzb(f_Csbm,f_flbm)values('"+csbm+"','"+f_flbm+"')";
                        sqls.add(sql);
                    }

                    if (f_sfzylx.equals("1")){
                        sql = "select * from tb"+f_shbm+"_tjlxwh where f_sfzylx='1' and f_sfsyhzs='1'";
                        String tjlx = sqlOperator.RunSQL_JSON(sql);
                        if (tjlx == null || tjlx.equals("") || tjlx.equals("[]")){
                            sql = "update tb"+f_shbm+"_tjlxwh set f_sfzylx='1' where f_flbm='"+f_flbm+"'";
                            sqls.add(sql);
                        }else {
                            return "408";
                        }
                    }
                }

                if (!f_sfsynh.equals("1") && !f_sfsydh.equals("1") && !f_sfsyhzs.equals("1") && f_sfzylx.equals("1")){
                    return "410";
                }
                sqlOperator.ExecSql(sqls);

                sqls = new ArrayList<>();
                //查询分类编码下所有分类编码
                sql = "select f_flbm from tb"+f_shbm+"_tjmxwh where f_flbm like '"+f_flbm+"%'";
                String flbmList = sqlOperator.RunSQL_JSON(sql);
                JSONArray flbmJarr = new JSONArray(flbmList);
                if (f_sfsynh.equals("1")){
                    if (f_sfzylx.equals("1")){
                        sql = "select * from tb"+f_shbm+"_tjlxwh where f_sfzylx='1' and f_sfsynh='1'";
                        String tjlx = sqlOperator.RunSQL_JSON(sql);
                        if (tjlx != null && !tjlx.equals("") & !tjlx.equals("[]")){
                            //厂商类型补贴标准表中插入数据
                            for (int i = 0; i < flbmJarr.length(); i++){
                                JSONObject flbmObj = flbmJarr.getJSONObject(i);
                                String flbm = flbmObj.getString("F_FLBM");
                                sql ="insert into tb"+f_shbm+"_cslxbtbz(f_flbm,f_Khlx) values('"+flbm+"','0')";
                                sqls.add(sql);
                            }
                        }
                    }
                }
                if (f_sfsydh.equals("1")){
                    if (f_sfzylx.equals("1")){
                        sql = "select * from tb"+f_shbm+"_tjlxwh where f_sfzylx='1' and f_sfsydh='1'";
                        String tjlx = sqlOperator.RunSQL_JSON(sql);
                        if (tjlx != null && !tjlx.equals("") & !tjlx.equals("[]")){
                            //厂商类型补贴标准表中插入数据
                            for (int i = 0; i < flbmJarr.length(); i++){
                                JSONObject flbmObj = flbmJarr.getJSONObject(i);
                                String flbm = flbmObj.getString("F_FLBM");
                                sql ="insert into tb"+f_shbm+"_cslxbtbz(f_flbm,f_Khlx) values('"+flbm+"','1')";
                                sqls.add(sql);
                            }
                        }
                    }

                }
                if (f_sfsyhzs.equals("1")){
                    if (f_sfzylx.equals("1")){
                        sql = "select * from tb"+f_shbm+"_tjlxwh where f_sfzylx='1' and f_sfsyhzs='1'";
                        String tjlx = sqlOperator.RunSQL_JSON(sql);
                        if (tjlx != null && !tjlx.equals("") & !tjlx.equals("[]")){
                            //厂商类型补贴标准表中插入数据
                            for (int i = 0; i < flbmJarr.length(); i++){
                                JSONObject flbmObj = flbmJarr.getJSONObject(i);
                                String flbm = flbmObj.getString("F_FLBM");
                                sql ="insert into tb"+f_shbm+"_cslxbtbz(f_flbm,f_Khlx) values('"+flbm+"','2')";
                                sqls.add(sql);
                            }
                        }
                    }
                }
                sqlOperator.ExecSql(sqls);
                result = "ok";
            }
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
     * 修改新增类型
     * @param tjlxmc
     * @param flbm
     * @param sfzylx
     * @param sfsynh
     * @param sfsydh
     * @param sfsyhzs
     * @param request
     * @return
     */
    public String updateLx(String tjlxmc, String flbm, String sfzylx, String sfsynh, String sfsydh, String sfsyhzs, HttpServletRequest request){
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            List sqls = new ArrayList<>();
            String sql = "";

            if("".equals(tjlxmc) || tjlxmc == null){
                result = "406";
                System.out.println("请输入统计类型！");
            } else {
                sql = "update tb"+f_shbm+"_tjlxwh set f_tjlxmc='"+tjlxmc+"',f_sfsynh='"+sfsynh+"',f_sfsydh='"+sfsydh+"',f_sfsyhzs='"+sfsyhzs+"' where f_flbm='"+flbm+"';";
                sqls.add(sql);
                sql = "update tb"+f_shbm+"_tjmxwh set f_flmc='"+tjlxmc+"' where f_flbm='"+flbm+"'";
                sqls.add(sql);


                //类型为农户
                if (sfsynh.equals("1")){
                    sql = "select f_Csbm from tb"+f_shbm+"_csda where f_Khlx='0'";
                    String csbmList = sqlOperator.RunSQL_JSON(sql);
                    JSONArray csbmJarr = new JSONArray(csbmList);
                    for (int i = 0; i < csbmJarr.length(); i++){
                        JSONObject csbmObj = csbmJarr.getJSONObject(i);
                        String csbm = csbmObj.getString("F_CSBM");
                        sql ="insert into tb"+f_shbm+"_cstjmxdzb(f_Csbm,f_flbm)values('"+csbm+"','"+flbm+"')";
                        sqls.add(sql);
                    }

                }else {
                    sql = "select * from tb"+f_shbm+"_cstjmxdzb where f_flbm='"+flbm+"'";
                    String cstjmxResult = sqlOperator.RunSQL_JSON(sql);
                    if (cstjmxResult != null && !cstjmxResult.equals("") && !cstjmxResult.equals("[]")){
                        sql = "delete from tb"+f_shbm+"_cstjmxdzb where f_flbm='"+flbm+"'";
                        sqls.add(sql);
                    }
                }

                //类型为大户
                if (sfsydh.equals("1")){
                    sql = "select f_Csbm from tb"+f_shbm+"_csda where f_Khlx='1'";
                    String csbmList = sqlOperator.RunSQL_JSON(sql);
                    JSONArray csbmJarr = new JSONArray(csbmList);
                    for (int i = 0; i < csbmJarr.length(); i++){
                        JSONObject csbmObj = csbmJarr.getJSONObject(i);
                        String csbm = csbmObj.getString("F_CSBM");
                        sql ="insert into tb"+f_shbm+"_cstjmxdzb(f_Csbm,f_flbm)values('"+csbm+"','"+flbm+"')";
                        sqls.add(sql);
                    }

                }else {
                    sql = "select * from tb"+f_shbm+"_cstjmxdzb where f_flbm='"+flbm+"'";
                    String cstjmxResult = sqlOperator.RunSQL_JSON(sql);
                    if (cstjmxResult != null && !cstjmxResult.equals("") && !cstjmxResult.equals("[]")){
                        sql = "delete from tb"+f_shbm+"_cstjmxdzb where f_flbm='"+flbm+"'";
                        sqls.add(sql);
                    }
                }

                //类型为合作社
                if (sfsyhzs.equals("1")){
                    sql = "select f_Csbm from tb"+f_shbm+"_csda where f_Khlx='2'";
                    String csbmList = sqlOperator.RunSQL_JSON(sql);
                    JSONArray csbmJarr = new JSONArray(csbmList);
                    for (int i = 0; i < csbmJarr.length(); i++){
                        JSONObject csbmObj = csbmJarr.getJSONObject(i);
                        String csbm = csbmObj.getString("F_CSBM");
                        sql ="insert into tb"+f_shbm+"_cstjmxdzb(f_Csbm,f_flbm)values('"+csbm+"','"+flbm+"')";
                        sqls.add(sql);
                    }

                }else {
                    sql = "select * from tb"+f_shbm+"_cstjmxdzb where f_flbm='"+flbm+"'";
                    String cstjmxResult = sqlOperator.RunSQL_JSON(sql);
                    if (cstjmxResult != null && !cstjmxResult.equals("") && !cstjmxResult.equals("[]")){
                        sql = "delete from tb"+f_shbm+"_cstjmxdzb where f_flbm='"+flbm+"'";
                        sqls.add(sql);
                    }
                }

                if ((!sfsynh.equals("1") && !sfsydh.equals("1") && !sfsyhzs.equals("1")) || !sfzylx.equals("1")){
                    sql = "update tb"+f_shbm+"_tjlxwh set f_sfzylx='0' where f_flbm='"+flbm+"'";
                    sqls.add(sql);
                }

                if (!sfsynh.equals("1") && !sfsydh.equals("1") && !sfsyhzs.equals("1") && sfzylx.equals("1")){
                    return "411";
                }

                sqlOperator.ExecSql(sqls);

                sqls = new ArrayList<>();
                //查询分类编码下所有分类编码
                sql = "select f_flbm from tb"+f_shbm+"_tjmxwh where f_flbm like '"+flbm+"%'";
                String flbmList = sqlOperator.RunSQL_JSON(sql);
                JSONArray flbmJarr = new JSONArray(flbmList);
                if (sfzylx.equals("1")){
                    if (sfsynh.equals("1")){
                        //厂商类型补贴标准表中插入数据
                        for (int i = 0; i < flbmJarr.length(); i++){
                            JSONObject flbmObj = flbmJarr.getJSONObject(i);
                            String yjflbm = flbmObj.getString("F_FLBM");
                            sql = "select * from tb"+f_shbm+"_cslxbtbz where f_flbm='"+yjflbm+"' and f_Khlx='0'";
                            String isnullBtbz = sqlOperator.RunSQL_JSON(sql);
                            if (isnullBtbz == null || isnullBtbz.equals("") || isnullBtbz.equals("[]")){
                                sql ="insert into tb"+f_shbm+"_cslxbtbz(f_flbm,f_Khlx) values('"+yjflbm+"','0')";
                                sqls.add(sql);
                            }
                        }

                        sql = "update tb"+f_shbm+"_tjlxwh set f_sfzylx='1' where f_flbm='"+flbm+"'";
                        sqls.add(sql);
                    } else if (sfsynh.equals("0")) {
                        sql ="delete tb"+f_shbm+"_cslxbtbz where f_flbm like '"+flbm+"%' and f_Khlx='0'";
                        sqls.add(sql);
                    }

                    if (sfsydh.equals("1")){
                        //厂商类型补贴标准表中插入数据
                        for (int i = 0; i < flbmJarr.length(); i++){
                            JSONObject flbmObj = flbmJarr.getJSONObject(i);
                            String yjflbm = flbmObj.getString("F_FLBM");
                            sql = "select * from tb"+f_shbm+"_cslxbtbz where f_flbm='"+yjflbm+"' and f_Khlx='1'";
                            String isnullBtbz = sqlOperator.RunSQL_JSON(sql);
                            if (isnullBtbz == null || isnullBtbz.equals("") || isnullBtbz.equals("[]")){
                                sql ="insert into tb"+f_shbm+"_cslxbtbz(f_flbm,f_Khlx) values('"+yjflbm+"','1')";
                                sqls.add(sql);
                            }
                        }

                        sql = "update tb"+f_shbm+"_tjlxwh set f_sfzylx='1' where f_flbm='"+flbm+"'";
                        sqls.add(sql);
                    }else if (sfsydh.equals("0")) {
                        sql ="delete tb"+f_shbm+"_cslxbtbz where f_flbm like '"+flbm+"%' and f_Khlx='1'";
                        sqls.add(sql);
                    }

                    if (sfsyhzs.equals("1")){
                        //厂商类型补贴标准表中插入数据
                        for (int i = 0; i < flbmJarr.length(); i++){
                            JSONObject flbmObj = flbmJarr.getJSONObject(i);
                            String yjflbm = flbmObj.getString("F_FLBM");
                            sql = "select * from tb"+f_shbm+"_cslxbtbz where f_flbm='"+yjflbm+"' and f_Khlx='2'";
                            String isnullBtbz = sqlOperator.RunSQL_JSON(sql);
                            if (isnullBtbz == null || isnullBtbz.equals("") || isnullBtbz.equals("[]")){
                                sql ="insert into tb"+f_shbm+"_cslxbtbz(f_flbm,f_Khlx) values('"+yjflbm+"','2')";
                                sqls.add(sql);
                            }
                        }

                        sql = "update tb"+f_shbm+"_tjlxwh set f_sfzylx='1' where f_flbm='"+flbm+"'";
                        sqls.add(sql);
                    }else if (sfsyhzs.equals("0")) {
                        sql ="delete tb"+f_shbm+"_cslxbtbz where f_flbm like '"+flbm+"%' and f_Khlx='2'";
                        sqls.add(sql);
                    }
                }else{
                    //厂商类型补贴标准表中删除数据
                    sql ="delete tb"+f_shbm+"_cslxbtbz where f_flbm like '"+flbm+"%'";
                    sqls.add(sql);

                    sql = "update tb"+f_shbm+"_tjlxwh set f_sfzylx='0' where f_flbm='"+flbm+"'";
                    sqls.add(sql);
                }

                sqlOperator.ExecSql(sqls);
                result = "ok";
            }
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
     * 保存删除类型
     * @param flbm
     * @param request
     * @return
     */
    public String deleteLx(String flbm, HttpServletRequest request){
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            List sqls = new ArrayList<>();
            String sql = "";

            if("".equals(flbm) || flbm == null){
                result = "407";
                System.out.println("分类编码为空！");
            } else {
                sql = "delete from tb"+f_shbm+"_tjlxwh where f_flbm='"+flbm+"'";
                sqls.add(sql);
                sql = "delete from tb"+f_shbm+"_tjmxwh where f_flbm like '"+flbm+"%'";
                sqls.add(sql);
                sql = "delete from tb"+f_shbm+"_cstjmxdzb where f_flbm like '"+flbm+"%'";
                sqls.add(sql);

                //厂商类型补贴标准表中删除数据
                sql ="select * from tb"+f_shbm+"_cslxbtbz where f_flbm='"+flbm+"'";
                String btbzList = sqlOperator.RunSQL_JSON(sql);
                if (btbzList != null && !btbzList.equals("") && !btbzList.equals("[]")){
                    sql ="delete tb"+f_shbm+"_cslxbtbz where f_flbm like '"+flbm+"%'";
                    sqls.add(sql);
                }
                sqlOperator.ExecSql(sqls);
                result = "ok";
            }
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
     * 获取类型明细
     * @param request
     * @return
     */
    public String getLxmx(HttpServletRequest request){
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql="select * from tb"+f_shbm+"_tjmxwh order by f_flbm";
            String jsonStr = sqlOperator.RunSQL_JSON(sql);
            JSONArray jsonArray = new JSONArray(jsonStr);
            JSONArray resutJson = new JSONArray();
            List<Node> nodes = new ArrayList<>();
            for (int i = 0 ; i<jsonArray.length(); i++){
                JSONObject json = jsonArray.getJSONObject(i);
                Integer jb = Integer.parseInt(json.getString("F_JB"));
                Integer mj = Integer.parseInt(json.getString("F_MJ"));
                Map<String,Object> map = new HashMap<String,Object>();

                Node node = new Node();
                node.setId(json.getString("F_FLBM"));
                if (json.getString("F_DWMC") == null || json.getString("F_DWMC").equals("")){
                    node.setTitle(json.getString("F_FLBM")+" - "+json.getString("F_FLMC"));
                }else {
                    node.setTitle(json.getString("F_FLBM")+" - "+json.getString("F_FLMC")+" ("+json.getString("F_DWMC")+")");
                }

                if(mj == 1){
                    node.setType("item");
                }else{
                    node.setType("folder");
                }
                node.setJb(jb);
                nodes.add(node);
                JSONObject resultJson = new JSONObject(map);
                resutJson.put(resultJson);
            }
            NodeUtil nodeUtil = new NodeUtil();
            result = nodeUtil.NodeTreeByTjmx(nodes);
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
     * 获取统计明细档案
     * @param flbm
     * @param request
     * @return
     */
    public String getTjmxda(String flbm, HttpServletRequest request){
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "";
            if("".equals(flbm)){
                sql = "select * from tb"+f_shbm+"_tjmxwh order by f_flbm";
                result = sqlOperator.RunSQL_JSON(sql);
            }else{
                sql = "select * from tb"+f_shbm+"_tjmxwh where f_flbm = '"+flbm+"' order by f_flbm";
                result = sqlOperator.RunSQL_JSON(sql);
            }
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
     * 获取最大分类编码
     * @param flbm
     * @param jb
     * @param request
     * @return
     */
    public String getMaxtjmx(String flbm, String jb, HttpServletRequest request){
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            if("".equals(flbm)){
                String sql = "select Max(f_flbm) from tb"+f_shbm+"_tjmxwh where f_jb = '1'";
                result = sqlOperator.queryOneRecorderData(sql);
            }else{
                if (jb.equals("2")){
                    String sjflbm = flbm.substring(0,3);
                    String sql = "select Max(f_flbm) from tb"+f_shbm+"_tjmxwh where f_flbm like '"+sjflbm+"%' and f_jb = '"+jb+"'";
                    result = sqlOperator.queryOneRecorderData(sql);
                } else if (jb.equals("3")) {
                    String sjflbm = flbm.substring(0,6);
                    String sql = "select Max(f_flbm) from tb"+f_shbm+"_tjmxwh where f_flbm like '"+sjflbm+"%' and f_jb = '"+jb+"'";
                    result = sqlOperator.queryOneRecorderData(sql);
                }else {
                    String sql = "select Max(f_flbm) from tb"+f_shbm+"_tjmxwh where f_flbm like '"+flbm+"%' and f_jb = '"+jb+"'";
                    result = sqlOperator.queryOneRecorderData(sql);
                }
            }

            if(result == null){
                result = flbm+"001";
            }else{
                switch (jb){
                    case "1":
                        result = String.format("%3d",(Integer.parseInt(result)+1)).replace(" ","0");
                        break;
                    case "2":
                        result = String.format("%6d",(Integer.parseInt(result)+1)).replace(" ","0");
                        break;
                    case "3":
                        result = String.format("%9d",(Integer.parseInt(result)+1)).replace(" ","0");
                        break;
                }
            }
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
     * 保存统计明细档案
     * @param flbm
     * @param flmc
     * @param flmx
     * @param jb
     * @param mj
     * @param request
     * @return
     */
    public String saveTjmxda(String flbm, String flmc, String flmx, String jb, String mj,String dwmc, HttpServletRequest request){
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        List<String> sqls = new ArrayList<>();

        String result = null;
        try {
            //根据分类编码查询统计明细维护
            String sql = "select * from tb"+f_shbm+"_tjmxwh where f_flbm = '"+flbm+"'";
            String temp = sqlOperator.RunSQL_JSON(sql);

            //查询有结果，修改
            if(temp != null && !"".equals(temp) && !"[]".equals(temp)){
                sql = "update tb"+f_shbm+"_tjmxwh set f_flmc = '"+flmc+"',f_flmx = '"+flmx+"' where f_flbm = '"+flbm+"' ";
                sqls.add(sql);
                sql = "update tb"+f_shbm+"_tjlxwh set f_tjlxmc = '"+flmc+"' where f_flbm = '"+flbm+"' ";
                sqls.add(sql);
                if (jb.equals("2")){
                    sql = "update tb"+f_shbm+"_tjmxwh set f_dwmc = '"+dwmc+"' where f_flbm = '"+flbm+"' ";
                    sqls.add(sql);
                }
            }else{
                //查询无结果，插入数据
                if (jb.equals("1")){
                    sql = "insert into tb"+f_shbm+"_tjmxwh(f_flbm,f_flmc,f_flmx,f_jb,f_mj,f_dwmc) " +
                            "values('"+flbm+"','"+flmc+"','"+flmx+"','"+jb+"','"+mj+"','')";
                    sqls.add(sql);
                    sql = "insert into tb"+f_shbm+"_tjlxwh(f_tjlxmc,f_flbm,f_sfzylx,f_sfsynh,f_sfsydh,f_sfsyhzs) " +
                            "values('"+flmc+"','"+flbm+"','0','0','0','0')";
                    sqls.add(sql);
                } else if (jb.equals("2")){
                    //查询该分类编码有没有数据
                    sql = "select * from tb"+f_shbm+"_cstjmxdzb where f_flbm='"+flbm+"'";
                    String cstjmx = sqlOperator.RunSQL_JSON(sql);
                    String sjflbm = flbm.substring(0,3);
                    //通过上级分类编码查询获得所有厂商编码
                    sql = "select * from tb"+f_shbm+"_cstjmxdzb where f_flbm='"+sjflbm+"'";
                    String csbmList = sqlOperator.RunSQL_JSON(sql);
                    JSONArray csbmJarr = new JSONArray(csbmList);
                    for (int i = 0; i < csbmJarr.length(); i++){
                        String csbm = csbmJarr.getJSONObject(i).getString("F_CSBM");
                        if (cstjmx == null || cstjmx.equals("") || cstjmx.equals("[]")){
                            sql ="insert into tb"+f_shbm+"_cstjmxdzb(f_Csbm,f_flbm)values('"+csbm+"','"+flbm+"')";
                            sqls.add(sql);
                        }else {
                            sql ="update tb"+f_shbm+"_cstjmxdzb set f_Csbm='"+csbm+"',f_flbm='"+flbm+"'";
                            sqls.add(sql);
                        }
                    }
                    sql = "update tb"+f_shbm+"_tjmxwh set f_mj='0' where f_flbm='"+sjflbm+"'";
                    sqls.add(sql);
                    sql = "insert into tb"+f_shbm+"_tjmxwh(f_flbm,f_flmc,f_flmx,f_jb,f_mj,f_dwmc) " +
                            "values('"+flbm+"','"+flmc+"','"+flmx+"','"+jb+"','"+mj+"','"+dwmc+"')";
                    sqls.add(sql);
                }else {
                    //查询该分类编码有没有数据
                    sql = "select * from tb"+f_shbm+"_cstjmxdzb where f_flbm='"+flbm+"'";
                    String cstjmx = sqlOperator.RunSQL_JSON(sql);
                    String sjflbm = flbm.substring(0,6);
                    //通过上级分类编码查询获得所有厂商编码
                    sql = "select * from tb"+f_shbm+"_cstjmxdzb where f_flbm='"+sjflbm+"'";
                    String csbmList = sqlOperator.RunSQL_JSON(sql);
                    JSONArray csbmJarr = new JSONArray(csbmList);
                    for (int i = 0; i < csbmJarr.length(); i++){
                        String csbm = csbmJarr.getJSONObject(i).getString("F_CSBM");
                        if (cstjmx == null || cstjmx.equals("") || cstjmx.equals("[]")){
                            sql ="insert into tb"+f_shbm+"_cstjmxdzb(f_Csbm,f_flbm)values('"+csbm+"','"+flbm+"')";
                            sqls.add(sql);
                        }else {
                            sql ="update tb"+f_shbm+"_cstjmxdzb set f_Csbm='"+csbm+"',f_flbm='"+flbm+"'";
                            sqls.add(sql);
                        }
                    }
                    sql = "update tb"+f_shbm+"_tjmxwh set f_mj='0' where f_flbm='"+sjflbm+"'";
                    sqls.add(sql);
                    sql = "insert into tb"+f_shbm+"_tjmxwh(f_flbm,f_flmc,f_flmx,f_jb,f_mj,f_dwmc) " +
                            "values('"+flbm+"','"+flmc+"','"+flmx+"','"+jb+"','"+mj+"','')";
                    sqls.add(sql);
                }


                //查询该分类编码最上级，并且是否种养类型是否为1。
                String flbmzsj = flbm.substring(0,3);
                sql = "select f_flbm from tb"+f_shbm+"_tjlxwh where f_flbm='"+flbmzsj+"' and f_sfzylx='1'";
                String tempResult = sqlOperator.queryOneRecorderData(sql);
                //如果存在，将分类编码和客户类型存入厂商类型补贴标准表
                if (tempResult != null && !tempResult.equals("") && !tempResult.equals("[]")){
                    sql = "select * from tb"+f_shbm+"_tjlxwh where f_flbm='"+flbmzsj+"'";
                    String temlTjlx = sqlOperator.RunSQL_JSON(sql);
                    JSONArray tjlxJarr = new JSONArray(temlTjlx);
                    JSONObject tjlxObj = tjlxJarr.getJSONObject(0);
                    String nhVal = tjlxObj.getString("F_SFSYNH");
                    String dhVal = tjlxObj.getString("F_SFSYDH");
                    String hzsVal = tjlxObj.getString("F_SFSYHZS");

                    if (nhVal.equals("1")){
                        sql ="insert into tb"+f_shbm+"_cslxbtbz(f_flbm,f_Khlx) values('"+flbm+"','0')";
                        sqls.add(sql);
                    }
                    if (dhVal.equals("1")){
                        sql ="insert into tb"+f_shbm+"_cslxbtbz(f_flbm,f_Khlx) values('"+flbm+"','1')";
                        sqls.add(sql);
                    }
                    if (hzsVal.equals("1")){
                        sql ="insert into tb"+f_shbm+"_cslxbtbz(f_flbm,f_Khlx) values('"+flbm+"','2')";
                        sqls.add(sql);
                    }
                }
            }

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

    /**
     * 删除统计明细档案
     * @param flbm
     * @param jb
     * @param request
     * @return
     */
    public String deleteTjmxda(String flbm,String jb, HttpServletRequest request){
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        List<String> sqls = new ArrayList<>();
        String sql = "";

        String result = null;
        try {
            if(jb.equals("1")){
                sql = "delete from tb"+f_shbm+"_tjmxwh where f_flbm like '"+flbm+"%'";
                sqls.add(sql);
                sql = "delete from tb"+f_shbm+"_tjlxwh where f_flbm='"+flbm+"'";
                sqls.add(sql);
                sql = "delete from tb"+f_shbm+"_cstjmxdzb where f_flbm like '"+flbm+"%'";
                sqls.add(sql);
            } else if (jb.equals("2")) {
                sql = "delete from tb"+f_shbm+"_tjmxwh where f_flbm like '"+flbm+"%'";
                sqlOperator.ExecSQL(sql);
                String dzflbm = flbm.substring(0,4);
                sql = "select * from tb"+f_shbm+"_tjmxwh where f_flbm like '"+dzflbm+"%'";
                String xjflxx = sqlOperator.RunSQL_JSON(sql);
                String sjflbm = flbm.substring(0,3);
                if (xjflxx == null || xjflxx.equals("") || xjflxx.equals("[]")){
                    sql = "update tb"+f_shbm+"_tjmxwh set f_mj='1' where f_flbm='"+sjflbm+"'";
                    sqls.add(sql);
                }
                sql = "delete from tb"+f_shbm+"_cstjmxdzb where f_flbm like '"+flbm+"%'";
                sqls.add(sql);
            }else {
                sql = "delete from tb"+f_shbm+"_tjmxwh where f_flbm='"+flbm+"'";
                sqlOperator.ExecSQL(sql);
                String dzflbm = flbm.substring(0,7);
                sql = "select * from tb"+f_shbm+"_tjmxwh where f_flbm like '"+dzflbm+"%'";
                String xjflxx = sqlOperator.RunSQL_JSON(sql);
                String sjflbm = flbm.substring(0,6);
                if (xjflxx == null || xjflxx.equals("") || xjflxx.equals("[]")){
                    sql = "update tb"+f_shbm+"_tjmxwh set f_mj='1' where f_flbm='"+sjflbm+"'";
                    sqls.add(sql);
                }
                sql = "delete from tb"+f_shbm+"_cstjmxdzb where f_flbm='"+flbm+"'";
                sqls.add(sql);
            }

            //厂商类型补贴标准表中删除数据
            sql ="select * from tb"+f_shbm+"_cslxbtbz where f_flbm='"+flbm+"'";
            String btbzList = sqlOperator.RunSQL_JSON(sql);
            if (btbzList != null && !btbzList.equals("") && !btbzList.equals("[]")){
                sql ="delete tb"+f_shbm+"_cslxbtbz where f_flbm like '"+flbm+"%'";
                sqls.add(sql);
            }

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

    /**
     * 加载厂商统计明细
     * @param request
     * @return
     */
    public String loadcstjmx(String khlx,HttpServletRequest request){
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        String result = null;
        try {
            sql = "select tjmx.f_flbm,tjmx.f_flmc,tjmx.f_jb,tjmx.f_mj,tjmx.f_dwmc\n" +
                    "from tb"+f_shbm+"_tjmxwh tjmx \n" +
                    "left join tb"+f_shbm+"_tjlxwh tjlx on tjmx.f_flbm like tjlx.f_flbm+'%'\n" +
                    "where "+khlx+" = '1' \n" +
                    "order by tjmx.f_flbm";
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
     * 加载客户分类明细具体数量（xxx亩）
     * @param csbm
     * @param request
     * @return
     */
    public String loadsl(String csbm,String khlx, HttpServletRequest request){
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        String result = null;
        try {
            sql = "select dzb.f_Csbm,csda.f_Csmc, dzb.f_flbm,dzb.f_sl,tjmx.f_flmc,tjmx.f_jb,tjmx.f_mj,tjmx.f_dwmc\n" +
                    "from tb"+f_shbm+"_cstjmxdzb dzb\n" +
                    "left join tb"+f_shbm+"_tjmxwh tjmx on dzb.f_flbm=tjmx.f_flbm\n" +
                    "left join tb"+f_shbm+"_Csda csda on csda.f_Csbm=dzb.f_Csbm\n";
            if (csbm != null && !csbm.equals("")){
                sql += "where dzb.f_Csbm='"+csbm+"' " ;
            }
            sql += " and tjmx.f_mj='1' and csda.f_Khlx='"+khlx+"'";
            sql += "order by f_flbm";
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
     * 加载当前客户类型末级明细的序号和名称
     * @param khlx
     * @param request
     * @return
     */
    public String loadmjxh(String khlx, HttpServletRequest request){
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        String result = null;
        try {
            String f_khlx = "";
            if (khlx.equals("0")){
                f_khlx = "f_sfsynh";
            } else if (khlx.equals("1")){
                f_khlx = "f_sfsydh";
            } else if (khlx.equals("2")){
                f_khlx = "f_sfsyhzs";
            }

            sql = "select tjmx.f_flbm,tjmx.f_flmc\n" +
                    "from tb"+f_shbm+"_tjmxwh tjmx \n" +
                    "left join tb"+f_shbm+"_tjlxwh tjlx on tjmx.f_flbm like tjlx.f_flbm+'%'\n" +
                    "where tjmx.f_mj = '1' and "+f_khlx+" = '1'\n" +
                    "order by tjmx.f_flbm";
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
     * 获取补贴基数表格
     * @param khlx
     * @param request
     * @return
     */
    @Override
    public String getBtjsTable(String khlx, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        String result = null;
        try {
            sql = "select btbz.*,tjmx.f_flmc\n" +
                    "from tb"+f_shbm+"_cslxbtbz btbz\n" +
                    "left join tb"+f_shbm+"_tjmxwh tjmx on tjmx.f_flbm=btbz.f_flbm\n" +
                    "where btbz.f_Khlx='"+khlx+"' and tjmx.f_mj='1'\n" +
                    "order by btbz.f_flbm";
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
     * 保存金额
     * @param nhje
     * @param dhje
     * @param hzsje
     * @param nhxh
     * @param dhxh
     * @param hzsxh
     * @param request
     * @return
     */
    @Override
    public String saveJe(String nhje, String dhje, String hzsje,String nhxh,String dhxh,String hzsxh, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        List sqls = new ArrayList<>();
        String result = null;
        try {
            //农户
            if (nhje != null && !nhje.equals("") && nhxh != null && !nhxh.equals("")){
                String[] nhjeList = nhje.split(",");
                String[] nhxhList = nhxh.split(",");
                for (int i = 0; i < nhjeList.length; i++){
                    if (nhjeList[i] == null || nhjeList[i].equals("") || nhjeList[i].equals("0") || nhjeList[i].equals("0.0")){
                        sql = "update tb"+f_shbm+"_cslxbtbz set f_mmje='0' where f_flbm='"+nhxhList[i]+"' and f_Khlx='0'";
                        sqls.add(sql);
                    }else {
                        float je = Float.parseFloat(nhjeList[i]);
                        sql = "update tb"+f_shbm+"_cslxbtbz set f_mmje='"+je+"' where f_flbm='"+nhxhList[i]+"' and f_Khlx='0'";
                        sqls.add(sql);
                    }
                }
            }

            //大户
            if (dhje != null && !dhje.equals("") && dhxh != null && !dhxh.equals("")){
                String[] dhjeList = dhje.split(",");
                String[] dhxhList = dhxh.split(",");
                for (int i = 0; i < dhjeList.length; i++){
                    if (dhjeList[i] == null || dhjeList[i].equals("") || dhjeList[i].equals("0") || dhjeList[i].equals("0.0")){
                        sql = "update tb"+f_shbm+"_cslxbtbz set f_mmje='0' where f_flbm='"+dhxhList[i]+"' and f_Khlx='1'";
                        sqls.add(sql);
                    }else {
                        float je = Float.parseFloat(dhjeList[i]);
                        sql = "update tb"+f_shbm+"_cslxbtbz set f_mmje='"+je+"' where f_flbm='"+dhxhList[i]+"' and f_Khlx='1'";
                        sqls.add(sql);
                    }
                }
            }

            //合作社
            if (hzsje != null && !hzsje.equals("") && hzsxh != null && !hzsxh.equals("")){
                String[] hzsjeList = hzsje.split(",");
                String[] hzsxhList = hzsxh.split(",");
                for (int i = 0; i < hzsjeList.length; i++){
                    if (hzsjeList[i] == null || hzsjeList[i].equals("") || hzsjeList[i].equals("0")){
                        sql = "update tb"+f_shbm+"_cslxbtbz set f_mmje='0' where f_flbm='"+hzsxhList[i]+"' and f_Khlx='2'";
                        sqls.add(sql);
                    }else {
                        float je = Float.parseFloat(hzsjeList[i]);
                        sql = "update tb"+f_shbm+"_cslxbtbz set f_mmje='"+je+"' where f_flbm='"+hzsxhList[i]+"' and f_Khlx='2'";
                        sqls.add(sql);
                    }
                }
            }

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

    /**
     * 展示补贴基数表格中除种养类型选择的内容
     * @param request
     * @return
     */
    @Override
    public String getJyjTable(HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        String result = null;
        try {
            sql = "select * from (select ROW_NUMBER() over(PARTITION BY f_jyjId order by f_jyjId) rownum,f_jyjId,f_jyjName,f_startTime,f_endTime,f_Khlx \n" +
                    "from tb"+f_shbm+"_jyj) a \n" +
                    "where a.rownum='1' \n" +
                    "order By f_jyjId";
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
     * 展示种养类型选择中的数据
     * @param request
     * @return
     */
    @Override
    public String getZylx(int jyjId,int state,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        String result = null;
        try {
            sql = "select jyj.f_flbm,tjmx.f_flmc,jyj.f_Khlx,jyj.f_state \n" +
                    "from tb"+f_shbm+"_jyj jyj \n" +
                    "left join tb"+f_shbm+"_tjmxwh tjmx on jyj.f_flbm=tjmx.f_flbm \n" +
                    "where jyj.f_jyjId='"+jyjId+"' \n";
            if (state == 0 || state == 1){
                sql += " and jyj.f_state='"+state+"' \n";
            }
            sql += "order By jyj.f_jyjId,jyj.f_Khlx,jyj.f_flbm";
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
     * 通过经营季id获取种养类型明细
     * @param index
     * @param request
     * @return
     */
    @Override
    public String getZylxByJyjid(int index, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        String result = null;
        try {
            sql = "select * from (select ROW_NUMBER() over(PARTITION BY f_jyjId order by f_jyjId) rownum,f_jyjId \n" +
                    "from tb"+f_shbm+"_jyj) a \n" +
                    "where a.rownum='1' \n" +
                    "order By f_jyjId";
            result = sqlOperator.RunSQL_JSON(sql);
            JSONArray jyjidJarr = new JSONArray(result);
            String jyjId = jyjidJarr.getJSONObject(index).getString("F_JYJID");


            sql = "select jyj.f_jyjId,jyj.f_flbm,tjmx.f_flmc,jyj.f_Khlx,jyj.f_state \n" +
                    "from tb"+f_shbm+"_jyj jyj \n" +
                    "left join tb"+f_shbm+"_tjmxwh tjmx on jyj.f_flbm=tjmx.f_flbm \n" +
                    "where jyj.f_jyjId='"+jyjId+"' \n";
            sql += "order By jyj.f_jyjId,jyj.f_Khlx,jyj.f_flbm";
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
     * 修改种养类型状态
     * @param jyjId
     * @param flbmItems
     * @param noflbmItems
     * @param request
     * @return
     */
    @Override
    public String saveZylxState(int jyjId,String flbmItems,String noflbmItems,String khlxItems,String nokhlxItems,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        String result = null;
        List sqls = new ArrayList<>();
        try {
            if (flbmItems != null && !flbmItems.equals("") && khlxItems != null && !khlxItems.equals("")){
                String[] flbmList = flbmItems.split(",");
                String[] khlxList = khlxItems.split(",");
                for (int i = 0; i < flbmList.length; i++){
                    sql += "update tb"+f_shbm+"_jyj set f_state='1' where f_flbm='"+flbmList[i]+"' and f_jyjId='"+jyjId+"' and f_Khlx='"+khlxList[i]+"'";
                    sqls.add(sql);
                }
            }

            if (noflbmItems != null && !noflbmItems.equals("") && nokhlxItems != null && !nokhlxItems.equals("")){
                String[] noflbmList = noflbmItems.split(",");
                String[] nokhlxList = nokhlxItems.split(",");
                for (int i = 0; i < noflbmList.length; i++){
                    sql += "update tb"+f_shbm+"_jyj set f_state='0' where f_flbm='"+noflbmList[i]+"' and f_jyjId='"+jyjId+"' and f_Khlx='"+nokhlxList[i]+"'";
                    sqls.add(sql);
                }
            }

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

    /**
     * 保存新增经营季
     * @param f_jyjName
     * @param f_startTime
     * @param f_endTime
     * @param request
     * @return
     */
    @Override
    public String saveAddJyj(String f_jyjName, String f_startTime, String f_endTime, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        String result = null;
        List sqls = new ArrayList<>();
        try {
            //查询最大经营季id，没有就返回1，有的话+1
            int jyjId = -1;
            sql = "select MAX(f_jyjId) from tb"+f_shbm+"_jyj";
            String jyjidResult = sqlOperator.queryOneRecorderData(sql);
            if (jyjidResult == null || jyjidResult.equals("")){
                jyjId = 1;
            }else {
                jyjId = Integer.parseInt(jyjidResult) +1;
            }

            //转换开始日期和结束日期格式，去除中间"-"
            String[] starts = f_startTime.split("-");
            String[] ends = f_endTime.split("-");
            String startTime = "";
            String endTime = "";
            for (int i = 0; i < starts.length; i++){
                startTime += starts[i];
                endTime += ends[i];
            }

            //查询当前客户类型的种养类型下，所有的分类编码
            String khlxStr = "f_sfsynh,f_sfsydh,f_sfsyhzs";
            String[] khlxList = khlxStr.split(",");

            for (int i = 0; i < khlxList.length; i++){
                sql = "select tjmx.f_flbm,tjmx.f_flmc\n" +
                        "from tb"+f_shbm+"_tjmxwh tjmx \n" +
                        "left join tb"+f_shbm+"_tjlxwh tjlx on tjmx.f_flbm like tjlx.f_flbm+'%'\n" +
                        "where tjmx.f_mj = '1' and "+khlxList[i]+" = '1' and f_sfzylx='1'";
                String flbmList = sqlOperator.RunSQL_JSON(sql);
                JSONArray flbmJarr = new JSONArray(flbmList);
                for (int j = 0; j < flbmJarr.length(); j++){
                    String f_flbm = flbmJarr.getJSONObject(j).getString("F_FLBM");

                    //将新增数据插入
                    sql = "insert into tb"+f_shbm+"_jyj(f_jyjId,f_jyjName,f_startTime,f_endTime,f_Khlx,f_flbm) values('"+jyjId+"','"+f_jyjName+"','"+startTime+"','"+endTime+"','"+i+"','"+f_flbm+"');";
                    sqls.add(sql);
                }
            }

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

    /**
     * 保存修改经营季
     * @param f_jyjId
     * @param f_jyjName
     * @param f_startTime
     * @param f_endTime
     * @param request
     * @return
     */
    @Override
    public String saveUpdateJyj(int f_jyjId, String f_jyjName, String f_startTime, String f_endTime, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        String result = null;
        List sqls = new ArrayList<>();
        try {
            //转换开始日期和结束日期格式，去除中间"-"
            String[] starts = f_startTime.split("-");
            String[] ends = f_endTime.split("-");
            String startTime = "";
            String endTime = "";
            for (int i = 0; i < starts.length; i++){
                startTime += starts[i];
                endTime += ends[i];
            }

            //查询当前客户类型的种养类型下，所有的分类编码
            String khlxStr = "f_sfsynh,f_sfsydh,f_sfsyhzs";
            String[] khlxList = khlxStr.split(",");

            for (int i = 0; i < khlxList.length; i++){
                sql = "select tjmx.f_flbm,tjmx.f_flmc\n" +
                        "from tb"+f_shbm+"_tjmxwh tjmx \n" +
                        "left join tb"+f_shbm+"_tjlxwh tjlx on tjmx.f_flbm like tjlx.f_flbm+'%'\n" +
                        "where tjmx.f_mj = '1' and "+khlxList[i]+" = '1' and f_sfzylx='1'";
                String flbmList = sqlOperator.RunSQL_JSON(sql);
                JSONArray flbmJarr = new JSONArray(flbmList);
                for (int j = 0; j < flbmJarr.length(); j++){
                    String f_flbm = flbmJarr.getJSONObject(j).getString("F_FLBM");

                    //修改数据
                    sql = "update tb"+f_shbm+"_jyj set f_jyjName='"+f_jyjName+"',f_startTime='"+startTime+"',f_endTime='"+endTime+"'\n" +
                            "where f_jyjId='"+f_jyjId+"' and f_Khlx='"+i+"' and f_flbm='"+f_flbm+"'";
                    sqls.add(sql);
                }
            }

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

    /**
     * 保存删除经营季
     * @param jyjId
     * @param request
     * @return
     */
    @Override
    public String saveDeleteJyj(String jyjId, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        String result = null;
        try {
            //根据经营季id删除表中数据
            sql = "delete tb"+f_shbm+"_jyj where f_jyjId='"+jyjId+"'";
            sqlOperator.ExecSQL(sql);
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

    /**
     * 获取厂商设置表
     * @param request
     * @return
     */
    @Override
    public String getCsszTable(String f_lxbm,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        String result = null;
        try {
            if(f_lxbm.equals("12") || f_lxbm.equals("13") || f_lxbm.equals("14")){
                sql = "select * from tb"+f_shbm+"_Cssz where f_sylx in ('0','1') order by f_px";
            }else{
                sql = "select * from tb"+f_shbm+"_Cssz where f_sylx='0' order by f_px";
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

    /**
     * 保存参数
     * @param csbmList
     * @param cszList
     * @param request
     * @return
     */
    @Override
    public String saveCs(String csbmList, String cszList, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        String result = null;
        List sqls = new ArrayList();
        try {
            if (csbmList != null && !csbmList.equals("") && cszList != null && !cszList.equals("")){
                String[] csbms = csbmList.split(",");
                String[] cszs = cszList.split(",");

                for (int i = 0; i < csbms.length; i++){
                    sql = "update tb"+f_shbm+"_Cssz set f_csz='"+cszs[i]+"' where f_csbm='"+csbms[i]+"'";
                    sqls.add(sql);
                }
                sqlOperator.ExecSql(sqls);
                result = "ok";
            }
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
     * 获取仓库档案明细
     * @param request
     * @return
     */
    @Override
    public String getCkdamx(HttpServletRequest request) {
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql="select * from tb"+f_shbm+"_ckdawh order by f_ckbm";
            String jsonStr = sqlOperator.RunSQL_JSON(sql);
            JSONArray jsonArray = new JSONArray(jsonStr);
            JSONArray resutJson = new JSONArray();
            List<Node> nodes = new ArrayList<>();
            for (int i = 0 ; i<jsonArray.length(); i++){
                JSONObject json = jsonArray.getJSONObject(i);
                Integer jb = Integer.parseInt(json.getString("F_JB"));
                Integer mj = Integer.parseInt(json.getString("F_MJ"));
                Map<String,Object> map = new HashMap<String,Object>();

                Node node = new Node();
                node.setId(json.getString("F_CKBM"));
                node.setTitle(json.getString("F_CKBM")+" - "+json.getString("F_CKMC"));

                if(mj == 1){
                    node.setType("item");
                }else{
                    node.setType("folder");
                }
                node.setJb(jb);
                nodes.add(node);
                JSONObject resultJson = new JSONObject(map);
                resutJson.put(resultJson);
            }
            NodeUtil nodeUtil = new NodeUtil();
            result = nodeUtil.NodeTreeByTjmx(nodes);
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
     * 获取仓库档案
     * @param f_ckbm
     * @param request
     * @return
     */
    @Override
    public String getCkda(String f_ckbm, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "";
            if("".equals(f_ckbm)){
                sql = "select * from tb"+f_shbm+"_ckdawh order by f_ckbm";
                result = sqlOperator.RunSQL_JSON(sql);
            }else{
                sql = "select * from tb"+f_shbm+"_ckdawh where f_ckbm = '"+f_ckbm+"' order by f_ckbm";
                result = sqlOperator.RunSQL_JSON(sql);
            }
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
     * 获取最大仓库编码
     * @param ckbm
     * @param jb
     * @param request
     * @return
     */
    @Override
    public String getMaxCkda(String ckbm, String jb, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            if("".equals(ckbm)){
                String sql = "select Max(f_ckbm) from tb"+f_shbm+"_ckdawh where f_jb = '1'";
                result = sqlOperator.queryOneRecorderData(sql);
            }else{
                if (jb.equals("2")){
                    String sjckbm = ckbm.substring(0,3);
                    String sql = "select Max(f_ckbm) from tb"+f_shbm+"_ckdawh where f_ckbm like '"+sjckbm+"%' and f_jb = '"+jb+"'";
                    result = sqlOperator.queryOneRecorderData(sql);
                } else if (jb.equals("3")) {
                    String sjckbm = ckbm.substring(0,6);
                    String sql = "select Max(f_ckbm) from tb"+f_shbm+"_ckdawh where f_ckbm like '"+sjckbm+"%' and f_jb = '"+jb+"'";
                    result = sqlOperator.queryOneRecorderData(sql);
                }else {
                    String sql = "select Max(f_ckbm) from tb"+f_shbm+"_ckdawh where f_ckbm like '"+ckbm+"%' and f_jb = '"+jb+"'";
                    result = sqlOperator.queryOneRecorderData(sql);
                }
            }

            if(result == null){
                result = ckbm+"001";
            }else{
                switch (jb){
                    case "1":
                        result = String.format("%3d",(Integer.parseInt(result)+1)).replace(" ","0");
                        break;
                    case "2":
                        result = String.format("%6d",(Integer.parseInt(result)+1)).replace(" ","0");
                        break;
                    case "3":
                        result = String.format("%9d",(Integer.parseInt(result)+1)).replace(" ","0");
                        break;
                }
            }
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
    public String saveCkda(String f_ckbm, String f_ckmc, String f_ckmj, String f_dz, String f_dh, String f_fzr, String f_cksx, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        List<String> sqls = new ArrayList<>();

        String result = null;
        try {
            //根据仓库编码查询仓库档案
            String sql = "select * from tb"+f_shbm+"_ckdawh where f_ckbm = '"+f_ckbm+"'";
            String tempResult = sqlOperator.RunSQL_JSON(sql);

            //查询有结果，修改
            if(tempResult != null && !"".equals(tempResult) && !"[]".equals(tempResult)){
                sql = "update tb"+f_shbm+"_ckdawh set f_ckmc = '"+f_ckmc+"',f_ckmj = '"+f_ckmj+"',f_dz = '"+f_dz+"',f_dh = '"+f_dh+"',f_fzr = '"+f_fzr+"',f_cksx = '"+f_cksx+"' where f_ckbm = '"+f_ckbm+"' ";
                sqls.add(sql);
            }else{
                //查询无结果，插入数据
                if (f_ckbm.length() == 3){
                    sql = "insert into tb"+f_shbm+"_ckdawh(f_ckbm,f_ckmc,f_ckmj,f_dz,f_dh,f_fzr,f_cksx,f_jb,f_mj) " +
                            "values('"+f_ckbm+"','"+f_ckmc+"','"+f_ckmj+"','"+f_dz+"','"+f_dh+"','"+f_fzr+"','"+f_cksx+"','1','1')";
                    sqls.add(sql);
                } else if (f_ckbm.length() == 6){
                    String sjckbm = f_ckbm.substring(0,3);
                    //判断仓库数据表中是否有过该仓库的记录，只要有过不给新建下级仓库
                    sql = "select * from tb"+f_shbm+"_cksjb where f_ckbm = '"+sjckbm+"'";
                    String cksjbResult = sqlOperator.RunSQL_JSON(sql);
                    if (cksjbResult != null && !cksjbResult.equals("") && !cksjbResult.equals("[]")){
                        return "412";
                    }else {
                        sql = "update tb"+f_shbm+"_ckdawh set f_mj='0' where f_ckbm='"+sjckbm+"'";
                        sqls.add(sql);
                        sql = "insert into tb"+f_shbm+"_ckdawh(f_ckbm,f_ckmc,f_ckmj,f_dz,f_dh,f_fzr,f_cksx,f_jb,f_mj) " +
                                "values('"+f_ckbm+"','"+f_ckmc+"','"+f_ckmj+"','"+f_dz+"','"+f_dh+"','"+f_fzr+"','"+f_cksx+"','2','1')";
                        sqls.add(sql);
                    }
                }else if (f_ckbm.length() == 9){
                    String sjckbm = f_ckbm.substring(0,6);
                    //判断仓库数据表中是否有过该仓库的记录，只要有过不给新建下级仓库
                    sql = "select * from tb"+f_shbm+"_cksjb where f_ckbm = '"+sjckbm+"'";
                    String cksjbResult = sqlOperator.RunSQL_JSON(sql);
                    if (cksjbResult != null && !cksjbResult.equals("") && !cksjbResult.equals("[]")){
                        return "412";
                    }else {
                        sql = "update tb"+f_shbm+"_ckdawh set f_mj='0' where f_ckbm='"+sjckbm+"'";
                        sqls.add(sql);
                        sql = "insert into tb"+f_shbm+"_ckdawh(f_ckbm,f_ckmc,f_ckmj,f_dz,f_dh,f_fzr,f_cksx,f_jb,f_mj) " +
                                "values('"+f_ckbm+"','"+f_ckmc+"','"+f_ckmj+"','"+f_dz+"','"+f_dh+"','"+f_fzr+"','"+f_cksx+"','3','1')";
                        sqls.add(sql);
                    }
                }
            }
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

    /**
     * 删除仓库档案
     * @param f_ckbm
     * @param request
     * @return
     */
    @Override
    public String deleteCkda(String f_ckbm, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        List<String> sqls = new ArrayList<>();
        String sql = "";

        String result = null;

        sql = "select f_jb from tb"+f_shbm+"_ckdawh where f_ckbm='"+f_ckbm+"'";
        String f_jb = sqlOperator.queryOneRecorderData(sql);
        try {
            //判断仓库数据表中是否有过该仓库的记录，只要有过不给新建下级仓库
            sql = "select * from tb"+f_shbm+"_cksjb where f_ckbm = '"+f_ckbm+"'";
            String cksjbResult = sqlOperator.RunSQL_JSON(sql);
            if (cksjbResult != null && !cksjbResult.equals("") && !cksjbResult.equals("[]")){
                return "412";
            }else {
                if(f_jb.equals("1")){
                    sql = "delete from tb"+f_shbm+"_ckdawh where f_ckbm like '"+f_ckbm+"%'";
                    sqls.add(sql);
                } else if (f_jb.equals("2")) {
                    sql = "delete from tb"+f_shbm+"_ckdawh where f_ckbm like '"+f_ckbm+"%'";
                    sqlOperator.ExecSQL(sql);
                    String dzckbm = f_ckbm.substring(0,4);
                    sql = "select * from tb"+f_shbm+"_ckdawh where f_ckbm like '"+dzckbm+"%'";
                    String xjckxx = sqlOperator.RunSQL_JSON(sql);
                    String sjckbm = f_ckbm.substring(0,3);
                    if (xjckxx == null || xjckxx.equals("") || xjckxx.equals("[]")){
                        sql = "update tb"+f_shbm+"_ckdawh set f_mj='1' where f_ckbm='"+sjckbm+"'";
                        sqls.add(sql);
                    }
                }else if (f_jb.equals("3")) {
                    sql = "delete from tb"+f_shbm+"_ckdawh where f_ckbm='"+f_ckbm+"'";
                    sqlOperator.ExecSQL(sql);
                    String dzckbm = f_ckbm.substring(0,7);
                    sql = "select * from tb"+f_shbm+"_ckdawh where f_ckbm like '"+dzckbm+"%'";
                    String xjckxx = sqlOperator.RunSQL_JSON(sql);
                    String sjckbm = f_ckbm.substring(0,6);
                    if (xjckxx == null || xjckxx.equals("") || xjckxx.equals("[]")){
                        sql = "update tb"+f_shbm+"_ckdawh set f_mj='1' where f_ckbm='"+sjckbm+"'";
                        sqls.add(sql);
                    }
                }
            }
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
    public String loadGsxx(HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";

        String result = null;

        try {
            sql = "select shda.f_Shmc,shda.f_lxbm,lxda.f_lxmc,shda.f_sjh,shda.f_Dz,shda.f_mm,shda.f_Xxdz,\n" +
                    "shda.f_Yb,shda.f_jyxkzh,shda.f_Dh,shda.f_Khh,shda.f_Email,shda.f_Sh,shda.f_Zh,shda.f_Zczb,\n" +
                    "shda.f_Fr,shda.f_sfls\n" +
                    "from tbShda shda\n" +
                    "left join tbshlxda lxda on shda.f_lxbm=lxda.f_lxbm\n" +
                    "where f_Shbm='"+f_shbm+"'";
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
    public String saveGsxx(String sjhm, String f_qydz, String f_xxdz, String f_zykl, String f_yzbm, String f_qrkl,
                           String f_lxdh, String f_jyxkzh, String f_emall, String f_khh, String f_khzh, String f_sh,
                           String f_fr, Float f_zczb, int f_sfls, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";

        String result = null;

        try {
            sql = " update tbShda set f_sjh='"+sjhm+"',f_Dz='"+f_qydz+"',f_mm='"+f_zykl+"',f_Xxdz='"+f_xxdz+"',f_Yb='"+f_yzbm+"',f_jyxkzh='"+f_jyxkzh+"',f_Dh='"+f_lxdh+"',\n" +
                    " f_Khh='"+f_khh+"',f_Email='"+f_emall+"',f_Sh='"+f_sh+"',f_Zh='"+f_khzh+"',f_Zczb='"+f_zczb+"',f_Fr='"+f_fr+"',f_sfls='"+f_sfls+"'\n" +
                    " where f_shbm='"+f_shbm+"'";
            sqlOperator.ExecSQL(sql);
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
