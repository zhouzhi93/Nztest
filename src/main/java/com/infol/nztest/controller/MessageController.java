package com.infol.nztest.controller;

import com.infol.nztest.service.MessageService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/message")
public class MessageController {

    @Autowired
    MessageService dao;


    @RequestMapping("/types")
    public String types(Model model){
        return "message/types";
    }

    @RequestMapping("/news")
    public String news(Model model){
        return "message/news";
    }

    @RequestMapping("/detail")
    public String detail(Model model){
        return "message/detail";
    }

    @RequestMapping("/publish")
    public String publish(Model model){
        return "message/publish";
    }
    /**
     * @deprecated 检查名称是否已存在
     * @param f_name
     * @return
     * @throws Exception
     */
    @RequestMapping("/exists")
    @ResponseBody
    public String existsName(String f_shbm, String f_id, String f_name, HttpServletRequest request) {
        JSONObject json = new JSONObject();f_shbm = this.realShbm(request);
        try{
            boolean exists = dao.existsName(f_shbm,f_id,f_name);
            json.put("states","0");
            json.put("result",exists?"1":"0");
        } catch(Exception e){
            json.put("states","4");
            json.put("msg",e.getMessage());
        }
        return json.toString();
    }
    /**
     * @deprecated  信息分类维护（新增与修改）
     * @param f_id
     * @param f_name
     * @param f_sid
     * @return
     * @throws Exception
     */
    @RequestMapping("/settype")
    @ResponseBody
    public String saveType(String f_shbm,String f_id, String f_name, String f_sid,HttpServletRequest request) {f_shbm = this.realShbm(request);
        JSONObject json = new JSONObject();
        try{
            String result = dao.saveType(f_shbm,f_id,f_name,f_sid);
            json.put("states","0");
            json.put("result",result);
        } catch(Exception e){
            json.put("states","4");
            json.put("msg",e.getMessage());
        }
        return json.toString();
    }
    /**
     * @deprecated 信息分类删除
     * @param f_id
     * @throws Exception
     */

    @RequestMapping("/deletetype")
    @ResponseBody
    public String delete(String f_shbm,String f_id,HttpServletRequest request) {f_shbm = this.realShbm(request);
        JSONObject json = new JSONObject();
        try{
            dao.delete(f_shbm,f_id);
            json.put("states","0");
            json.put("result","");
        } catch(Exception e){
            json.put("states","4");
            json.put("msg",e.getMessage());
        }
        return json.toString();
    }
    /**
     * @deprecated 查询信息分类
     * @param f_id
     * @param f_sid
     * @return
     * @throws Exception
     */

    @RequestMapping("/querytype")
    @ResponseBody
    public String query(String f_shbm,String f_id, String f_sid,HttpServletRequest request) {f_shbm = this.realShbm(request);
        JSONObject json = new JSONObject();
        try{
            String result = dao.query(f_shbm,f_id,f_sid);
            json.put("states","0");
            json.put("result",result);
        } catch(Exception e){
            e.printStackTrace();
            json.put("states","4");
            json.put("msg",e.getMessage());
        }
        return json.toString();
    }
    /**
     * @deprecated 信息查询
     * @param f_tid
     * @param f_id
     * @param f_title
     * @param f_zybm
     * @return
     * @throws Exception
     */

    @RequestMapping("/querynews")
    @ResponseBody
    public String queryNews(String f_shbm,String f_tid, String f_id, String f_title, String f_zybm, String top,String f_ksrq,String f_jsrq,HttpServletRequest request) {
        JSONObject json = new JSONObject();f_shbm = this.realShbm(request);
        try{
            String result = dao.queryNews(f_shbm,f_tid,f_id,f_title,f_zybm,top,f_ksrq,f_jsrq);
            json.put("states","0");
            json.put("result",result);
        } catch(Exception e){
            e.printStackTrace();
            json.put("states","4");
            json.put("msg",e.getMessage());
        }
        return json.toString();
    }
    /**
     * @deprecated 查询信息附件
     * @param f_tid
     * @return
     * @throws Exception
     */

    @RequestMapping("/annex")
    @ResponseBody
    public String queryAnnex(String f_shbm,String f_tid,HttpServletRequest request) {f_shbm = this.realShbm(request);
        JSONObject json = new JSONObject();
        try{
            String result = dao.queryAnnex(f_shbm,f_tid);
            json.put("states","0");
            json.put("result",result);
        } catch(Exception e){
            json.put("states","4");
            json.put("msg",e.getMessage());
        }
        return json.toString();
    }
    /**
     * @deprecated 删除信息
     * @param f_tid
     * @throws Exception
     */
    @RequestMapping("/delnews")
    @ResponseBody
    public String deleteNews(String f_shbm,String f_tid,HttpServletRequest request) {f_shbm = this.realShbm(request);
        JSONObject json = new JSONObject();
        try{
            dao.deleteNews(f_shbm,f_tid);
            json.put("states","0");
            json.put("result","");
        } catch(Exception e){
            json.put("states","4");
            json.put("msg",e.getMessage());
        }
        return json.toString();
    }
    /**
     * @deprecated 信息发布｜修改
     * @param info
     * @param annex
     * @return
     * @throws Exception
     */
    @RequestMapping("/setnews")
    @ResponseBody
    public String saveNews(String f_shbm,String info, String annex,HttpServletRequest request) {f_shbm = this.realShbm(request);
        JSONObject json = new JSONObject();
        try{
            System.out.println(info);
            System.out.println(annex);
            String result = dao.saveNews(f_shbm,info,annex);
            json.put("states","0");
            json.put("result",result);
        } catch(Exception e){
            json.put("states","4");
            json.put("msg",e.getMessage());
        }
        return json.toString();
    }

    private String realShbm(HttpServletRequest request) {
        return (String) request.getSession().getAttribute("f_shbm");
    }

}
