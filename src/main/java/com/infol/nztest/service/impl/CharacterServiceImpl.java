package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.CharacterService;
import util.WordToPinYin;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Transactional
@Service
public class CharacterServiceImpl implements CharacterService {
    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getJsmx(String jsbm, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "select js.f_Jsbm,js.f_Jsmc,js.f_Sfkj,js.f_Jslx,qx.f_Qxbm,qx.f_Qxmc,qx.f_JB,qx.f_SFMJ from tb"+f_shbm+"_Jsda js \n" +
                    "left join tb"+f_shbm+"_Jsqxdz jsqx on js.f_Jsbm = jsqx.f_Jsbm \n" +
                    "left join tb"+f_shbm+"_Qx qx on jsqx.f_Qxbm = qx.f_Qxbm ";
            if(!jsbm.equals("") && jsbm != null){
                sql+=" where js.f_Jsbm like '%"+jsbm+"%' or js.f_Jsmc like '%"+jsbm+"%' or js.f_c_col3 like '%"+jsbm+"%'";
            }
            result = sqlOperator.RunSQL_JSON(sql);
            JSONArray json = new JSONArray(result);
            for(int i = 0 ; i<json.length() ; i++){
                JSONObject json1 = json.getJSONObject(i);
                for(int j = i+1 ; j<json.length() ; j++){
                    JSONObject json2 = json.getJSONObject(j);
                    if(json1.getString("F_JSBM").equals(json2.getString("F_JSBM"))){
                        String qxbm = json1.getString("F_QXBM")+","+json2.getString("F_QXBM");
                        String qxmc = json1.getString("F_QXMC")+","+json2.getString("F_QXMC");
                        json1.put("F_QXBM",qxbm);
                        json1.put("F_QXMC",qxmc);
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
    public String addJsmx(String jsmc, String jslx, String jsqx, String sfkj,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql=" select MAX(f_Jsbm) from tb"+f_shbm+"_Jsda";
            String maxBm=sqlOperator.queryOneRecorderData(sql);
            int bmlen=maxBm.length();
            int bm=Integer.parseInt(maxBm)+1;
            String f_jsbm=String.valueOf(bm);
            while(f_jsbm.length()<bmlen){
                f_jsbm = "0" + f_jsbm;
            }
            String zjf = WordToPinYin.converterToFirstSpell(jsmc);
            List<String> sqls = new ArrayList<>();
            sql = "insert into tb"+f_shbm+"_Jsda(f_Jsbm,f_Jsmc,f_Sfkj,f_Jslx,f_c_col3) " +
                    "values('"+f_jsbm+"','"+jsmc+"','"+sfkj+"','"+jslx+"','"+zjf+"')";
            sqls.add(sql);
            String[] jsqxs = jsqx.split(",");
            for(int i = 0 ; i<jsqxs.length ; i++){
                String tempjsqxs = jsqxs[i];
                String[] tempjsqx = tempjsqxs.split("-");
                sql = "insert into tb"+f_shbm+"_Jsqxdz(f_Jsbm,f_Qxbm) " +
                        "values('"+f_jsbm+"','"+tempjsqx[0]+"')";
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
    public String removeJsmx(String jsbm,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            List<String> sqls = new ArrayList<>();
            String sql = "delete from tb"+f_shbm+"_Jsda where f_Jsbm = '"+jsbm+"'";
            sqls.add(sql);
            sql = "delete from tb"+f_shbm+"_Jsqxdz where f_Jsbm = '"+jsbm+"'";
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
    public String updateJsmx(String jsbm,String jsmc, String jslx, String jsqx, String sfkj,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {

            List<String> sqls = new ArrayList<>();

            String sql = "delete from tb"+f_shbm+"_Jsda where f_Jsbm = '"+jsbm+"'";
            sqls.add(sql);

            sql = "delete from tb"+f_shbm+"_Jsqxdz where f_Jsbm = '"+jsbm+"'";
            sqls.add(sql);

            String zjf = WordToPinYin.converterToFirstSpell(jsmc);
            sql = "insert into tb"+f_shbm+"_Jsda(f_Jsbm,f_Jsmc,f_Sfkj,f_Jslx,f_c_col3) " +
                    "values('"+jsbm+"','"+jsmc+"','"+sfkj+"','"+jslx+"','"+zjf+"')";
            sqls.add(sql);

            String[] jsqxs = jsqx.split(",");
            for(int i = 0 ; i<jsqxs.length ; i++){
                String tempjsqxs = jsqxs[i];
                String[] tempjsqx = tempjsqxs.split("-");
                sql = "insert into tb"+f_shbm+"_Jsqxdz(f_Jsbm,f_Qxbm) " +
                        "values('"+jsbm+"','"+tempjsqx[0]+"')";
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

    @Override
    public String getQxmx(String qxbm,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "";
            if("".equals(qxbm) || qxbm == null){
                //sql = "select * from tb"+f_shbm+"_Qx where f_SFMJ = '1' ";
                sql = "select * from tb"+f_shbm+"_Qx order by f_qxbm";
            }else{
                //sql = "select * from tb"+f_shbm+"_Qx where f_SFMJ = '1' and  (f_Qxbm like '%"+qxbm+"%' or f_Qxmc like '%"+qxbm+"%')";
                sql = "select * from tb"+f_shbm+"_Qx where f_Qxbm like '%"+qxbm+"%' or f_Qxmc like '%"+qxbm+"%' order by f_qxbm";
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
     * 获取角色档案表
     * @param jsbm 角色编码
     * @param request
     * @return
     */
    public String getJsdab(String jsbm, HttpServletRequest request){
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        String sql = "";
        try {
            //如果角色编码为空
            if (jsbm.equals("")){
                sql = "select * from tb"+f_shbm+"_Jsdab order by f_jsbm";
            }else {
                //如果角色编码非空
                sql = "select * from tb"+f_shbm+"_Jsdab where f_jsbm="+jsbm;
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
     * 获取角色已有的权限
     * @param jsbm 角色编码
     * @param request
     * @return
     */
    public String getJsqx(String jsbm,  HttpServletRequest request){
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        String sql = "";
        try {
            if (jsbm ==null || jsbm.equals("")){
                sql = "select jsqxdzb.f_qxbm,tbqx.f_Qxmc from tb"+f_shbm+"_Jsqxdzb jsqxdzb \n" +
                        "left join tb"+f_shbm+"_Qx tbqx on jsqxdzb.f_qxbm=tbqx.f_Qxbm order by tbqx.f_qxbm";
            }else {
                sql = "select jsqxdzb.f_qxbm,tbqx.f_Qxmc from tb"+f_shbm+"_Jsqxdzb jsqxdzb \n" +
                        "left join tb"+f_shbm+"_Qx tbqx on jsqxdzb.f_qxbm=tbqx.f_Qxbm \n" +
                        "where f_jsbm='"+jsbm+"' order by tbqx.f_qxbm";
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
     * 获取所有角色权限
     * @param request
     * @return
     */
    public String queryAllJsqx(HttpServletRequest request){
        //创建连接池
        openConnection();
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = null;
        String sql = "";
        try {
            sql = "select * from tb"+f_shbm+"_Qx order by f_Qxbm";
            openConnection();
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
     * 增加角色
     * @param jsbm
     * @param jsmc
     * @param request
     * @return
     */
    public String addjs(String jsbm, String jsmc, HttpServletRequest request){
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");

        String result = null;
        try {
            String sql = "";

            if("".equals(jsbm) || jsbm == null || "".equals(jsmc) || jsmc == null){
                System.out.println("请输入角色编码和角色名称！");
            } else {
                if (f_zybm.endsWith("01")){
                    sql = "insert into tb"+f_shbm+"_Jsdab(f_jsbm,f_jsmc) values('"+jsbm+"','"+jsmc+"');";
                    sqlOperator.ExecSQL(sql);
                    result = "ok";
                }else {
                    result = "405";
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
     * 查询最大角色编码+1
     * @param request
     * @return
     */
    public String queryMaxJsbm(HttpServletRequest request){
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;

        try {
            //select max(f_jsbm) from tb000001_Jsdab
            String sql = "select max(f_jsbm) from tb"+f_shbm+"_Jsdab";
            result = sqlOperator.queryOneRecorderData(sql);

            if (result == null){
                result = "1000000001";
            }else{
                result = (Integer.parseInt(result)+1)+"";
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
     * 修改角色
     * @param jsbm
     * @param jsmc
     * @param request
     * @return
     */
    public String updateJs(String jsbm, String jsmc, HttpServletRequest request){
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");

        String result = null;
        try {
            String sql = "";

            if("".equals(jsbm) || jsbm == null || "".equals(jsmc) || jsmc == null){
                System.out.println("请输入角色编码和角色名称！");
            } else {
                if (f_zybm.endsWith("01")){
                    sql = "update tb"+f_shbm+"_Jsdab set f_jsmc='"+jsmc+"' where f_jsbm='"+jsbm+"';";
                    sqlOperator.ExecSQL(sql);
                    result = "ok";
                }else {
                    result = "406";
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
     * 删除角色
     * @param jsbm
     * @param request
     * @return
     */
    public String deleteJs(String jsbm, HttpServletRequest request){
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");

        String result = null;
        try {
            List<String> sqls = new ArrayList<>();

            if("".equals(jsbm) || jsbm == null){
                System.out.println("请输入角色编码！");
            } else {
                if (f_zybm.equals(f_shbm+"01")){
                    if (jsbm.equals("1000000001")){
                        result = "410";
                    }else {
                        String sql = "DELETE FROM tb"+f_shbm+"_Jsdab WHERE f_jsbm='"+jsbm+"';";
                        sqls.add(sql);
                        sql = "DELETE FROM tb"+f_shbm+"_Jsqxdzb WHERE f_jsbm='"+jsbm+"';";
                        sqls.add(sql);
                        sqlOperator.ExecSql(sqls);
                        result = "ok";
                    }
                }else {
                    result = "407";
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
     * 修改角色权限
     * @param jsbm
     * @param qxbmList
     * @param noqxbmList
     * @param request
     * @return
     */
    public String updateJsqx(String jsbm, String qxbmList, String noqxbmList, HttpServletRequest request){
        openConnection();
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");

        String result = null;
        String queryResult = null;
        try {
            String sql = "";
            String sql1 = "";

            if("".equals(jsbm) || jsbm == null || "".equals(qxbmList) || qxbmList == null){
                System.out.println("请输入角色编码和权限编码！");
            } else {
                //通过权限名称查询权限编码,结果：00,0001,0002,...
                String[] qxbm = null;
                String[] noqxbm = null;
                //说明该角色已有所有权限
                if (noqxbmList == null){
                    System.out.println("没有需要删除的权限！");
                }

                //只有管理员能修改
                if (f_zybm.endsWith("01")){
                    //判断是否只插入一个qxbm
                    if (qxbmList.length() > 1){
                        qxbm = qxbmList.split(",");
                        //循环插入角色编码和权限编码
                        for (int i = 0; i < qxbm.length; i++){
                            String qxbmTemp = qxbm[i];
                            //判断数据是否已经存在
                            sql1 = "SELECT * FROM tb"+f_shbm+"_Jsqxdzb where f_jsbm='"+jsbm+"' and f_qxbm='"+qxbmTemp+"'";
                            queryResult = sqlOperator.queryOneRecorderData(sql1);
                            if (queryResult == null){
                                sql = "insert into tb"+f_shbm+"_Jsqxdzb(f_jsbm,f_qxbm) values('"+jsbm+"','"+qxbmTemp+"')";
                                sqlOperator.ExecSQL(sql);
                            }
                        }
                        result = "ok";
                    }else {
                        sql1 = "SELECT * FROM tb"+f_shbm+"_Jsqxdzb where f_jsbm='"+jsbm+"' and f_qxbm='"+qxbmList+"'";
                        queryResult = sqlOperator.queryOneRecorderData(sql1);
                        if (queryResult == null){
                            sql = "insert into tb"+f_shbm+"_Jsqxdzb(f_jsbm,f_qxbm) values('"+jsbm+"','"+qxbmList+"')";
                            sqlOperator.ExecSQL(sql);
                            result = "ok";
                        }
                    }

                    //判断是否只删除1个qxbm
                    if (noqxbmList.length() > 1){
                        noqxbm = noqxbmList.split(",");
                        //循环删除角色编码和权限编码
                        for (int i = 0; i < noqxbm.length; i++){
                            String noqxbmTemp = noqxbm[i];
                            //如果数据存在则删除
                            sql1 = "SELECT * FROM tb"+f_shbm+"_Jsqxdzb where f_jsbm='"+jsbm+"' and f_qxbm='"+noqxbmTemp+"'";
                            queryResult = sqlOperator.queryOneRecorderData(sql1);
                            if (queryResult != null){
                                //delete from tb000001_Jsqxdzb where f_jsbm='1000000001' and f_qxbm='00'
                                sql = "delete from tb"+f_shbm+"_Jsqxdzb where f_jsbm='"+jsbm+"' and f_qxbm='"+noqxbmTemp+"'";
                                sqlOperator.ExecSQL(sql);
                                result = "ok";
                            }
                        }
                    }else {
                        sql1 = "SELECT * FROM tb"+f_shbm+"_Jsqxdzb where f_jsbm='"+jsbm+"' and f_qxbm='"+noqxbmList+"'";
                        queryResult = sqlOperator.queryOneRecorderData(sql1);
                        if (queryResult != null){
                            sql = "delete from tb"+f_shbm+"_Jsqxdzb where f_jsbm='"+jsbm+"' and f_qxbm='"+noqxbmList+"'";
                            sqlOperator.ExecSQL(sql);
                            result = "ok";
                        }
                    }
                }else {
                    result = "408";
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
     * 修改角色职员
     * @param jsbm
     * @param zybmList
     * @param nozybmList
     * @param request
     * @return
     */
    public String updateJszy(String jsbm, String zybmList, String nozybmList, HttpServletRequest request){
        openConnection();
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");

        String result = null;
        String queryResult = null;
        try {
            List<String> sqls = new ArrayList<>();
            String sql1 = "";
            String sql = "";

            if("".equals(jsbm) || jsbm == null){
                System.out.println("请输入角色编码！");
            } else {
                String[] zybm = null;
                String[] nozybm = null;
                //说明该角色已有所有职员
                if (nozybmList == null){
                    System.out.println("没有需要删除的职员！");
                }
                zybm = zybmList.split(",");
                nozybm = nozybmList.split(",");

                //只能管理员进行修改操作
                if (f_zybm.endsWith("01")){
                    //查询角色编码有哪些权限
                    sql = "select f_qxbm from tb"+f_shbm+"_Jsqxdzb where f_jsbm='"+jsbm+"'order by f_qxbm";
                    String jsqxList = sqlOperator.RunSQL_JSON(sql);
                    JSONArray jsqxJson = new JSONArray(jsqxList);

                    if (zybmList != null && !zybmList.equals("")){
                        //Jszydzb循环插入角色编码和权限编码
                        for (int i = 0; i < zybm.length; i++){
                            String zybmTemp = zybm[i];
                            //根据zybm查询数据是否已经存在
                            sql1 = "SELECT f_zybm FROM tb"+f_shbm+"_Jszydzb where f_zybm='"+zybmTemp+"'";
                            queryResult = sqlOperator.queryOneRecorderData(sql1);
                            if (queryResult == null){
                                //如果结果为null，将数据插入
                                sql = "insert into tb"+f_shbm+"_Jszydzb(f_jsbm,f_zybm) values('"+jsbm+"','"+zybmTemp+"')";
                                sqls.add(sql);
                                //Zyqx插入职员编码和职员权限
                                for (int h = 0; h < jsqxJson.length(); h++) {
                                    JSONObject json = jsqxJson.getJSONObject(h);
                                    String[] qxbms = json.getString("F_QXBM").split(",");
                                    for (int j = 0; j < qxbms.length; j++) {
                                        sql = "insert into tb"+f_shbm+"_Zyqx(f_Zybm,f_Qxbm) values('"+zybmTemp+"','"+qxbms[j]+"');";
                                        sqls.add(sql);
                                    }
                                }
                            }else if (queryResult.equals(zybmTemp)){
                                //如果结果能查到，修改角色编码
                                sql = "update tb"+f_shbm+"_Jszydzb set f_jsbm='"+jsbm+"' where f_zybm='"+zybmTemp+"'";
                                sqls.add(sql);
                                //删除角色编码下所有的qxbm
                                sql = "delete from tb"+f_shbm+"_Zyqx where f_zybm='"+zybmTemp+"'";
                                sqls.add(sql);
                                //Zyqx插入职员编码和职员权限
                                for (int h = 0; h < jsqxJson.length(); h++) {
                                    JSONObject json = jsqxJson.getJSONObject(h);
                                    String[] qxbms = json.getString("F_QXBM").split(",");
                                    for (int j = 0; j < qxbms.length; j++) {
                                        sql = "insert into tb"+f_shbm+"_Zyqx(f_Zybm,f_Qxbm) values('"+zybmTemp+"','"+qxbms[j]+"');";
                                        sqls.add(sql);
                                    }
                                }
                            }
                        }
                    } else if (nozybmList != null && !nozybmList.equals("")) {
                        //循环删除角色编码和权限编码
                        for (int i = 0; i < nozybm.length; i++){
                            String nozybmTemp = nozybm[i];
                            //如果数据存在则删除
                            sql1 = "select f_zybm from tb"+f_shbm+"_Jszydzb where f_jsbm='"+jsbm+"' and f_zybm='"+nozybmTemp+"'";
                            queryResult = sqlOperator.queryOneRecorderData(sql1);
                            if (queryResult != null && !queryResult.equals("")){
                                sql = "delete from tb"+f_shbm+"_Jszydzb where f_jsbm='"+jsbm+"' and f_zybm='"+nozybmTemp+"'";
                                sqls.add(sql);
                                sql = "delete from tb"+f_shbm+"_Zyqx where f_zybm='"+nozybmTemp+"'";
                                sqls.add(sql);
                            }
                        }
                    }
                    sqlOperator.ExecSql(sqls);
                    result = "ok";
                }else {
                    //职员不许修改职员角色
                    result = "409";
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
     * 获取职员档案(查询结果为：当前角色编码下的zymc,sjh,bmbm,bmmc)
     * @param jsbm
     * @param request
     * @return
     */
    public String getZyda(String jsbm, HttpServletRequest request){
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "";

            sql = "select zyda.f_zybm,zyda.f_Zymc,zyda.f_sjh,zysxbm.f_Bmbm,bmda.f_Bmmc\n" +
                    "from tb"+f_shbm+"_Zyda zyda\n" +
                    "left join tb"+f_shbm+"_zysxbm zysxbm on zyda.f_zybm=zysxbm.f_Zybm\n" +
                    "left join tb"+f_shbm+"_Bmda bmda on zysxbm.f_Bmbm=bmda.f_Bmbm\n" +
                    "left join tb"+f_shbm+"_Jszydzb jszydzb on jszydzb.f_zybm=zyda.f_Zybm\n ";
            if (jsbm != null && !jsbm.equals("") ) {
                sql += " where jszydzb.f_jsbm='"+jsbm+"'\n ";
            }
            sql += " order by zyda.f_Zybm\n ";
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

