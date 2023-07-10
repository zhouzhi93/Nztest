package com.infol.nztest.service.impl;

import com.infol.nztest.controller.CameraController;
import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.AllotService;
import com.infol.nztest.service.SalesService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import util.HttpUtil;
import util.UtilTools;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.*;


@Transactional
@Service
public class AllotServiceImpl implements AllotService {
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
    public String SavaBill(String f_dcbmbm,String f_drbmbm,String yhje,String jsje,String spxx,String f_shbm,String f_zybm,String f_zymc,Integer dblx)
    {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql="";
            String f_djh=newMaxDjh(f_shbm,sqlOperator);
            Date day=new Date();
            SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMdd");
            String f_Rzrq=df1.format(day);
            List<String> sqlList= new ArrayList<>();

            sql = "insert into tb"+f_shbm+"_Spzyzb(f_Zylx,f_Djh,f_Zdrq,f_Rzrq,f_Zdrbm,f_Zdrmc,f_Fhrbm,f_Fhrmc,f_Zdbm,f_Zcbm,f_Zrbm,f_Yrckbm,f_Ycckbm,f_Zrrbm,f_ckbm)values" +
                    "('2','"+f_djh+"','"+f_Rzrq+"','"+f_Rzrq+"','"+f_zybm+"','"+f_zymc+"','"+f_zybm+"','"+f_zymc+"','"+f_dcbmbm+"','"+f_dcbmbm+"'," +
                    "'"+f_drbmbm+"',' ',' ','"+f_zybm+"','')";
            sqlList.add(sql);

            JSONArray jarr= new JSONArray(spxx);
            int dnxh=0;//单内序号
            for(int i=0;i<jarr.length();i++){
                JSONObject jobj=jarr.getJSONObject(i);

                String f_dcckbm=jobj.getString("dcckbm");//获取调出仓库编码
                if (f_dcckbm.equals("undefined")){
                    f_dcckbm = "001";
                }

                String f_drckbm=jobj.getString("drckbm");//获取调出仓库编码
                if (f_drckbm.equals("undefined")){
                    f_drckbm = "001";
                }

                String f_sptm=jobj.getString("sptm");
                sql="select count(*) from tb"+f_shbm+"_spkc where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"'";
                int count=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                if(count<=0) {//当天没有库存数据,需要结算到当天
                    sql = "insert into tb"+f_shbm+"_spkc\n" +
                            "select '" + f_Rzrq + "',f_Bmbm,f_Sptm,f_pch,f_Sgpch,f_kcsl,f_kcje,f_kcsj from " +
                            "tb"+f_shbm+"_spkc where f_Sptm='" + f_sptm + "' and f_Rq=(select MAX(f_Rq) from tb"+f_shbm+"_spkc where f_Sptm='" + f_sptm + "') and f_kcsl>0";
                    sqlOperator.ExecSQL(sql);//结转库存到当天
                }

                sql="select count(*) from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"' and f_ckbm='"+f_dcckbm+"'";
                int count1=Integer.parseInt(sqlOperator.queryOneRecorderData(sql));
                if(count1<=0) {//当天没有库存数据,需要结算到当天
                    sql = "insert into tb"+f_shbm+"_cksjb\n" +
                            "select '" + f_Rzrq + "',f_Bmbm,f_Sptm,f_pch,f_Sgpch,f_kcsl,f_kcje,f_kcsj,f_ckbm from " +
                            "tb"+f_shbm+"_cksjb where f_Sptm='" + f_sptm + "' and f_ckbm='"+f_dcckbm+"' and f_Rq=(select MAX(f_Rq) from tb"+f_shbm+"_cksjb where f_Sptm='" + f_sptm + "' and f_ckbm='"+f_dcckbm+"') and f_kcsl>0";
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
                String f_jldw=spJson.getString("F_JLDW");
                String f_lsdj = spJson.getString("F_XSDJ");
                String f_zhjj=spJson.getString("F_ZHJJ");
                String f_spmc=spJson.getString("F_SPMC");

                //判断库存是否足够
                sql="select isnull(SUM(f_kcsl),0) from tb"+f_shbm+"_spkc where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"' and f_bmbm ='"+f_dcbmbm+"'";
                double f_kcsl= Double.parseDouble(sqlOperator.queryOneRecorderData(sql));
                if(f_kcsl<f_xssl){
                    throw  new Exception("【"+f_spmc+"】库存不足!");
                }
                sql="select * from tb"+f_shbm+"_spkc where f_Sptm='"+f_sptm+"' and f_kcsl>0 and f_rq='"+f_Rzrq+"'  and f_bmbm ='"+f_dcbmbm+"' order by f_pch asc";
                ResultSet rsKc=sqlOperator.RunSQLToResSet(sql);
                while(rsKc.next()){
                    double pckc= Double.parseDouble(rsKc.getString("f_kcsl"));//批次库存
                    double f_kcje=Double.parseDouble(rsKc.getString("f_kcje"));//库存金额
                    double f_ykcsj=Double.parseDouble(rsKc.getString("f_kcsj"));//库存税金
                    double f_kcdj=f_kcje/pckc;
                    if(dblx == 1){
                        f_xsdj = f_kcdj;
                    }
                    String f_pch=rsKc.getString("f_pch");
                    String f_sgpch=rsKc.getString("f_sgpch");
                    if(f_xssl<=pckc)//一个批次库存就够
                    {
                        double f_ssje=SplitAndRound(f_xssl*f_xsdj,2);
                        double f_sssj=SplitAndRound(f_ssje/(1+f_sl/100)*f_sl/100,2);//实收税金
                        double f_hscb=SplitAndRound(f_kcdj*f_xssl,2);//含税成本
                        double f_wscb=SplitAndRound(f_hscb/(1+f_sl/100),2);//无税成本
                        double f_kcsj = SplitAndRound(f_hscb / (1 + f_sl / 100) * f_sl / 100, 2);//库存税金

                        String tempsql="select count(*) from tb"+f_shbm+"_spkc where f_Sptm='"+f_sptm+"' " +
                                "and f_bmbm ='"+f_drbmbm+"' and f_pch='"+f_pch+"'";

                        sql="update tb"+f_shbm+"_spkc set f_kcsl=f_kcsl -"+f_xssl+",f_kcje= f_kcje-"+Double.toString(f_hscb)+",f_kcsj=f_kcsj -"+Double.toString(f_kcsj)+
                                " where f_pch='"+f_pch+"' and f_sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"' and f_bmbm = '"+f_dcbmbm+"'";
                        sqlList.add(sql);
                        int countkc=Integer.parseInt(sqlOperator.queryOneRecorderData(tempsql));
                        if (countkc>0) {
                            sql="update tb"+f_shbm+"_spkc set f_kcsl=f_kcsl + "+f_xssl+",f_kcje= f_kcje+"+Double.toString(f_ssje)+",f_kcsj=f_kcsj +"+Double.toString(f_kcsj)+
                                    " where f_pch='"+f_pch+"' and f_sptm='"+f_sptm+"' and f_bmbm = '"+f_drbmbm+"' and f_rq='"+f_Rzrq+"'";
                        }else{
                            sql="insert into tb"+f_shbm+"_spkc(f_Rq,f_Bmbm,f_Sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj)" +
                                    "values('"+f_Rzrq+"','"+f_drbmbm+"','"+f_sptm+"','"+f_pch+"','"+f_sgpch+"','"+f_xssl+"','"+f_ssje+"','"+f_kcsj+"')";
                        }
                        sqlList.add(sql);
                        dnxh++;
                        break;
                    }else {
                        double f_ssje=SplitAndRound(pckc*f_xsdj,2);
                        double f_sssj=SplitAndRound(f_ssje/(1+f_sl/100)*f_sl/100,2);//实收税金
                        double f_hscb=SplitAndRound(f_kcdj*pckc,2);//含税成本
                        double f_wscb=SplitAndRound(f_hscb/(1+f_sl/100),2);//无税成本
                        double f_kcsj = SplitAndRound(f_hscb / (1 + f_sl / 100) * f_sl / 100, 2);//库存税金
                        sql="update tb"+f_shbm+"_spkc set f_kcsl='0',f_kcje='0',f_kcsj='0' where f_pch='"+f_pch+"' and f_sptm='"+f_sptm+"' and f_bmbm ='"+f_dcbmbm+"'  and f_rq='"+f_Rzrq+"' ";;
                        sqlList.add(sql);
                        String tempsql="select count(*) from tb"+f_shbm+"_spkc where f_Sptm='"+f_sptm+"' " +
                                "and f_bmbm ='"+f_drbmbm+"' and f_pch='"+f_pch+"'";
                        int countkc=Integer.parseInt(sqlOperator.queryOneRecorderData(tempsql));
                        if (countkc>0) {
                            sql="update tb"+f_shbm+"_spkc set f_kcsl=f_kcsl + "+pckc+",f_kcje= f_kcje+"+Double.toString(f_ssje)+",f_kcsj=f_kcsj +"+Double.toString(f_kcsj)+
                                    " where f_pch='"+f_pch+"' and f_sptm='"+f_sptm+"' and f_bmbm = '"+f_drbmbm+"' and f_rq='"+f_Rzrq+"'";
                        }else{
                            sql="insert into tb"+f_shbm+"_spkc(f_Rq,f_Bmbm,f_Sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj)" +
                                    "values('"+f_Rzrq+"','"+f_drbmbm+"','"+f_sptm+"','"+f_pch+"','"+f_sgpch+"','"+pckc+"','"+f_ssje+"','"+f_kcsj+"')";
                        }
                        sqlList.add(sql);
                        f_xssl=f_xssl-pckc;
                        dnxh++;
                        continue;
                    }
                }

                //判断仓库库存是否足够
                sql="select isnull(SUM(f_kcsl),0) from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"' and f_bmbm ='"+f_dcbmbm+"' and f_ckbm ='"+f_dcckbm+"'";
                double f_kcsl1= Double.parseDouble(sqlOperator.queryOneRecorderData(sql));
                if(f_kcsl1<f_xssl){
                    throw  new Exception("【"+f_spmc+"】库存不足!");
                }
                sql="select * from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_kcsl>0 and f_rq='"+f_Rzrq+"'  and f_bmbm ='"+f_dcbmbm+"' and f_ckbm ='"+f_dcckbm+"' order by f_pch asc";
                ResultSet rsKc1=sqlOperator.RunSQLToResSet(sql);
                while(rsKc1.next()){
                    double pckc= Double.parseDouble(rsKc.getString("f_kcsl"));//批次库存
                    double f_kcje=Double.parseDouble(rsKc.getString("f_kcje"));//库存金额
                    double f_ykcsj=Double.parseDouble(rsKc.getString("f_kcsj"));//库存税金
                    double f_kcdj=f_kcje/pckc;
                    if(dblx == 1){
                        f_xsdj = f_kcdj;
                    }
                    String f_pch=rsKc.getString("f_pch");
                    String f_sgpch=rsKc.getString("f_sgpch");
                    if(f_xssl<=pckc)//一个批次库存就够
                    {
                        double f_ssje=SplitAndRound(f_xssl*f_xsdj,2);
                        double f_sssj=SplitAndRound(f_ssje/(1+f_sl/100)*f_sl/100,2);//实收税金
                        double f_hscb=SplitAndRound(f_kcdj*f_xssl,2);//含税成本
                        double f_wscb=SplitAndRound(f_hscb/(1+f_sl/100),2);//无税成本
                        double f_wsml=SplitAndRound(f_ssje-f_sssj-f_wscb,2);//无税毛利
                        double f_hsml=SplitAndRound(f_ssje-f_hscb,2);//含税毛利
                        double f_kcsj = SplitAndRound(f_hscb / (1 + f_sl / 100) * f_sl / 100, 2);//库存税金
                        double f_lsje = SplitAndRound(Double.parseDouble(f_lsdj)*f_xssl,2);
                        sql="insert into tb"+f_shbm+"_Spzycb(f_Zylx,f_Djh,f_Dnxh,f_Zdbm,f_Sptm,f_ypzjh,f_Zhjj,f_Zysl,f_Zydj,f_Zyje," +
                                "f_Zysj,f_Sl,f_Lsdj,f_Lsje,f_Yrckbm,f_Ycckbm,f_pch,f_sgpch,f_hsbccb,f_wsbccb,f_bccj,f_ckbm,f_drckbm)values" +
                                "('2','"+f_djh+"','"+Integer.toString(dnxh)+"','"+f_dcbmbm+"','"+f_sptm+"','"+f_ypzjh+"','"+f_zhjj+"','"+Double.toString(f_xssl)+"'," +
                                "'"+Double.toString(f_xsdj)+"','"+Double.toString(f_ssje)+"','"+Double.toString(f_sssj)+"','"+f_sl+"','"+f_lsdj+"','"+Double.toString(f_lsje)+"'," +
                                "' ',' ','"+f_pch+"','"+f_sgpch+"','"+Double.toString(f_hscb)+"',"+
                                "'"+Double.toString(f_wscb)+"','"+Double.toString(f_hsml)+"','"+f_dcckbm+"','"+f_drckbm+"')";
                        sqlList.add(sql);

                        String tempsql="select count(*) from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_ckbm='"+f_drckbm+"' " +
                                " and f_bmbm ='"+f_drbmbm+"' and f_pch='"+f_pch+"'";

                        sql="update tb"+f_shbm+"_cksjb set f_kcsl=f_kcsl -"+f_xssl+",f_kcje= f_kcje-"+Double.toString(f_hscb)+",f_kcsj=f_kcsj -"+Double.toString(f_kcsj)+
                                " where f_pch='"+f_pch+"' and f_sptm='"+f_sptm+"' and f_rq='"+f_Rzrq+"' and f_bmbm = '"+f_dcbmbm+"' and f_ckbm='"+f_dcckbm+"'";
                        sqlList.add(sql);
                        int countkc=Integer.parseInt(sqlOperator.queryOneRecorderData(tempsql));
                        if (countkc>0) {
                            sql="update tb"+f_shbm+"_cksjb set f_kcsl=f_kcsl + "+f_xssl+",f_kcje= f_kcje+"+Double.toString(f_ssje)+",f_kcsj=f_kcsj +"+Double.toString(f_kcsj)+
                                    " where f_pch='"+f_pch+"' and f_sptm='"+f_sptm+"' and f_bmbm = '"+f_drbmbm+"' and f_rq='"+f_Rzrq+"' and f_ckbm='"+f_drckbm+"'";
                        }else{
                            sql="insert into tb"+f_shbm+"_cksjb(f_Rq,f_Bmbm,f_Sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj,f_ckbm)" +
                                    "values('"+f_Rzrq+"','"+f_drbmbm+"','"+f_sptm+"','"+f_pch+"','"+f_sgpch+"','"+f_xssl+"','"+f_ssje+"','"+f_kcsj+"','"+f_drckbm+"')";
                        }
                        sqlList.add(sql);
                        dnxh++;
                        break;
                    }else {
                        double f_ssje=SplitAndRound(pckc*f_xsdj,2);
                        double f_sssj=SplitAndRound(f_ssje/(1+f_sl/100)*f_sl/100,2);//实收税金
                        double f_hscb=SplitAndRound(f_kcdj*pckc,2);//含税成本
                        double f_wscb=SplitAndRound(f_hscb/(1+f_sl/100),2);//无税成本
                        double f_wsml=f_ssje-f_sssj-f_wscb;//无税毛利
                        double f_hsml=SplitAndRound(f_ssje-f_hscb,2);//含税毛利
                        double f_lsje = SplitAndRound(Double.parseDouble(f_lsdj)*f_xssl,2);
                        double f_kcsj = SplitAndRound(f_hscb / (1 + f_sl / 100) * f_sl / 100, 2);//库存税金
                        sql="insert into tb"+f_shbm+"_Spzycb(f_Zylx,f_Djh,f_Dnxh,f_Zdbm,f_Sptm,f_ypzjh,f_Zhjj,f_Zysl,f_Zydj,f_Zyje," +
                                "f_Zysj,f_Sl,f_Lsdj,f_Lsje,f_Yrckbm,f_Ycckbm,f_pch,f_sgpch,f_hsbccb,f_wsbccb,f_bccj,f_ckbm,f_drckbm)values" +
                                "('2','"+f_djh+"','"+Integer.toString(dnxh)+"','"+f_dcbmbm+"','"+f_sptm+"','"+f_ypzjh+"','"+f_zhjj+"','"+Double.toString(pckc)+"'," +
                                "'"+Double.toString(f_xsdj)+"','"+Double.toString(f_ssje)+"','"+Double.toString(f_sssj)+"','"+f_sl+"','"+f_lsdj+"','"+Double.toString(f_lsje)+"'," +
                                "' ',' ','"+f_pch+"','"+f_sgpch+"','"+Double.toString(f_hscb)+"',"+
                                "'"+Double.toString(f_wscb)+"','"+Double.toString(f_hsml)+"','"+f_dcckbm+"','"+f_drckbm+"')";
                        sqlList.add(sql);
                        sql="update tb"+f_shbm+"_cksjb set f_kcsl='0',f_kcje='0',f_kcsj='0' where f_pch='"+f_pch+"' and f_sptm='"+f_sptm+"' and f_bmbm ='"+f_dcbmbm+"'  and f_rq='"+f_Rzrq+"' and f_ckbm='"+f_dcckbm+"' ";
                        sqlList.add(sql);
                        String tempsql="select count(*) from tb"+f_shbm+"_cksjb where f_Sptm='"+f_sptm+"' and f_ckbm='"+f_drckbm+"' " +
                                "and f_bmbm ='"+f_drbmbm+"' and f_pch='"+f_pch+"'";
                        int countkc=Integer.parseInt(sqlOperator.queryOneRecorderData(tempsql));
                        if (countkc>0) {
                            sql="update tb"+f_shbm+"_cksjb set f_kcsl=f_kcsl + "+pckc+",f_kcje= f_kcje+"+Double.toString(f_ssje)+",f_kcsj=f_kcsj +"+Double.toString(f_kcsj)+
                                    " where f_pch='"+f_pch+"' and f_sptm='"+f_sptm+"' and f_bmbm = '"+f_drbmbm+"' and f_rq='"+f_Rzrq+"' and f_ckbm='"+f_drckbm+"'";
                        }else{
                            sql="insert into tb"+f_shbm+"_cksjb(f_Rq,f_Bmbm,f_Sptm,f_pch,f_sgpch,f_kcsl,f_kcje,f_kcsj,f_ckbm)" +
                                    "values('"+f_Rzrq+"','"+f_drbmbm+"','"+f_sptm+"','"+f_pch+"','"+f_sgpch+"','"+pckc+"','"+f_ssje+"','"+f_kcsj+"','"+f_drckbm+"')";
                        }
                        sqlList.add(sql);
                        f_xssl=f_xssl-pckc;
                        dnxh++;
                        continue;
                    }
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
    public String GetBillDetail(String cxtj, String bmbm,String f_ksrq,String f_jsrq,String f_shbm,String f_zybm)
    {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String zysxbm=GetZysxbmByZybm(f_zybm,f_shbm,sqlOperator);
            String sql = "select zb.f_Djh,zb.f_Zdrq,zb.f_Zdrbm,zb.f_Zdrmc,zb.f_Zdbm,bm1.f_Bmmc as f_zdbmmc,f_Zcbm,bm2.f_Bmmc as f_zcbmmc, \n" +
                    "f_Zrbm,bm3.f_Bmmc as f_zrbmmc,zb.f_Djbz,cb.f_ckbm,ckda1.f_ckmc as f_dcckmc,cb.f_drckbm,ckda2.f_ckmc as f_drckmc \n" +
                    "from tb"+f_shbm+"_Spzyzb zb \n" +
                    "left join tb"+f_shbm+"_Spzycb cb on zb.f_Djh=cb.f_Djh \n" +
                    "left join (select * from tb000002_ckdawh ckda)ckda1 on cb.f_ckbm = ckda1.f_ckbm\n" +
                    "left join (select * from tb000002_ckdawh ckda)ckda2 on cb.f_drckbm = ckda2.f_ckbm \n" +
                    "left join (select * from tb"+f_shbm+"_Bmda bm) bm1 on bm1.f_Bmbm = zb.f_Zdbm \n" +
                    "left join (select * from tb"+f_shbm+"_Bmda bm) bm2 on bm2.f_Bmbm = zb.f_Zcbm \n" +
                    "left join (select * from tb"+f_shbm+"_Bmda bm) bm3 on bm3.f_Bmbm = zb.f_Zrbm \n" +
                    "where zb.f_zdrq between '"+f_ksrq+"' and '"+f_jsrq+"' \n";
            if(!cxtj.equals("")){
                sql+=" and (bm1.f_Bmmc like '%"+cxtj+"%' or bm2.f_Bmmc like '%"+cxtj+"%' or bm3.f_Bmmc like '%"+cxtj+"%') \n";
            }
            if(!zysxbm.equals("")){
                sql+=" and (zb.f_Zcbm in("+zysxbm+") or zb.f_Zrbm in("+zysxbm+")) ";
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
    public String GetSpzyDetail(String cxtj,String f_ksrq,String f_jsrq,String f_shbm,String f_zybm)
    {
//创建连接池
        openConnection();

        String result = null;
        try {
            String zysxbm=GetZysxbmByZybm(f_zybm,f_shbm,sqlOperator);
            String sql = "select zb.f_Djh,zb.f_Rzrq,cb.f_Sptm,f_Spmc,f_Zydj,f_Zysl,f_Ggxh,f_jldw,f_Zyje,f_Pch,f_sgpch,spda.f_nybz,f_Zcbm,bm2.f_Bmmc as f_zcbmmc, " +
                    "f_Zrbm,bm3.f_Bmmc as f_zrbmmc,f_bccj " +
                    "from tb"+f_shbm+"_Spzycb cb " +
                    "left join tb"+f_shbm+"_Spzyzb zb on zb.f_Djh=cb.f_Djh " +
                    "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm " +
                    "left join (select * from tb"+f_shbm+"_Bmda bm) bm1 on bm1.f_Bmbm = zb.f_Zdbm " +
                    "left join (select * from tb"+f_shbm+"_Bmda bm) bm2 on bm2.f_Bmbm = zb.f_Zcbm " +
                    "left join (select * from tb"+f_shbm+"_Bmda bm) bm3 on bm3.f_Bmbm = zb.f_Zrbm " +
                    "where zb.f_rzrq between '"+f_ksrq+"' and '"+f_jsrq+"' and spda.f_f_colum1='0' ";
            if(!cxtj.equals("")){
                sql+=" and (bm1.f_Bmmc like '%"+cxtj+"%' or bm2.f_Bmmc like '%"+cxtj+"%' or bm3.f_Bmmc like '%"+cxtj+"%') ";
                sql+=" and cb.f_sptm like '%"+cxtj+"%' or f_spmc like '%"+cxtj +"%'";
            }
            if(!zysxbm.equals("")){
                sql+=" and (f_Zcbm in("+zysxbm+") or f_Zrbm in("+zysxbm+"))";
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
    public  String  GetZyHzcbmx(String f_djh,String f_shbm){
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql = "select cb.f_Sptm,f_Spmc,f_Zydj,f_Zysl,f_Ggxh,f_jldw,f_Zyje,f_Pch,f_Sgpch,f_bccj from tb"+f_shbm+"_Spzycb cb \n" +
                    "left join tb"+f_shbm+"_Spda spda on spda.f_Sptm=cb.f_Sptm where f_Djh='"+f_djh+"' and spda.f_f_colum1='0' ";
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
    public String GetSpkccbdj(Integer f_xssl,String f_sptm,String f_dcbmbm, String f_shbm) {
        //创建连接池
        openConnection();

        String result = null;
        try {
            String sql="select * from tb"+f_shbm+"_spkc where f_Sptm='"+f_sptm+"' and f_kcsl>0 and f_rq=(select MAX(f_Rq) from tb"+f_shbm+"_spkc where f_Sptm='" + f_sptm + "')  " +
                    "and f_bmbm ='"+f_dcbmbm+"' order by f_pch asc";
            ResultSet rsKc=sqlOperator.RunSQLToResSet(sql);
            double f_ssje = 0;
            double sssl = f_xssl;
            while(rsKc.next()){
                double pckc= Double.parseDouble(rsKc.getString("f_kcsl"));//批次库存
                double f_kcje=Double.parseDouble(rsKc.getString("f_kcje"));//库存金额
                double f_ykcsj=Double.parseDouble(rsKc.getString("f_kcsj"));//库存税金
                double f_kcdj=f_kcje/pckc;
/*                if(dblx == 1){
                    f_xsdj = f_kcdj;
                }*/
                double f_xsdj = f_kcdj;

                String f_pch=rsKc.getString("f_pch");
                String f_sgpch=rsKc.getString("f_sgpch");
                if(sssl<=pckc)//一个批次库存就够
                {
                    f_ssje+=SplitAndRound(sssl*f_xsdj,2);
                    break;
                }else {
                    f_ssje+=SplitAndRound(pckc*f_xsdj,2);
                    sssl= sssl- (int) pckc;
                    continue;
                }

            }
            Double xsdj = SplitAndRound(f_ssje/f_xssl,2);
            result = xsdj.toString();
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
    public String newMaxDjh(String f_shbm,SqlServerOperator sqlser) {
        String bm = null;
        UtilTools ut = new UtilTools();
        try {
            StringBuilder sql = new StringBuilder();
            String rq = this.retime().substring(0,6);
            sql.append("select max(f_djh) f_djh ");
            sql.append(" from tb").append(f_shbm).append("_Spzyzb ");
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
