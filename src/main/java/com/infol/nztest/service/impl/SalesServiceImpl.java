package com.infol.nztest.service.impl;

import com.infol.nztest.controller.CameraController;
import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.SalesService;
import com.infol.nztest.service.StorService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import util.HttpUtil;
import util.UtilTools;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;


@Transactional
@Service
public class SalesServiceImpl implements SalesService {

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
    public String GetSpda(String spxx,String f_shbm) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select f_sptm,f_spmc,f_ggxh,f_jldw,convert(decimal(18,2),f_xsdj)f_xsdj,convert(decimal(18,2),f_zhjj)f_zhjj,'' as f_sptp from tb"+f_shbm+"_spda where f_f_colum1=0 and f_xjbz = '0' ";
            if(!spxx.equals("")){
                sql+=" and (f_sptm like '%"+spxx+"%' or f_spmc like '%"+spxx+"%' or f_c_colum3 like '%"+spxx+"%') ";
            }
            sql += " order by f_sptm";
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
    public String GetSpda_PD(String pd,String f_shbm,String type) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql="";
            if(type.equals("0")){
                sql="select f_sptm,f_spmc,f_ggxh,f_jldw,convert(decimal(18,2),f_xsdj)f_xsdj,convert(decimal(18,2),f_Zhjj) f_Zhjj,f_Xjbz from tb"+f_shbm+"_spda where  f_ypzjh='"+pd+"' and f_f_colum1=0";
            }else {
                sql = "select f_sptm,f_spmc,f_ggxh,f_jldw,convert(decimal(18,2),f_xsdj)f_xsdj,convert(decimal(18,2),f_Zhjj) f_Zhjj,f_Xjbz from tb"+f_shbm+"_spda";
                sql+=" where  substring(f_ypzjh,1,2)+substring(f_ypzjh,5,LEN(f_ypzjh))='"+pd+"' and f_f_colum1=0";
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
    public String GetWxsp(String f_zybm,String f_shbm,String f_djlx) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select wx.f_sptm,f_spmc,f_ggxh,f_jldw,convert(decimal(18,2),f_xsdj)f_xsdj from tbwxsp wx inner join tb"+f_shbm+"_Spda sp on sp.f_Sptm=wx.f_sptm where f_shbm='"+f_shbm+"' and f_zybm='"+f_zybm+"' and f_djlx="+f_djlx;
            result = sqlOperator.RunSQL_JSON(sql);
            sql="delete from tbwxsp where f_shbm='"+f_shbm+"' and f_zybm='"+f_zybm+"' and f_djlx="+f_djlx;
            sqlOperator.ExecSQL(sql);
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
    public String GetKhda(String khxx,String identity,String f_shbm) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select f_Csbm,f_Csmc,f_dh,f_jb,f_zjf from tb"+f_shbm+"_csda where f_cslx='1'";
            if(khxx != null && !khxx.equals("")){
                sql+=" and (f_csmc like '%"+khxx+"%' or f_sfzh = '"+khxx+"' or f_zjf like '%"+khxx+"%')";
            }
            if(identity != null && !identity.equals("")){
                sql+=" and f_sfzh like '%"+identity+"%'";
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
    public String AddKhda(String f_khmc,String f_sjhm,String f_sfzh,String f_bzxx,String f_xxdz,String f_shbm) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql=" select isnull(MAX(f_csbm),'000000') from tb"+f_shbm+"_Csda";
            String maxBm=sqlOperator.queryOneRecorderData(sql);
            int bmlen=maxBm.length();
            int bm=Integer.parseInt(maxBm)+1;
            String f_csbm=String.valueOf(bm);
            while(f_csbm.length()<bmlen){
                f_csbm = "0" + f_csbm;
            }
            sql = "insert into tb"+f_shbm+"_csda(f_cslx,f_Csbm,f_Csmc,f_dh,f_jb,f_dz,f_sfzh,f_Bzxx)" +
                    "values('1','"+f_csbm+"','"+f_khmc+"','"+f_sjhm+"','1','"+f_xxdz+"','"+f_sfzh+"','"+f_bzxx+"')";
            sqlOperator.ExecSQL(sql);
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
     * 保存单据
     * @param khbm
     * @param yhje
     * @param jsje
     * @param spxx
     * @param f_zybm
     * @param f_bmbm
     * @param f_zymc
     * @param f_shbm
     * @param redio
     * @param catalogue
     * @param jhgkbm
     * @param zfbz 支付标志 1,现金 2,储值卡 3,卷类 4,空IC卡 5,转账 6,信用卡 12,赊销 13,支付卡 14,会员卡(,分隔)
     * @return
     */
    @Override
    @Transactional
    public String SavaBill(String khbm, String yhje, String jsje, String spxx, String f_zybm, String f_bmbm,
                           String f_zymc, String f_shbm, String redio,String catalogue,String jhgkbm,Integer zfbz)
    {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql="";
            if(yhje == null || "".equals(yhje)){yhje = "0";}
            if(jsje == null || "".equals(jsje)){jsje = "0";}
            //获取最大单据号+1
            String f_djh=newBillNo(f_shbm,sqlOperator);
            Date day=new Date();
            SimpleDateFormat df = new SimpleDateFormat("HHmmss");
            String f_Xssj=df.format(day);//获得时分秒
            SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMdd");
            String f_Rzrq=df1.format(day);//获得年月日
            Integer f_Zfbz=zfbz;//支付标志
            String f_djlx="0";//单据类型 0：正常销售单 1：暂估销售单 2：暂估红冲单
            List<String> sqlList= new ArrayList<>();
            String filename = "";//文件名
            //下载录音文件到服务器
            if(redio != null && !"".equals(redio)){
                filename = f_shbm+"_"+f_bmbm+"_"+f_djh+".mp3";//商户编码_部门编码_单据号.mp3
                CameraController.decoderBase64File(redio,catalogue+filename,catalogue);
            }

            sql = "insert into tb"+f_shbm+"_Xsmxzb(f_Djh,f_Bmbm,f_Syybm,f_Syymc,f_Xssj,f_Rzrq,f_Zfbz,f_Djlx,f_Khbm,f_Yyybm,f_Zfje,rediourl,f_Ckbm)values" +
                    "('"+f_djh+"','"+f_bmbm+"','"+f_zybm+"','"+f_zymc+"','"+f_Xssj+"','"+f_Rzrq+"','"+f_Zfbz+"','"+f_djlx+"','"+khbm+"','"+f_zybm+"','"+jsje+"','"+filename+"','')";
            sqlList.add(sql);

            JSONArray jarr= new JSONArray(spxx);//将商品信息转换成jsonArray
            int dnxh=0;//单内序号
            for(int i=0;i<jarr.length();i++){
                JSONObject jobj=jarr.getJSONObject(i);//商品信息遍历

                String f_ckbm=jobj.getString("ckbm");//获取仓库编码
                if (f_ckbm.equals("undefined")){
                    f_ckbm = "001";
                }

                String f_sptm=jobj.getString("sptm");//获取商品编码
                //从商品库存表查询条数，根据商品编码和年月日
                sql="select count(*) from tb"+f_shbm+"_spkc where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"'";
                int count=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                //当天没有库存数据,需要结算到当天
                if(count<=0) {
                    sql = "insert into tb"+f_shbm+"_spkc\n" +
                            "select '" + f_Rzrq + "',f_Bmbm,f_Sptm,f_pch,f_Sgpch,f_kcsl,f_kcje,f_kcsj from " +
                            "tb"+f_shbm+"_spkc where f_Sptm='" + f_sptm + "' and f_Rq=(select MAX(f_Rq) from tb"+f_shbm+"_spkc where f_Sptm='" + f_sptm + "') and f_kcsl>0";
                    sqlOperator.ExecSQL(sql);//结转库存到当天
                }

                //从仓库数据表查询条数，根据商品编码,年月日和库存编码
                sql="select count(*) from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"' and f_ckbm='"+f_ckbm+"'";
                int count1=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                //当天没有库存数据,需要结算到当天
                if(count1<=0) {
                    sql = "insert into tb"+f_shbm+"_cksjb\n" +
                            "select '" + f_Rzrq + "',f_Bmbm,f_Sptm,f_pch,f_Sgpch,f_kcsl,f_kcje,f_kcsj,f_ckbm from " +
                            "tb"+f_shbm+"_cksjb where f_Sptm='" + f_sptm + "' and f_ckbm='"+f_ckbm+"' and f_Rq=(select MAX(f_Rq) from tb"+f_shbm+"_cksjb where f_Sptm='" + f_sptm + "' and f_ckbm='"+f_ckbm+"') and f_kcsl>0";
                    sqlOperator.ExecSQL(sql);//结转库存到当天
                }

                sql="select * from tb"+f_shbm+"_spda where f_sptm='"+f_sptm+"' and f_f_colum1=0";
                String spRes=sqlOperator.RunSQL_JSON(sql);
                JSONArray spjarr=new JSONArray(spRes);
                JSONObject spJson=spjarr.getJSONObject(0);
                double f_sl=Double.parseDouble(spJson.getString("F_SL"));
                double f_xssl= Double.parseDouble(jobj.getString("xssl"));
                double f_xsdj=Double.parseDouble(jobj.getString("spdj"));
                String f_ypzjh=spJson.getString("F_YPZJH");
                String f_spmc=spJson.getString("F_SPMC");

                //判断库存是否足够
                sql="select isnull(SUM(f_kcsl),0) from tb"+f_shbm+"_spkc where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"' and f_bmbm ='"+f_bmbm+"'";
                double f_kcsl= Double.parseDouble(sqlOperator.queryOneRecorderData(sql));
                if(f_kcsl<f_xssl){
                    throw  new Exception("【"+f_spmc+"】库存不足!");
                }
                sql="select * from tb"+f_shbm+"_spkc where f_Sptm='"+f_sptm+"' and f_kcsl>0 and f_rq='"+f_Rzrq+"'  and f_bmbm ='"+f_bmbm+"' order by f_pch asc";
                String rsKcStr=sqlOperator.RunSQL_JSON(sql);
                JSONArray rsKcJsons = new JSONArray(rsKcStr);
                for(int j = 0 ;j<rsKcJsons.length();j++){
                    JSONObject rsKc = rsKcJsons.getJSONObject(j);
                    double pckc= Double.parseDouble(rsKc.getString("F_KCSL"));//批次库存
                    double f_kcje=Double.parseDouble(rsKc.getString("F_KCJE"));//库存金额
                    double f_ykcsj=Double.parseDouble(rsKc.getString("F_KCSJ"));//库存税金
                    double f_kcdj=f_kcje/pckc;
                    String f_pch=rsKc.getString("F_PCH");
                    String f_sgpch=rsKc.getString("F_SGPCH");
                    if(f_xssl<=pckc) {//一个批次库存就够
                        double f_ssje=SplitAndRound(f_xssl*f_xsdj,2);//实收金额
                        double f_sssj=SplitAndRound(f_ssje/(1+f_sl/100)*f_sl/100,2);//实收税金
                        double f_hscb=SplitAndRound(f_kcdj*f_xssl,2);//含税成本
                        double f_wscb=SplitAndRound(f_hscb/(1+f_sl/100),2);//无税成本
                        double f_wsml=SplitAndRound(f_ssje-f_sssj-f_wscb,2);//无税毛利
                        double f_kcsj = SplitAndRound(f_hscb / (1 + f_sl / 100) * f_sl / 100, 2);//库存税金
                        if(i == jarr.length()-1){
                            sql = "insert into tb"+f_shbm+"_Xsmxcb(f_Djh,f_Bmbm,f_Dnxh,f_ypzjh,f_Sptm,f_Xssl,f_Ssje,f_sssj,f_Zkzr,f_pch,f_sgpch,f_hscb,f_wscb,f_wsml,f_Ckbm)values" +
                                    "('"+f_djh+"','"+f_bmbm+"','"+Integer.toString(dnxh)+"','"+f_ypzjh+"','"+f_sptm+"','"+Double.toString(f_xssl)+"'," +
                                    "'"+Double.toString(f_ssje-Double.parseDouble(yhje))+"','"+Double.toString(f_sssj)+"','"+yhje+"','"+f_pch+"','"+f_sgpch+"','"+Double.toString(f_hscb)+"','"+Double.toString(f_wscb)+"'" +
                                    ",'"+Double.toString(f_wsml)+"','"+f_ckbm+"')";
                        }else{
                            sql="insert into tb"+f_shbm+"_Xsmxcb(f_Djh,f_Bmbm,f_Dnxh,f_ypzjh,f_Sptm,f_Xssl,f_Ssje,f_sssj,f_pch,f_sgpch,f_hscb,f_wscb,f_wsml,f_Ckbm)values" +
                                    "('"+f_djh+"','"+f_bmbm+"','"+Integer.toString(dnxh)+"','"+f_ypzjh+"','"+f_sptm+"','"+Double.toString(f_xssl)+"'," +
                                    "'"+Double.toString(f_ssje)+"','"+Double.toString(f_sssj)+"','"+f_pch+"','"+f_sgpch+"','"+Double.toString(f_hscb)+"','"+Double.toString(f_wscb)+"'" +
                                    ",'"+Double.toString(f_wsml)+"','"+f_ckbm+"')";
                        }
                        sqlList.add(sql);
//                        double sykc=pckc-f_xssl;//剩余库存
//                        double sykcje=f_kcje-f_hscb;//剩余库存金额
//                        double sykcsj=f_ykcsj-f_kcsj;
                        sql="update tb"+f_shbm+"_spkc set f_kcsl=f_kcsl -"+f_xssl+",f_kcje= f_kcje-"+Double.toString(f_hscb)+",f_kcsj=f_kcsj -"+Double.toString(f_kcsj)+" where f_pch='"+f_pch+"' and f_sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"'";
                        sqlList.add(sql);
                        dnxh++;
                        break;
                    }else {
                        double f_ssje=SplitAndRound(pckc*f_xsdj,2);
                        double f_sssj=SplitAndRound(f_ssje/(1+f_sl/100)*f_sl/100,2);//实收税金
                        double f_hscb=SplitAndRound(f_kcdj*pckc,2);//含税成本
                        double f_wscb=SplitAndRound(f_hscb/(1+f_sl/100),2);//无税成本
                        double f_wsml=f_ssje-f_sssj-f_wscb;//无税毛利
                        if(i == jarr.length()-1){
                            sql="insert into tb"+f_shbm+"_Xsmxcb(f_Djh,f_Bmbm,f_Dnxh,f_ypzjh,f_Sptm,f_Xssl,f_Ssje,f_sssj,f_Zkzr,f_pch,f_sgpch,f_hscb,f_wscb,f_wsml,f_Ckbm)values" +
                                    "('"+f_djh+"','"+f_bmbm+"','"+Integer.toString(dnxh)+"','"+f_ypzjh+"','"+f_sptm+"','"+Double.toString(pckc)+"'," +
                                    "'"+Double.toString(f_ssje-Double.parseDouble(yhje))+"','"+Double.toString(f_sssj)+"','"+yhje+"','"+f_pch+"','"+f_sgpch+"','"+Double.toString(f_hscb)+"','"+Double.toString(f_wscb)+"'" +
                                    ",'"+Double.toString(f_wsml)+"','"+f_ckbm+"')";
                        }else{
                            sql="insert into tb"+f_shbm+"_Xsmxcb(f_Djh,f_Bmbm,f_Dnxh,f_ypzjh,f_Sptm,f_Xssl,f_Ssje,f_sssj,f_pch,f_sgpch,f_hscb,f_wscb,f_wsml,f_Ckbm)values" +
                                    "('"+f_djh+"','"+f_bmbm+"','"+Integer.toString(dnxh)+"','"+f_ypzjh+"','"+f_sptm+"','"+Double.toString(pckc)+"'," +
                                    "'"+Double.toString(f_ssje)+"','"+Double.toString(f_sssj)+"','"+f_pch+"','"+f_sgpch+"','"+Double.toString(f_hscb)+"','"+Double.toString(f_wscb)+"'" +
                                    ",'"+Double.toString(f_wsml)+"','"+f_ckbm+"')";
                        }

                        sqlList.add(sql);
                        sql="update tb"+f_shbm+"_spkc set f_kcsl='0',f_kcje='0',f_kcsj='0' where f_pch='"+f_pch+"' and f_sptm='"+f_sptm+"' and f_bmbm ='"+f_bmbm+"'  and f_rq='"+f_Rzrq+"'";;
                        sqlList.add(sql);
                        f_xssl=f_xssl-pckc;
                        dnxh++;
                        continue;
                    }
                }

                //判断仓库库存是否足够
                sql="select isnull(SUM(f_kcsl),0) from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"' and f_bmbm ='"+f_bmbm+"' and f_ckbm ='"+f_ckbm+"'";
                double f_kcsl1= Double.parseDouble(sqlOperator.queryOneRecorderData(sql));
                if(f_kcsl1<f_xssl){
                    throw  new Exception("【"+f_spmc+"】库存不足!");
                }
                sql="select * from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_kcsl>0 and f_rq='"+f_Rzrq+"'  and f_bmbm ='"+f_bmbm+"' and f_ckbm ='"+f_ckbm+"' order by f_pch asc";
                String rsKcStr1=sqlOperator.RunSQL_JSON(sql);
                JSONArray rsKcJsons1 = new JSONArray(rsKcStr1);
                for(int j = 0 ;j<rsKcJsons1.length();j++){
                    JSONObject rsKc = rsKcJsons1.getJSONObject(j);
                    double pckc= Double.parseDouble(rsKc.getString("F_KCSL"));//批次库存
                    double f_kcje=Double.parseDouble(rsKc.getString("F_KCJE"));//库存金额
                    double f_ykcsj=Double.parseDouble(rsKc.getString("F_KCSJ"));//库存税金
                    double f_kcdj=f_kcje/pckc;
                    String f_pch=rsKc.getString("F_PCH");
                    String f_sgpch=rsKc.getString("F_SGPCH");
                    if(f_xssl<=pckc) {//一个批次库存就够
                        double f_ssje=SplitAndRound(f_xssl*f_xsdj,2);
                        double f_sssj=SplitAndRound(f_ssje/(1+f_sl/100)*f_sl/100,2);//实收税金
                        double f_hscb=SplitAndRound(f_kcdj*f_xssl,2);//含税成本
                        double f_wscb=SplitAndRound(f_hscb/(1+f_sl/100),2);//无税成本
                        double f_wsml=SplitAndRound(f_ssje-f_sssj-f_wscb,2);//无税毛利
                        double f_kcsj = SplitAndRound(f_hscb / (1 + f_sl / 100) * f_sl / 100, 2);//库存税金
                        sql="update tb"+f_shbm+"_cksjb set f_kcsl=f_kcsl -"+f_xssl+",f_kcje= f_kcje-"+Double.toString(f_hscb)+",f_kcsj=f_kcsj -"+Double.toString(f_kcsj)+" where f_pch='"+f_pch+"' and f_sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"' and f_ckbm='"+f_ckbm+"'";
                        sqlList.add(sql);
                        dnxh++;
                        break;
                    }else {
                        double f_ssje=SplitAndRound(pckc*f_xsdj,2);
                        double f_sssj=SplitAndRound(f_ssje/(1+f_sl/100)*f_sl/100,2);//实收税金
                        double f_hscb=SplitAndRound(f_kcdj*pckc,2);//含税成本
                        double f_wscb=SplitAndRound(f_hscb/(1+f_sl/100),2);//无税成本
                        double f_wsml=f_ssje-f_sssj-f_wscb;//无税毛利
                        sql="update tb"+f_shbm+"_cksjb set f_kcsl='0',f_kcje='0',f_kcsj='0' where f_pch='"+f_pch+"' and f_sptm='"+f_sptm+"' and f_bmbm ='"+f_bmbm+"'  and f_rq='"+f_Rzrq+"' and f_ckbm='"+f_ckbm+"'";
                        sqlList.add(sql);
                        f_xssl=f_xssl-pckc;
                        dnxh++;
                        continue;
                    }
                }
            }

            //赊账情况写入qkmxb
            if(f_Zfbz == 9){
                sql = "insert into tb"+f_shbm+"_Qkmxb(f_Djh,f_Bmbm,f_Khbm,f_Qkrq,f_Qkje,f_Syje)values" +
                        "('"+f_djh+"','"+f_bmbm+"','"+khbm+"','"+f_Rzrq+"','"+jsje+"','"+jsje+"')";
                sqlList.add(sql);
            }


            sqlOperator.ExecSql(sqlList);
            //根据不同公司判断走逻辑调接口
            if("0".equals(jhgkbm)){
                if(filename != null && !"".equals(filename)){
                    filename = catalogue+filename;
                }
                //storService.responseBmmx(f_bmbm,f_shbm);


                this.responseSales(f_djh,f_shbm,filename);
            }
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

    @Transactional
    public void responseSales(String djh,String shbm,String filename) throws Exception{

        //创建连接池
        openConnection();

        HttpUtil util = new HttpUtil();
        List<String> sqls = new ArrayList<>();
        Map<String, String> map = new HashMap<String, String>();
        String sql = "select '"+shbm+"_'+xsz.f_Bmbm as storeCode,kh.f_sfzh as 'identity',kh.f_csmc as name,bm.f_Bmmc as storeName," +
                "xsz.f_Djh as orderNo,xsz.f_Rzrq+xsz.f_Xssj as orderTime,xsz.f_Zfje as amt " +
                "from tb"+shbm+"_Xsmxzb xsz " +
                "left join tb"+shbm+"_Csda kh on xsz.f_Khbm = kh.f_Csbm " +
                "left join tb"+shbm+"_Bmda bm on xsz.f_Bmbm = bm.f_Bmbm " ;
        if(!djh.equals("") && djh != null){
            sql+="where xsz.f_Djh = '"+djh+"'";
        }
        String result = sqlOperator.RunSQL_JSONNoToCase(sql);
        if(!result.isEmpty()){
            JSONArray json = new JSONArray(result);
            for(int i = 0 ; i<json.length() ; i++){
                JSONObject temp = json.getJSONObject(i);
                Iterator j = temp.keys();
                while (j.hasNext()){
                    String key = j.next().toString();
                    String value = temp.getString(key);
                    if("orderTime".equals(key.trim())){
                        SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
                        SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        Date date = format.parse(value);
                        map.put(key.trim(),format2.format(date));
                    }else{
                        map.put(key.trim(),value);
                    }

                }
                String[] shbm_bmbm = map.get("storeCode").toString().split("_");
                String tempshbm = shbm_bmbm[0];
                String tempbmbm = shbm_bmbm[1];
                String sqlsub = "select sp.f_Spmc as productName,splb.f_Splbbm as typeCode,splb.f_Splbmc as typeName," +
                        "sp.f_ggxh as sku,sp.f_ypzjh as pd,xsc.f_Xssl as cnt,sp.f_Xsdj as price,xsc.f_Ssje as amt " +
                        "from tb"+tempshbm+"_Xsmxcb xsc " +
                        "left join tb"+tempshbm+"_Spda sp on xsc.f_Sptm = sp.f_Sptm " +
                        "left join tb"+tempshbm+"_Splbdz dz on sp.f_Sptm = dz.f_Sptm " +
                        "left join tb"+tempshbm+"_Splbda splb on splb.f_Splbbm = dz.f_Splbbm " +
                        "where xsc.f_Djh = '"+ map.get("orderNo")+"' and '"+tempshbm+"_'+f_Bmbm = '"+map.get("storeCode")+"'" ;
                String tempresult = sqlOperator.RunSQL_JSONNoToCase(sqlsub);
                map.put("detail",tempresult);
                Boolean base = util.sales(map,filename);
                if(base){
                    String sql2 = "update tb"+shbm+"_Xsmxzb set f_sczt = 1 " +
                            "where f_Djh = '"+djh+"'";
                    sqls.add(sql2);
                    sqlOperator.ExecSql(sqls);
                }
                System.out.println(map.toString());
            }
        }
    }


    public String SavaBill_refund(String f_ydjh,String yhje,String jsje,String spxx,String f_zybm,String f_bmbm,String f_zymc,String f_shbm)
    {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql="";
//            sql="select isnull(MAX(f_djh),'0000000000') from tb"+f_shbm+"_Xsmxzb";
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
            sql="select * from tb"+f_shbm+"_xsmxzb where f_djh='"+f_ydjh+"'";
            ResultSet rsZb=sqlOperator.RunSQLToResSet(sql);

            String khbm="";
            if(rsZb.next()){
                khbm=rsZb.getString("f_khbm");
                f_bmbm=rsZb.getString("f_bmbm");//退货部门编码取原单据部门编码
            }

            List<String> sqlList= new ArrayList<>();
            sql = "insert into tb"+f_shbm+"_Xsmxzb(f_Djh,f_Ydjh,f_Bmbm,f_Syybm,f_Syymc,f_Xssj,f_Rzrq,f_Zfbz,f_Djlx,f_Khbm,f_Yyybm,f_Zfje,f_Ckbm)values" +
                    "('"+f_djh+"','"+f_ydjh+"','"+f_bmbm+"','"+f_zybm+"','"+f_zymc+"','"+f_Xssj+"','"+f_Rzrq+"','"+f_Zfbz+"','"+f_djlx+"','"+khbm+"','"+f_zybm+"','"+-1*Double.parseDouble(jsje)+"','')";
            sqlList.add(sql);

            //获取仓库编码
            sql = "select f_ckbm from tb"+f_shbm+"_xsmxzb where f_djh='"+f_ydjh+"'";
            String f_ckbm = sqlOperator.queryOneRecorderData(sql);

            JSONArray jarr= new JSONArray(spxx);
            for(int i=0;i<jarr.length();i++){
                JSONObject jobj=jarr.getJSONObject(i);

                String f_sptm=jobj.getString("sptm");
                sql="select count(*) from tb"+f_shbm+"_spkc where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"'";
                int count=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                if(count<=0) {//当天没有库存数据,需要结算到当天
                    sql = "insert into tb"+f_shbm+"_spkc\n" +
                            "select '" + f_Rzrq + "',f_Bmbm,f_Sptm,f_pch,f_Sgpch,f_kcsl,f_kcje,f_kcsj from " +
                            "tb"+f_shbm+"_spkc where f_Sptm='" + f_sptm + "' and f_Rq=(select MAX(f_Rq) from tb"+f_shbm+"_spkc where f_Sptm='" + f_sptm + "') and f_kcsl>0";
                    sqlOperator.ExecSQL(sql);//结转库存到当天
                }

                sql="select count(*) from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"' and f_ckbm='"+f_ckbm+"'";
                int count1=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                if(count1<=0) {//当天没有库存数据,需要结算到当天
                    sql = "insert into tb"+f_shbm+"_cksjb\n" +
                            "select '" + f_Rzrq + "',f_Bmbm,f_Sptm,f_pch,f_Sgpch,f_kcsl,f_kcje,f_kcsj,f_ckbm from " +
                            "tb"+f_shbm+"_cksjb where f_Sptm='" + f_sptm + "' and f_ckbm='"+f_ckbm+"' and f_Rq=(select MAX(f_Rq) from tb"+f_shbm+"_cksjb where f_Sptm='" + f_sptm + "') and f_kcsl>0";
                    sqlOperator.ExecSQL(sql);//结转库存到当天
                }

                String f_pch=jobj.getString("pch");
                String f_sgpch=jobj.getString("sgpch");
                String djh = jobj.getString("djh");
                sql="select * from tb"+f_shbm+"_spda where f_sptm='"+f_sptm+"' and f_f_colum1=0";
                String spRes=sqlOperator.RunSQL_JSON(sql);
                JSONArray spjarr=new JSONArray(spRes);
                JSONObject spJson=spjarr.getJSONObject(0);
                double f_sl=Double.parseDouble(spJson.getString("F_SL"));
                double f_xssl=-1* Double.parseDouble(jobj.getString("xssl"));
                double f_xsdj=Double.parseDouble(jobj.getString("spdj"));
                String f_ypzjh=spJson.getString("F_YPZJH");
                sql="select * from tb"+f_shbm+"_xsmxcb where f_sptm='"+f_sptm+"' and f_djh='"+djh+"' and f_bmbm ='"+f_bmbm+"' and f_pch='"+f_pch+"' and f_Ckbm='"+f_ckbm+"'";
                ResultSet rscb=sqlOperator.RunSQLToResSet(sql);
                if(rscb.next()) {
                    double f_ssje = SplitAndRound(f_xssl * f_xsdj, 2);
                    double f_sssj = SplitAndRound(f_ssje / (1 + f_sl / 100) * f_sl / 100, 2);//实收税金
                    double f_yhscb = Double.parseDouble(rscb.getString("f_hscb"));//含税成本
                    double f_yxssl=Double.parseDouble(rscb.getString("f_xssl"));//原销售数量
                    double f_gjdj=SplitAndRound(f_yhscb/f_yxssl,2);//成本单价
                    double f_hscb=f_gjdj*f_xssl;
                    double f_wscb=SplitAndRound(f_hscb/(1+f_sl/100),2);//无税成本
                    double f_wsml=SplitAndRound(f_ssje-f_sssj-f_wscb,2);//无税毛利
                    double f_kcsj = SplitAndRound(f_hscb / (1 + f_sl / 100) * f_sl / 100, 2);//库存税金
                    sql="select count(*) from tb"+f_shbm+"_spkc where f_sptm='"+f_sptm+"' and f_pch='"+f_pch+"'  and f_bmbm ='"+f_bmbm+"' and f_rq='"+f_Rzrq+"'";
                    count=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                    if(count>0) {
                        sql = "update tb"+f_shbm+"_spkc set f_kcsl=f_kcsl-'" + f_xssl + "',f_kcje=f_kcje-'" + f_hscb + "',f_kcsj=f_kcsj-'"+f_kcsj+"' where f_pch='" + f_pch + "' and f_sptm='" + f_sptm + "'  and f_rq='"+f_Rzrq+"'";
                        sqlList.add(sql);
                    }else {
                        sql = "insert into tb"+f_shbm+"_spkc select f_Rq,f_Bmbm,f_Sptm,f_pch,f_Sgpch,'"+-1*f_xssl+"','"+-1*f_hscb+"',f_kcsj from tb"+f_shbm+"_spkc where f_pch='" + f_pch + "' and f_sptm='" + f_sptm + " and f_kcsl=0'";
                        sqlList.add(sql);
                    }

                    sql="select count(*) from tb"+f_shbm+"_cksjb where f_sptm='"+f_sptm+"' and f_pch='"+f_pch+"'  and f_bmbm ='"+f_bmbm+"' and f_rq='"+f_Rzrq+"' and f_ckbm='"+f_ckbm+"'";
                    count=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                    if(count>0) {
                        sql = "update tb"+f_shbm+"_cksjb set f_kcsl=f_kcsl-'" + f_xssl + "',f_kcje=f_kcje-'" + f_hscb + "',f_kcsj=f_kcsj-'"+f_kcsj+"' where f_pch='" + f_pch + "' and f_sptm='" + f_sptm + "'  and f_rq='"+f_Rzrq+"' and f_ckbm='"+f_ckbm+"'";
                        sqlList.add(sql);
                    }else {
                        sql = "insert into tb"+f_shbm+"_cksjb select f_Rq,f_Bmbm,f_Sptm,f_pch,f_Sgpch,'"+-1*f_xssl+"','"+-1*f_hscb+"',f_kcsj,f_ckbm from tb"+f_shbm+"_cksjb where f_pch='" + f_pch + "' and f_sptm='" + f_sptm + " and f_kcsl=0' and f_ckbm='"+f_ckbm+"'";
                        sqlList.add(sql);
                    }
                    sql="insert into tb"+f_shbm+"_Xsmxcb(f_Djh,f_Bmbm,f_Dnxh,f_ypzjh,f_Sptm,f_Xssl,f_Ssje,f_sssj,f_pch,f_sgpch,f_hscb,f_wscb,f_wsml,f_Ckbm)values" +
                            "('"+f_djh+"','"+f_bmbm+"','"+Integer.toString(i)+"','"+f_ypzjh+"','"+f_sptm+"','"+Double.toString(f_xssl)+"'," +
                            "'"+Double.toString(f_ssje)+"','"+Double.toString(f_sssj)+"','"+f_pch+"','"+f_sgpch+"','"+Double.toString(f_hscb)+"','"+Double.toString(f_wscb)+"'" +
                            ",'"+Double.toString(f_wsml)+"','"+f_ckbm+"')";
                    sqlList.add(sql);
                }
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
            String sql = "select f_Djh,f_Syybm,f_Syymc,f_Yyybm,f_Khbm,kh.f_Csmc,f_Rzrq,f_Xssj,isnull(F_RZRQ ,'')+isnull(f_Xssj ,'') as F_ZDSJ," +
                    "(case f_Zfbz when '1' then '现金' when '2' then '储值卡' when '3' then '卷类' when '4' then '空IC卡' when '5' then '转账' " +
                    "when '6' then '信用卡' when '12' then '赊销' when '13' then '支付卡' when '14' then '会员卡' end)f_Zfbz,f_Zfje,f_Djlx from tb"+f_shbm+"_xsmxzb zb " +
                    "left join tb"+f_shbm+"_Csda kh on kh.f_Csbm=zb.f_Khbm and kh.f_Cslx='1' where zb.f_rzrq between'"+f_ksrq+"' and '"+f_jsrq+"'";
            if(!khxx.equals("")){
                sql+=" and kh.f_csmc like '%"+khxx+"%'";//表结构暂无 客户信息
            }
            if(!zysxbm.equals("")){
                sql+=" and f_bmbm in("+zysxbm+")";
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
    public String GetBillDetailByKhbm(String khbm, String searchSpxx, String f_bmbm, String f_ksrq, String f_jsrq, String f_shbm, String f_zybm) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String zysxbm=GetZysxbmByZybm(f_zybm,f_shbm,sqlOperator);
            String sql = "select f_Djh,f_Syybm,f_Syymc,f_Yyybm,f_Khbm,kh.f_Csmc,f_Rzrq,f_Xssj,isnull(F_RZRQ ,'')+isnull(f_Xssj ,'') as F_ZDSJ," +
                    "(case f_Zfbz when '1' then '现金' when '2' then '储值卡' when '3' then '卷类' when '4' then '空IC卡' when '5' then '转账' " +
                    "when '6' then '信用卡' when '12' then '赊销' when '13' then '支付卡' when '14' then '会员卡' end)f_Zfbz,f_Zfje,f_Djlx from tb"+f_shbm+"_xsmxzb zb " +
                    "left join tb"+f_shbm+"_Csda kh on kh.f_Csbm=zb.f_Khbm and kh.f_Cslx='1' where zb.f_rzrq between'"+f_ksrq+"' and '"+f_jsrq+"' and f_Khbm='"+khbm+"'";
            if(!searchSpxx.equals("")){
                sql+=" and kh.f_csmc like '%"+searchSpxx+"%'";//表结构暂无 客户信息
            }
            if(!zysxbm.equals("")){
                sql+=" and f_bmbm in("+zysxbm+")";
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
    public String GetSalesDetail(String cxtj,String f_ksrq,String f_jsrq,String f_shbm,String f_zybm)
    {
//创建连接池
        openConnection();

        String result = null;
        try {
            String zysxbm=GetZysxbmByZybm(f_zybm,f_shbm,sqlOperator);
            String sql = "select zb.f_Djh,zb.f_Rzrq,cb.f_Sptm,f_Spmc,f_Xsdj,f_Xssl,f_Sgpch,f_Ggxh,f_jldw,f_Ssje,f_Pch,f_nybz,case f_nybz when '0' then '禁限农药' else '非禁限农药' end as F_NYBZMC " +
                    "from tb"+f_shbm+"_Xsmxcb cb " +
                    "left join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh=cb.f_Djh " +
                    "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm " +
                    "left join tb"+f_shbm+"_Csda kh on kh.f_Csbm=zb.f_Khbm and kh.f_Cslx='1' where zb.f_rzrq between'"+f_ksrq+"' and '"+f_jsrq+"'";
            if(!cxtj.equals("")){
                sql+=" and kh.f_csmc like '%"+cxtj+"%' or kh.f_csbm like '%"+cxtj+"%'";//表结构暂无 客户信息
                sql+=" and cb.f_sptm like '%"+cxtj+"%' or f_spmc like '%"+cxtj +"%'";
            }
            if(!zysxbm.equals("")){
                sql+=" and zb.f_bmbm in("+zysxbm+")";
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
    public String GetSalesDetailByKhbm(String khbm, String searchSpxx, String f_ksrq, String f_jsrq, String f_shbm, String f_zybm) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String zysxbm=GetZysxbmByZybm(f_zybm,f_shbm,sqlOperator);
            String sql = "select zb.f_Djh,zb.f_Rzrq,cb.f_Sptm,f_Spmc,f_Xsdj,f_Xssl,f_Sgpch,f_Ggxh,f_jldw,f_Ssje,f_Pch,f_nybz,case f_nybz when '0' then '禁限农药' else '非禁限农药' end as F_NYBZMC " +
                    "from tb"+f_shbm+"_Xsmxcb cb " +
                    "left join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh=cb.f_Djh " +
                    "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm " +
                    "left join tb"+f_shbm+"_Csda kh on kh.f_Csbm=zb.f_Khbm and kh.f_Cslx='1' where zb.f_rzrq between'"+f_ksrq+"' and '"+f_jsrq+"' and zb.f_Khbm='"+khbm+"'";
            if(!searchSpxx.equals("")){
                sql+=" and cb.f_sptm like '%"+searchSpxx+"%' or f_spmc like '%"+searchSpxx +"%'";
            }
            if(!zysxbm.equals("")){
                sql+=" and zb.f_bmbm in("+zysxbm+")";
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
    public String GetSalesDetailByDjh(String djh,String f_shbm,String f_zybm)
    {
//创建连接池
        openConnection();

        String result = null;
        try {
            String zysxbm=GetZysxbmByZybm(f_zybm,f_shbm,sqlOperator);
            String sql = "select zb.f_Djh,zb.f_Rzrq,cb.f_Sptm,f_Spmc,f_Xsdj,f_Xssl,f_Sgpch,f_Ggxh,f_jldw,f_Ssje,f_Pch,f_nybz,case f_nybz when '0' then '禁限农药' else '非禁限农药' end as F_NYBZMC " +
                    "from tb"+f_shbm+"_Xsmxcb cb " +
                    "left join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh=cb.f_Djh " +
                    "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm " +
                    "left join tb"+f_shbm+"_Csda kh on kh.f_Csbm=zb.f_Khbm and kh.f_Cslx='1' where zb.f_Djh ='"+djh+"' ";
            if(!zysxbm.equals("")){
                sql+=" and zb.f_bmbm in("+zysxbm+")";
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
    public  String  GetSaleZbxx(String khxx,String f_shbm,String f_bmbm,String f_spxx){
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select zb.f_djh,cb.f_Dnxh,sp.f_Spmc,f_Syymc,f_Rzrq,f_Xssj,cb.f_Xssl,cb.f_Ssje,sp.f_Ggxh,sp.f_Jldw,isnull(kh.f_Csmc,'')f_Csmc from tb"+f_shbm+"_Xsmxzb zb " +
                    "left join tb"+f_shbm+"_Xsmxcb cb on zb.f_Djh = cb.f_Djh and zb.f_Bmbm = cb.f_Bmbm " +
                    "left join tb"+f_shbm+"_Spda sp on cb.f_Sptm = sp.f_Sptm " +
                    "left join tb"+f_shbm+"_Csda kh on kh.f_csbm=zb.f_Khbm and kh.f_Cslx='1' where 1=1 ";
            if(!khxx.equals("")){
                sql+=" and f_Khbm like '%"+khxx+"%' and zb.f_zfje >0 and zb.f_bmbm='"+f_bmbm+"'";
            }
            if(f_spxx != null && !"".equals(f_spxx)){
                sql+=" and (sp.f_Spmc like '%"+f_spxx+"%' or sp.f_c_colum3 like '%"+f_spxx+"%') ";
            }
            sql+=" order by zb.f_djh desc";
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
    ///
    public String  GetSalecbmx(String data,String f_shbm){
        //创建连接池
        openConnection();

        String result = null;
        StringBuffer sqls = new StringBuffer();
        try {
            String[] spdjs = data.split("/");
            for (int i= 0 ; i<spdjs.length;i++){
                String[] djmx = spdjs[i].split(",");
                String sql = "select cb.f_Djh,cb.f_Sptm,f_Spmc,convert(decimal(18,2),f_Ssje/f_Xssl)f_xsdj,f_Xssl,f_Ggxh,f_jldw,f_Ssje,f_Pch,f_Sgpch,zb.rediourl from tb"+f_shbm+"_Xsmxcb cb " +
                        "left join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh = cb.f_Djh and zb.f_Bmbm = cb.f_Bmbm " +
                        "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm where cb.f_Djh='"+djmx[0]+"' and cb.f_Dnxh = '"+djmx[1]+"' " +
                        " union all ";
                sqls.append(sql);
            }

            result = sqlOperator.RunSQL_JSON(sqls.substring(0,sqls.length()-10));
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
    public String getXsdXq(String f_djh, String f_shbm) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select cb.f_Djh,cb.f_Sptm,f_Spmc,convert(decimal(18,2),f_Ssje/f_Xssl)f_xsdj,f_Xssl,f_Ggxh,f_jldw,f_Ssje,f_Pch,f_Sgpch,zb.rediourl \n" +
                    "from tb"+f_shbm+"_Xsmxcb cb\n" +
                    "left join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh = cb.f_Djh and zb.f_Bmbm = cb.f_Bmbm\n" +
                    "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm \n" +
                    "where cb.f_Djh='"+f_djh+"'";
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
            String rq = this.retime().substring(0,6);//截取日期前6位，202303
            sql.append("select max(f_djh) f_djh ");
            sql.append(" from tb").append(f_shbm).append("_xsmxzb ");
            sql.append(" where f_djh like '").append(rq).append("%'");
            //查询最大单据号，当单据号相似
            String f_djh = sqlser.queryOneRecorderData(sql.toString());
            //查询结果为空，单据号为2023030001
            if (f_djh == null || "".equals(f_djh)) {
                return rq + "0001";
            }
            //查询有结果，根据传过来的编码求得下一个编码
            bm =  ut.bmAddOne(f_djh);
        } catch(Exception e){
        } finally {
//            this.sqlOperator.closeConnection();
        }
        return bm;
    }

    //转换日期
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

    @Override
    public String getSaleAll() {
        //创建连接池
        openConnection();

        String result = null;
        try {

            String sql="select * from tbshda where f_shzt='1'";

            ResultSet rs=sqlOperator.RunSQLToResSet(sql);
            sql="";
            while(rs.next()){
                String fgsh=(String) rs.getString("f_shbm");

                String sqlsub = "select '"+fgsh+"_'+xsz.f_Bmbm as storeCode,kh.f_sfzh as 'identity',kh.f_csmc as name,bm.f_Bmmc as storeName," +
                        "xsz.f_Djh as orderNo,xsz.f_Xssj as orderTime,xsz.f_Zfje as amt " +
                        "from tb"+fgsh+"_Xsmxzb xsz " +
                        "left join tb"+fgsh+"_Csda kh on xsz.f_Khbm = kh.f_Csbm " +
                        "left join tb"+fgsh+"_Bmda bm on xsz.f_Bmbm = bm.f_Bmbm " +
                        "where xsz.f_sczt != 1" ;

                if(sql.equals("")){
                    sql=sqlsub;
                }else
                {
                    sql+=" union all ";
                    sql+=  sqlsub;
                }
            }
            result = sqlOperator.RunSQL_JSON(sql);
            Map<String, Object> map = new HashMap<String, Object>();
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
                    String[] shbm_bmbm = map.get("STORECODE").toString().split("_");
                    String tempshbm = shbm_bmbm[0];
                    String tempbmbm = shbm_bmbm[1];
                    String sqlsub = "select sp.f_Spmc as productName,splb.f_Splbbm as typeCode,splb.f_Splbmc as typeName," +
                            "sp.f_ggxh as sku,sp.f_ypzjh as pd,xsc.f_Xssl as cnt,sp.f_Xsdj as price,xsc.f_Ssje as amt " +
                            "from tb"+tempshbm+"_Xsmxcb xsc " +
                            "left join tb"+tempshbm+"_Spda sp on xsc.f_Sptm = sp.f_Sptm " +
                            "left join tb"+tempshbm+"_Splbdz dz on sp.f_Sptm = dz.f_Sptm " +
                            "left join tb"+tempshbm+"_Splbda splb on splb.f_Splbbm = dz.f_Splbbm " +
                            "where xsc.f_Djh = '"+ map.get("ORDERNO")+"' and '"+tempshbm+"_'+f_Bmbm = '"+map.get("STORECODE")+"'" ;
                    String tempresult = sqlOperator.RunSQL_JSON(sqlsub);
                    map.put("detail",tempresult);
                    System.out.println(map.toString());
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
    public String getkhxx(String khbm, String f_shbm) {
        //创建连接池
        openConnection();
        String result = "";
        JSONObject json = new JSONObject();

        try {
            //查出电话，身份证号，集中配送，经营面积
            String sql = "select csda.f_Dh,csda.f_sfzh,csda.f_Sfjzps,SUM(dzb.f_sl) jymj\n" +
                    "            from tb"+f_shbm+"_Csda csda\n" +
                    "            left join tb"+f_shbm+"_cstjmxdzb dzb on dzb.f_Csbm=csda.f_Csbm\n" +
                    "            where csda.f_Csbm='"+khbm+"'\n" +
                    "            GROUP BY csda.f_Dh,csda.f_sfzh,csda.f_Sfjzps";
            result = sqlOperator.RunSQL_JSON(sql);
            json.put("jcxxResult",result);

            //查询当前日期所属季度的经营季Id，开始和结束日期
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            String dateStr = sdf.format(date);
            sql = "select f_jyjId,f_startTime,f_endTime\n" +
                    "from tb"+f_shbm+"_jyj \n" +
                    "where '"+dateStr+"' between f_startTime and f_endTime";
            result = sqlOperator.RunSQL_JSON(sql);
            JSONArray jarr1 = new JSONArray(result);
            String jyjId = jarr1.getJSONObject(0).getString("F_JYJID");
            String startTime = jarr1.getJSONObject(0).getString("F_STARTTIME");
            String endTime = jarr1.getJSONObject(0).getString("F_ENDTIME");

            //计算允许购买金额
            sql = "select jyj.f_flbm,dzb.f_sl,btbz.f_mmje \n" +
                    "from tb"+f_shbm+"_jyj jyj\n" +
                    "left join tb"+f_shbm+"_cstjmxdzb dzb  on jyj.f_flbm=dzb.f_flbm\n" +
                    "left join tb"+f_shbm+"_cslxbtbz btbz on btbz.f_flbm=jyj.f_flbm\n" +
                    "where dzb.f_Csbm='"+khbm+"' and f_state='1' and btbz.f_Khlx=(select f_Khlx from tb"+f_shbm+"_Csda where f_Csbm='"+khbm+"') and jyj.f_jyjId='"+jyjId+"'";
            result = sqlOperator.RunSQL_JSON(sql);
            JSONArray jarr = new JSONArray(result);
            double zje = 0;//总金额
            for (int i = 0; i < jarr.length(); i++){
                JSONObject jsonObject = jarr.getJSONObject(i);
                double sl = jsonObject.getDouble("F_SL");//数量
                double mmje = jsonObject.getDouble("F_MMJE");//每亩金额
                double je = sl*mmje;//金额
                zje += je;
            }
            String f_yxgmje = String.format("%.2f",zje);
            json.put("f_yxgmje",f_yxgmje);

            //计算本季累计购买金额
            //查询开始和结束日期之间所有的销售金额并相加
            sql = "select SUM(zb.f_Zfje) bjljgmje\n" +
                    "from tb"+f_shbm+"_Xsmxzb zb\n" +
                    "where zb.f_Rzrq between '"+startTime+"' and '"+endTime+"' and zb.f_Khbm='"+khbm+"'";
            result = sqlOperator.queryOneRecorderData(sql);
            if (result == null){
                result = "0";
            }else {
                double resultDouble = Double.parseDouble(result);
                result = String.format("%.2f", resultDouble);
            }
            json.put("f_bjljgmje",result);

            //计算本年累计购买金额
            SimpleDateFormat yearSdf = new SimpleDateFormat("yyyy");
            String yearStr = yearSdf.format(date);
            String yearStart = yearStr + "0101";
            String yearEnd = yearStr + "1231";
            sql = "select SUM(zb.f_Zfje) bjljgmje\n" +
                    "from tb"+f_shbm+"_Xsmxzb zb\n" +
                    "where zb.f_Rzrq between '"+yearStart+"' and '"+yearEnd+"' and zb.f_Khbm='"+khbm+"'";
            result = sqlOperator.queryOneRecorderData(sql);
            if (result == null){
                result = "0";
            }else {
                double resultDouble = Double.parseDouble(result);
                result = String.format("%.2f", resultDouble);
            }
            json.put("f_bnljgmje",result);

            result = json.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return  result;
    }

    @Override
    public String loadLsxsd(String khbm,String f_djh,String zdrq, String f_shbm) {
        //创建连接池
        openConnection();
        String result = "";

        try {
            String sql = "";
            if (zdrq == null || zdrq.equals("")){
                Date date = new Date();
                SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
                zdrq = df.format(date);
            }else {
                String[] zdrqs = zdrq.split("-");
                zdrq = zdrqs[0] + zdrqs[1] + zdrqs[2];
            }


            if (f_djh == null || f_djh.equals("")){
                sql = "select f_Djh from tb"+f_shbm+"_Xsmxzb where f_Khbm='"+khbm+"' and f_Djh<=(select MAX(f_djh) from tb"+f_shbm+"_Xsmxzb where f_Khbm='"+khbm+"') and f_Rzrq<='"+zdrq+"' order by f_djh desc";
            }else {
                sql = "select f_Djh from tb"+f_shbm+"_Xsmxzb where f_Khbm='"+khbm+"' and f_Djh<'"+f_djh+"' and f_Rzrq<='"+zdrq+"' order by f_djh desc";
            }
            result = sqlOperator.RunSQL_JSON(sql);
            if (result.equals("[]")){
                result = "410";
            }else {
                JSONArray jarr = new JSONArray(result);
                JSONObject jobj = jarr.getJSONObject(0);
                String djh = jobj.getString("F_DJH");

                sql = "select cb.f_ckbm,zb.f_Rzrq,cb.f_Sptm,spda.f_Spmc,spda.f_Ggxh,cb.f_Xssl,(cb.f_Ssje/cb.f_Xssl) f_dj,cb.f_Ssje,zb.f_Djh\n" +
                        "from tb"+f_shbm+"_Xsmxzb zb\n" +
                        "left join tb"+f_shbm+"_Xsmxcb cb on zb.f_Djh=cb.f_Djh\n" +
                        "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm\n" +
                        "where f_Khbm='"+khbm+"' and zb.f_Djh='"+djh+"' ";
                result = sqlOperator.RunSQL_JSON(sql);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return  result;
    }

    @Override
    public String firstXsd(String khbm, String f_shbm) {
        //创建连接池
        openConnection();
        String result = "";

        try {
            String sql = "";
            sql = "select cb.f_ckbm,zb.f_Rzrq,cb.f_Sptm,spda.f_Spmc,spda.f_Ggxh,cb.f_Xssl,(cb.f_Ssje/cb.f_Xssl) f_dj,cb.f_Ssje,zb.f_Djh\n" +
                    "from tb"+f_shbm+"_Xsmxzb zb\n" +
                    "left join tb"+f_shbm+"_Xsmxcb cb on zb.f_Djh=cb.f_Djh\n" +
                    "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm\n" +
                    "where f_Khbm='"+khbm+"' and zb.f_Djh=\n" +
                    "(select MIN(f_Djh) from tb"+f_shbm+"_Xsmxzb where f_Khbm='"+khbm+"')";
            result = sqlOperator.RunSQL_JSON(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return  result;
    }

    @Override
    public String finallyXsd(String khbm, String f_shbm) {
        //创建连接池
        openConnection();
        String result = "";

        try {
            String sql = "";
            sql = "select cb.f_ckbm,zb.f_Rzrq,cb.f_Sptm,spda.f_Spmc,spda.f_Ggxh,cb.f_Xssl,(cb.f_Ssje/cb.f_Xssl) f_dj,cb.f_Ssje,zb.f_Djh\n" +
                    "from tb"+f_shbm+"_Xsmxzb zb\n" +
                    "left join tb"+f_shbm+"_Xsmxcb cb on zb.f_Djh=cb.f_Djh\n" +
                    "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm\n" +
                    "where f_Khbm='"+khbm+"' and zb.f_Djh=\n" +
                    "(select MAX(f_Djh) from tb"+f_shbm+"_Xsmxzb where f_Khbm='"+khbm+"')";
            result = sqlOperator.RunSQL_JSON(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return  result;
    }

    @Override
    public String afterXsd(String khbm, String f_djh, String zdrq, String f_shbm) {
        //创建连接池
        openConnection();
        String result = "";

        try {
            String sql = "";
            if (zdrq == null || zdrq.equals("")){
                Date date = new Date();
                SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
                zdrq = df.format(date);
            }else {
                String[] zdrqs = zdrq.split("-");
                zdrq = zdrqs[0] + zdrqs[1] + zdrqs[2];
            }


            if (f_djh == null || f_djh.equals("")){
                result = "411";
            }else {
                sql = "select f_Djh from tb"+f_shbm+"_Xsmxzb where f_Khbm='"+khbm+"' and f_Djh>'"+f_djh+"' and f_Rzrq>='"+zdrq+"' order by f_djh";
            }
            result = sqlOperator.RunSQL_JSON(sql);
            if (result.equals("[]")){
                result = "411";
            }else {
                JSONArray jarr = new JSONArray(result);
                JSONObject jobj = jarr.getJSONObject(0);
                String djh = jobj.getString("F_DJH");

                sql = "select cb.f_ckbm,zb.f_Rzrq,cb.f_Sptm,spda.f_Spmc,spda.f_Ggxh,cb.f_Xssl,(cb.f_Ssje/cb.f_Xssl) f_dj,cb.f_Ssje,zb.f_Djh\n" +
                        "from tb"+f_shbm+"_Xsmxzb zb\n" +
                        "left join tb"+f_shbm+"_Xsmxcb cb on zb.f_Djh=cb.f_Djh\n" +
                        "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm\n" +
                        "where f_Khbm='"+khbm+"' and zb.f_Djh='"+djh+"' ";
                result = sqlOperator.RunSQL_JSON(sql);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if(sqlOperator!=null){
                sqlOperator.closeConnection();
            }
        }
        return  result;
    }

    @Override
    public String GetKhdaByCsbm(String f_csbm, String cslx, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            //查厂商档案
            String sql = "select shda.f_lxbm,csda.f_Csbm,csda.f_Csmc,csda.f_dh,csda.f_sfzh,csda.f_qybm,csda.f_Bzxx,csda.f_Dz,csda.f_Lxr,csda.f_jb,csda.f_Scxkzh,csda.f_Khh,csda.f_Yhkh,csda.f_Tyxym,csda.f_Sfjzps,csda.f_Khlx \n" +
                    "from tb"+f_shbm+"_csda csda\n" +
                    "left join tbShda shda on shda.f_shbm='"+f_shbm+"' \n" +
                    "where f_Cslx = '"+cslx+"' and f_Csbm='"+f_csbm+"'";
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
    public String getJdrqqj(String khbm, String rq, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        try {
            String[] rqs = rq.split("-");
            String rqstr = rqs[0]+rqs[1]+rqs[2];

            String sql = "select jyj.f_startTime,jyj.f_endTime \n" +
                    "from tb"+f_shbm+"_jyj jyj\n" +
                    "where f_khlx=(select f_Khlx from tb"+f_shbm+"_Csda where f_Csbm='"+khbm+"') \n" +
                    "and '"+rqstr+"' between jyj.f_startTime and jyj.f_endTime\n";
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
