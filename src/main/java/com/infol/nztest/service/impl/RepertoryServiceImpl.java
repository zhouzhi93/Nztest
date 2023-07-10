package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.RepertoryService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Transactional
@Service
public class RepertoryServiceImpl implements RepertoryService {
    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getKctzs(String kcrq, String spmc, String djh, String sptm, String gysbm, String gysmc,
                           Integer pageIndex,Integer pageSize, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");

        String result = null;
        if(!"".equals(kcrq)){
            String[] ksrqs = kcrq.split("-");
            kcrq = ksrqs[0]+ksrqs[1]+ksrqs[2];
        }
        try {

            String sql = "select count(*) from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"'";

            String bmbms = sqlOperator.queryOneRecorderData(sql);

            sql = "select kc.f_Bmbm,bm.f_Bmmc,sp.f_Sptm,sp.f_ypzjh,sp.f_Spmc,sp.f_Ggxh,sp.f_Jldw,kc.f_kcsl,\n" +
                    "kc.f_kcsj,CAST(kc.f_kcje as DECIMAL(13,2)) as f_cbje,isnull(bj.f_Bjkc,'') f_Bjkc \n" +
                    "from tb"+f_shbm+"_spkc kc \n" +
                    "left join tb"+f_shbm+"_Spda sp on sp.f_Sptm = kc.f_Sptm \n" +
                    "left join tb"+f_shbm+"_Spgjcb gjcb on gjcb.f_Sptm = kc.f_Sptm and gjcb.f_Pch = kc.f_pch and gjcb.f_Gjsl >0 \n" +
                    "left join tb"+f_shbm+"_Spgjzb gjzb on gjzb.f_Djh = gjcb.f_Djh \n" +
                    "left join tb"+f_shbm+"_Csda cs on cs.f_Csbm = gjzb.f_Gysbm \n"+
                    "left join tb"+f_shbm+"_Bmda bm on bm.f_Bmbm = kc.f_Bmbm " +
                    "left join tb"+f_shbm+"_Bjkc bj on bm.f_Bmbm = bj.f_Bmbm and sp.f_Sptm = bj.f_Sptm " +
                    "where 1=1 and (kc.f_kcsl != 0 and kc.f_kcje != 0)";
            if(bmbms != null && !"0".equals(bmbms)){
                sql+="and kc.f_Bmbm in(select f_Bmbm from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"') ";
            }
            if(!"".equals(kcrq)){
                sql+="and f_Rq = (select MAX(f_Rq) from tb"+f_shbm+"_spkc where f_Rq <= '"+kcrq+"' and f_Sptm = kc.f_Sptm) ";
            }
            if(!"".equals(spmc)){
                sql+="and sp.f_Spmc like '%"+spmc+"%' ";
            }
            if(!"".equals(sptm)){
                sql+="and kc.f_Sptm like '%"+sptm+"%' ";
            }
            if(!"".equals(djh)){
                sql+="and sp.f_ypzjh like '%"+djh+"%' ";
            }
            if(!"".equals(gysmc)){
                sql+="and cs.f_Csmc like '%"+gysmc+"%' or cs.f_Zjf like '%"+gysmc+"%' ";
            }
            if(!"".equals(gysbm)){
                sql+="and gjzb.f_Gysbm = '"+gysbm+"' ";
            }
            result = sqlOperator.RunSQL_JSON(sql);
            JSONArray json = new JSONArray(result);
            for(int i = 0 ; i<json.length() ; i++){
                JSONObject json1 = json.getJSONObject(i);
                String bmbm1 = json1.getString("F_BMBM");
                String sptm1 = json1.getString("F_SPTM");
                for(int j = i+1 ; j<json.length() ; j++){
                    JSONObject json2 = json.getJSONObject(j);
                    String bmbm2 = json2.getString("F_BMBM");
                    String sptm2 = json2.getString("F_SPTM");
                    if(bmbm1.equals(bmbm2) && sptm1.equals(sptm2)){
                        String kcsl2 = json2.getString("F_KCSL");
                        Float kcsl = Float.parseFloat(json1.getString("F_KCSL"))+Float.parseFloat(json2.getString("F_KCSL"));
                        Float kcje = Float.parseFloat(json1.getString("F_CBJE"))+Float.parseFloat(json2.getString("F_CBJE"));
                        json1.put("F_KCSL",kcsl.toString());
                        json1.put("F_CBJE",kcje.toString());
                        json.put(i,json1);
                        json.remove(j);
                        j--;
                    }
                }
            }

            for(int i = 0 ; i<json.length() ; i++){
                JSONObject json1 = json.getJSONObject(i);
                Float kcje = Float.parseFloat(json1.getString("F_CBJE"));
                Float kcsl = Float.parseFloat(json1.getString("F_KCSL"));
                Float cbdj = null;
                if(kcsl == 0){
                    cbdj = 0f;
                }else{
                    cbdj = kcje/kcsl;
                }
                BigDecimal bg = new BigDecimal(cbdj).setScale(2, RoundingMode.UP);
                cbdj = bg.floatValue();
                json1.put("F_CBDJ",cbdj.toString());
                json.put(i,json1);
            }

            if(pageIndex != null){
                int start = (pageIndex - 1) * pageSize;
                int end = pageIndex * pageSize;
                int index = 0;
                JSONArray jsonResult = new JSONArray();
                for (int i = start ; i < end ; i++){
                    if(i >= json.length()){
                        break;
                    }
                    jsonResult.put(index,json.getJSONObject(i));
                    index++;
                }

                result = jsonResult.toString();
            }else{
                result = json.toString();
            }

            System.out.println(result);

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
    public String getKctzs_total(String kcrq, String spmc, String djh, String sptm, String gysbm, String gysmc,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");

        String result = null;
        if(!"".equals(kcrq)){
            String[] ksrqs = kcrq.split("-");
            kcrq = ksrqs[0]+ksrqs[1]+ksrqs[2];
        }
        try {

            String sql = "select count(*) from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"'";

            String bmbms = sqlOperator.queryOneRecorderData(sql);

            sql = "select kc.f_Bmbm,bm.f_Bmmc,sp.f_Sptm,sp.f_ypzjh,sp.f_Spmc,sp.f_Ggxh,sp.f_Jldw,kc.f_kcsl,\n" +
                    "kc.f_kcsj,CAST(kc.f_kcje as DECIMAL(13,2)) as f_cbje \n" +
                    "from tb"+f_shbm+"_spkc kc \n" +
                    "left join tb"+f_shbm+"_Spda sp on sp.f_Sptm = kc.f_Sptm \n" +
                    "left join tb"+f_shbm+"_Spgjcb gjcb on gjcb.f_Sptm = kc.f_Sptm and gjcb.f_Pch = kc.f_pch and gjcb.f_Gjsl >0 \n" +
                    "left join tb"+f_shbm+"_Spgjzb gjzb on gjzb.f_Djh = gjcb.f_Djh \n" +
                    "left join tb"+f_shbm+"_Csda cs on cs.f_Csbm = gjzb.f_Gysbm \n"+
                    "left join tb"+f_shbm+"_Bmda bm on bm.f_Bmbm = kc.f_Bmbm " +
                    "where 1=1 and (kc.f_kcsl != 0 and kc.f_kcje != 0)";
            if(bmbms != null && !"0".equals(bmbms)){
                sql+="and kc.f_Bmbm in(select f_Bmbm from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"') ";
            }
            if(!"".equals(kcrq)){
                sql+="and f_Rq = (select MAX(f_Rq) from tb"+f_shbm+"_spkc where f_Rq <= '"+kcrq+"' and f_Sptm = kc.f_Sptm) ";
            }
            if(!"".equals(spmc)){
                sql+="and sp.f_Spmc like '%"+spmc+"%' ";
            }
            if(!"".equals(sptm)){
                sql+="and kc.f_Sptm like '%"+sptm+"%' ";
            }
            if(!"".equals(djh)){
                sql+="and sp.f_ypzjh like '%"+djh+"%' ";
            }
            if(!"".equals(gysmc)){
                sql+="and cs.f_Csmc like '%"+gysmc+"%' or cs.f_Zjf like '%"+gysmc+"%' ";
            }
            if(!"".equals(gysbm)){
                sql+="and gjzb.f_Gysbm = '"+gysbm+"' ";
            }
            result = sqlOperator.RunSQL_JSON(sql);
            JSONArray json = new JSONArray(result);
            for(int i = 0 ; i<json.length() ; i++){
                JSONObject json1 = json.getJSONObject(i);
                String bmbm1 = json1.getString("F_BMBM");
                String sptm1 = json1.getString("F_SPTM");
                for(int j = i+1 ; j<json.length() ; j++){
                    JSONObject json2 = json.getJSONObject(j);
                    String bmbm2 = json2.getString("F_BMBM");
                    String sptm2 = json2.getString("F_SPTM");
                    if(bmbm1.equals(bmbm2) && sptm1.equals(sptm2)){
                        String kcsl2 = json2.getString("F_KCSL");
                        Float kcsl = Float.parseFloat(json1.getString("F_KCSL"))+Float.parseFloat(json2.getString("F_KCSL"));
                        Float kcje = Float.parseFloat(json1.getString("F_CBJE"))+Float.parseFloat(json2.getString("F_CBJE"));
                        json1.put("F_KCSL",kcsl.toString());
                        json1.put("F_CBJE",kcje.toString());
                        json.put(i,json1);
                        json.remove(j);
                        j--;
                    }
                }
            }

            result = ""+json.length();
            System.out.println(json.length());
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
    public String getKctzsBj(HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String result = null;
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        try {

            String sql = "select count(*) from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"'";

            String bmbms = sqlOperator.queryOneRecorderData(sql);

            sql = "select kc.f_Bmbm,bm.f_Bmmc,sp.f_Sptm,sp.f_ypzjh,sp.f_Spmc,sp.f_Ggxh,sp.f_Jldw,kc.f_kcsl,\n" +
                    "kc.f_kcsj,CAST(kc.f_kcje as DECIMAL(13,2)) as f_cbje,isnull(bj.f_Bjkc,'0') f_Bjkc,isnull(gjzb.f_Gysbm,'') f_Gysbm,cs2.f_Csmc as f_Gysmc \n" +
                    "from tb"+f_shbm+"_spkc kc \n" +
                    "left join tb"+f_shbm+"_Spda sp on sp.f_Sptm = kc.f_Sptm \n" +
                    "left join tb"+f_shbm+"_Spgjcb gjcb on gjcb.f_Sptm = kc.f_Sptm and gjcb.f_Pch = kc.f_pch and gjcb.f_Gjsl >0 \n" +
                    "left join tb"+f_shbm+"_Spgjzb gjzb on gjzb.f_Djh = gjcb.f_Djh \n" +
                    "left join tb"+f_shbm+"_Csda cs on cs.f_Csbm = gjzb.f_Gysbm \n"+
                    "left join tb"+f_shbm+"_Bmda bm on bm.f_Bmbm = kc.f_Bmbm \n" +
                    "left join tb"+f_shbm+"_Bjkc bj on bm.f_Bmbm = bj.f_Bmbm and sp.f_Sptm = bj.f_Sptm \n" +
                    "left join tb"+f_shbm+"_Csda cs2 on gjzb.f_Gysbm = cs2.f_Csbm and cs2.f_Cslx = '0' \n"+
                    "where 1=1 and (kc.f_kcsl != 0 and kc.f_kcje != 0) ";
            if(bmbms != null && !"0".equals(bmbms)){
                sql+="and kc.f_Bmbm in(select f_Bmbm from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"') ";
            }
            sql+="and f_Rq = (select MAX(f_Rq) from tb"+f_shbm+"_spkc where f_Rq <= '"+format.format(new Date())+"' and f_Sptm = kc.f_Sptm) ";
            result = sqlOperator.RunSQL_JSON(sql);
            JSONArray json = new JSONArray(result);
            for(int i = 0 ; i<json.length() ; i++){
                JSONObject json1 = json.getJSONObject(i);
                String bmbm1 = json1.getString("F_BMBM");
                String sptm1 = json1.getString("F_SPTM");
                for(int j = i+1 ; j<json.length() ; j++){
                    JSONObject json2 = json.getJSONObject(j);
                    String bmbm2 = json2.getString("F_BMBM");
                    String sptm2 = json2.getString("F_SPTM");
                    if(bmbm1.equals(bmbm2) && sptm1.equals(sptm2)){
                        String kcsl2 = json2.getString("F_KCSL");
                        Float kcsl = Float.parseFloat(json1.getString("F_KCSL"))+Float.parseFloat(json2.getString("F_KCSL"));
                        Float kcje = Float.parseFloat(json1.getString("F_CBJE"))+Float.parseFloat(json2.getString("F_CBJE"));
                        json1.put("F_KCSL",kcsl.toString());
                        json1.put("F_CBJE",kcje.toString());
                        json.put(i,json1);
                        json.remove(j);
                        j--;
                    }
                }
            }

            for(int i = 0 ; i<json.length() ; i++){
                JSONObject json1 = json.getJSONObject(i);
                Float kcje = Float.parseFloat(json1.getString("F_CBJE"));
                Float kcsl = Float.parseFloat(json1.getString("F_KCSL"));
                Float cbdj = null;
                if(kcsl == 0){
                    cbdj = 0f;
                }else{
                    cbdj = kcje/kcsl;
                }
                BigDecimal bg = new BigDecimal(cbdj).setScale(2, RoundingMode.UP);
                cbdj = bg.floatValue();
                json1.put("F_CBDJ",cbdj.toString());
                json.put(i,json1);
            }

            for(int i = 0 ; i<json.length() ; i++){
                JSONObject json1 = json.getJSONObject(i);
                Float bjkc = Float.parseFloat(json1.getString("F_BJKC"));
                Float kcsl = Float.parseFloat(json1.getString("F_KCSL"));
                if(kcsl>bjkc){
                    json.remove(i);
                    i--;
                }
            }
            result = json.toString();
            System.out.println(result);

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
    public String getKcpcmx(String kcrq, String sptm, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");

        String result = null;
        if(!"".equals(kcrq)){
            String[] ksrqs = kcrq.split("-");
            kcrq = ksrqs[0]+ksrqs[1]+ksrqs[2];
        }
        try {

            String sql = "select count(*) from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"'";

            String bmbms = sqlOperator.queryOneRecorderData(sql);


            sql = "select kc.f_Bmbm,sp.f_Sptm,sp.f_Spmc,kc.f_kcsl,\n" +
                    " Convert(decimal(18,2),(case kc.f_kcje when 0 then 0 else (f_kcje/f_kcsl) end)) as f_cbdj ,CAST(kc.f_kcje as DECIMAL(13,2)) as f_cbje,kc.f_pch \n" +
                    "from tb"+f_shbm+"_spkc kc \n" +
                    "left join tb"+f_shbm+"_Spda sp on sp.f_Sptm = kc.f_Sptm \n" +
                    "where 1=1 and f_Rq = (select MAX(f_Rq) from tb"+f_shbm+"_spkc where f_Rq <= '"+kcrq+"' and f_Sptm = kc.f_Sptm) and kc.f_Sptm like '%"+sptm+"%' ";
            if(bmbms != null && !"0".equals(bmbms)){
                sql+="and kc.f_Bmbm in(select f_Bmbm from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"') ";
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
     * 获取权限信息
     * @param f_JB
     * @param f_Qxbm
     * @return
     */
    public String getQxxx(int f_JB, String f_Qxbm,HttpServletRequest request){
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "";
            if (f_JB == 1){
                //查询所有级别为1的权限
                sql="select * from tb"+f_shbm+"_Qx where f_JB='"+f_JB+"' order by f_Qxbm";
            } else if (f_JB == 2) {
                //查询所有级别为2，且qxbm相似1级权限编码的权限
                sql = "select * from tb"+f_shbm+"_Qx where f_Qxbm like '"+f_Qxbm+"%' and f_JB='"+f_JB+"' order by f_Qxbm";
            } else {
                System.out.println("f_JB不存在！");
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
     * 保存菜单
     * @param yjcd
     * @param ejcd
     * @param newcd
     * @return
     */
    public String savecd(String yjcd,String ejcd,String newcd,HttpServletRequest request){
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");

        String result = null;
        try {
            String sql = "";
            //判断是否为管理员登录，只有管理员能修改菜单
            if (f_zybm.endsWith("01")){
                //二级菜单为空时，修改一级菜单
                if(ejcd == null || ejcd.equals("") || ejcd.equals("请选择")){
                    sql = "update tb"+f_shbm+"_Qx set f_Qxmc='"+newcd+"' where f_Qxbm='"+yjcd+"'";
                }else{
                    //二级菜单有值时，只改二级菜单
                    sql = "update tb"+f_shbm+"_Qx set f_Qxmc='"+newcd+"' where f_Qxbm='"+ejcd+"'";
                }
                sqlOperator.ExecSQL(sql);
                result = "ok";
            }else {
                result = "405";
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
    public String SavaBill(String yhje, String jsje, String spxx, String f_zybm, String f_bmbm, String f_zymc, String f_shbm,String ycckbm,String yrckbm) {
        {
            //创建连接池
            openConnection();
            String result = null;
            try {
                String sql="";
                Date day=new Date();
                SimpleDateFormat df = new SimpleDateFormat("HHmmss");
                String f_Xssj=df.format(day);
                SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMdd");
                String f_Rzrq=df1.format(day);
                List<String> sqlList= new ArrayList<>();
                String f_pch=f_Rzrq+f_Xssj;
                JSONArray jarr= new JSONArray(spxx);
                for(int i=0;i<jarr.length();i++){
                    JSONObject jobj=jarr.getJSONObject(i);
                    String f_sptm=jobj.getString("sptm");

                    sql="select * from tb"+f_shbm+"_spda where f_sptm='"+f_sptm+"' and f_f_colum1=0";
                    String spRes=sqlOperator.RunSQL_JSON(sql);
                    JSONArray spjarr=new JSONArray(spRes);
                    JSONObject spJson=spjarr.getJSONObject(0);
                    double f_sl=Double.parseDouble(spJson.getString("F_SL"));
                    double f_gjsl= Double.parseDouble(jobj.getString("gjsl"));
                    double f_yrsl = Double.parseDouble(jobj.getString("gjsl"));//一个批次不够时，f_gjsl会被修改覆盖，影响移入库存的插入
                    double f_gjdj=Double.parseDouble(jobj.getString("gjdj"));

                    //移出仓库当天没有库存数据,需要结算到当天
                    sql="select count(*) from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"'and f_ckbm='"+ycckbm+"'";
                    int count=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                    if(count<=0) {
                        sql = "insert into tb"+f_shbm+"_cksjb\n" +
                                "select '" + f_Rzrq + "',f_Bmbm,f_Sptm,f_pch,f_Sgpch,f_kcsl,f_kcje,f_kcsj,f_ckbm from " +
                                "tb"+f_shbm+"_cksjb where f_Sptm='" + f_sptm + "' and f_ckbm='"+ycckbm+"' and f_Rq=(select MAX(f_Rq) from tb"+f_shbm+"_cksjb where f_Sptm='" + f_sptm + "' and f_ckbm='"+ycckbm+"') and f_kcsl>0";
                        sqlOperator.ExecSQL(sql);//结转库存到当天
                    }

                    //移出仓库当天没有库存数据,需要结算到当天
                    sql="select count(*) from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"'and f_ckbm='"+yrckbm+"'";
                    int count1=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                    if(count1<=0) {
                        sql = "insert into tb"+f_shbm+"_cksjb\n" +
                                "select '" + f_Rzrq + "',f_Bmbm,f_Sptm,f_pch,f_Sgpch,f_kcsl,f_kcje,f_kcsj,f_ckbm from " +
                                "tb"+f_shbm+"_cksjb where f_Sptm='" + f_sptm + "' and f_ckbm='"+yrckbm+"' and f_Rq=(select MAX(f_Rq) from tb"+f_shbm+"_cksjb where f_Sptm='" + f_sptm + "' and f_ckbm='"+yrckbm+"') and f_kcsl>0";
                        sqlOperator.ExecSQL(sql);//结转库存到当天
                    }

                    //判断移出商品数量大于仓库里库存数量
                    sql="select isnull(SUM(f_kcsl),0) from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"' and f_bmbm ='"+f_bmbm+"' and f_ckbm ='"+ycckbm+"'";
                    double f_kcsl= Double.parseDouble(sqlOperator.queryOneRecorderData(sql));
                    if(f_kcsl<f_gjsl){
                        throw  new Exception("库存不足!");
                    }

                    //移出仓库修改库存数量、总金额和税金，优先修改低批次的
                    sql="select * from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_kcsl>0 and f_rq='"+f_Rzrq+"'  and f_bmbm ='"+f_bmbm+"' and f_ckbm ='"+ycckbm+"' order by f_pch asc";
                    String rsKcStr=sqlOperator.RunSQL_JSON(sql);
                    JSONArray rsKcJsons = new JSONArray(rsKcStr);
                    for(int j = 0 ;j<rsKcJsons.length();j++){
                        JSONObject rsKc = rsKcJsons.getJSONObject(j);
                        double pckc= Double.parseDouble(rsKc.getString("F_KCSL"));//批次库存
                        double f_kcje=Double.parseDouble(rsKc.getString("F_KCJE"));//库存金额
                        double f_ykcsj=Double.parseDouble(rsKc.getString("F_KCSJ"));//库存税金
                        double f_kcdj=f_kcje/pckc;
                        String pch=rsKc.getString("F_PCH");
                        if(f_gjsl<=pckc) {//一个批次库存就够
                            double f_ssje=SplitAndRound(f_gjsl*f_gjdj,2);
                            double f_sssj=SplitAndRound(f_ssje/(1+f_sl/100)*f_sl/100,2);//实收税金
                            double f_hscb=SplitAndRound(f_kcdj*f_gjsl,2);//含税成本
                            double f_wscb=SplitAndRound(f_hscb/(1+f_sl/100),2);//无税成本
                            double f_wsml=SplitAndRound(f_ssje-f_sssj-f_wscb,2);//无税毛利
                            double f_kcsj = SplitAndRound(f_hscb / (1 + f_sl / 100) * f_sl / 100, 2);//库存税金
                            sql="update tb"+f_shbm+"_cksjb set f_kcsl=f_kcsl -"+f_gjsl+",f_kcje= f_kcje-"+Double.toString(f_hscb)+",f_kcsj=f_kcsj -"+Double.toString(f_kcsj)+" where f_pch='"+pch+"' and f_sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"' and f_ckbm='"+ycckbm+"' and f_bmbm ='"+f_bmbm+"'";
                            sqlList.add(sql);
                            break;
                        }else {
                            double f_ssje=SplitAndRound(pckc*f_gjdj,2);
                            double f_sssj=SplitAndRound(f_ssje/(1+f_sl/100)*f_sl/100,2);//实收税金
                            double f_hscb=SplitAndRound(f_kcdj*pckc,2);//含税成本
                            double f_wscb=SplitAndRound(f_hscb/(1+f_sl/100),2);//无税成本
                            double f_wsml=f_ssje-f_sssj-f_wscb;//无税毛利
                            sql="update tb"+f_shbm+"_cksjb set f_kcsl='0',f_kcje='0',f_kcsj='0' where f_pch='"+pch+"' and f_sptm='"+f_sptm+"' and f_bmbm ='"+f_bmbm+"'  and f_rq='"+f_Rzrq+"' and f_ckbm='"+ycckbm+"'";
                            sqlList.add(sql);
                            f_gjsl=f_gjsl-pckc;
                            continue;
                        }
                    }

                    //移入仓库插入数据
                    double f_ssje=SplitAndRound(f_yrsl*f_gjdj,2);
                    double f_sssj=SplitAndRound(f_ssje/(1+f_sl/100)*f_sl/100,2);//实收税金
                    sql="insert into tb"+f_shbm+"_cksjb(f_Rq,f_Bmbm,f_Sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj,f_ckbm)" +
                            "values('"+f_Rzrq+"','"+f_bmbm+"','"+f_sptm+"','"+f_pch+"','','"+f_yrsl+"','"+f_ssje+"','"+f_sssj+"','"+yrckbm+"')";
                    sqlList.add(sql);
                }
                sqlOperator.ExecSql(sqlList);
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
    }

    @Override
    public String loadBm(HttpServletRequest request) {
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "select * from tb"+f_shbm+"_Bmda where f_bmlx='0' order by f_bmbm";
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
    public String loadCk(HttpServletRequest request) {
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "select * from tb"+f_shbm+"_ckdawh order by f_ckbm";
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
    public String loadSp(HttpServletRequest request) {
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "select * from tb"+f_shbm+"_Spda order by f_Sptm";
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
    public String loadGys(HttpServletRequest request) {
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "select * from tb"+f_shbm+"_csda where f_Cslx='0' order by f_Csbm";
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
    public String loadCkbb(String kcrq, String f_bmbm, String f_ckbm, String sptm, String gysbm,
                           Integer pageIndex, Integer pageSize, HttpServletRequest request) {
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String total = null;
        String listResult = null;
        try {
            String rq = "";
            String[] kcrqs = kcrq.split("-");
            for(int h = 0; h < kcrqs.length; h++){
                rq += kcrqs[h];
            }


            //查询仓库库存，根据sptm和ckbm去重复，数量求和，单价根据单价总和/批次数，总金额根据数量*平均单价
            //可选参数：f_bmbm,f_ckbm,f_sptm,f_Gysbm
            String[] f_bmbms = null;
            if(f_bmbm != null && !"".equals(f_bmbm)){
                f_bmbms = f_bmbm.split(",");
            }
            String[] f_ckbms = null;
            if(f_ckbm != null && !"".equals(f_ckbm)){
                f_ckbms = f_ckbm.split(",");
            }
            String[] f_sptms = null;
            if(sptm != null && !"".equals(sptm)){
                f_sptms = sptm.split(",");
            }
            String[] f_gysbms = null;
            if(gysbm != null && !"".equals(gysbm)){
                f_gysbms = gysbm.split(",");
            }
            String sql = "select * from\n" +
                    "       (select cksjb.f_bmbm,bmda.f_bmmc,cksjb.f_ckbm,ckda.f_ckmc,cksjb.f_Sptm,spda.f_Spmc,spda.f_Ggxh,spda.f_Jldw,\n" +
                    "           sum(cksjb.f_kcsl) f_kcsl,CAST(sum(cksjb.f_kcje)/case sum(cksjb.f_kcsl) when 0 then 1 else sum(cksjb.f_kcsl) end as DECIMAL(13,2)) f_kcdj,CAST(sum(cksjb.f_kcje) as DECIMAL(13,2)) f_kcje,cksjb.f_Rq\n" +
                    "           from tb"+f_shbm+"_cksjb cksjb\n" +
                    "           left join tb"+f_shbm+"_Bmda bmda on cksjb.f_Bmbm=bmda.f_Bmbm\n" +
                    "           left join tb"+f_shbm+"_ckdawh ckda on cksjb.f_ckbm=ckda.f_ckbm\n" +
                    "           left join tb"+f_shbm+"_Spda spda on cksjb.f_sptm=spda.f_Sptm\n" +
                    "           left join tb"+f_shbm+"_Spgjcb gjcb on cksjb.f_pch=gjcb.f_Pch and cksjb.f_Sptm=gjcb.f_Sptm\n" +
                    "           left join tb"+f_shbm+"_Spgjzb gjzb on gjcb.f_Djh=gjzb.f_Djh\n" +
                    "           where cksjb.f_Rq=(select MAX(f_Rq) from tb"+f_shbm+"_cksjb where f_Rq <= '"+rq+"')";

            if (f_bmbms != null && f_bmbms.length>0){
                sql += " and cksjb.f_Bmbm in (";
                for(int i = 0; i < f_bmbms.length; i++){
                    if (i == f_bmbms.length-1){
                        sql += "'"+f_bmbms[i]+"'";
                    }else {
                        sql += "'"+f_bmbms[i]+"',";
                    }
                }
                sql+=")";
            }
            if (f_ckbms != null && !f_ckbms.equals("")){
                sql += " and cksjb.f_Ckbm in (";
                for(int i = 0; i < f_ckbms.length; i++){
                    if (i == f_ckbms.length-1){
                        sql += "'"+f_ckbms[i]+"'";
                    }else {
                        sql += "'"+f_ckbms[i]+"',";
                    }
                }
                sql += ")";
            }
            if (f_sptms != null && !f_sptms.equals("")){
                sql += " and cksjb.f_Sptm in (";
                for(int i = 0; i < f_sptms.length; i++){
                    if (i == f_sptms.length-1){
                        sql += "'"+f_sptms[i]+"'";
                    }else {
                        sql += "'"+f_sptms[i]+"',";
                    }
                }
                sql += ")";
            }
            if (f_gysbms != null && !f_gysbms.equals("")){
                sql += " and gjzb.f_Gysbm in (";
                for(int i = 0; i < f_gysbms.length; i++){
                    if (i == f_gysbms.length-1){
                        sql += "'"+f_gysbms[i]+"'";
                    }else {
                        sql += "'"+f_gysbms[i]+"',";
                    }
                }
                sql += ")";
            }
            sql += "group by cksjb.f_bmbm,bmda.f_bmmc,cksjb.f_ckbm,ckda.f_ckmc,cksjb.f_Sptm,spda.f_Spmc,spda.f_Ggxh,spda.f_Jldw,cksjb.f_Rq) a\n" +
                    "order by a.f_Rq";
            listResult = sqlOperator.RunSQL_JSON(sql);


            JSONArray json = new JSONArray(listResult);
            //pageIndex:当前页数,3    pageSize:页面容量,5   start:当前页面开始记录数,10  end:当前页面结束记录数,15(不包含15)     第三页展示第10~14条记录
            if(pageIndex != null){//当前页数
                int start = (pageIndex - 1) * pageSize;//开始页数
                int end = pageIndex * pageSize;//结束页数
                int index = 0;
                JSONArray jsonResult = new JSONArray();
                for (int i = start ; i < end ; i++){
                    if(i >= json.length()){
                        break;
                    }
                    jsonResult.put(index,json.getJSONObject(i));
                    index++;
                }
                total = jsonResult.length()+"";
            }else{
                total = json.length()+"";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("list",listResult);
        jsonObject.put("total",total);
        return jsonObject.toString();
    }


    //double 四舍五入;
    public double SplitAndRound(double a, int n) {
        a = a * Math.pow(10, n);
        return (Math.round(a)) / (Math.pow(10, n));
    }
}
