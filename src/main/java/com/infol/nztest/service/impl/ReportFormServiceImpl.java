package com.infol.nztest.service.impl;

import com.infol.nztest.dao.SqlServerOperator;
import com.infol.nztest.service.ReportFormService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.*;

@Transactional
@Service
public class ReportFormServiceImpl implements ReportFormService {
    private static SqlServerOperator sqlOperator = null;

    public static void openConnection(){
        try {
            sqlOperator = new SqlServerOperator();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String loadBm(String f_shbm,String f_zybm) {
        openConnection();
        String result = null;
        try {
            String sql = "select bmda.f_Bmbm,bmda.f_Bmmc \n" +
                    "from tb"+f_shbm+"_Bmda bmda\n" +
                    "left join tb"+f_shbm+"_zysxbm zysxbm on bmda.f_Bmbm=zysxbm.f_Bmbm\n" +
                    "where zysxbm.f_Zybm='"+f_zybm+"'";
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
    public String loadZhjxc(String bmbm, String ksrq, String jsrq, String spflbm, String sptm, Integer pageIndex, Integer pageSize, HttpServletRequest request) {
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String total = null;
        String listResult = null;
        if (ksrq == null || ksrq.equals("") || jsrq == null || jsrq.equals("")){
            return "410";
        }else {
            try {
                String[] ksrqs = ksrq.split("-");
                String[] jsrqs = jsrq.split("-");
                String f_ksrq = ksrqs[0] + ksrqs[1] + ksrqs[2];
                String f_jsrq = jsrqs[0] + jsrqs[1] + jsrqs[2];

                //数据库内为含税金额
                //含税金额
                //无税金额=含税金额-税金
                String sql = "select spda.f_Sptm,f_Spmc,f_Ggxh,f_Xsdj,isnull(f_qcsl,0) f_qcsl,isnull(f_qcje,0) f_qcje,isnull(f_qcsj,0) f_qcsj,isnull(f_qcwsje,0) f_qcwsje,\n" +
                        "isnull(f_qmsl,0) f_qmsl,isnull(f_qmje,0) f_qmje,isnull(f_qmsj,0) f_qmsj,isnull(f_qmwsje,0) f_qmwsje,\n" +
                        "isnull(f_gjsl,0) f_gjsl,isnull(f_gjje,0) f_gjje,isnull(f_gjsj,0) f_gjsj,isnull(f_gjwsje ,0) f_gjwsje,\n" +
                        "isnull(br.f_zysl,0) f_brsl,isnull(br.f_zyje,0) f_brje,isnull(br.f_zysj,0) f_brsj,isnull(br.f_zywsje ,0) f_brwsje,\n" +
                        "isnull(bc.f_zysl,0) f_bcsl,isnull(bc.f_zyje,0) f_bcje,isnull(bc.f_zysj,0) f_bcsj,isnull(bc.f_zywsje ,0) f_bcwsje,\n" +
                        "isnull(f_sysl,0) f_sysl,isnull(f_syje,0) f_syje,isnull(f_sysj,0) f_sysj,isnull(f_sywsje ,0) f_sywsje,\n" +
                        "isnull(f_shsl,0) f_shsl,isnull(f_shje,0) f_shje,isnull(f_shsj,0) f_shsj,isnull(f_shwsje ,0) f_shwsje,\n" +
                        "isnull(f_xssl,0) f_xssl,isnull(f_xsje,0) f_xsje,isnull(f_xssj,0) f_xssj,isnull(f_xswsje ,0) f_xswsje\n" +
                        "from tb"+f_shbm+"_Spda spda\n" +
                        "left join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=spda.f_Sptm\n" +
                        "left join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(spkc.f_kcsl),0) f_qcsl,isnull(SUM(spkc.f_kcje),0) f_qcje,\n" +
                        "\tisnull(SUM(spkc.f_kcsj),0) f_qcsj,isnull(SUM(spkc.f_kcje-spkc.f_kcsj),0) f_qcwsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda \n" +
                        "\tleft join tb"+f_shbm+"_spkc spkc on spkc.f_Sptm=spda.f_Sptm  and spkc.f_Rq=(select MAX(f_rq) from tb"+f_shbm+"_spkc where f_rq<'"+f_ksrq+"' and f_Sptm = spda.f_Sptm)\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=spkc.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere spda.f_f_colum1=0\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand spkc.f_Bmbm='"+bmbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                        sql += "\tgroup by spda.f_Sptm) qc on spda.f_Sptm = qc.f_Sptm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(spkc.f_kcsl),0) f_qmsl,isnull(SUM(spkc.f_kcje),0) f_qmje,\n" +
                        "\tisnull(SUM(spkc.f_kcsj),0) f_qmsj,isnull(SUM(spkc.f_kcje-spkc.f_kcsj),0) f_qmwsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_spkc spkc on spkc.f_Sptm=spda.f_Sptm and spkc.f_Rq=(select MAX(f_rq) from tb"+f_shbm+"_spkc where f_rq<='"+f_jsrq+"' and f_Sptm = spda.f_Sptm)\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=spkc.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere spda.f_f_colum1=0 \n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand spkc.f_Bmbm='"+bmbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                        sql += "\tgroup by spda.f_Sptm) qm on spda.f_Sptm = qm.f_Sptm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(cb.f_Gjsl),0) f_gjsl,isnull(SUM(cb.f_Gjje),0) f_gjje,\n" +
                        "\tisnull(SUM(cb.f_Gjsj),0) f_gjsj,isnull(SUM(cb.f_Gjje-cb.f_Gjsj),0) f_gjwsje\t\n" +
                        "\tfrom  tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spgjcb cb on cb.f_Sptm=spda.f_Sptm \n" +
                        "\tleft join tb"+f_shbm+"_Spgjzb zb on cb.f_Djh=zb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere zb.f_Gjlx=0 \n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Bmbm='"+bmbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                sql += "\tgroup by spda.f_Sptm) gj on spda.f_Sptm = gj.f_Sptm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(cb.f_Zysl),0) f_zysl,isnull(SUM(cb.f_Zyje),0) f_zyje,\n" +
                        "\tisnull(SUM(cb.f_Zysj),0) f_zysj,isnull(SUM(cb.f_Zyje-cb.f_Zysj),0) f_zywsje\t\n" +
                        "\tfrom  tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spzycb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Spzyzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere 1=1\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Zrbm='"+bmbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                        sql += "\tgroup by spda.f_Sptm) br on spda.f_Sptm = br.f_Sptm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(cb.f_Zysl),0) f_zysl,isnull(SUM(cb.f_Zyje),0) f_zyje,\n" +
                        "\tisnull(SUM(cb.f_Zysj),0) f_zysj,isnull(SUM(cb.f_Zyje-cb.f_Zysj),0) f_zywsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spzycb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Spzyzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere 1=1\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Zcbm='"+bmbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                sql += "\tgroup by spda.f_Sptm) bc on spda.f_Sptm = bc.f_Sptm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(cb.f_Sysl),0) f_sysl,isnull(SUM(cb.f_Syje),0) f_syje,\n" +
                        "\tisnull(SUM(cb.f_Sysj),0) f_sysj,isnull(SUM(cb.f_Syje-cb.f_Sysj),0) f_sywsje\t\n" +
                        "\tfrom  tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spsycb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Spsyzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere cb.f_sylx=1\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Bmbm='"+bmbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                        sql += "\tgroup by spda.f_Sptm) sy on spda.f_Sptm = sy.f_Sptm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(cb.f_Sysl),0) f_shsl,isnull(SUM(cb.f_Syje),0) f_shje,\n" +
                        "\tisnull(SUM(cb.f_Sysj),0) f_shsj,isnull(SUM(cb.f_Syje-cb.f_Sysj),0) f_shwsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spsycb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Spsyzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere cb.f_sylx=2\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Bmbm='"+bmbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                        sql += "\tgroup by spda.f_Sptm) sh on spda.f_Sptm = sh.f_Sptm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(cb.f_Xssl),0) f_xssl,isnull(SUM(cb.f_Ssje),0) f_xsje,\n" +
                        "\tisnull(SUM(cb.f_Sssj),0) f_xssj,isnull(SUM(cb.f_Ssje-cb.f_Sssj),0) f_xswsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Xsmxcb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere 1=1\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Bmbm='"+bmbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                        sql += "\tgroup by spda.f_Sptm) xs on spda.f_Sptm = xs.f_Sptm\n" +
                        "where spda.f_f_colum1=0 \n";
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                        sql += "order by spda.f_Sptm";
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
    }

    @Override
    public String loadCk(HttpServletRequest request) {
        //创建连接池
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String sql = "";
        String result = null;
        try {
            sql = "select * from tb"+f_shbm+"_ckdawh order by f_ckbm";
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
    public String loadCrkcx(String bmbm, String ckbm, String ksrq, String jsrq, String spflbm, String sptm, Integer pageIndex, Integer pageSize, HttpServletRequest request) {
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String total = null;
        String listResult = null;
        if (ksrq == null || ksrq.equals("") || jsrq == null || jsrq.equals("")){
            return "410";
        }else {
            try {
                String[] ksrqs = ksrq.split("-");
                String[] jsrqs = jsrq.split("-");
                String f_ksrq = ksrqs[0] + ksrqs[1] + ksrqs[2];
                String f_jsrq = jsrqs[0] + jsrqs[1] + jsrqs[2];

                //数据库内为含税金额
                //含税金额
                //无税金额=含税金额-税金
                String sql = "select spda.f_Sptm,f_Spmc,f_Ggxh,f_Jldw,\n" +
                        "isnull(f_qcsl,0) f_qcsl,isnull(f_qcje,0) f_qcje,isnull(f_qcsj,0) f_qcsj,isnull(f_qcwsje,0) f_qcwsje,\n" +
                        "isnull(f_qmsl,0) f_qmsl,isnull(f_qmje,0) f_qmje,isnull(f_qmsj,0) f_qmsj,isnull(f_qmwsje,0) f_qmwsje,\n" +
                        "(isnull(gj.f_gjsl,0)+isnull(br.f_zysl,0)+isnull(sy.f_sysl,0)) f_rksl,(isnull(gj.f_gjje,0)+isnull(br.f_zyje,0)+isnull(sy.f_syje,0)) f_rkje,(isnull(gj.f_gjsj,0)+isnull(br.f_zysj,0)+isnull(sy.f_sysj,0)) f_rksj,(isnull(gj.f_gjwsje,0)+isnull(br.f_zywsje,0)+isnull(sy.f_sywsje,0)) f_rkwsje,\n" +
                        "(isnull(xs.f_xssl,0)+isnull(bc.f_zysl,0)-isnull(sh.f_shsl,0)) f_cksl,(isnull(xs.f_xsje,0)+isnull(bc.f_zyje,0)-isnull(sh.f_shje,0)) f_ckje,(isnull(xs.f_xssj,0)+isnull(bc.f_zysj,0)-isnull(sh.f_shsj,0)) f_cksj,(isnull(xs.f_xswsje,0)+isnull(bc.f_zywsje,0)-isnull(sh.f_shwsje,0)) f_ckwsje\n" +
                        "from tb"+f_shbm+"_Spda spda\n" +
                        "left join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=spda.f_Sptm\n" +
                        "left join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(cksjb.f_kcsl),0) f_qcsl,isnull(SUM(cksjb.f_kcje),0) f_qcje,\n" +
                        "\tisnull(SUM(cksjb.f_kcsj),0) f_qcsj,isnull(SUM(cksjb.f_kcje-cksjb.f_kcsj),0) f_qcwsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda \n" +
                        "\tleft join tb"+f_shbm+"_cksjb cksjb on cksjb.f_Sptm=spda.f_Sptm  and cksjb.f_Rq=(select MAX(f_rq) from tb"+f_shbm+"_cksjb where f_rq<'"+f_ksrq+"' and f_Sptm = spda.f_Sptm)\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cksjb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere spda.f_f_colum1=0\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand cksjb.f_Bmbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cksjb.f_ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                        sql += "\tgroup by spda.f_Sptm) qc on spda.f_Sptm = qc.f_Sptm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(cksjb.f_kcsl),0) f_qmsl,isnull(SUM(cksjb.f_kcje),0) f_qmje,\n" +
                        "\tisnull(SUM(cksjb.f_kcsj),0) f_qmsj,isnull(SUM(cksjb.f_kcje-cksjb.f_kcsj),0) f_qmwsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_cksjb cksjb on cksjb.f_Sptm=spda.f_Sptm and cksjb.f_Rq=(select MAX(f_rq) from tb"+f_shbm+"_cksjb where f_rq<'"+f_jsrq+"' and f_Sptm = spda.f_Sptm)\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cksjb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere spda.f_f_colum1=0 \n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand cksjb.f_Bmbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cksjb.f_ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                        sql += "\tgroup by spda.f_Sptm) qm on spda.f_Sptm = qm.f_Sptm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(cb.f_Gjsl),0) f_gjsl,isnull(SUM(cb.f_Gjje),0) f_gjje,\n" +
                        "\tisnull(SUM(cb.f_Gjsj),0) f_gjsj,isnull(SUM(cb.f_Gjje-cb.f_Gjsj),0) f_gjwsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spgjcb cb on spda.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Spgjzb zb on cb.f_Djh=zb.f_Djh  and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere zb.f_Gjlx=0 \n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Bmbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cb.f_ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                        sql += "\tgroup by spda.f_Sptm) gj on spda.f_Sptm = gj.f_Sptm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(cb.f_Zysl),0) f_zysl,isnull(SUM(cb.f_Zyje),0) f_zyje,\n" +
                        "\tisnull(SUM(cb.f_Zysj),0) f_zysj,isnull(SUM(cb.f_Zyje-cb.f_Zysj),0) f_zywsje\t\n" +
                        "\tfrom  tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spzycb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Spzyzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere 1=1\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Zrbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cb.f_ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                        sql += "\tgroup by spda.f_Sptm) br on spda.f_Sptm = br.f_Sptm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(cb.f_Sysl),0) f_sysl,isnull(SUM(cb.f_Syje),0) f_syje,\n" +
                        "\tisnull(SUM(cb.f_Sysj),0) f_sysj,isnull(SUM(cb.f_Syje-cb.f_Sysj),0) f_sywsje\t\n" +
                        "\tfrom  tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spsycb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Spsyzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere cb.f_sylx=1\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Bmbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cb.f_Ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                        sql += "\tgroup by spda.f_Sptm) sy on spda.f_Sptm = sy.f_Sptm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(cb.f_Zysl),0) f_zysl,isnull(SUM(cb.f_Zyje),0) f_zyje,\n" +
                        "\tisnull(SUM(cb.f_Zysj),0) f_zysj,isnull(SUM(cb.f_Zyje-cb.f_Zysj),0) f_zywsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spzycb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Spzyzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere 1=1\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Zcbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cb.f_Ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                        sql += "\tgroup by spda.f_Sptm) bc on spda.f_Sptm = bc.f_Sptm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(cb.f_Sysl),0) f_shsl,isnull(SUM(cb.f_Syje),0) f_shje,\n" +
                        "\tisnull(SUM(cb.f_Sysj),0) f_shsj,isnull(SUM(cb.f_Syje-cb.f_Sysj),0) f_shwsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spsycb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Spsyzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere cb.f_sylx=2\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Bmbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cb.f_Ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                        sql += "\tgroup by spda.f_Sptm) sh on spda.f_Sptm = sh.f_Sptm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,\n" +
                        "\tisnull(SUM(cb.f_Xssl),0) f_xssl,isnull(SUM(cb.f_Ssje),0) f_xsje,\n" +
                        "\tisnull(SUM(cb.f_Sssj),0) f_xssj,isnull(SUM(cb.f_Ssje-cb.f_Sssj),0) f_xswsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Xsmxcb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere 1=1\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Bmbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cb.f_Ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                       sql += "\tgroup by spda.f_Sptm) xs on spda.f_Sptm = xs.f_Sptm\n" +
                        "where spda.f_f_colum1=0 \n";
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    String[] sptms = sptm.split(",");
                    sql += "\tand spda.f_Sptm in (";
                    for (int i = 0; i < sptms.length; i++){
                        if (i == sptms.length -1){
                            sql += "'"+sptms[i]+"'";
                        }else{
                            sql += "'"+sptms[i]+"',";
                        }
                    }
                    sql += ")\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "and spda.f_Sptm in(select distinct f_Sptm from tb"+f_shbm+"_cksjb where f_ckbm = '"+ckbm+"')\n";
                }
                        sql += "order by spda.f_Sptm";

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
    }

    @Override
    public String showDetail(String sptm, String bmbm, String ckbm, String ksrq, String jsrq, String spflbm, HttpServletRequest request) {
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String result = null;
        if (ksrq == null || ksrq.equals("") || jsrq == null || jsrq.equals("")){
            return "410";
        }else {
            try {
                String[] ksrqs = ksrq.split("-");
                String[] jsrqs = jsrq.split("-");
                String f_ksrq = ksrqs[0] + ksrqs[1] + ksrqs[2];
                String f_jsrq = jsrqs[0] + jsrqs[1] + jsrqs[2];

                //数据库内为含税金额
                //含税金额
                //无税金额=含税金额-税金
                String sql = "select '"+f_ksrq+"' as f_rq,'期初库存' as f_djlx,isnull(f_qcje/f_qcsl,0) f_dj,\n" +
                        "isnull(f_qcsl,0) f_sl,isnull(f_qcje,0) f_je,isnull(f_qcsj,0) f_sj,isnull(f_qcwsje,0) f_wsje\n" +
                        "from tb"+f_shbm+"_Spda spda\n" +
                        "left join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=spda.f_Sptm\n" +
                        "left join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,cksjb.f_Rq,\n" +
                        "\tisnull(SUM(cksjb.f_kcsl),0) f_qcsl,isnull(SUM(cksjb.f_kcje),0) f_qcje,\n" +
                        "\tisnull(SUM(cksjb.f_kcsj),0) f_qcsj,isnull(SUM(cksjb.f_kcje-cksjb.f_kcsj),0) f_qcwsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda \n" +
                        "\tleft join tb"+f_shbm+"_cksjb cksjb on cksjb.f_Sptm=spda.f_Sptm  and cksjb.f_Rq=(select MAX(f_rq) from tb"+f_shbm+"_cksjb where f_rq<'"+f_ksrq+"' and f_Sptm = spda.f_Sptm)\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cksjb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere spda.f_f_colum1=0\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand cksjb.f_Bmbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cksjb.f_ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "\tand spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += "\tgroup by spda.f_Sptm,cksjb.f_Rq) qc on spda.f_Sptm = qc.f_Sptm\n" +
                        "where spda.f_f_colum1=0 \n";
                if (spflbm != null && !spflbm.equals("")){
                    sql += "and lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "and spda.f_Sptm='"+sptm+"'\n";
                }
                        sql +="\n" +
                        "union all\n" +
                        "\n" +
                        "select '"+f_jsrq+"' as f_rq,'期末库存' as f_djlx,isnull(f_qmje/f_qmsl,0) f_dj,\n" +
                        "isnull(f_qmsl,0) f_sl,isnull(f_qmje,0) f_je,isnull(f_qmsj,0) f_sj,isnull(f_qmwsje,0) f_wsje\n" +
                        "from tb"+f_shbm+"_Spda spda\n" +
                        "left join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=spda.f_Sptm\n" +
                        "left join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,cksjb.f_Rq,\n" +
                        "\tisnull(SUM(cksjb.f_kcsl),0) f_qmsl,isnull(SUM(cksjb.f_kcje),0) f_qmje,\n" +
                        "\tisnull(SUM(cksjb.f_kcsj),0) f_qmsj,isnull(SUM(cksjb.f_kcje-cksjb.f_kcsj),0) f_qmwsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda \n" +
                        "\tleft join tb"+f_shbm+"_cksjb cksjb on cksjb.f_Sptm=spda.f_Sptm  and cksjb.f_Rq=(select MAX(f_rq) from tb"+f_shbm+"_cksjb where f_rq<'"+f_jsrq+"' and f_Sptm = spda.f_Sptm)\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cksjb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere spda.f_f_colum1=0\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand cksjb.f_Bmbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cksjb.f_ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "\tand spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += "\tgroup by spda.f_Sptm,cksjb.f_Rq) qm on spda.f_Sptm = qm.f_Sptm\n" +
                        "where spda.f_f_colum1=0 \n";
                if (spflbm != null && !spflbm.equals("")){
                    sql += "and lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "and spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += "\n" +
                        "\n" +
                        "\n" +
                        "union all\n" +
                        "\n" +
                        "select isnull(gj.f_Rzrq,'') f_rq,'进货单' as f_djlx,isnull(f_gjje/f_gjsl,0) f_dj,\n" +
                        "isnull(f_gjsl,0) f_sl,isnull(f_gjje,0) f_je,isnull(f_gjsj,0) f_sj,isnull(f_gjwsje,0) f_wsje\n" +
                        "from tb"+f_shbm+"_Spda spda\n" +
                        "left join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=spda.f_Sptm\n" +
                        "left join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,zb.f_Rzrq,\n" +
                        "\tisnull(cb.f_Gjsl,0) f_gjsl,isnull(cb.f_Gjje,0) f_gjje,\n" +
                        "\tisnull(cb.f_Gjsj,0) f_gjsj,isnull(cb.f_Gjje-cb.f_Gjsj,0) f_gjwsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spgjcb cb on spda.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Spgjzb zb on cb.f_Djh=zb.f_Djh  and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere zb.f_Gjlx=0 \n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Bmbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cb.f_ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "\tand spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += ") gj on spda.f_Sptm = gj.f_Sptm\n" +
                        "where spda.f_f_colum1=0 \n";
                if (spflbm != null && !spflbm.equals("")){
                    sql += "and lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "and spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += "\n" +
                        "\n" +
                        "union all\n" +
                        "\n" +
                        "\n" +
                        "select isnull(br.f_Rzrq,'') f_rq,'调拨单' as f_djlx,isnull(f_zyje/f_zysl,0) f_dj,\n" +
                        "isnull(f_zysl,0) f_sl,isnull(f_zyje,0) f_je,isnull(f_zysj,0) f_sj,isnull(f_zywsje,0) f_wsje\n" +
                        "from tb"+f_shbm+"_Spda spda\n" +
                        "left join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=spda.f_Sptm\n" +
                        "left join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,zb.f_Rzrq,\n" +
                        "\tisnull(cb.f_Zysl,0) f_zysl,isnull(cb.f_Zyje,0) f_zyje,\n" +
                        "\tisnull(cb.f_Zysj,0) f_zysj,isnull(cb.f_Zyje-cb.f_Zysj,0) f_zywsje\t\n" +
                        "\tfrom  tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spzycb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Spzyzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere 1=1\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Zrbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cb.f_Ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "\tand spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += ") br on spda.f_Sptm = br.f_Sptm\n" +
                        "where spda.f_f_colum1=0 \n";
                if (spflbm != null && !spflbm.equals("")){
                    sql += "and lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "and spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += "\n" +
                        "\n" +
                        "\n" +
                        "union all\n" +
                        "\n" +
                        "\n" +
                        "select isnull(sy.f_Rzrq,'') f_rq,'损益单' as f_djlx,isnull(f_syje/f_sysl,0) f_dj,\n" +
                        "isnull(f_sysl,0) f_sl,isnull(f_syje,0) f_je,isnull(f_sysj,0) f_sj,isnull(f_sywsje,0) f_wsje\n" +
                        "from tb"+f_shbm+"_Spda spda\n" +
                        "left join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=spda.f_Sptm\n" +
                        "left join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,zb.f_Rzrq,\n" +
                        "\tisnull(cb.f_Sysl,0) f_sysl,isnull(cb.f_Syje,0) f_syje,\n" +
                        "\tisnull(cb.f_Sysj,0) f_sysj,isnull(cb.f_Syje-cb.f_Sysj,0) f_sywsje\t\n" +
                        "\tfrom  tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spsycb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Spsyzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere cb.f_sylx=1\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Bmbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cb.f_Ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "\tand spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += ") sy on spda.f_Sptm = sy.f_Sptm\n" +
                        "where spda.f_f_colum1=0 \n";
                if (spflbm != null && !spflbm.equals("")){
                    sql += "and lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "and spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += "\n" +
                        "\n" +
                        "union all\n" +
                        "\n" +
                        "\n" +
                        "select isnull(bc.f_Rzrq,'') f_rq,'调拨单' as f_djlx,isnull(f_zyje/f_zysl,0) f_dj,\n" +
                        "isnull(-1*f_zysl,0) f_sl,isnull(-1*f_zyje,0) f_je,isnull(-1*f_zysj,0) f_sj,isnull(-1*f_zywsje,0) f_wsje\n" +
                        "from tb"+f_shbm+"_Spda spda\n" +
                        "left join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=spda.f_Sptm\n" +
                        "left join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,zb.f_Rzrq,\n" +
                        "\tisnull(cb.f_Zysl,0) f_zysl,isnull(cb.f_Zyje,0) f_zyje,\n" +
                        "\tisnull(cb.f_Zysj,0) f_zysj,isnull(cb.f_Zyje-cb.f_Zysj,0) f_zywsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spzycb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Spzyzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere 1=1\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Zcbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cb.f_Ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "\tand spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += ") bc on spda.f_Sptm = bc.f_Sptm\n" +
                        "where spda.f_f_colum1=0 \n";
                if (spflbm != null && !spflbm.equals("")){
                    sql += "and lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "and spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += "\n" +
                        "\n" +
                        "union all\n" +
                        "\n" +
                        "\n" +
                        "select isnull(sh.f_Rzrq,'') f_rq,'损益单' as f_djlx,isnull(f_shje/f_shsl,0) f_dj,\n" +
                        "isnull(f_shsl,0) f_sl,isnull(f_shje,0) f_je,isnull(f_shsj,0) f_sj,isnull(f_shwsje,0) f_wsje\n" +
                        "from tb"+f_shbm+"_Spda spda\n" +
                        "left join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=spda.f_Sptm\n" +
                        "left join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,zb.f_Rzrq,\n" +
                        "\tisnull(cb.f_Sysl,0) f_shsl,isnull(cb.f_Syje,0) f_shje,\n" +
                        "\tisnull(cb.f_Sysj,0) f_shsj,isnull(cb.f_Syje-cb.f_Sysj,0) f_shwsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Spsycb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Spsyzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere cb.f_sylx=2\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Bmbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cb.f_Ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "\tand spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += ") sh on spda.f_Sptm = sh.f_Sptm\n" +
                        "where spda.f_f_colum1=0 \n";
                if (spflbm != null && !spflbm.equals("")){
                    sql += "and lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "and spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += "\n" +
                        "union all\n" +
                        "\n" +
                        "\n" +
                        "select isnull(xs.f_Rzrq,'') f_rq,'销售单' as f_djlx,isnull(f_xsje/f_xssl,0) f_dj,\n" +
                        "isnull(-1*f_xssl,0) f_sl,isnull(-1*f_xsje,0) f_je,isnull(-1*f_xssj,0) f_sj,isnull(-1*f_xswsje,0) f_wsje\n" +
                        "from tb"+f_shbm+"_Spda spda\n" +
                        "left join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=spda.f_Sptm\n" +
                        "left join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "left join\n" +
                        "\t(select spda.f_Sptm,zb.f_Rzrq,\n" +
                        "\tisnull(cb.f_Xssl,0) f_xssl,isnull(cb.f_Ssje,0) f_xsje,\n" +
                        "\tisnull(cb.f_Sssj,0) f_xssj,isnull(cb.f_Ssje-cb.f_Sssj,0) f_xswsje\t\n" +
                        "\tfrom tb"+f_shbm+"_Spda spda\n" +
                        "\tleft join tb"+f_shbm+"_Xsmxcb cb on cb.f_Sptm=spda.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh=cb.f_Djh and zb.f_Rzrq between '"+f_ksrq+"' and '"+f_jsrq+"'\n" +
                        "\tleft join tb"+f_shbm+"_Splbdz lbdz on lbdz.f_Sptm=cb.f_Sptm\n" +
                        "\tleft join tb"+f_shbm+"_Splbda lbda on lbda.f_Splbbm=lbdz.f_Splbbm\n" +
                        "\twhere 1=1\n";
                if (bmbm != null && !bmbm.equals("")){
                    sql += "\tand zb.f_Bmbm='"+bmbm+"'\n";
                }
                if (ckbm != null && !ckbm.equals("")){
                    sql += "\tand cb.f_Ckbm='"+ckbm+"'\n";
                }
                if (spflbm != null && !spflbm.equals("")){
                    sql += "\tand lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "\tand spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += ") xs on spda.f_Sptm = xs.f_Sptm\n" +
                        "where spda.f_f_colum1=0 \n";
                if (spflbm != null && !spflbm.equals("")){
                    sql += "and lbdz.f_Splbbm='"+spflbm+"'\n";
                }
                if (sptm != null && !sptm.equals("")){
                    sql += "and spda.f_Sptm='"+sptm+"'\n";
                }
                        sql += "\n" +
                        "\n" +
                        "order by f_rq,f_djlx";
                result = sqlOperator.RunSQL_JSON(sql);
            }catch (Exception e) {
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
    public String loadXsj(String f_shbm) {
        openConnection();
        String result = null;
        try {
            String sql = "select distinct f_jyjId,f_jyjName,f_startTime,f_endTime from tb"+f_shbm+"_jyj order by f_jyjId";
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
    public String getZylx(String f_khlx,String jyjId,String f_shbm) {
        openConnection();
        String result = null;
        try {
            String sql = "select jyj.*,tjmx.f_flmc \n" +
                    "from tb"+f_shbm+"_jyj jyj\n" +
                    "left join tb"+f_shbm+"_tjmxwh tjmx on tjmx.f_flbm=jyj.f_flbm\n" +
                    "where jyj.f_state='1' and jyj.f_jyjId='"+jyjId+"' and jyj.f_Khlx='"+f_khlx+"'\n" +
                    "order by jyj.f_flbm";
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
    public String loadJxsbb(String jyjId, Integer pageIndex, Integer pageSize, HttpServletRequest request) {
        openConnection();

        String f_shbm = (String) request.getSession().getAttribute("f_shbm");

        String sql = "";
        String total = null;
        String listResult = null;
        List<JSONArray> xscbJarrList = new ArrayList<>();
        try {
            //1、获取经营季日期区间
            sql = "select distinct f_startTime,f_endTime from tb"+f_shbm+"_jyj where f_jyjId='"+jyjId+"'";
            String result = sqlOperator.RunSQL_JSON(sql);
            JSONArray rqqjJarr = new JSONArray(result);
            String ksrq = rqqjJarr.getJSONObject(0).getString("F_STARTTIME");
            String jsrq = rqqjJarr.getJSONObject(0).getString("F_ENDTIME");

            //2、获取所有产生销售的部门
            sql = "select distinct cb.f_Bmbm\n" +
                    "from tb"+f_shbm+"_Xsmxcb cb\n" +
                    "left join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh=cb.f_Djh\n" +
                    "where zb.f_Rzrq between '"+ksrq+"' and '"+jsrq+"' \n" +
                    "order by f_bmbm desc";
            result = sqlOperator.RunSQL_JSON(sql);
            JSONArray bmJarr = new JSONArray(result);
            //3、查询所有经营季中打钩的，并且经营季id为1的分类编码
            sql = "select distinct f_flbm from tb"+f_shbm+"_jyj \n" +
                    "where f_jyjId='"+jyjId+"' and f_state='1'";
            result = sqlOperator.RunSQL_JSON(sql);
            JSONArray flbmJarr = new JSONArray(result);
            for (int i = 0; i < bmJarr.length(); i++){
                String f_bmbm = bmJarr.getJSONObject(i).getString("F_BMBM");
                //4、获取所有销售的适用范围，和第三步进行比对，有则留
                sql = "select cb.*,zb.f_Khbm,sp.f_syfw,bmda.f_Bmmc,csda.f_Khlx \n" +
                        "from tb"+f_shbm+"_Xsmxcb cb\n" +
                        "left join tb"+f_shbm+"_Xsmxzb zb on zb.f_Djh=cb.f_Djh\n" +
                        "left join tb"+f_shbm+"_Spda sp on cb.f_sptm = sp.f_Sptm\n" +
                        "left join tb"+f_shbm+"_Bmda bmda on bmda.f_Bmbm=cb.f_Bmbm\n" +
                        "left join tb"+f_shbm+"_Csda csda on csda.f_Csbm=zb.f_Khbm\n" +
                        "where zb.f_Rzrq between '"+ksrq+"' and '"+jsrq+"' and cb.f_Bmbm = '"+f_bmbm+"'\n" +
                        "order by f_sptm";
                result = sqlOperator.RunSQL_JSON(sql);
                JSONArray xscbJarr = new JSONArray(result);
                for (int j = 0; j < xscbJarr.length(); j++){
                    String f_sptm = xscbJarr.getJSONObject(j).getString("F_SPTM");
                    String f_syfws = xscbJarr.getJSONObject(j).getString("F_SYFW");
                    String[] syfws = f_syfws.split(",");
                    int k = 0;
                    for (int g = 0; g < syfws.length; g++){
                        String syfw = syfws[g];
                        for (int h = 0; h < flbmJarr.length(); h++){
                            String f_flbm = flbmJarr.getJSONObject(h).getString("F_FLBM");
                            //所有经营季打钩的flbm和产生销售的商品syfw进行比对，存在则保留
                            if (syfw.equals(f_flbm)){
                                k++;
                            }
                        }
                    }
                    if (k == 0){
                        xscbJarr.remove(j);
                    }
                }
                xscbJarrList.add(xscbJarr);
            }

            sql = "select * from\n" +
                    "\t(select zb.*,kh.f_Khlx,row_number() over (partition by f_sl order by f_sl,jyj.f_flbm)rownum from tb"+f_shbm+"_cstjmxdzb zb\n" +
                    "\tleft join tb"+f_shbm+"_Csda kh on zb.f_Csbm = kh.f_Csbm and kh.f_Cslx = '1'\n" +
                    "\tinner join (select jyj.f_jyjId,jyj.f_flbm,tjmx.f_flmc,jyj.f_Khlx,jyj.f_state \n" +
                    "\t\tfrom tb"+f_shbm+"_jyj jyj \n" +
                    "\t\tleft join tb"+f_shbm+"_tjmxwh tjmx on jyj.f_flbm=tjmx.f_flbm \n" +
                    "\t\twhere jyj.f_jyjId='"+jyjId+"' and f_state = 1) jyj on jyj.f_Khlx = kh.f_Khlx \n" +
                    "\t\tand zb.f_flbm = jyj.f_flbm \n" +
                    "\t\tand f_sl = (select MAX(zb2.f_sl) \n" +
                    "\t\t\tfrom (select zb.* from tb"+f_shbm+"_cstjmxdzb zb\n" +
                    "\t\t\tleft join tb"+f_shbm+"_Csda kh on zb.f_Csbm = kh.f_Csbm and kh.f_Cslx = '1'\n" +
                    "\t\t\tinner join (select jyj.f_jyjId,jyj.f_flbm,tjmx.f_flmc,jyj.f_Khlx,jyj.f_state \n" +
                    "\t\t\t\tfrom tb"+f_shbm+"_jyj jyj \n" +
                    "\t\t\t\tleft join tb"+f_shbm+"_tjmxwh tjmx on jyj.f_flbm=tjmx.f_flbm \n" +
                    "\t\t\t\twhere jyj.f_jyjId='"+jyjId+"' and f_state = '1') jyj on jyj.f_Khlx = kh.f_Khlx and zb.f_flbm = jyj.f_flbm and f_sl != '0') zb2 \n" +
                    "\twhere zb.f_Csbm = zb2.f_Csbm)\n" +
                    "\tand f_sl != '0')a\n" +
                    "where a.rownum='1'\n" +
                    "order by a.f_Csbm,a.f_flbm";
            String tdmjJson = sqlOperator.RunSQL_JSON(sql);
            JSONArray tdmjJarr = new JSONArray(tdmjJson);
            JSONArray jsons = new JSONArray();

            for (int i = 0; i < xscbJarrList.size(); i++){
                JSONArray tempJarr = xscbJarrList.get(i);
                String f_bmbm = tempJarr.getJSONObject(0).getString("F_BMBM");
                String f_bmmc = tempJarr.getJSONObject(0).getString("F_BMMC");
                JSONObject json = new JSONObject();
                json.put("F_BMBM",f_bmbm);
                json.put("F_BMMC",f_bmmc);
                BigDecimal zje = new BigDecimal(0);
                BigDecimal tempje = new BigDecimal(0);

                for(int j = 0 ; j<tempJarr.length() ; j++){
                    JSONObject tempJson = tempJarr.getJSONObject(j);
                    for(int h = 0; h < tdmjJarr.length(); h++){
                        String tdmjStr = tdmjJarr.getJSONObject(h).getString("F_CSBM");
                        String flbmStr = tdmjJarr.getJSONObject(h).getString("F_FLBM");
                        String khlxStr = tdmjJarr.getJSONObject(h).getString("F_KHLX");
                        if(tempJson.getString("F_KHBM").equals(tdmjStr) && tempJson.getString("F_KHLX").equals(khlxStr)){
                            String[] syfws = tempJson.getString("F_SYFW").split(",");
                            for(String syfw : syfws){
                                if(syfw.equals(flbmStr)){
                                    if(json.has(khlxStr+"-"+flbmStr)){
                                        BigDecimal spje = tempJson.getBigDecimal("F_SSJE");
                                        BigDecimal je = json.getBigDecimal(khlxStr+"-"+flbmStr);
                                        je = je.add(spje);
                                        json.put(khlxStr+"-"+flbmStr,je);
                                    }else {
                                        BigDecimal spje = tempJson.getBigDecimal("F_SSJE");
                                        json.put(khlxStr+"-"+flbmStr,spje);
                                    }
                                    BigDecimal je = tempJson.getBigDecimal("F_SSJE");
                                    zje = tempje.add(je);
                                    tempje = zje;
                                }
                            }
                        }
                    }
                }
                json.put("ZJE",zje);

                jsons.put(json);
            }

            listResult = jsons.toString();



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

}
