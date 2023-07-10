package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.ClerkService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import util.WordToPinYin;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Transactional
@Service
public class ClerkServiceImpl implements ClerkService {
    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getZymx(String zybm,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "";
            JSONArray json = null;

            sql = "select sh.f_Shbm,sh.f_Shmc,zy.f_Zybm,zy.f_Zymc,zy.f_sjh,zy.f_Xgrq,isnull(zybm.f_Bmbm,'') f_Bmbm,isnull(bm.f_Bmmc,'') f_Bmmc \n" +
                    "from tb" + f_shbm + "_Zyda zy \n" +
                    "left join tb" + f_shbm + "_zysxbm zybm on zybm.f_Zybm = zy.f_Zybm \n" +
                    "left join tb" + f_shbm + "_Bmda bm on zybm.f_Bmbm = bm.f_Bmbm \n" +
                    "left join tbShda sh on sh.f_Shbm = '" + f_shbm + "'";
            if (!zybm.equals("") && zybm != null) {
                sql += " where zy.f_Zybm like '%" + zybm + "%' or zy.f_Zymc like '%" + zybm + "%' or zy.f_Zjf like '%" + zybm + "%'";
            }
            sql += " order by zy.f_Zybm ";
            result = sqlOperator.RunSQL_JSON(sql);
            json = new JSONArray(result);
            for (int g = 0; g < json.length(); g++) {
                JSONObject json1 = json.getJSONObject(g);
                for (int j = g + 1; j < json.length(); j++) {
                    JSONObject json2 = json.getJSONObject(j);
                    String[] bmbms = json1.getString("F_BMBM").split(",");
                    if (json1.getString("F_ZYBM").equals(json2.getString("F_ZYBM"))) {
                        boolean bmbmpd = false;
                        for (int h = 0; h < bmbms.length; h++) {
                            if (json2.getString("F_BMBM").equals(bmbms[h])) {
                                bmbmpd = true;
                                break;
                            }
                        }
                        if (!bmbmpd) {
                            String sxbm = json1.getString("F_BMBM") + "," + json2.getString("F_BMBM");
                            String bmmc = json1.getString("F_BMMC") + "," + json2.getString("F_BMMC");
                            json1.put("F_BMBM", sxbm);
                            json1.put("F_BMMC", bmmc);
                        }
                        json.put(g, json1);
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

    /**
     * 获取职员权限
     * @param zybm
     * @param qxxx
     * @param request
     * @return
     */
    public String getZyqx(String zybm,String qxxx,HttpServletRequest request){
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "";
            JSONArray json = null;
            sql = "select zyqx.f_Zybm,isnull(zyqx.f_Qxbm,'') f_qxbm,isnull(qx.f_Qxmc,'') f_qxmc,jszy.f_jsbm,jsda.f_jsmc \n" +
                    "from tb" + f_shbm + "_Zyqx zyqx \n" +
                    "left join tb" + f_shbm + "_Qx qx on zyqx.f_Qxbm = qx.f_Qxbm \n" +
                    "left join tb" + f_shbm + "_Jszydzb jszy on zyqx.f_Zybm=jszy.f_zybm \n" +
                    "left join tb" + f_shbm + "_Jsdab jsda on jszy.f_jsbm=jsda.f_jsbm " ;
            if (!zybm.equals("") && zybm != null && !qxxx.equals("") && qxxx != null) {
                sql += " where zyqx.f_Zybm='"+zybm+"' and qx.f_Qxmc like '%"+qxxx+"%'";
            }
            sql += " order by zyqx.f_Zybm, zyqx.f_Qxbm ";
            result = sqlOperator.RunSQL_JSON(sql);
            json = new JSONArray(result);
            for (int g = 0; g < json.length(); g++) {
                JSONObject json1 = json.getJSONObject(g);
                for (int j = g + 1; j < json.length(); j++) {
                    JSONObject json2 = json.getJSONObject(j);
                    String[] qxbms = json1.getString("F_QXBM").split(",");
                    if (json1.getString("F_ZYBM").equals(json2.getString("F_ZYBM"))) {
                        boolean qxbmpd = false;
                        for (int h = 0; h < qxbms.length; h++) {
                            if (json2.getString("F_QXBM").equals(qxbms[h])) {
                                qxbmpd = true;
                                break;
                            }
                        }
                        if (!qxbmpd) {
                            String qxbm = json1.getString("F_QXBM") + "," + json2.getString("F_QXBM");
                            String qxmc = json1.getString("F_QXMC") + "," + json2.getString("F_QXMC");
                            json1.put("F_QXBM", qxbm);
                            json1.put("F_QXMC", qxmc);
                        }
                        json.put(g, json1);
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
    public String addZymx(String zymc, String sjh, String zyqx, String zykl,String sxbm,String zyjs,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        List<String> sqls = new ArrayList<>();

        String result = null;
        try {
            //从平台职员档案查该手机号有多少条记录，没记录即可继续注册
            String sql = "select count(*) from tbptzyda where f_sjh = '"+sjh+"'";
            String ptzyCount = sqlOperator.queryOneRecorderData(sql);

            if(ptzyCount != null && !"0".equals(ptzyCount)){
                return "该手机号已注册，请重新选择！";
            }

            //查询最大职员编码+1作为新的职员编码
            sql="select MAX(f_Zybm) from tb"+f_shbm+"_Zyda";
            String maxBm=sqlOperator.queryOneRecorderData(sql);
            int bmlen=maxBm.length();
            int bm=Integer.parseInt(maxBm)+1;
            String f_zybm=String.valueOf(bm);
            while(f_zybm.length()<bmlen){
                f_zybm = "0" + f_zybm;
            }
            //zykl = MD5.MD5(zykl);
            SimpleDateFormat format = new SimpleDateFormat("YYYYmmdd");
            String zjf = WordToPinYin.converterToFirstSpell(zymc);
            //往Zyda表插数据，可以不插职员口令字段
            if("".equals(zykl) || zykl == null){
                sql = "insert into tb"+f_shbm+"_Zyda(f_Zybm,f_Zymc,f_Xgrq,f_sjh,f_Zjf) " +
                        "values('"+f_zybm+"','"+zymc+"','"+format.format(new Date())+"','"+sjh+"','"+zjf+"')";
            }else{
                sql = "insert into tb"+f_shbm+"_Zyda(f_Zybm,f_Zymc,f_Xgrq,f_Zykl,f_sjh,f_Zjf) " +
                        "values('"+f_zybm+"','"+zymc+"','"+format.format(new Date())+"','"+zykl+"','"+sjh+"','"+zjf+"')";
            }

            sqls.add(sql);

            String[] sxbms = sxbm.split(",");
            for(int i = 0 ; i<sxbms.length ; i++){
                String tempsxbm = sxbms[i];
                //根据职员编码查询最大序号
                sql =" select MAX(f_Xh) from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"'";
                String maxXh=sqlOperator.queryOneRecorderData(sql);
                int xh=0;
                if(maxXh != null && !"".equals(maxXh)){
                    xh=Integer.parseInt(maxXh)+1;
                }
                //职员所辖编码表插入数据
                sql = "insert into tb"+f_shbm+"_zysxbm(f_Zybm,f_Bmbm,f_Xh) " +
                        "values('"+f_zybm+"','"+tempsxbm+"','"+xh+"')";
                sqls.add(sql);
            }

            //角色职员对照表中插入zyjs和f_zybm
            sql = "insert into tb"+f_shbm+"_Jszydzb(f_jsbm,f_zybm) " +
                    "values('"+zyjs+"','"+f_zybm+"')";
            sqls.add(sql);


            String[] zyqxs = zyqx.split(",");
            for(int i = 0 ; i<zyqxs.length ; i++){
                String tempzyqxs = zyqxs[i];
                String[] tempzyqx = tempzyqxs.split("-");

                //职员权限表中插入职员编码和权限编码
                sql = "insert into tb"+f_shbm+"_Zyqx(f_Zybm,f_Qxbm) " +
                        "values('"+f_zybm+"','"+tempzyqx[0]+"')";
                sqls.add(sql);
            }

            //往平台职员档案插入数据
            sql = "insert into tbptzyda(f_Zybm,f_Zymc,f_Xgrq,f_Zykl,f_sjh,f_zylx,f_shbm) " +
                    "values('"+f_zybm+"','"+zymc+"','"+format.format(new Date())+"','"+zykl+"','"+sjh+"','1','"+f_shbm+"') ";
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
    public String removeZymx(String zybm,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");

        List<String> sqls = new ArrayList<>();

        String result = null;
        String sql = "";

        try {
            //管理员才可以删除
            if (f_zybm.equals(f_shbm+"01")){
                //删除职员编码为xxxxxx01，无法删除
                if(zybm.equals(f_shbm+"01")){
                    result = "408";
                }else {
                    sql = "delete from tb"+f_shbm+"_Zyda where f_Zybm = '"+zybm+"'";
                    sqls.add(sql);
                    sql =" delete from tb"+f_shbm+"_zysxbm where f_Zybm = '"+zybm+"'";
                    sqls.add(sql);
                    sql =" delete from tb"+f_shbm+"_Jszydzb where f_Zybm = '"+zybm+"'";
                    sqls.add(sql);
                    sql = "delete from tb"+f_shbm+"_Zyqx where f_Zybm = '"+zybm+"'";
                    sqls.add(sql);
                    sql = "delete from tbptzyda where f_Zybm = '"+zybm+"'";
                    sqls.add(sql);
                    sqlOperator.ExecSql(sqls);
                    result = "ok";
                }
            }else {
                result = "407";
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
     * 修改职员明细
     * @param zybm
     * @param zymc
     * @param sjh
     * @param zyqx
     * @param zykl
     * @param sxbm
     * @param request
     * @return
     */
    @Override
    public String updateZymx(String zybm, String zymc, String sjh, String zyqx, String zykl,String sxbm,String zyjs,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        List<String> sqls = new ArrayList<>();

        String result = null;
        try {
            //如果没职员口令，根据职员编码查询职员口令
            if("".equals(zykl) || zykl == null){
                String sql = "select Max(f_Zykl) from tb"+f_shbm+"_Zyda where f_Zybm = '"+zybm+"'";
                String xh = sqlOperator.queryOneRecorderData(sql);
                zykl = xh;
            }
            //查询需要编辑用户的商户编码
            String sql = "select f_shbm from tbptzyda where f_Zybm='"+zybm+"'";
            String newshbm = sqlOperator.queryOneRecorderData(sql);

            //根据职员编码删除对应职员档案
            sql = "delete from tb"+f_shbm+"_Zyda where f_Zybm = '"+zybm+"'";
            sqls.add(sql);
            //根据职员编码删除对应职员权限
            sql = "delete from tb"+f_shbm+"_Zyqx where f_Zybm = '"+zybm+"'";
            sqls.add(sql);
            //根据职员编码删除对应职员所辖编码
            sql =" delete from tb"+f_shbm+"_zysxbm where f_Zybm = '"+zybm+"'";
            sqls.add(sql);
            //根据职员编码删除对应角色职员对照表
            sql =" delete from tb"+f_shbm+"_Jszydzb where f_Zybm = '"+zybm+"'";
            sqls.add(sql);
            //根据职员编码删除对应职员平台职员档案
            sql =" delete from tbptzyda where f_Zybm = '"+zybm+"'";
            sqls.add(sql);

            //zykl = MD5.MD5(zykl);
            SimpleDateFormat format = new SimpleDateFormat("YYYYmmdd");
            String zjf = WordToPinYin.converterToFirstSpell(zymc);
            //职员档案插数据
            sql = "insert into tb"+f_shbm+"_Zyda(f_Zybm,f_Zymc,f_Xgrq,f_Zykl,f_sjh,f_Zjf) " +
                    "values('"+zybm+"','"+zymc+"','"+format.format(new Date())+"','"+zykl+"','"+sjh+"','"+zjf+"')";
            sqls.add(sql);

            String[] sxbms = sxbm.split(",");
            for(int i = 0 ; i<sxbms.length ; i++){
                String tempsxbm = sxbms[i];
                //查询职员编码最大序号+1
                sql =" select MAX(f_Xh) from tb"+f_shbm+"_zysxbm where f_Zybm = '"+zybm+"'";
                String maxXh=sqlOperator.queryOneRecorderData(sql);
                int xh=0;
                if(maxXh != null && !"".equals(maxXh)){
                    xh=Integer.parseInt(maxXh)+1;
                }
                //职员所辖编码表插数据
                sql = "insert into tb"+f_shbm+"_zysxbm(f_Zybm,f_Bmbm,f_Xh) " +
                        "values('"+zybm+"','"+tempsxbm+"','"+xh+"')";
                sqls.add(sql);
            }

            String[] zyqxs = zyqx.split(",");
            for(int i = 0 ; i<zyqxs.length ; i++){
                String tempzyqxs = zyqxs[i];
                String[] tempzyqx = tempzyqxs.split("-");
                //职员权限表插入数据
                sql = "insert into tb"+f_shbm+"_Zyqx(f_Zybm,f_Qxbm) " +
                        "values('"+zybm+"','"+tempzyqx[0]+"')";
                sqls.add(sql);
            }

            //角色职员对照表插入数据
            sql = "insert into tb"+f_shbm+"_Jszydzb(f_jsbm,f_zybm) " +
                    "values('"+zyjs+"','"+zybm+"')";
            sqls.add(sql);

            //平台职员档案表插入数据
            sql = "insert into tbptzyda(f_Zybm,f_Zymc,f_Xgrq,f_Zykl,f_sjh,f_zylx,f_shbm) " +
                    "values('"+zybm+"','"+zymc+"','"+format.format(new Date())+"','"+zykl+"','"+sjh+"','1','"+newshbm+"') ";
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
