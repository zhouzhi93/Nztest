package util;


import com.infol.nztest.dao.SqlServerOperator;
import org.apache.http.HttpRequest;
import org.json.JSONObject;
import sun.net.www.protocol.http.HttpURLConnection;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;

import java.security.KeyStore;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.X509TrustManager;
import javax.servlet.http.HttpServletRequest;

public class GoodsAnayalysis {

        private static SqlServerOperator sqlOperator = null;

        public static void openConnection(){
            try {
                sqlOperator = new SqlServerOperator();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        private String cookie;


        public String getPage(String strURL){
            try {
                StringBuilder sb = new StringBuilder();
                URL url = new URL(strURL);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setDoOutput(true);
                connection.setDoInput(true);
                connection.setUseCaches(false);

                if(cookie != null){
                    connection.setRequestProperty("Cookie", "HttpOnly=true; Hm_lvt_96c55a3847063dc0f3d6d32b55654297=1526347929,1526349020,1527387949,1527414667; PHPSESSID={sessionId}; Hm_lpvt_96c55a3847063dc0f3d6d32b55654297=1527415223".replace("{sessionId}",this.cookie));
                }
                connection.setRequestProperty("Host", "www.chinapesticide.org.cn");
                connection.setRequestProperty("Origin", "http://www.chinapesticide.org.cn");
                connection.setRequestProperty("User-Agent",
                        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.108 Safari/537.36");
                connection.setInstanceFollowRedirects(true);
                connection.setRequestMethod("GET");
                connection.setRequestProperty("Accept", "*/*");
                connection.setRequestProperty("Upgrade-Insecure-Requests", "1");
                connection
                        .setRequestProperty("Referer", "HttpOnly=true; http://ah.chinavolunteer.cn/app/user/login.php");
                connection.setConnectTimeout(5000);
                connection.setReadTimeout(5000);
                connection.connect();

                int code = connection.getResponseCode();
                InputStream is = null;
                if (code == 200) {
                    is = connection.getInputStream();
                } else {
                    is = connection.getErrorStream();
                }

                Map<String,List<String>> map=connection.getHeaderFields();
                for(Map.Entry<String,List<String>> cur: map.entrySet()){
                    if("Set-Cookie".equals(cur.getKey())){

                        String cook = cur.getValue().get(1).split(";")[0].split("=")[1];
                        this.cookie = cook;
                    }
                }

                int length = is.available();
                if (length != -1) {
                    StringBuilder sbs = new StringBuilder();
                    String curLine = "";
                    BufferedReader br = new BufferedReader(new  InputStreamReader(is));

                    while ((curLine = br.readLine()) != null) {
                        sbs.append(curLine);
                    }
                    return sbs.toString();
                }

            } catch (IOException e) {
                System.out.println("11111");
                e.printStackTrace();
            }
            JSONObject r = new JSONObject();
            r.put("code", 1);
            r.put("msg", "22222");
            return r.toString();
        }

        public String post(String strURL, Map<String, String> params) {
            try {
                StringBuilder sb = new StringBuilder();
                URL url = new URL(strURL);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setDoOutput(true);
                connection.setDoInput(true);
                connection.setUseCaches(false);

                if(cookie != null){
                    connection.setRequestProperty("Cookie", "HttpOnly=true; Hm_lvt_96c55a3847063dc0f3d6d32b55654297=1526347929,1526349020,1527387949,1527414667; PHPSESSID={sessionId}; Hm_lpvt_96c55a3847063dc0f3d6d32b55654297=1527415223".replace("{sessionId}",cookie));
                }
                connection.setRequestProperty("Host", "www.chinapesticide.org.cn");
                connection.setRequestProperty("Origin", "http://www.chinapesticide.org.cn");
                connection.setRequestProperty("Referer", "http://www.chinapesticide.org.cn/myquery/queryselect");
                connection.setRequestProperty("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.108 Safari/537.36");
                connection.setRequestProperty("X-Requested-With", "XMLHttpRequest");
                connection.setInstanceFollowRedirects(true);
                connection.setRequestMethod("POST");
                connection.setRequestProperty("Accept", "*/*");
                connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
                connection.setConnectTimeout(5000);
                connection.setReadTimeout(5000);
                connection.connect();

                OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(),"UTF-8");
/*                for (Map.Entry<String, String> entry : params.entrySet()) {
                    sb.append(entry.getKey());
                    sb.append("=");
                    sb.append(entry.getValue());
                    sb.append("&");
                }

                String postdata = sb.toString();
                //System.out.println(postdata);
                postdata = postdata.substring(0, postdata.length() - 1);

                out.append(postdata);*/
                out.flush();
                out.close();

                int code = connection.getResponseCode();
                InputStream is = null;
                if (code == 200) {
                    is = connection.getInputStream();
                } else {
                    is = connection.getErrorStream();
                }
                InputStreamReader isr =  new InputStreamReader(is, "utf-8");
                BufferedReader br = new BufferedReader(isr);
                String line = null;
                StringBuilder sbb = new StringBuilder();
                while ((line = br.readLine()) != null) {
                    if("".equals(line.trim()))continue;
                    sbb.append(line.trim());
                }
                br.close();
                return sbb.toString();

            } catch (IOException e) {
                System.out.println("23333");
                e.printStackTrace();
            }
            return "";
        }
        public String analysisCode(String text,String pid) {
            int i = -1;
            String left = null;
            //System.out.println(text);
            //System.out.println(text.indexOf(pid)+"=================>>"+pid);
            int len = pid.length();
            while((i=text.toUpperCase().indexOf(pid))!=-1) {
                //System.out.println("================="+i);
                left = text.substring(0,i);
                text=text.substring(i+len);
                i = left.lastIndexOf("<");
                if(i==-1)continue;
                left = left.substring(i);
                if(left.toLowerCase().startsWith("<a ")){
                    i = left.indexOf("open(");
                    //System.out.println(i);
                    if(i==-1)continue;
                    left = left.substring(i+5,left.indexOf(","));

                    //System.out.println(left);
                    if(left.startsWith("'"))left = left.substring(1,left.length()-1);

                    //System.out.println(left);
                    break;
                }
            }
            return left;
        }
        public static Map parseMap(String data) {
            Map result = new HashMap();

            String[] ref = data.split("&");
            for (String cur : ref) {
                String[] d = cur.split("=");

                if (d.length == 2) {
                    result.put(d[0], d[1]);
                } else {
                    result.put(d[0], "");
                }

            }
            return result;
        }


        public static String encode(String data) throws UnsupportedEncodingException {
            return java.net.URLEncoder.encode(java.net.URLEncoder.encode(data, "UTF-8"), "UTF-8");
        }

        public static String getSex(String number) {
            char sex = number.charAt(16);
            return "" + Integer.parseInt("" + sex) % 2;
        }


        public String findInfos(String pid) {
            //访问网页获取cookie
            getPage("http://www.chinapesticide.org.cn");
            //System.out.println(this.cookie);
            //组织参数
            Map param = new HashMap();
            param.put("referer","http://www.chinapesticide.org.cn/myquery/queryselect");
            param.put("pageNo","1");
            param.put("pageSize","20");
            param.put("djzh",pid);//////////////
            param.put("cjmc","");
            param.put("sf","");
            param.put("nylb","");
            param.put("zhl","");
            param.put("jx","");
            param.put("zwmc","");
            param.put("fzdx","");
            param.put("syff","");
            param.put("dx","");
            param.put("yxcf","");
            param.put("yxcf_en","");
            param.put("yxcfhl","");
            param.put("yxcf2","");
            param.put("yxcf2_en","");
            param.put("yxcf2hl","");
            param.put("yxcf3","");
            param.put("yxcf3_en","");
            param.put("yxcf3hl","");
            param.put("yxqs_start","");
            param.put("yxqs_end","");
            param.put("yxjz_start","");
            param.put("yxjz_end","");

            //获取报文
            String resp = post("http://www.chinapesticide.org.cn/myquery/queryselect",param);
            //System.out.println(resp);
            //获取code
            String code = this.analysisCode(resp,pid);
            //System.out.println(code);
            //获取详细信息
            String info = this.getHTML(code,pid);
            return info;
        }

        public String getGoods(String pd, String f_shbm) {
            //创建连接池
            openConnection();
            String result = null;
            try {
                String sql = "SELECT count(*) from tb"+f_shbm+"_Spda ";
                sql+=" where f_ypzjh  = '"+pd+"'";

                //result = sqlOperator.queryOneRecorderData(sql);

                if(result != null && !"".equals(result)){
                    if(Integer.parseInt(result) >= 1){
                        result = "err";
                    }else{
                        sql = "SELECT ypdjh,ypzjl+ypjx+ypmc as ypmc,splb.f_Splbbm,yplb,ypjx,ypzjl,djhyxq,djhsccj from tbbznyda d " +
                                "LEFT JOIN tb"+f_shbm+"_Splbda splb on splb.f_Splbmc = d.yplb ";
                        sql+=" where ypdjh  = '"+pd+"'";
                        result = sqlOperator.RunSQL_JSON(sql);
                    }
                }else{
                    sql = "SELECT ypdjh,ypzjl+ypjx+ypmc as ypmc,splb.f_Splbbm,yplb,ypjx,ypzjl,djhyxq,djhsccj from tbbznyda d " +
                            "LEFT JOIN tb"+f_shbm+"_Splbda splb on splb.f_Splbmc = d.yplb ";
                    sql+=" where ypdjh  = '"+pd+"'";
                    result = sqlOperator.RunSQL_JSON(sql);
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

        private String findText(String html,String key) {//在文本中查找指定属性值
            String txt = null;
            try{
                int i = html.indexOf(key);
                if(i==-1)return "";
                txt = html.substring(i+key.length());
                i = txt.toLowerCase().indexOf("<td");
                txt=txt.substring(i+3);
                i = txt.indexOf(">");
                txt = txt.substring(i+1);
                i = txt.toLowerCase().indexOf("</td>");
                txt = txt.substring(0,i);
            } catch(Exception e){
                txt="";
            }
            return txt;
        }
        //http://www.chinapesticide.org.cn/myquery/querydetail?pdno=558D0600CB1A4E148DF5A9261F6E77F2&pdrgno=PD20142114
        private String getHTML(String pdno,String pdrgno)  {
            try{
                StringBuilder sb = new StringBuilder();
                sb.append("http://www.chinapesticide.org.cn/myquery/querydetail?");//558D0600CB1A4E148DF5A9261F6E77F2
                sb.append("pdno=").append(pdno);
                sb.append("&pdrgno=").append(pdrgno);//PD20142114
                URL url = new URL(sb.toString());
                URLConnection urlConnection = url.openConnection();
                // 获取输入流
                BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(), "utf-8"));
                String line = null;
                sb.setLength(0);
                //boolean start = false;
                while ((line = br.readLine()) != null) {
                    if("".equals(line.trim()))continue;
                    sb.append(line.trim());
                }
                br.close();
                String html =  sb.toString();
                int i = html.indexOf("<h1>农药登记数据</h1>");
                if(i!=-1) {
                    html = html.substring(i);
                    i=html.toLowerCase().indexOf("<table");

                    html = html.substring(i);
                    i=html.toLowerCase().indexOf("</table>");
                    html = html.substring(0,i);
                }
                StringBuilder sql = new StringBuilder();
                String zjl = this.findText(html,"总有效成分含量");
                sql.append("f_sptm=").append(this.findText(html,"登记证号")).append(",");
                sql.append("f_spmc=").append(zjl)
                        .append(this.findText(html,"剂型")).append(this.findText(html,"登记名称"));
                sql.append(",f_ggxh=").append(zjl);
                sql.append(",f_splbmc=").append(this.findText(html,"农药类别"));
                sql.append(",f_gysmc=").append(this.findText(html,"登记证持有人"));
                return sql.toString();
            } catch(Exception e){
                return "";
            }
        }

    //处理http请求  requestUrl为请求地址  requestMethod请求方式，值为"GET"或"POST"
    public String httpsRequest(String requestUrl,String requestMethod,String outputStr){
        StringBuffer buffer=new StringBuffer();
        try{
            //创建SSLContext
            //SSLContext sslContext=SSLContext.getInstance("SSL");
            SSLContext sslContext=SSLContext.getInstance("TLS");
            System.setProperty("https.protocols", "TLSv1");


            TrustManager[] tm={new MyX509TrustManager()};
            //初始化
            sslContext.init(null, tm, new java.security.SecureRandom());;
            //获取SSLSocketFactory对象
            SSLSocketFactory ssf=sslContext.getSocketFactory();
            URL url=new URL(requestUrl);
            HttpsURLConnection conn=(HttpsURLConnection)url.openConnection();
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            conn.setRequestMethod(requestMethod);
            //设置当前实例使用的SSLSoctetFactory
            conn.setSSLSocketFactory(ssf);
            conn.connect();
            //往服务器端写内容
		    /*if(null!=outputStr){
		        OutputStream os=conn.getOutputStream();
		        os.write(outputStr.getBytes("utf-8"));
		        os.close();
		    }  */

            //读取服务器端返回的内容
            InputStream is=conn.getInputStream();
            InputStreamReader isr=new InputStreamReader(is,"utf-8");
            BufferedReader br=new BufferedReader(isr);

            String line=null;
            while((line=br.readLine())!=null){
                buffer.append(line);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return buffer.toString();
    }
    private String getHTML(String urlStr) throws Exception  {
        if(urlStr.startsWith("https")) {
            // 创建HttpsURLConnection对象，并设置其SSLSocketFactory对象
            //HttpsURLConnection httpsConn = (HttpsURLConnection) url.openConnection();
            // 取得该连接的输入流，以读取响应内容
            //in = new InputStreamReader(httpsConn.getInputStream(), "utf-8");
            return this.httpsRequest(urlStr,"GET",null);
        }
        int s = urlStr.length();
        int i = urlStr.indexOf("=");
        if(i==-1&&s>16){
            urlStr=urlStr.substring(0,s-16)+"="+urlStr.substring(s-16);
        }
        URL url = new URL(urlStr);
        URLConnection urlConnection = url.openConnection();
        // 获取输入流
        BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(), "utf-8"));
        String line = null;
        StringBuilder sb = new StringBuilder();
        while ((line = br.readLine()) != null) {
            if("".equals(line.trim()))continue;
            //line = new String(line.getBytes("GBK"),"UTF-8");
            sb.append(line.trim().toLowerCase());
        }
        br.close();
        String html =  sb.toString();
        i = html.indexOf("<body");
        if(i!=-1) {
            html = html.substring(i+5);
            i=html.indexOf(">");
            html = html.substring(i+1);
        }
        /*sb.setLength(0);
        int k=0;
        while((i=html.indexOf("<script"))!=-1){
        	sb.append(html.substring(0,i));
        	html = html.substring(i+8);
        	i=html.indexOf("</script");
        	sb.append(html.substring(i+10));
        	html  = sb.toString();
        	sb.setLength(0);
            k++;
            if(k>20)break;
        }*/
        return html;
    }
    private String findText(String html,String key,String split) {//在文本中查找指定属性值
        String txt = null;
        try{
            int i = html.indexOf(key);
            if(i==-1)return "";
            txt = html.substring(i+key.length());
            i = txt.indexOf("</");
            if(i<txt.indexOf("<"+split)){
                txt=txt.substring(i+2);
                if(txt.toLowerCase().startsWith("td")) {
                    split="td";
                }
            }

            i = txt.indexOf("<"+split);
            if(i==-1){
                if(split!=null&&"span".equals(split)){
                    return this.findText(html,key,"div");
                } else if(split!=null&&"div".equals(split)){
                    return this.findText(html,key,"td");
                }
                return "";
            }
            txt=txt.substring(i+split.length()+1);
            i = txt.indexOf(">");
            txt = txt.substring(i+1);
            i = txt.indexOf("</"+split+">");
            txt = txt.substring(0,i);
        } catch(Exception e){
            txt="";
        }
        return txt;
    }

    private String replaceStr(String str) {
        if(str==null||"".equals(str.trim()))return "";
        while(str.indexOf(" ")!=-1)str=str.replaceAll(" ","");
        while(str.indexOf("<br />")!=-1)str=str.replaceAll("<br />","");
        while(str.indexOf("<br/>")!=-1)str=str.replaceAll("<br/>","");
        while(str.indexOf("<BR />")!=-1)str=str.replaceAll("<BR />","");
        while(str.indexOf("<BR/>")!=-1)str=str.replaceAll("<BR/>","");
        return str;
    }
    public String goodsInfo(String url) throws Exception{
        String html = this.getHTML(url);
        int i = url.length();
        StringBuilder sql = new StringBuilder();
        String split = "span";
        sql.append("f_sptm=").append(url.substring(i-16));
        String nymc = this.findText(html,"农药名称",split);
        String cpmc = this.findText(html,"产品名称",split);
        String pcmc = this.findText(html,"品种名称",split);
        sql.append(",f_spmc=").append(nymc);
        boolean mc1=nymc!=null&&!"".equals(nymc.trim());
        boolean mc2=cpmc!=null&&!"".equals(cpmc.trim());
        if(mc1&&mc2)sql.append("(").append(cpmc).append(")");
        else sql.append(cpmc);
        sql.append(pcmc);
        sql.append(",f_ggxh=").append(this.findText(html,"产品规格",split));

        sql.append(",f_pch=").append(this.findText(html,"批次",split));
        sql.append(this.findText(html,"批号",split)).append("");
        String code = this.replaceStr(this.findText(html,"32位",split));
        String code1 = this.replaceStr(this.findText(html,"追溯码",split));
        if(code==null||"".equals(code)) {
            if(code1!=null&&!"".equals(code1))code = code1;
            else code="";
        } else if(code1!=null&&!"".equals(code1)&&!code.equals(code1)) {
            code = code1;
        }
        sql.append(",djzh=").append(code);
        return sql.toString();


        /**
         <div id="divproinfo">
         <p>产品名称：<span id="lbpname">阿米西达</span></p>
         <p>产品规格：<span id="lbspecial">10ML</span></p>
         <p id="plotno">产品批号：<span id="lblotno">SNA6L00020</span></p>
         <p><span id="lbTxt">产品序号</span>：<span id="lbfwcode">9976871471896180</span></p>

         <li><span class="security-info">产品名称 : </span><span id="product_name" class="word-wrap">可杀得3000</span></li>
         <li><span class="security-info">农药名称 : </span><span id="product_component">46%氢氧化铜水分散粒剂</span></li>
         <li><span class="security-info">产品规格 : </span><span id="product_spec">10g*125*4</span></li>
         <li><span class="security-info">生产日期 : </span><span id="produce_date">2016-05-20</span></li>
         <li><span class="security-info">生产企业 : </span><span id="produce_enterprise" class="word-wrap">上海生农生化股份有限公司</span></li>
         <li><span class="security-info">生产批次 : </span><span id="product_lot">MAR17SHS91</span></li>

         <div id="divPro" style="max-width: 100%">
         产品名称：<span id="lbpname">百泰</span><br />
         农药名称：<span id="lbename">60%唑醚·代森联水分散粒剂</span><br />
         产品规格：<span id="lbspecial">20g</span><br /></div>

         <li><span class="security-info">产品名称:</span><span id="security_code" class="word-wrap">银法利</span></li>
         <li><span class="security-info">农药名称:</span><span id="security_code" class="word-wrap">氟菌·霜霉威687.5克/升悬浮剂</span></li>
         <li><span class="security-info">生产日期:</span><span id="security_code" class="word-wrap">2018-03-08</span></li>
         <li><span class="security-info">生产企业:</span><span id="security_code" class="word-wrap">拜耳作物科学（中国）有限公司</span></li>
         <li><span class="security-info">生产批次:</span><span id="security_code" class="word-wrap">PH00006736</span></li>

         <tr><td class="result1Td"><div class="result1">品种名称：</div></td>
         <td><div class="result2">40%阿维炔螨特乳油（凯击）</div></td></tr>
         <tr><td class="result1Td"><div class="result1">生产经营者：</div></td>
         <td><div class="result2">山东邹平农药有限公司</div></td></tr>
         <tr><td class="result1Td"><div class="result1">单元识别码：</div></td>
         <td><div class="result2">11211051001100697171027006932041</div></td></tr>
         <tr><td class="result1Td"><div class="result1">净含量：</div></td>
         <td><div class="result2">100毫升</div></td></tr>
         <tr><td class="result1Td"><div class="result1">登记证号：</div></td>
         <td><div class="result2">PD20121105</div></td></tr>

         <tr><td>产品名称:</td><td>25克/升 五氟磺草胺可分散油悬浮剂</td>       </tr>
         <tr><td >产品批号：</td><td>B494I5MF01</td>     </tr>
         <tr><td >质量检验：</td> <td>合格</td> </tr>
         <tr><td >32位追溯码：</td><td>1170671124200001<br />4098138908915296</td>      </tr>
         <tr><td >所属省市：</td><td>江苏省 <span>-</span> 苏州市</td>    </tr>

         */

    }







}
