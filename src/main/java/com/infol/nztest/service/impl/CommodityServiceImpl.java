package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.ClerkService;
import com.infol.nztest.service.ClientService;
import com.infol.nztest.service.CommodityService;
import com.infol.nztest.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import util.Node;
import util.NodeUtil;
import util.WordToPinYin;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Transactional
@Service
public class CommodityServiceImpl implements CommodityService {
    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Autowired
    private ClientService clientService;
    @Autowired
    private LoginService loginService;

    @Override
    public String getSpda(String spxx,Integer pageIndex,Integer pageSize,Integer xjbz, HttpServletRequest request) {
        //创建连接池
        openConnection();
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String result = null;
        try {
            String clerk = loginService.GetZysxbm(f_zybm,f_shbm);
            JSONArray clerkJson = new JSONArray(clerk);
            String sql = "select spda.f_sptm,spda.f_ypzjh,f_spmc,f_ggxh,f_Jldw,f_Xsdj,spda.f_Zhjj,spda.f_Sl,spda.f_Xxsl,lbda.f_Splbmc,cs.f_Csmc,cs.f_Csbm," +
                    "isnull(lbda.f_Splbbm,'') f_Splbbm,isnull(lbda.f_Jb,'') f_Jb ,isnull(lbda.f_Mj,'') f_Mj,cs.f_Scxkzh,isnull(gysdz.f_Gysbm,'') f_Gysbm,cs2.f_Csmc as f_Gysmc,spda.f_f_colum1 f_splx,f_nybz," +
                    "f_nycpdjz,f_nycpbz,f_nycpbq,f_nycpsms,f_nycpzmwjbh,f_yxcf,f_dxbm,f_yxq,f_scqy,f_ppmc,f_syfw,f_zhl,f_jx,f_mbzzl,f_mbzzldw,f_Xjbz,case when f_sptp = '' then '/image/default.png' else f_sptp end as f_sptp ";
            /*if(clerkJson.length() == 1){
                sql+=",isnull(bj.f_Bjkc,'') f_Bjkc ";
            }else{
                sql+=",'' as f_Bjkc ";
            }*/
            sql+="from tb"+f_shbm+"_spda spda \n" +
                    "left join tb"+f_shbm+"_Splbdz spdz on spda.f_Sptm = spdz.f_Sptm \n" +
                    "left join tb"+f_shbm+"_Splbda lbda on spdz.f_Splbbm = lbda.f_Splbbm \n" +
                    "left join tb"+f_shbm+"_Csda cs on spda.f_Sccsbm = cs.f_Csbm \n" +
                    "left join tb"+f_shbm+"_Gysdz gysdz on gysdz.f_Sptm = spda.f_Sptm \n" +
                    "left join tb"+f_shbm+"_Csda cs2 on gysdz.f_Gysbm = cs2.f_Csbm and cs2.f_Cslx = '0' \n";
            /*if(clerkJson.length() == 1){
                sql += "left join tb"+f_shbm+"_Bjkc bj on bj.f_sptm = spda.f_Sptm and bj.f_bmbm = '"+clerkJson.getJSONObject(0).get("F_BMBM")+"' \n";
            }*/
            sql += " where 1=1 ";
            if(!spxx.equals("") && spxx != null){
                sql+="and spda.f_sptm like '%"+spxx+"%' or spda.f_spmc like '%"+spxx+"%' or f_c_colum3 like '%"+spxx+"%' or spda.f_ypzjh like '%"+spxx+"%' ";
            }
            if(xjbz == 0){
                sql+= "and spda.f_xjbz = '0'";
            }
            result = sqlOperator.RunSQL_JSON(sql);
            JSONArray json = new JSONArray(result);
            for(int i = 0 ; i<json.length() ; i++){
                JSONObject json1 = json.getJSONObject(i);
                String sptm1 = json1.getString("F_SPTM");
                for(int j = i+1 ; j<json.length() ; j++){
                    JSONObject json2 = json.getJSONObject(j);
                    String sptm2 = json2.getString("F_SPTM");
                    if(sptm1.equals(sptm2)){
                        String f_gysbm = json1.getString("F_GYSBM")+","+json2.getString("F_GYSBM");
                        String f_gysmc = json1.getString("F_GYSMC")+","+json2.getString("F_GYSMC");
                        json1.put("F_GYSBM",f_gysbm);
                        json1.put("F_GYSMC",f_gysmc);
                        json.put(i,json1);
                        json.remove(j);
                        j--;
                    }
                }
            }

            int start = (pageIndex - 1) * pageSize;
            int end = pageIndex * pageSize;
            JSONArray jsonResult = new JSONArray();
            int index = 0;
            for (int i = start ; i < end ; i++){
                if(i >= json.length()){
                    break;
                }
                jsonResult.put(index,json.getJSONObject(i));
                index++;
            }

            result = jsonResult.toString();
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
    public String getSpda_total(String spxx,Integer xjbz, HttpServletRequest request) {
        //创建连接池
        openConnection();
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = null;
        try {
            String sql = "select spda.f_sptm,spda.f_ypzjh,f_spmc,f_ggxh,f_Jldw,f_Xsdj,spda.f_Zhjj,spda.f_Sl,spda.f_Xxsl,lbda.f_Splbmc,cs.f_Csmc,cs.f_Csbm," +
                    "isnull(lbda.f_Splbbm,'') f_Splbbm,isnull(lbda.f_Jb,'') f_Jb ,isnull(lbda.f_Mj,'') f_Mj,cs.f_Scxkzh,isnull(gysdz.f_Gysbm,'') f_Gysbm,cs2.f_Csmc as f_Gysmc,spda.f_f_colum1 f_splx,f_nybz," +
                    "f_nycpdjz,f_nycpbz,f_nycpbq,f_nycpsms,f_nycpzmwjbh,f_zhl,f_jx,f_mbzzl,f_mbzzldw \n" +
                    "from tb"+f_shbm+"_spda spda \n" +
                    "left join tb"+f_shbm+"_Splbdz spdz on spda.f_Sptm = spdz.f_Sptm \n" +
                    "left join tb"+f_shbm+"_Splbda lbda on spdz.f_Splbbm = lbda.f_Splbbm \n" +
                    "left join tb"+f_shbm+"_Csda cs on spda.f_Sccsbm = cs.f_Csbm \n" +
                    "left join tb"+f_shbm+"_Gysdz gysdz on gysdz.f_Sptm = spda.f_Sptm \n" +
                    "left join tb"+f_shbm+"_Csda cs2 on gysdz.f_Gysbm = cs2.f_Csbm and cs2.f_Cslx = '0' where 1=1 ";
            if(!spxx.equals("") && spxx != null){
                sql+="and spda.f_sptm like '%"+spxx+"%' or spda.f_spmc like '%"+spxx+"%' or f_c_colum3 like '%"+spxx+"%' ";
            }
            if(xjbz == 0){
                sql+= "and spda.f_xjbz = '0'";
            }
            result = sqlOperator.RunSQL_JSON(sql);
            JSONArray json = new JSONArray(result);
            for(int i = 0 ; i<json.length() ; i++){
                JSONObject json1 = json.getJSONObject(i);
                String sptm1 = json1.getString("F_SPTM");
                for(int j = i+1 ; j<json.length() ; j++){
                    JSONObject json2 = json.getJSONObject(j);
                    String sptm2 = json2.getString("F_SPTM");
                    if(sptm1.equals(sptm2)){
                        String f_gysbm = json1.getString("F_GYSBM")+","+json2.getString("F_GYSBM");
                        String f_gysmc = json1.getString("F_GYSMC")+","+json2.getString("F_GYSMC");
                        json1.put("F_GYSBM",f_gysbm);
                        json1.put("F_GYSMC",f_gysmc);
                        json.put(i,json1);
                        json.remove(j);
                        j--;
                    }
                }
            }
            result = ""+json.length();
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
    public String getMaxSptm(String splbbm, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "select Max(f_sptm) from tb"+f_shbm+"_spda";
            if(!splbbm.equals("")){
                sql+=" where f_sptm like '"+splbbm+"%' ";
            }
            result = sqlOperator.queryOneRecorderData(sql);
            if(result == null){
                result = splbbm+"0000001";
                return result;
            }else{
                int bmlen=result.length();
                long bm=Long.parseLong(result)+1;
                String sptm=String.valueOf(bm);
                while(sptm.length()<bmlen){
                    sptm = "0" + sptm;
                }
                result = sptm;
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
    public String GetSpda(String spxx, HttpServletRequest request) {
        //创建连接池
        openConnection();
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = null;
        try {
            String sql = "select f_sptm,f_spmc,f_ggxh,f_jldw,f_xsdj from tb"+f_shbm+"_spda";
            if(!spxx.equals("")){
                sql+=" where f_sptm like '%"+spxx+"%' or f_spmc like '%"+spxx+"%' or f_c_colum3 like '%"+spxx+"%'";
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
    public String saveSpda(String sptm,String djh,String spmc,String spfl,String ggxh,String jldw,String xsj,
                           String jhj,String jxsl,String xxsl,String scxkz,String ghs,String scqy,String splx,String nybz,
                           String nycpdjz,String nycpbz,String nycpbq,String nycpsms,String nycpzmwjbh,
                           String zhl,String jx,String mbzzl,String mbzzldw,String ppmc,String yxcf,String dx,
                           String yxq,String syfw,HttpServletRequest request) {
        //创建连接池
        openConnection();
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        spmc.trim();
        spmc = spmc.replaceAll("\t","");
        List<String> sqls = new ArrayList<>();

        if(nycpdjz != null && !"".equals(nycpdjz)){
            nycpdjz = request.getRequestURL().toString().replace(request.getRequestURI(),"")+nycpdjz;
        }

        if(nycpbz != null && !"".equals(nycpbz)){
            nycpbz = request.getRequestURL().toString().replace(request.getRequestURI(),"")+nycpbz;
        }

        if(nycpbq != null && !"".equals(nycpbq)){
            nycpbq = request.getRequestURL().toString().replace(request.getRequestURI(),"")+nycpbq;
        }

        if(nycpsms != null && !"".equals(nycpsms)){
            nycpsms = request.getRequestURL().toString().replace(request.getRequestURI(),"")+nycpsms;
        }

        String result = null;
        try {
            String zjf = WordToPinYin.converterToFirstSpell(spmc);

            String sql = "";
            if (djh != null & !djh.equals("")){
                sql = "SELECT count(*) from tb"+f_shbm+"_Spda ";
                sql+=" where f_ypzjh  = '"+djh+"' and f_Ggxh = '"+ggxh+"'";

                result = sqlOperator.queryOneRecorderData(sql);

                if(result != null && !"".equals(result)){
                    if(Integer.parseInt(result) >= 1){
                        return "该商品("+spmc+ggxh+")已添加！";
                    }
                }
            }


            sql = "insert into tb"+f_shbm+"_Spda(f_sptm,f_ypzjh,f_Spmc,f_Ggxh,f_Jldw,f_Xsdj,f_Zhjj,f_scqy,f_jb,f_c_colum3,f_Sl,f_Xxsl,f_f_colum1,f_nybz," +
                    "f_nycpdjz,f_nycpbz,f_nycpbq,f_nycpsms,f_nycpzmwjbh,f_zhl,f_jx,f_mbzzl,f_mbzzldw,f_yxcf,f_dxbm,f_yxq,f_ppmc,f_syfw) " +
                    "values('"+sptm+"','"+djh+"','"+spmc+"','"+ggxh+"','"+jldw+"','"+xsj+"','"+jhj+"','"+scqy+"','1','"+zjf+"','"+jxsl+"','"+xxsl+"','"+splx+"','"+nybz+"'," +
                    "       '"+nycpdjz+"','"+nycpbz+"','"+nycpbq+"','"+nycpsms+"','"+nycpzmwjbh+"','"+zhl+"','"+jx+"','"+mbzzl+"','"+mbzzldw+"','"+yxcf+"','"+dx+"','"+yxq+"','"+ppmc+"','"+syfw+"')";
            sqls.add(sql);
            sql = "insert into tb"+f_shbm+"_Splbdz(f_Splbbm,f_Sptm) " +
                    "values('"+spfl+"','"+sptm+"')";
            sqls.add(sql);
            String[] ghss = ghs.split(",");
            sql = "select Max(f_Xh) from tb"+f_shbm+"_Gysdz where f_Sptm = '"+sptm+"'";
            String xh = sqlOperator.queryOneRecorderData(sql);
            if(xh == null){
                xh = "0";
            }else{
                xh = (Integer.parseInt(xh)+1)+"";
            }
            for(int i = 0 ; i<ghss.length ; i++){
                sql = "select f_Csbm,f_Csmc from tb"+f_shbm+"_csda";
                sql += " where f_Cslx = '0' and f_Csmc = '"+ghss[i]+"'";

                result = sqlOperator.RunSQL_JSON(sql);
                JSONArray jsonArray = null;
                if(result != null && !"".equals(result) && !"[]".equals(result)){
                    jsonArray = new JSONArray(result);
                }else{
                    clientService.AddKhda(ghss[i],"","","","","","","0","",request);
                    sql = "select f_Csbm,f_Csmc from tb"+f_shbm+"_csda";
                    sql += " where f_Cslx = '0' and f_Csmc = '"+ghss[i]+"'";
                    result = sqlOperator.RunSQL_JSON(sql);
                    jsonArray = new JSONArray(result);
                }
                sql = "insert into tb"+f_shbm+"_Gysdz(f_Sptm,f_Gysbm,f_Xh) " +
                        "values('"+sptm+"','"+jsonArray.getJSONObject(0).get("F_CSBM")+"','"+xh+"')";
                sqls.add(sql);
                xh = (Integer.parseInt(xh)+1)+"";
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
    public String saveBjkc(String sptm, String bjkc, HttpServletRequest request) {
        //创建连接池
        openConnection();
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        List<String> sqls = new ArrayList<>();

        String result = null;
        try {

            String sql = "insert into tb"+f_shbm+"_Bjkc(f_bmbm,f_Sptm) \n" +
                    "select f_bmbm,f_sptm from tb"+f_shbm+"_Spda,tb"+f_shbm+"_Bmda \n" +
                    "where not EXISTS(SELECT f_bmbm,f_sptm from tb"+f_shbm+"_Bjkc)";
            sqlOperator.ExecSQL(sql);

            String clerk = null;
            sql = "select sx.f_bmbm,f_Bmmc,CASE f_yjdz WHEN '' THEN '"+f_shbm+"_'+sx.f_Bmbm+'_02' ELSE f_yjdz END as f_yjdz ," +
                    "CASE f_yjzh WHEN '' THEN '"+f_shbm+"_'+sx.f_Bmbm+'_01' ELSE f_yjzh END as f_yjzh,f_yjmm,f_dkqppbm,f_jhgsbm from tb"+f_shbm+"_zysxbm sx left join tb"+f_shbm+"_Bmda bm on bm.f_Bmbm=sx.f_Bmbm where f_Zybm='"+f_zybm+"'";
            String sxbm=sqlOperator.RunSQL_JSON(sql);
            JSONArray jarr=new JSONArray(sxbm);
            if(jarr.length()<=0){
                sql="select f_bmbm,f_Bmmc,f_jhgsbm from tb"+f_shbm+"_bmda";
                clerk=sqlOperator.RunSQL_JSON(sql);
            }else{
                clerk=sxbm;
            }
            JSONArray clerkJson = new JSONArray(clerk);
            for(int i = 0; i<clerkJson.length(); i++){
                JSONObject json = clerkJson.getJSONObject(i);
                if(bjkc != null && !"".equals(bjkc)){
                    sql = "update tb"+f_shbm+"_Bjkc set f_Bjkc = "+bjkc+" ";
                }else{
                    sql = "update tb"+f_shbm+"_Bjkc set f_Bjkc = '' ";
                }
                sql += " where f_Bmbm = '"+json.get("F_BMBM")+"'";
                if(sptm != null && !"".equals(sptm)){
                    sql += " and f_sptm = '"+sptm+"'";
                }
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
    public String updateSpda(String sptm,String djh,String spmc,String spfl,String ggxh,String jldw,String xsj,
                             String jhj,String jxsl,String xxsl,String scxkz,String ghs,String scqy,String splx,String nybz,
                             String nycpdjz,String nycpbz,String nycpbq,String nycpsms,String nycpzmwjbh,
                             String zhl,String jx,String mbzzl,String mbzzldw,String ppmc,String yxcf,String dx,String yxq,
                             String syfw,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        spmc.trim();
        spmc = spmc.replaceAll("\t","");
        List<String> sqls = new ArrayList<>();

        if(nycpdjz != null && !"".equals(nycpdjz)){
            nycpdjz = request.getRequestURL().toString().replace(request.getRequestURI(),"")+nycpdjz;
        }

        if(nycpbz != null && !"".equals(nycpbz)){
            nycpbz = request.getRequestURL().toString().replace(request.getRequestURI(),"")+nycpbz;
        }

        if(nycpbq != null && !"".equals(nycpbq)){
            nycpbq = request.getRequestURL().toString().replace(request.getRequestURI(),"")+nycpbq;
        }

        if(nycpsms != null && !"".equals(nycpsms)){
            nycpsms = request.getRequestURL().toString().replace(request.getRequestURI(),"")+nycpsms;
        }

        String result = null;
        try {

            String sql = "delete from tb"+f_shbm+"_Splbdz where f_Sptm = '"+sptm+"'";
            sqls.add(sql);
            sql = "delete from tb"+f_shbm+"_Gysdz where f_sptm = '"+sptm+"'";
            sqls.add(sql);
            String zjf = WordToPinYin.converterToFirstSpell(spmc);
            sql = "update tb"+f_shbm+"_Spda set ";
            if(djh != null && !"".equals(djh)){
                sql += "f_ypzjh = '"+djh+"',";
            }
            if(spmc != null && !"".equals(spmc)){
                sql += "f_Spmc = '"+spmc+"',";
            }
            if(ggxh != null && !"".equals(ggxh)){
                sql += "f_Ggxh = '"+ggxh+"',";
            }
            if(jldw != null && !"".equals(jldw)){
                sql += "f_Jldw = '"+jldw+"',";
            }
            if(xsj != null && !"".equals(xsj)){
                sql += "f_Xsdj = '"+xsj+"',";
            }
            if(jhj != null && !"".equals(jhj)){
                sql += "f_Zhjj = '"+jhj+"',";
            }
            if(scqy != null && !"".equals(scqy)){
                sql += "f_scqy = '"+scqy+"',";
            }
            if(zjf != null && !"".equals(zjf)){
                sql += "f_c_colum3 = '"+zjf+"',";
            }
            if(jxsl != null && !"".equals(jxsl)){
                sql += "f_Sl = '"+jxsl+"',";
            }
            if(xxsl != null && !"".equals(xxsl)){
                sql += "f_Xxsl = '"+xxsl+"',";
            }
            if(splx != null && !"".equals(splx)){
                sql += "f_f_colum1 = '"+splx+"',";
            }
            if(nybz != null && !"".equals(nybz)){
                sql += "f_nybz = '"+nybz+"',";
            }
            if(nycpdjz != null && !"".equals(nycpdjz)){
                sql += "f_nycpdjz = '"+nycpdjz+"',";
            }
            if(nycpbz != null && !"".equals(nycpbz)){
                sql += "f_nycpbz = '"+nycpbz+"',";
            }
            if(nycpbq != null && !"".equals(nycpbq)){
                sql += "f_nycpbq = '"+nycpbq+"',";
            }
            if(nycpsms != null && !"".equals(nycpsms)){
                sql += "f_nycpsms = '"+nycpsms+"',";
            }
            if(nycpzmwjbh != null && !"".equals(nycpzmwjbh)){
                sql += "f_nycpzmwjbh = '"+nycpzmwjbh+"',";
            }
            if(ppmc != null && !"".equals(ppmc)){
                sql += "f_ppmc = '"+ppmc+"',";
            }
            if(yxcf != null && !"".equals(yxcf)){
                sql += "f_yxcf = '"+yxcf+"',";
            }
            if(dx != null && !"".equals(dx)){
                sql += "f_dxbm = '"+dx+"',";
            }
            if(yxq != null && !"".equals(yxq)){
                sql += "f_yxq = '"+yxq+"',";
            }
            if(syfw != null && !"".equals(syfw)){
                sql += "f_syfw = '"+syfw+"',";
            }
            if(jx != null && !"".equals(jx)){
                sql += "f_jx = '"+jx+"',";
            }
            if(zhl != null && !"".equals(zhl)){
                sql += "f_zhl = '"+zhl+"',";
            }
            if(mbzzl != null && !"".equals(mbzzl)){
                sql += "f_mbzzl = '"+mbzzl+"',";
            }
            if(mbzzldw != null && !"".equals(mbzzldw)){
                sql += "f_mbzzldw = '"+mbzzldw+"',";
            }
            sql = sql.substring(0,sql.length()-1);
            sql += " where f_sptm = '"+sptm+"'";
            sqls.add(sql);
            sql = "insert into tb"+f_shbm+"_Splbdz(f_Splbbm,f_Sptm) " +
                    "values('"+spfl+"','"+sptm+"')";
            sqls.add(sql);
            String[] ghss = ghs.split(",");
            Integer xh = 0;
            for(int i = 0 ; i<ghss.length ; i++){
                sql = "select f_Csbm,f_Csmc from tb"+f_shbm+"_csda";
                sql += " where f_Cslx = '0' and f_Csmc = '"+ghss[i]+"'";

                result = sqlOperator.RunSQL_JSON(sql);
                JSONArray jsonArray = null;
                if(result != null && !"".equals(result) && !"[]".equals(result)){
                    jsonArray = new JSONArray(result);
                }else{
                    clientService.AddKhda(ghss[i],"","","","","","","0","",request);
                    sql = "select f_Csbm,f_Csmc from tb"+f_shbm+"_csda";
                    sql += " where f_Cslx = '0' and f_Csmc = '"+ghss[i]+"'";
                    result = sqlOperator.RunSQL_JSON(sql);
                    jsonArray = new JSONArray(result);
                }
                sql = "insert into tb"+f_shbm+"_Gysdz(f_Sptm,f_Gysbm,f_Xh) " +
                        "values('"+sptm+"','"+jsonArray.getJSONObject(0).get("F_CSBM")+"','"+xh+"')";
                sqls.add(sql);
                xh++;
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
    public String updateSpTp(String sptm, String sptp, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        List<String> sqls = new ArrayList<>();

        String result = null;
        //sptp = request.getRequestURL().toString().replace(request.getRequestURI(),"")+sptp;
        try {

            String sql = "update tb"+f_shbm+"_Spda set ";
            if(sptp != null && !"".equals(sptp)){
                sql += "f_sptp = '"+sptp+"',";
            }
            sql = sql.substring(0,sql.length()-1);
            sql += " where f_sptm = '"+sptm+"'";
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
    public String stopstart(String sptm,Integer xjbz,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        List<String> sqls = new ArrayList<>();
        String result = null;
        try {

            String sql = "update tb"+f_shbm+"_Spda set f_xjbz = '"+xjbz+"' ";
            sql += " where f_sptm = '"+sptm+"'";
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
    public String removeSpda(String sptm, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        List<String> sqls = new ArrayList<>();

        String result = null;
        try {


            String sql = "delete from tb"+f_shbm+"_Splbdz where f_sptm = '"+sptm+"'";
            sqls.add(sql);

            sql = "delete from tb"+f_shbm+"_Gysdz where f_sptm = '"+sptm+"'";
            sqls.add(sql);
            sql = "delete from tb"+f_shbm+"_Spda where f_sptm = '"+sptm+"'";
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
    public String getMaxSplbbm(String splbbm,String jb, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            if("".equals(splbbm)){
                String sql = "select Max(f_Splbbm) from tb"+f_shbm+"_Splbda where f_jb = '1'";
                result = sqlOperator.queryOneRecorderData(sql);
            }else{
                String sql = "select Max(f_Splbbm) from tb"+f_shbm+"_Splbda where f_Splbbm like '"+splbbm+"%' and f_jb = '"+jb+"'";
                result = sqlOperator.queryOneRecorderData(sql);
            }

            if(result == null){
                result = splbbm+"01";
            }else{
                result = "0"+(Integer.parseInt(result)+1);
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
     * 获得商品类别
     * @param splbbm
     * @param request
     * @return
     */
    @Override
    public String getSplb(String splbbm, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "";
            if("".equals(splbbm)){
                sql = "select * from tb"+f_shbm+"_Splbda";
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
                    node.setId(json.getString("F_SPLBBM"));
                    node.setTitle(json.getString("F_SPLBMC"));
                    if(mj == 1){
                        node.setType("item");
                    }else{
                        node.setType("folder");

                    }
                    nodes.add(node);
                    JSONObject resultJson = new JSONObject(map);
                    resutJson.put(resultJson);
                }
                NodeUtil nodeUtil = new NodeUtil();
                result = nodeUtil.NodeTree(nodes);
                System.out.println(result);
            }else{
                sql = "select * from tb"+f_shbm+"_Splbda where f_Splbbm = '"+splbbm+"'";
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
    public String getSplbmx(String splbbm, String jb, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql = "";
            if("".equals(splbbm) || splbbm == null){
                sql = "select * from tb"+f_shbm+"_Splbda where f_jb = '1' ";
            }else{
                sql = "select * from tb"+f_shbm+"_Splbda where f_Splbbm like '"+splbbm+"%' and f_jb = '"+jb+"'";
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
    public String saveSplbda(String splbbm, String splbmc, String bz,String jb, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        List<String> sqls = new ArrayList<>();

        String result = null;
        try {

            String sql = "select * from tb"+f_shbm+"_Splbda where f_Splbbm = '"+splbbm+"'";

            String temp = sqlOperator.RunSQL_JSON(sql);

            if(temp != null && !"".equals(temp) && !"[]".equals(temp)){
                sql = "update tb"+f_shbm+"_Splbda set f_Splbmc = '"+splbmc+"',f_Memo = '"+bz+"' where f_Splbbm = '"+splbbm+"' ";
                sqls.add(sql);
            }else{
                sql = "insert into tb"+f_shbm+"_Splbda(f_Splbbm,f_Splbmc,f_Jb,f_Mj,f_Memo) " +
                        "values('"+splbbm+"','"+splbmc+"','"+jb+"','1','"+bz+"')";
                sqls.add(sql);
                if(splbbm.length() > 2){
                    String sjlbbm = splbbm.substring(0,splbbm.length()-2);
                    sql = "update tb"+f_shbm+"_Splbda set f_Mj = '0' where f_Splbbm = '"+sjlbbm+"' ";
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
     * 加载毒性列表
     * @param request
     * @return
     */
    @Override
    public String loadDx(HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {

            String sql = "select * from tb"+f_shbm+"_Dxb order by f_dxbm";

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
    public String loadSyfw(HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {

            String sql = "select f_flbm from tb"+f_shbm+"_tjlxwh where f_sfzylx='1'";
            String flbmResult = sqlOperator.RunSQL_JSON(sql);
            sql = "";
            JSONArray jarr = new JSONArray(flbmResult);
            for (int i = 0; i < jarr.length(); i++){
                String f_flbm = jarr.getJSONObject(i).getString("F_FLBM");
                if (i == jarr.length()-1){
                   sql += "select tjmx.f_flbm,tjmx.f_flmc\n" +
                           "from tb"+f_shbm+"_tjmxwh tjmx\n" +
                           "where tjmx.f_flbm like '"+f_flbm+"%'\n" +
                           "and tjmx.f_mj='1'\n";
                }else {
                    sql += "select tjmx.f_flbm,tjmx.f_flmc\n" +
                            "from tb"+f_shbm+"_tjmxwh tjmx\n" +
                            "where tjmx.f_flbm like '"+f_flbm+"%'\n" +
                            "and tjmx.f_mj='1'\n" +
                            "union all\n";
                }
            }
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


}
