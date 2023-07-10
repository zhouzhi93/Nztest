package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.AdminClerkService;
import com.infol.nztest.service.JGClerkService;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import util.MD5;
import util.Node;
import util.NodeUtil;

import java.text.SimpleDateFormat;
import java.util.*;

@Transactional
@Service
public class JGClerkServiceImpl implements JGClerkService {
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
            String sql = "select zy.*,f_qymc from tbJGZyda zy \n" +
                    "left Join tbqyda qy on zy.f_FGQY = qy.f_qybm ";
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
    public String addZymx(String zylx, String zymc, String zykl, String dh,String dwmc,String fgqy) {
        //创建连接池
        openConnection();

        List<String> sqls = new ArrayList<>();

        String result = null;
        try {
            String sql=" select MAX(f_Zybm) from tbJGZyda";
            String maxBm=sqlOperator.queryOneRecorderData(sql);
            if(maxBm == null || "".equals(maxBm)){
                maxBm = "000000";
            }
            int bmlen=maxBm.length();
            int bm = Integer.parseInt(maxBm)+1;
            String f_zybm=String.valueOf(bm);
            while(f_zybm.length()<bmlen){
                f_zybm = "0" + f_zybm;
            }

            //暂时不加
            //zykl = MD5.MD5(zykl);
            SimpleDateFormat format = new SimpleDateFormat("YYYYmmdd");
            if("".equals(zykl) || zykl == null){
                sql = "insert into tbJGZyda(f_zylx,f_Zybm,f_Zymc,f_dh,f_dwmc,f_FGQY) " +
                        "values('"+zylx+"','"+f_zybm+"','"+zymc+"','"+dh+"','"+dwmc+"','"+fgqy+"')";
            }else{
                sql = "insert into tbJGZyda(f_zylx,f_Zybm,f_Zymc,f_Zykl,f_dh,f_dwmc,f_FGQY) " +
                        "values('"+zylx+"','"+f_zybm+"','"+zymc+"','"+zykl+"','"+dh+"','"+dwmc+"','"+fgqy+"')";
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
    public String removeZymx(String zybm) {
        //创建连接池
        openConnection();

        List<String> sqls = new ArrayList<>();

        String result = null;
        try {
            String sql = "delete from tbJGZyda where f_Zybm = '"+zybm+"'";
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
    public String updateZymx(String zylx, String zybm, String zymc, String zykl, String dh,String dwmc,String fgqy) {
        //创建连接池
        openConnection();

        List<String> sqls = new ArrayList<>();

        if("".equals(zykl) || zykl == null){
            String sql = "select MAX(f_Zykl) from tbJGZyda where f_Zybm = '"+zybm+"'";
            zykl = sqlOperator.queryOneRecorderData(sql);
        }

        String result = null;
        try {

            String sql = "delete from tbJGZyda where f_Zybm = '"+zybm+"'";
            sqls.add(sql);

            //zykl = MD5.MD5(zykl);
            if("".equals(zykl) || zykl == null){
                sql = "insert into tbJGZyda(f_zylx,f_Zybm,f_Zymc,f_dh,f_dwmc,f_FGQY) " +
                        "values('"+zylx+"','"+zybm+"','"+zymc+"','"+dh+"','"+dwmc+"','"+fgqy+"')";
            }else{
                sql = "insert into tbJGZyda(f_zylx,f_Zybm,f_Zymc,f_Zykl,f_dh,f_dwmc,f_FGQY) " +
                        "values('"+zylx+"','"+zybm+"','"+zymc+"','"+zykl+"','"+dh+"','"+dwmc+"','"+fgqy+"')";
            }
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
    public String getQymx() {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "";
            sql = "select * from tbqyda ";
            String jsonStr = sqlOperator.RunSQL_JSON(sql);
            JSONArray jsonArray = new JSONArray(jsonStr);
            JSONArray resutJson = new JSONArray();
            List<Node> nodes = new ArrayList<>();
            for (int i = 0 ; i<jsonArray.length(); i++){
                JSONObject json = jsonArray.getJSONObject(i);
                Integer mj = Integer.parseInt(json.getString("F_MJ"));
                Map<String,Object> map = new HashMap<String,Object>();

                Node node = new Node();
                node.setId(json.getString("F_QYBM"));
                node.setTitle(json.getString("F_QYMC"));
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
    public void saveQymx() {
        //创建连接池
        openConnection();

        List<String> sqls = new ArrayList<>();

        String result = null;
        try {

            String sql = "";
            sql = "select * from tbqyda where f_qybm > 999999";
            String jsonStr = sqlOperator.RunSQL_JSON(sql);
            JSONArray jsonArray = new JSONArray(jsonStr);

            for (int i = 0 ; i<jsonArray.length(); i++){
                JSONObject json = jsonArray.getJSONObject(i);
                String qybm = json.getString("F_QYBM");
                String qymc = json.getString("F_QYMC");
                String sfqy = json.getString("F_SFQY");
                String jb = json.getString("F_JB");
                String mj = json.getString("F_MJ");
                String zjf = json.getString("F_ZJF");
                String sjqybm = qybm.substring(0,4)+qybm.substring(6,qybm.length());
                sql = "delete from tbqyda where f_qybm = '"+qybm+"'";
                sqlOperator.ExecSQL(sql);
                sql = "insert into tbqyda values('"+sjqybm+"','"+qymc+"','"+sfqy+"','"+jb+"','"+mj+"','"+zjf+"')";
                sqlOperator.ExecSQL(sql);
            }


            sql = "select * from tbqyda";
            jsonStr = sqlOperator.RunSQL_JSON(sql);
            jsonArray = new JSONArray(jsonStr);
            for (int i = 0 ; i<jsonArray.length(); i++){
                JSONObject json = jsonArray.getJSONObject(i);
                Integer jb = Integer.parseInt(json.getString("F_JB"));
                Integer mj = Integer.parseInt(json.getString("F_MJ"));
                String qybm = json.getString("F_QYBM");
                Map<String,Object> map = new HashMap<String,Object>();
                if(jb != 1){
                    String sjqybm = qybm.substring(0,qybm.length()-2);
                    sql = "select * from tbqyda where f_qybm = '"+sjqybm+"'";
                    String jsonStr2 = sqlOperator.RunSQL_JSON(sql);
                    if("[]".equals(jsonStr2) || "".equals(jsonStr2) || jsonStr2 == null){
                        sql = "insert into tbqyda values('"+sjqybm+"','其他县','1','"+(jb-1)+"','0','')";
                        sqls.add(sql);
                    }
                }

            }

            HashSet h = new HashSet(sqls);
            sqls.clear();
            sqls.addAll(h);
            sqlOperator.ExecSql(sqls);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
    }

}
