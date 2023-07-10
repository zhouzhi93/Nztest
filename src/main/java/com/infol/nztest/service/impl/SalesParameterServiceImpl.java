package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.SalesParameterService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;

@Transactional
@Service
public class SalesParameterServiceImpl implements SalesParameterService {
    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getXstzs(String ksrq, String jsrq, String spmc, String djh, String sptm, String khbm, String khmc,
                           String qybm,Integer pageIndex,Integer pageSize, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");

        String result = null;
        if(!"".equals(ksrq)){
            String[] ksrqs = ksrq.split("-");
            ksrq = ksrqs[0]+ksrqs[1]+ksrqs[2];
        }
        if(!"".equals(jsrq)){
            String[] jsrqs = jsrq.split("-");
            jsrq = jsrqs[0]+jsrqs[1]+jsrqs[2];
        }
        try {

            String sql = "select count(*) from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"'";

            String bmbms = sqlOperator.queryOneRecorderData(sql);

            sql = "select xsc.f_Sptm,xsc.f_ypzjh,sp.f_Spmc,sp.f_Ggxh,bm.f_Bmmc,\n" +
                    "isnull((select tcs.f_Csmc from tb"+f_shbm+"_Csda tcs where tcs.f_Csbm = sp.f_Sccsbm),'') f_scqy,\n" +
                    "isnull((select tcs.f_Scxkzh from tb"+f_shbm+"_Csda tcs where tcs.f_Csbm = sp.f_Sccsbm),'') f_scxkzh,\n" +
                    "ISNULL(cs.f_Csmc,'') f_khmc,xsz.f_Rzrq,ISNULL(cs.f_Dh,'') f_dh,ISNULL(cs.f_sfzh,'') f_sfzh,sp.f_Jldw,xsc.f_Xssl, \n" +
                    "CAST(xsc.f_Ssje as DECIMAL(13,2)) as f_Ssje,Convert(decimal(18,2),(case xsc.f_Ssje when 0 then 0 else (xsc.f_Ssje/xsc.f_Xssl) end)) as f_xsdj " +
                    "from tb"+f_shbm+"_Xsmxcb xsc \n" +
                    "inner join tb"+f_shbm+"_Xsmxzb xsz on xsc.f_Djh = xsz.f_Djh \n" +
                    "left join tb"+f_shbm+"_Spda sp on sp.f_Sptm = xsc.f_Sptm \n" +
                    "left join tb"+f_shbm+"_Csda cs on xsz.f_Khbm = cs.f_Csbm and cs.f_Cslx = 1 " +
                    "left join tb"+f_shbm+"_Bmda bm on bm.f_Bmbm = xsz.f_Bmbm " +
                    "where 1=1 ";
            if(bmbms != null && !"0".equals(bmbms)){
                sql+="and xsz.f_Bmbm in(select f_Bmbm from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"') ";
            }
            if(!"".equals(ksrq) && "".equals(jsrq)){
                sql+="and f_Rzrq >= '"+ksrq+"' ";
            }
            if("".equals(ksrq) && !"".equals(jsrq)){
                sql+="and f_Rzrq <= '"+jsrq+"' ";
            }
            if(!"".equals(ksrq) && !"".equals(jsrq)){
                sql+="and f_Rzrq between '"+ksrq+"' and '"+jsrq+"' ";
            }
            if(!"".equals(spmc)){
                sql+="and sp.f_Spmc like '%"+spmc+"%' ";
            }
            if(!"".equals(sptm)){
                sql+="and xsc.f_Sptm like '%"+sptm+"%' ";
            }
            if(!"".equals(djh)){
                sql+="and xsc.f_ypzjh like '%"+djh+"%' ";
            }
            if(!"".equals(khmc)){
                sql+="and cs.f_Csmc like '%"+khmc+"%' ";
            }
            if(!"".equals(khbm)){
                sql+="and xsz.f_Khbm = '"+sptm+"' ";
            }
            if(!"".equals(qybm)){
                sql+="and (select tcs.f_Csmc from tb"+f_shbm+"_Csda tcs where tcs.f_Csbm = sp.f_Sccsbm) like  '%"+qybm+"%' ";
            }
            if(pageIndex != null){
                int start = (pageIndex - 1) * pageSize + 1;
                int end = pageIndex * pageSize;
                String fySql="select * from (select ROW_NUMBER()over (order by f_Bmmc) as rowno,* from ( ";
                fySql+=sql;
                fySql+=" )p)m where rowno>="+Integer.toString(start)+" and rowno<="+Integer.toString(end);
                result = sqlOperator.RunSQL_JSON(fySql);
            }else{
                result = sqlOperator.RunSQL_JSON(sql);
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
    public String getXstzs_total(String ksrq, String jsrq, String spmc, String djh, String sptm, String khbm, String khmc,
                           String qybm, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");

        String result = null;
        if(!"".equals(ksrq)){
            String[] ksrqs = ksrq.split("-");
            ksrq = ksrqs[0]+ksrqs[1]+ksrqs[2];
        }
        if(!"".equals(jsrq)){
            String[] jsrqs = jsrq.split("-");
            jsrq = jsrqs[0]+jsrqs[1]+jsrqs[2];
        }
        try {

            String sql = "select count(*) from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"'";

            String bmbms = sqlOperator.queryOneRecorderData(sql);

            sql = "select COUNT(*) " +
                    "from tb"+f_shbm+"_Xsmxcb xsc \n" +
                    "inner join tb"+f_shbm+"_Xsmxzb xsz on xsc.f_Djh = xsz.f_Djh \n" +
                    "left join tb"+f_shbm+"_Spda sp on sp.f_Sptm = xsc.f_Sptm \n" +
                    "left join tb"+f_shbm+"_Csda cs on xsz.f_Khbm = cs.f_Csbm and cs.f_Cslx = 1 " +
                    "left join tb"+f_shbm+"_Bmda bm on bm.f_Bmbm = xsz.f_Bmbm " +
                    "where 1=1 ";
            if(bmbms != null && !"0".equals(bmbms)){
                sql+="and xsz.f_Bmbm in(select f_Bmbm from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"') ";
            }
            if(!"".equals(ksrq) && "".equals(jsrq)){
                sql+="and f_Rzrq >= '"+ksrq+"' ";
            }
            if("".equals(ksrq) && !"".equals(jsrq)){
                sql+="and f_Rzrq <= '"+jsrq+"' ";
            }
            if(!"".equals(ksrq) && !"".equals(jsrq)){
                sql+="and f_Rzrq between '"+ksrq+"' and '"+jsrq+"' ";
            }
            if(!"".equals(spmc)){
                sql+="and sp.f_Spmc like '%"+spmc+"%' ";
            }
            if(!"".equals(sptm)){
                sql+="and xsc.f_Sptm like '%"+sptm+"%' ";
            }
            if(!"".equals(djh)){
                sql+="and xsc.f_ypzjh like '%"+djh+"%' ";
            }
            if(!"".equals(khmc)){
                sql+="and cs.f_Csmc like '%"+khmc+"%' ";
            }
            if(!"".equals(khbm)){
                sql+="and xsz.f_Khbm = '"+sptm+"' ";
            }
            if(!"".equals(qybm)){
                sql+="and (select tcs.f_Csmc from tb"+f_shbm+"_Csda tcs where tcs.f_Csbm = sp.f_Sccsbm) like  '%"+qybm+"%' ";
            }
            result = sqlOperator.queryOneRecorderData(sql);
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
    public String getCjtzs(String ksrq, String jsrq, String spmc, String djh, String sptm, String gysbm,
                           String gysmc, String qybm,Integer pageIndex,Integer pageSize, HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");

        String result = null;
        if(!"".equals(ksrq)){
            String[] ksrqs = ksrq.split("-");
            ksrq = ksrqs[0]+ksrqs[1]+ksrqs[2];
        }
        if(!"".equals(jsrq)){
            String[] jsrqs = jsrq.split("-");
            jsrq = jsrqs[0]+jsrqs[1]+jsrqs[2];
        }
        try {

            String sql = "select count(*) from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"'";

            String bmbms = sqlOperator.queryOneRecorderData(sql);

            sql = "select bm.f_Bmmc,gjc.f_Sptm,gjc.f_ypzjh,sp.f_Spmc,sp.f_Ggxh,\n" +
                    "isnull((select tcs.f_Csmc from tb"+f_shbm+"_Csda tcs where tcs.f_Csbm = sp.f_Sccsbm),'') f_scqy,\n" +
                    "isnull((select tcs.f_Scxkzh from tb"+f_shbm+"_Csda tcs where tcs.f_Csbm = sp.f_Sccsbm),'') f_scxkzh,\n" +
                    "\t\tISNULL(cs.f_Csmc,'') f_gysmc,ISNULL(cs.f_Scxkzh,'') f_gysxkzh,ISNULL(cs.f_Dh,'') f_dh,\n" +
                    "\t\tgjz.f_Rzrq,gjc.f_scrq,gjc.f_scpch,ISNULL(cs.f_sfzh,'') f_sfzh,sp.f_jldw,gjc.f_Gjsl \n" +
                    "from tb"+f_shbm+"_Spgjcb gjc \n" +
                    "inner join tb"+f_shbm+"_Spgjzb gjz on gjc.f_Djh = gjz.f_Djh \n" +
                    "left join tb"+f_shbm+"_Spda sp on sp.f_Sptm = gjc.f_Sptm \n" +
                    "left join tb"+f_shbm+"_Csda cs on gjz.f_Gysbm = cs.f_Csbm and cs.f_Cslx = 0 "+
                    "left join tb"+f_shbm+"_Bmda bm on bm.f_Bmbm = gjz.f_Bmbm " +
                    "where 1=1 ";
            if(bmbms != null && !"0".equals(bmbms)){
                sql+="and gjz.f_Bmbm in(select f_Bmbm from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"') ";
            }
            if(!"".equals(ksrq) && "".equals(jsrq)){
                sql+="and f_Rzrq >= '"+ksrq+"' ";
            }
            if("".equals(ksrq) && !"".equals(jsrq)){
                sql+="and f_Rzrq <= '"+jsrq+"' ";
            }
            if(!"".equals(ksrq) && !"".equals(jsrq)){
                sql+="and f_Rzrq between '"+ksrq+"' and '"+jsrq+"' ";
            }
            if(!"".equals(spmc)){
                sql+="and sp.f_Spmc like '%"+spmc+"%' ";
            }
            if(!"".equals(sptm)){
                sql+="and gjc.f_Sptm like '%"+sptm+"%' ";
            }
            if(!"".equals(djh)){
                sql+="and gjc.f_ypzjh like '%"+djh+"%' ";
            }
            if(!"".equals(gysmc)){
                sql+="and cs.f_Csmc like '%"+gysmc+"%' ";
            }
            if(!"".equals(gysbm)){
                sql+="and gjz.f_Gysbm = '"+gysbm+"' ";
            }
            if(!"".equals(qybm)){
                sql+="and (select tcs.f_Csmc from tb"+f_shbm+"_Csda tcs where tcs.f_Csbm = sp.f_Sccsbm) like  '%"+qybm+"%' ";
            }

            if(pageIndex != null){
                int start = (pageIndex - 1) * pageSize + 1;
                int end = pageIndex * pageSize;
                String fySql="select * from (select ROW_NUMBER()over (order by f_Bmmc) as rowno,* from ( ";
                fySql+=sql;
                fySql+=" )p)m where rowno>="+Integer.toString(start)+" and rowno<="+Integer.toString(end);
                result = sqlOperator.RunSQL_JSON(fySql);
            }else{
                result = sqlOperator.RunSQL_JSON(sql);
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
    public String getCjtzs_total(String ksrq, String jsrq, String spmc, String djh, String sptm, String gysbm,
                           String gysmc, String qybm,HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");

        String result = null;
        if(!"".equals(ksrq)){
            String[] ksrqs = ksrq.split("-");
            ksrq = ksrqs[0]+ksrqs[1]+ksrqs[2];
        }
        if(!"".equals(jsrq)){
            String[] jsrqs = jsrq.split("-");
            jsrq = jsrqs[0]+jsrqs[1]+jsrqs[2];
        }
        try {

            String sql = "select count(*) from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"'";

            String bmbms = sqlOperator.queryOneRecorderData(sql);

            sql = "select COUNT(*) " +
                    "from tb"+f_shbm+"_Spgjcb gjc \n" +
                    "inner join tb"+f_shbm+"_Spgjzb gjz on gjc.f_Djh = gjz.f_Djh \n" +
                    "left join tb"+f_shbm+"_Spda sp on sp.f_Sptm = gjc.f_Sptm \n" +
                    "left join tb"+f_shbm+"_Csda cs on gjz.f_Gysbm = cs.f_Csbm and cs.f_Cslx = 0 "+
                    "left join tb"+f_shbm+"_Bmda bm on bm.f_Bmbm = gjz.f_Bmbm " +
                    "where 1=1 ";
            if(bmbms != null && !"0".equals(bmbms)){
                sql+="and gjz.f_Bmbm in(select f_Bmbm from tb"+f_shbm+"_zysxbm where f_Zybm = '"+f_zybm+"') ";
            }
            if(!"".equals(ksrq) && "".equals(jsrq)){
                sql+="and f_Rzrq >= '"+ksrq+"' ";
            }
            if("".equals(ksrq) && !"".equals(jsrq)){
                sql+="and f_Rzrq <= '"+jsrq+"' ";
            }
            if(!"".equals(ksrq) && !"".equals(jsrq)){
                sql+="and f_Rzrq between '"+ksrq+"' and '"+jsrq+"' ";
            }
            if(!"".equals(spmc)){
                sql+="and sp.f_Spmc like '%"+spmc+"%' ";
            }
            if(!"".equals(sptm)){
                sql+="and gjc.f_Sptm like '%"+sptm+"%' ";
            }
            if(!"".equals(djh)){
                sql+="and gjc.f_ypzjh like '%"+djh+"%' ";
            }
            if(!"".equals(gysmc)){
                sql+="and cs.f_Csmc like '%"+gysmc+"%' ";
            }
            if(!"".equals(gysbm)){
                sql+="and gjz.f_Gysbm = '"+gysbm+"' ";
            }
            if(!"".equals(qybm)){
                sql+="and (select tcs.f_Csmc from tb"+f_shbm+"_Csda tcs where tcs.f_Csbm = sp.f_Sccsbm) like  '%"+qybm+"%' ";
            }

            result = sqlOperator.queryOneRecorderData(sql);
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

}
