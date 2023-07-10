package com.infol.nztest.controller;

import com.infol.nztest.service.IndexService;
import org.json.JSONArray;
import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import util.GoodsAnayalysis;
import util.HttpUtils;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/htmlPage")
public class HtmlPageController {
    @Autowired
    private IndexService indexService;

    private GoodsAnayalysis goods = new GoodsAnayalysis();
    @RequestMapping("/index")
    public String index(Model model,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_lxbm = (String) request.getSession().getAttribute("f_lxbm");
        String result = "";
        String newsList="";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = indexService.IndexTongji(f_shbm);
        }
        //尝试抓去http://www.chinapesticide.org.cn/yqnq/index.jhtml 网站中咨询
        try{
            if("3".equals(f_lxbm) || "4".equals(f_lxbm) || "9".equals(f_lxbm)){
                String htmlStr= HttpUtils.get("http://www.chinabgao.com/info/index.html");
                org.jsoup.nodes.Document doc = Jsoup.parse(htmlStr);
                Elements bodyMain=doc.getElementsByClass("ul14");
                if(bodyMain.size()>0){
                    JSONArray jarr= new JSONArray();
                    Element content=bodyMain.get(0);
                    Elements lielems=content.select("a[href]");//a[href]
                    for(Element element : lielems){
                        JSONObject jobj=new JSONObject();
                        jobj.put("url",element.attr("href"));
                        jobj.put("title",element.attr("title"));
                        jobj.put("date","");
                        jarr.put(jobj);
                    }
                    newsList=jarr.toString();
                }
            }else{
                String htmlStr= HttpUtils.get("http://www.chinapesticide.org.cn/yqnq/index.jhtml");
                org.jsoup.nodes.Document doc = Jsoup.parse(htmlStr);
                Elements bodyMain=doc.getElementsByClass("web_ser_body_right_main_list");
                if(bodyMain.size()>0){
                    JSONArray jarr= new JSONArray();
                    Element content=bodyMain.get(0);
                    Elements lielems=content.select("a[href]");//a[href]
                    for(Element element : lielems){
                        JSONObject jobj=new JSONObject();
                        jobj.put("url",element.attr("href"));
                        jobj.put("title",element.attr("title"));
                        jobj.put("date",element.siblingElements().get(0).text());
                        jarr.put(jobj);
                    }
                    newsList=jarr.toString();
                }
            }
        }catch (Exception e){

        }
        model.addAttribute("newsList", newsList);
        model.addAttribute("tjdata", result);
        return "htmlPage/index";
    }
    @RequestMapping("/certsearch")
    @ResponseBody
    public String certsearch(Model model,HttpServletRequest request,String nydjh){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String f_lxbm = (String) request.getSession().getAttribute("f_lxbm");
        String result = "";
        String newsList="";
        String _d = null;
        if (f_zybm == null) {
            result = "尚未登录";
        }else{
            _d = goods.getGoods(nydjh,f_shbm);
        }
        //尝试抓去http://www.chinapesticide.org.cn/yqnq/index.jhtml 网站中咨询
        try{
            String htmlStr= HttpUtils.get("http://www.chinapesticide.org.cn/myquery/tagdetail?pdno="+nydjh);
            org.jsoup.nodes.Document doc = Jsoup.parse(htmlStr);
            Elements bodyMain=doc.getElementsByTag("div");
            if(bodyMain.size()>0){
                JSONArray jarr= new JSONArray();
                Element content=bodyMain.get(0);
                result = content.toString();
                int index = result.indexOf("农药登记证号：");
                String temp = result.substring(index,result.length()-1);
                int index2 = temp.indexOf("</td>");
                if(_d != null && !"".equals(_d) && !"[]".equals(_d)){
                    JSONArray json = new JSONArray(_d);
                    String str = "<span style=\"padding-left: 60px;\" class=\"style4\">有效期至：</span><span>"+json.getJSONObject(0).get("DJHYXQ")+"</span>" +
                            "<span style=\"padding-left: 60px;\" class=\"style4\">农药类别：</span><span>"+json.getJSONObject(0).get("YPLB")+"</span>";
                    result = result.substring(0,index+index2)+str+result.substring(index+index2,result.length());
                }else{
                    String str = "<span style=\"padding-left: 60px;\" class=\"style4\">有效期至：</span><span></span>" +
                            "<span style=\"padding-left: 60px;\" class=\"style4\">农药类别：</span><span></span>";
                    result = result.substring(0,index+index2)+str+result.substring(index+index2,result.length());
                }

                /*Elements lielems=content.select("a[href]");//a[href]
                for(Element element : lielems){
                    JSONObject jobj=new JSONObject();
                    jobj.put("url",element.attr("href"));
                    jobj.put("title",element.attr("title"));
                    jobj.put("date","");
                    jarr.put(jobj);
                }
                newsList=jarr.toString();*/
            }
        }catch (Exception e){

        }
        return result;
    }
    @RequestMapping("/news")
    public String news(Model model,HttpServletRequest request){
        String f_zybm = (String) request.getSession().getAttribute("f_zybm");
        String f_bmbm = (String) request.getSession().getAttribute("f_bmbm");
        String f_zymc = (String) request.getSession().getAttribute("f_zymc");
        String f_shbm = (String) request.getSession().getAttribute("f_shbm");
        String result = "";
        String newsList="";
        if (f_zybm == null) {
            result = "尚未登录";
        } else {
            result = indexService.IndexTongji(f_shbm);
        }
        //尝试抓去http://www.chinapesticide.org.cn/yqnq/index.jhtml 网站中咨询
        try{
            String htmlStr= HttpUtils.get("http://www.chinapesticide.org.cn/yqnq/index.jhtml");
            org.jsoup.nodes.Document doc = Jsoup.parse(htmlStr);
            Elements bodyMain=doc.getElementsByClass("web_ser_body_right_main_list");
            if(bodyMain.size()>0){
                JSONArray jarr= new JSONArray();
                Element content=bodyMain.get(0);
                Elements lielems=content.select("a[href]");//a[href]
                for(Element element : lielems){
                    JSONObject jobj=new JSONObject();
                    jobj.put("url",element.attr("href"));
                    jobj.put("title",element.attr("title"));
                    jobj.put("date",element.siblingElements().get(0).text());
                    jarr.put(jobj);
                }
                newsList=jarr.toString();
            }

        }catch (Exception e){

        }
        model.addAttribute("newsList", newsList);
        model.addAttribute("tjdata", result);
        return "htmlPage/news";
    }
}
