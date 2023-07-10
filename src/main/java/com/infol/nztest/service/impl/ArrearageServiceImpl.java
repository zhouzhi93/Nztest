package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.ArrearageService;
import com.infol.nztest.service.PurchaseService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import util.UtilTools;

import javax.servlet.http.HttpServletRequest;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.*;

@Transactional
@Service
public class ArrearageServiceImpl implements ArrearageService{
    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    @Transactional
    public String SavaBill(String f_gysbm,String yhje,String jsje,String spxx,String f_zybm,String f_bmbm,String f_zymc,String f_shbm,String f_djbz)
    {
        //创建连接池
        openConnection();
        String result = null;
        try {
            String sql="";
//            String sql="select isnull(MAX(f_djh),'0000000000') from tb"+f_shbm+"_Spgjzb";
//            String maxDjh=sqlOperator.queryOneRecorderData(sql);
//            int djhlen=maxDjh.length();
//            int bm=Integer.parseInt(maxDjh)+1;
//            String f_djh=String.valueOf(bm);
//            while(f_djh.length()<djhlen){
//                f_djh = "0" + f_djh;
//            }
            String f_djh=newBillNo(f_shbm,sqlOperator);
            Date day=new Date();
            SimpleDateFormat df = new SimpleDateFormat("HHmmss");
            String f_Xssj=df.format(day);
            SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMdd");
            String f_Rzrq=df1.format(day);
            String f_Zfbz="1";
            String f_djlx="0";
            String f_ckbm="01";
            List<String> sqlList= new ArrayList<>();
            sql = "insert tb"+f_shbm+"_Spgjzb(f_Gjlx,f_Djh,f_Zdrq,f_Rzrq,f_Zdrbm,f_Zdrmc,f_Zrrbm,f_Bmbm,f_Ckbm,f_djbz,f_Gysbm,f_Jyfs,f_Djlx,f_State)\n" +
                    "values('0','"+f_djh+"','"+f_Rzrq+"','"+f_Rzrq+"','"+f_zybm+"','"+f_zymc+"',"+f_zybm+",'"+f_bmbm+"','"+f_ckbm+"','"+f_djbz+"','"+f_gysbm+"','0','0','1')";
            sqlList.add(sql);
            String f_pch=f_Rzrq+f_Xssj;
            JSONArray jarr= new JSONArray(spxx);
            for(int i=0;i<jarr.length();i++){
                JSONObject jobj=jarr.getJSONObject(i);
                String f_sptm=jobj.getString("sptm");
                String f_sgpch=jobj.getString("sgpch");//手工批次号
                sql="select * from tb"+f_shbm+"_spda where f_sptm='"+f_sptm+"' and f_f_colum1=0";
                String spRes=sqlOperator.RunSQL_JSON(sql);
                JSONArray spjarr=new JSONArray(spRes);
                JSONObject spJson=spjarr.getJSONObject(0);
                double f_sl=Double.parseDouble(spJson.getString("F_SL"));
                String f_ypzjh=spJson.getString("F_YPZJH");
                double f_gjsl= Double.parseDouble(jobj.getString("gjsl"));
                double f_gjdj=Double.parseDouble(jobj.getString("gjdj"));
                double f_ssje=f_gjsl*f_gjdj;
                double f_sssj = SplitAndRound(f_ssje / (1 + f_sl / 100) * f_sl / 100, 2);//税金
                sql="select count(*) from tb"+f_shbm+"_spkc where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"'";
                int count=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                if(count<=0) {//当天没有库存数据,需要结算到当天
                    sql = "insert into tb"+f_shbm+"_spkc\n" +
                            "select '" + f_Rzrq + "',f_Bmbm,f_Sptm,f_pch,f_Sgpch,f_kcsl,f_kcje,f_kcsj from " +
                            "tb"+f_shbm+"_spkc where f_Sptm='" + f_sptm + "' and f_Rq=(select MAX(f_Rq) from tb"+f_shbm+"_spkc where f_Sptm='" + f_sptm + "') and f_kcsl>0";
                    sqlOperator.ExecSQL(sql);//结转库存到当天
                }
                sql="insert into tb"+f_shbm+"_Spgjcb(f_Bmbm,f_Gjlx,f_Djh,f_Dnxh,f_Ckbm,f_Sptm,f_ypzjh,f_Gjsl,f_Gjdj,f_Gjje,f_Gjsj,f_Sl,f_Lsdj,f_Lsje,f_Pch,f_sgpch)\n" +
                        "values('"+f_bmbm+"','0','"+f_djh+"','"+Integer.toString(i)+"','"+f_ckbm+"','"+f_sptm+"'," +
                        "'"+f_ypzjh+"','"+f_gjsl+"','"+f_gjdj+"',"+f_ssje+",'"+f_sssj+"','"+f_sl+"','"+f_gjdj+"','0','"+f_pch+"','"+f_sgpch+"')";
                sqlList.add(sql);
                sql="insert into tb"+f_shbm+"_spkc(f_Rq,f_Bmbm,f_Sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj)" +
                        "values('"+f_Rzrq+"','"+f_bmbm+"','"+f_sptm+"','"+f_pch+"','"+f_sgpch+"','"+f_gjsl+"','"+f_ssje+"','"+f_sssj+"')";
                sqlList.add(sql);
            }
            sqlOperator.ExecSql(sqlList);
            result="ok|"+f_djh;
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
    public String GetBillDetail(String khxx, String bmbm,String f_ksrq,String f_jsrq,String f_shbm,String f_zybm)
    {
//创建连接池
        openConnection();

        String result = null;
        try {
            String zysxbm=GetZysxbmByZybm(f_zybm,f_shbm,sqlOperator);
            String sql = "select qk.f_Bmbm,bm.f_Bmmc,bm.f_Dh as f_bmdh,cs.f_Csmc f_khmc,cs.f_sfzh,cs.f_Dh,qk.f_qkrq,qk.f_Djh,qk.f_qkje,qk.f_ysje,qk.f_syje " +
                    "from tb"+f_shbm+"_Qkmxb qk left join tb"+f_shbm+"_Csda cs on qk.f_Khbm = cs.f_Csbm and f_Cslx = 1 " +
                    "left join tb"+f_shbm+"_Bmda bm on qk.f_Bmbm = bm.f_Bmbm ";
            if(f_ksrq != null && !"".equals(f_ksrq)){
                sql += "where f_qkrq between '"+f_ksrq+"' and '"+f_jsrq+"' and qk.f_syje > 0 ";
            }else{
                sql += "where f_qkrq <= '"+f_jsrq+"' and qk.f_syje > 0 ";
            }

            if(!khxx.equals("")){
               sql+=" and (cs.f_Csmc like '%"+khxx+"%' or cs.f_Zjf like '%"+khxx+"%')";
            }
            if(!zysxbm.equals("")){
                sql+=" and qk.f_bmbm in("+zysxbm+")";
            }
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

    @Override
    public String proceeds(String f_djh, String f_bmbm, Double f_qkje, Double f_skje, Double f_syje, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String sql="";
            f_syje = f_syje-f_skje;
            f_skje = f_qkje-f_syje;
            sql="update tb"+f_shbm+"_Qkmxb set f_ysje='"+f_skje+"',f_syje='"+f_syje+"' " +
                    "where f_djh = '"+f_djh+"' and f_bmbm = '"+f_bmbm+"'";
            sqlOperator.executeUpdate(sql);
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

    //double 四舍五入;
    public double SplitAndRound(double a, int n) {
        a = a * Math.pow(10, n);
        return (Math.round(a)) / (Math.pow(10, n));
    }
    /**
     * @deprecated 获取最大单据号+1
     * @param f_shbm
     * @param
     * @return
     */
    public String newBillNo(String f_shbm,SqlServerOperator sqlser) {
        String bm = null;
        UtilTools ut = new UtilTools();
        try {
            StringBuilder sql = new StringBuilder();
            String rq = this.retime().substring(0,6);
            sql.append("select max(f_djh) f_djh ");
            sql.append(" from tb").append(f_shbm).append("_spgjzb ");
            sql.append(" where f_djh like '").append(rq).append("%'");
            String f_djh = sqlser.queryOneRecorderData(sql.toString());
            if (f_djh == null || "".equals(f_djh)) return rq + "0001";
            bm =  ut.bmAddOne(f_djh);
        } catch(Exception e){
        } finally {
//            this.sqlOperator.closeConnection();
        }
        return bm;
    }
    private static String retime() {
        Calendar date = new GregorianCalendar();
        return String.valueOf(date.get(Calendar.YEAR)*10000+(date.get(Calendar.MONTH)+1)*100+date.get(Calendar.DATE));

    }
    /**
    *职员所辖部门编码
    */
    private String GetZysxbmByZybm(String f_zybm,String f_shbm,SqlServerOperator sqlOperator) {
        String result = "";
        try {
            String sql = "select f_bmbm from tb"+f_shbm+"_zysxbm where f_Zybm='"+f_zybm+"'";
            ResultSet rs = sqlOperator.RunSQLToResSet(sql);
            while (rs.next()){
                if(result==""){
                    result="'"+rs.getString("f_bmbm")+"'";
                }else{
                    result+=",'"+rs.getString("f_bmbm")+"'";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  result;
    }
}
