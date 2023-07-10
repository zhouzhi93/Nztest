package com.infol.nztest.controller;

import ch.qos.logback.core.net.SyslogOutputStream;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.ResponseBody;
import util.GoodsAnayalysis;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/goodsAnalysis")
public class GoodsAnalysisController {
    //@Autowired
    private GoodsAnayalysis goods = new GoodsAnayalysis();

    @RequestMapping("/goodsInfo")
    @ResponseBody
    public String getSpda(HttpServletRequest request){
        String v=request.getParameter("url");
        if(v == null || "".equals(v)){
            return null;
        }
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        int s=v.length();
        int i=0;
        String _bm=null;
        boolean ty=false;
        if(s>4&&(v.startsWith("http") || v.startsWith("HTTP"))){//扫描
            for(i=s;i>0;i--){
                if("1234567890".indexOf(v.substring(i-1,i))==-1){
                    _bm = v.substring(i);
                    break;
                }
            }
            if(_bm.length()==32){//处理
                ty=true;
                _bm = (_bm.startsWith("1")?"PD":(_bm.startsWith("2")?"WP":"LS"))+"20"+_bm.substring(1,7);
            }
        } else {
            _bm = v.substring(0,2).toUpperCase();
            if("PD".equalsIgnoreCase(_bm)||"WP".equalsIgnoreCase(_bm)||"LS".equalsIgnoreCase(_bm)){
                _bm = v;
                ty=true;
            } else _bm=null;
        }
/*        String _d = null;
        if(ty||v.indexOf("http")!=-1) {
            if (ty) {
                _d = goods.findInfos(_bm);
            } else {
                try {
                    _d = goods.goodsInfo(v);
                }catch(Exception ee){
                    _d="";
                }
            }
        }

        if(_bm != null){
            if(!_bm.toUpperCase().startsWith("PD") && !_bm.toUpperCase().startsWith("WP")&& !_bm.toUpperCase().startsWith("LS")){
                _bm = "";
            }
        }*/


        String _d = goods.getGoods(_bm,f_shbm);

        return _d;
    }

    public String strtoJson(String str){

        JSONObject json = new JSONObject();
        String[] strs = str.split(",");

        for (int i=0 ; i<strs.length ; i++){
            String temp = strs[i];
            String[] temps = temp.split("=");
            if(temps.length == 1){
                json.put(temps[0],"");
            }else{
                json.put(temps[0],temps[1]);
            }

        }

        return json.toString();
    }

}
