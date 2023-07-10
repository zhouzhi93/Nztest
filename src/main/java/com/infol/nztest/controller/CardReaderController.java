package com.infol.nztest.controller;

import com.infol.nztest.service.SalesService;
import com.infol.nztest.service.StorService;
import com.infol.nztest.service.impl.SalesServiceImpl;
import com.infol.nztest.service.impl.StorServiceImpl;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import util.HttpUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

@RestController
@RequestMapping(value = "/cardreader")
public class CardReaderController {

    @Autowired
    private SalesService salesService;

    @Autowired
    private StorService storService ;

    //读取市民卡卡号获取信息
    @RequestMapping("/citizencard")
    @ResponseBody
    public String getCitizenCard(String card, String serial,HttpServletRequest request,HttpServletResponse response) throws Exception{
        HttpUtil  dao = new HttpUtil();
        String tempcard = "310246299000";//310246299000放

        try {
            String result = dao.userInfoBycard(card,serial);
            System.out.println(result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    //读取身份证获取信息
    @RequestMapping("/identity")
    @ResponseBody
    public String getIdentity(String identity) throws Exception{
        HttpUtil  dao = new HttpUtil();
        try {
            String result = dao.userInfoByIdentityNoCard(identity);
            System.out.println(result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    //传输销售单
    @RequestMapping("/responseSeals")
    @ResponseBody
    public String responseSeals(){
        HttpUtil  dao = new HttpUtil();
        salesService = new SalesServiceImpl();
        String result = salesService.getSaleAll();
        Map<String, Object> map = new HashMap<String, Object>();
/*        if(!result.isEmpty()){
            JSONArray json = new JSONArray(result);
            for(int i = 0 ; i<json.length() ; i++){
                JSONObject temp = json.getJSONObject(i);
                Iterator j = temp.keys();
                while (j.hasNext()){
                    String key = j.next().toString();
                    String value = temp.getString(key);
                    map.put(key.trim(),value);
                }
                System.out.println(map.toString());
            }
        }*/
        return result;
    }

    //传输部门档案
    @RequestMapping("/responseStors")
    @ResponseBody
    public String responseStors(){
        HttpUtil  dao = new HttpUtil();
        storService = new StorServiceImpl();
        String result = storService.getBmmxAll();
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
                System.out.println(map.toString());
            }
        }
        return result;
    }

}
