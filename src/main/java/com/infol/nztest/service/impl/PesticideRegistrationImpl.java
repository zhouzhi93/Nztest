package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.PesticideRegistrationService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@Transactional
@Service
public class PesticideRegistrationImpl implements PesticideRegistrationService{
    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String GetKhda(String f_sfzh,String f_dh){
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql="";
            ResultSet rs=sqlOperator.RunSQLToResSet("select * from tbshda where f_shzt='1'");
            while(rs.next()) {
                String fgsh = (String) rs.getString("f_shbm");
                String sqlsub = "select '"+fgsh+"' f_shbm,* from tb"+fgsh+"_csda where f_cslx='1' ";
                if(!f_sfzh.equals("")){
                    sqlsub+=" and f_sfzh = '"+f_sfzh+"'";
                }
                if(!f_dh.equals("")) {
                    sqlsub+=" and f_dh = '"+f_dh+"'";
                }
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
    public  String  GetSaleZbxx(String f_cxtj,String f_shbm,String f_khbm,String f_nybz){
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql="";
            ResultSet rs=sqlOperator.RunSQLToResSet("select * from tbshda where f_shzt='1'");
            while(rs.next()) {
                String fgsh = (String) rs.getString("f_shbm");
                String sqlsub = "select zb.f_Djh,bmda.f_Bmmc,zb.f_Rzrq,zb.f_Xssj,cb.f_Sptm," +
                        "f_Spmc,f_Xsdj,f_Xssl,f_Ggxh,f_jldw,f_Ssje,spda.f_ypzjh," +
                        "isnull((select top 1(f_Csmc) from tb"+fgsh+"_Gysdz dz left join tb"+fgsh+"_Csda csda on csda.f_Csbm=dz.f_Gysbm where dz.f_Sptm=cb.f_sptm),'')f_gysmc " +
                        "from tb"+fgsh+"_Xsmxcb cb \n" +
                        "left join tb"+fgsh+"_Xsmxzb zb on zb.f_Djh=cb.f_Djh \n" +
                        "left join tb"+fgsh+"_Spda spda on spda.f_Sptm=cb.f_Sptm \n" +
                        "left join tb"+fgsh+"_bmda bmda on bmda.f_Bmbm=zb.f_Bmbm where f_khbm='"+f_khbm+"'" +
                        " and f_xssl>0 and spda.f_nybz='"+f_nybz+"'\n ";
                if(!f_cxtj.equals("")){
                    sqlsub+=" and f_Spmc like'%"+f_cxtj+"%'";
                }
                if(sql.equals("")){
                    sql=sqlsub;
                }else
                {
                    sql+=" union all ";
                    sql+=  sqlsub;
                }
            }
            sql="select * from ("+sql+") m order by f_djh desc";
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
     * 保存农药登记
     * @param splist
     * @return
     */
    @Override
    public String SavaNydj(String splist){
        //创建连接池
        openConnection();
        String result = null;
        try {
            JSONArray jarr= new JSONArray(splist);
            if(jarr.length()==0){throw new Exception("没有需要保存的数据!");}
            List<String> sqlList= new ArrayList<>();
            String sql="";
            for(int i=0;i<jarr.length();i++){
                JSONObject jobj=jarr.getJSONObject(i);
                sql="insert into tbnysydj(f_nybz,f_khmc,f_sfzh,f_lxdh,f_nymc,f_nyzjh,f_ggxh,f_bmmc,f_gjsj," +
                        "f_djh,f_jldw,f_nysl,f_csmc,f_yysj,f_nzw,f_fzdx,f_sysl,F_pbnd,f_sycs,f_zhsj,f_yyjgsj,f_bz)" +
                        "values('"+jobj.getString("f_nybz")+"'," +
                        "'"+jobj.getString("f_khmc")+"'," +
                        "'"+jobj.getString("f_sfzh")+"','"+jobj.getString("f_lxdh")+"'," +
                        "'"+jobj.getString("f_nymc")+"','"+jobj.getString("f_nyzjh")+"'," +
                        "'"+jobj.getString("f_ggxh")+"','"+jobj.getString("f_bmmc")+"'," +
                        "'"+jobj.getString("f_gjsj")+"','"+jobj.getString("f_djh")+"'," +
                        "'"+jobj.getString("f_jldw")+"','"+jobj.getString("f_nysl")+"'," +
                        "'"+jobj.getString("f_csmc")+"','"+jobj.getString("f_yysj")+"'," +
                        "'"+jobj.getString("f_nzw")+"','"+jobj.getString("f_fzdx")+"'," +
                        "'"+jobj.getString("f_sysl")+"','"+jobj.getString("f_pbnd")+"'," +
                        "'"+jobj.getString("f_sycs")+"','"+jobj.getString("f_zhsj")+"'," +
                        "'"+jobj.getString("f_yyjgsj")+"','"+jobj.getString("f_bz")+"')";
                sqlList.add(sql);
            }
            sqlOperator.ExecSql(sqlList);
            return "ok";
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
