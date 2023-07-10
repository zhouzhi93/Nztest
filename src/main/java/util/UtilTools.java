package util;

//import javax.servlet.http.HttpServletRequest;
import com.infol.nztest.dao.SqlServerOperator;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

import java.lang.reflect.Method;
import java.net.URLDecoder;
import java.util.regex.*;
import java.math.*;
import java.text.*;

public class UtilTools {
    private static final String COL_SPLIT = "≮";
    private static final String ROW_SPLIT = "≯";
    private static int len = 2;

    /**
     * @deprecated：对传过来带年月日中间带连接符的去除连接符
     * @param time String
     * @return String
     */
    public static String replaceLine(String time) {
        StringBuilder date = new StringBuilder();
        if (time == null) {
            return "";
        } else if (time.indexOf("-") != -1) {
            int f = time.indexOf("-");
            int e = time.lastIndexOf("-");
            if(e==f)return "";
            date.append(time.substring(0,f));
            if(e==f+2) date.append("0");
            date.append(time.substring(f+1,e));
            if (e==time.length()-2) date.append("0");
            date.append(time.substring(e+1));
        } else date.append(time);
        return date.toString();
    }


    //返回年月日
    public static String reCurtime() {
        String cur = null;
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        cur = format.format(date).toString();
        return cur;
    }

    public static String reCurtime2() {
        String cur = null;
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmm");
        cur = format.format(date).toString();
        return cur;
    }
    /**
     * @description 上月
     * @return
     */
    public static String preny(){
        String strtemp = "";
        Calendar calender = new GregorianCalendar();
        int year = calender.get(Calendar.YEAR);
        int month = calender.get(Calendar.MONTH)+1;
        if(month==1){
            month=12;
            year=year-1;
        }else month=month-1;

        if (month < 10) {
            strtemp = year + "0" + month;
        } else {
            strtemp = year + "" + month;
        }
        return strtemp;
    }
    public static String preny(String ny){
        int pny = -1;
        try {
            pny = Integer.parseInt(ny);
            pny-=pny%100==1?89:1;
        } catch (Exception e){
        }
        return String.valueOf(pny);
    }
    /**
     * @description 上年同期
     * @return
     */
    public static String presny(String ny){
        int pny = -1;
        try {
            pny = Integer.parseInt(ny)-100;
        } catch (Exception e){
        }
        return String.valueOf(pny);
    }
    /**
     * @deprecated：将科学计数法的值转为正常数值
     * @param value String
     * @return String
     */
    public static String kxjsFormat(String value) {
        String temp = value;
        if ("".equals(value.trim())) {
            return "";
        }
        if ("".equals(value.replaceAll("0",""))||".".equals(value.replaceAll("0",""))) {
            return "";
        } else if (value.indexOf("E") != -1) {
            if(value.startsWith("-"))return "-"+UtilTools.kxjsFormat(value.substring(1));
            try {
                int s = Integer.parseInt(value.substring(value.indexOf("E") + 1)); //位数
                temp = temp.substring(0, temp.indexOf("E")); //数值部分
                boolean back = false; //向前移(否)
                if (s < 0) {
                    back = true;
                    s *= -1;
                }
                int point = temp.indexOf("."); //小数点的位置
                temp = temp.substring(0, point) + temp.substring(point + 1); //去掉小数点
                if (back) { //向前移
                    if (point > s) {
                        temp = temp.substring(0, point - s) + "." +
                                temp.substring(point - s);
                    } else {
                        for (int j = 0; j < s - point; j++) {
                            temp = "0" + temp;
                        }
                        temp = "0." + temp;
                    }
                } else { //向后移
                    if (value.length() > point + s) {
                        temp = temp.substring(0, point + s) + "." +
                                temp.substring(point + s);
                    } else {
                        for (int k = temp.length(); k < s + point; k++) {
                            temp += "0";
                        }
                    }
                }
            } catch (Exception e) {
            }
        }
        return temp;
    }

    //四舍五入到到几位小数
    public static double formartNumber(double value, int lens) {
        double bs = 1.0;
        for(int i = 0; i < lens; i++) {
            bs *= 10;
        }
        return Math.round(value * bs) / bs;
    }
    /**
     * 提供精确的小数位四舍五入处理。
     * @param v 需要四舍五入的数字
     * @param scale 小数点后保留几位
     * @return 四舍五入后的结果
     */
    public static double round(double v, int scale) {
        if (scale < 0) {
            throw new IllegalArgumentException(
                    "The scale must be a positive integer or zero");
        }
        BigDecimal b = new BigDecimal(Double.toString(v));
        BigDecimal one = new BigDecimal("1");
        return b.divide(one, scale, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    public static String formatNumber(String value, int lens) {
        if (value == null || "".equals(value.trim())) {
            return " ";
        }
        try {
            double val = UtilTools.round(new BigDecimal(value).doubleValue(),lens);
            if(val == 0.00) {
                value = " ";
            } else {
                value = UtilTools.formatDouble(val, lens);
            }
        } catch (Exception e) {
            System.out.println(value+"-->"+lens+">>formatNumber error");
        } finally {
            return value;
        }
    }

    /**
     * @deprecated:将数值型字符串转化为双精度数
     * @param value String
     * @return double
     */
    public static double parseStringToDouble(String value) {
        double number = 0.0;
        if (value != null && !"".equals(value.trim())) {
            try {
                BigDecimal bd = new BigDecimal(value);
                number = bd.doubleValue();
            } catch (Exception e) {
            }
        }
        return number;
    }
    /**
     * @deprecated:将数值型字符串转化为双精度数
     * @param value String
     * @return double
     */
    public static double parseStringToDouble(String value,String jd) {
        int num = 2;
        try{num = Integer.parseInt(jd);}catch(Exception e){}
        return UtilTools.parseStringToDouble(value,num);
    }
    /**
     * @deprecated:将数值型字符串转化为双精度数
     * @param value String
     * @return double
     */
    public static double parseStringToDouble(String value,int jd) {
        double num = UtilTools.parseStringToDouble(value);
        return UtilTools.formartNumber(num,jd);
    }



    /**
     * @deprecated：主要用在数据型数据set方法中
     * @param num double
     * @return String
     */
    public static String tranString(double num) {
        if (num == 0.0) {
            return "";
        }
        return UtilTools.formatDouble(num,len);
    }

    public static String tranString(String num) {
        return tranString(num,len);
    }

    /**
     * @deprecated  提供精确的小数位四舍五入处理
     * @param num String
     * @param flag String
     * @return String
     */
    public static String tranString(String num, int flag) {
        if (num == null || "".equals(num.trim())) {
            num = " ";
        } else {
            try {
                BigDecimal bd = new BigDecimal(num);
                double value = bd.doubleValue();
                if (value == 0.0) {
                    num = " ";
                } else {
                    num = UtilTools.formatDouble(value,flag);
                }
            } catch (Exception e) {
                System.out.println(num+"-->"+flag+">>TranString error");
            }
        }
        return num;

    }

    /**
     * @deprecated：根据指定精度，格式化相应的数据
     * @param num double
     * @param key String
     * @return String
     */
    public static String tranString(double num, int key) {
        if (num == 0.0) {
            return "";
        }
        return UtilTools.formatDouble(num, key);
    }
    public static double addTwoString(String first,String second) {
        double val = UtilTools.parseStringToDouble(first);
        return UtilTools.addStringNumber(val,second);
    }

    /**
     * @deprecated：数据汇总时用到
     * @param first double
     * @param second String
     * @return double
     */
    public static double addStringNumber(double first, String second) {
        BigDecimal bd = new BigDecimal(first);
        if (second != null && !"".equals(second.trim())) {
            try {
                bd = bd.add(new BigDecimal(second));
            } catch (Exception e){
                System.out.println(">"+second+"< is error");
            }

        }
        return bd.doubleValue();
    }
    //格式化双精度数
    public static String formatDouble(double value, int flag) {
        if (value == 0.00) {
            return "";
        }
        StringBuilder str = new StringBuilder("0");
        if(flag > 0) {
            str.append(".");
        }
        for(int i = 0; i < flag; i++) {
            str.append("0");
        }
        DecimalFormat df = new DecimalFormat(str.toString());
        return df.format(value);
    }

    /**
     * @deprecated：获得当前年份
     * @return String
     */
    public static String getCurrentYear() {
        Date date = new Date();
        return String.valueOf(date.getYear() + 1900);
    }

    /**
     * @deprecated 用来处理树选择的条件:分两种情况：
     * @param filed String
     * @param str String
     * @return String
     */
    public static String reString(String filed, String f_fgsbm, String str) {
        StringBuilder sql = new StringBuilder();
        int j = 0;
        if (str != null && !"".equals(str)) {
            String[] arr = str.split(",");
            String middle = null;
            for (int i = 0; i < arr.length; i++) {
                middle = arr[i];
                if (f_fgsbm != null) { //存在分公司编码，那必定要取部门条件
                    if (middle.indexOf("-") > 0 &&
                            f_fgsbm.equals(middle.substring(0, middle.indexOf("-")))) {
                        middle = middle.substring(middle.indexOf("-") + 1);
                        sql.append(" or ").append(filed).append(" like '").
                                append(middle).append("%'");
                    }
                } else { //否则是取公司编码，或商品编码条件
                    if (middle.indexOf("-") > 0) {
                        middle = middle.substring(0, middle.indexOf("-"));
                        if (sql.toString().indexOf("'" + middle + "%'") < 0) { //不存在
                            sql.append(" or ").append(filed).append(" like '").
                                    append(middle).append("%'");
                        }
                    } else {
                        sql.append(" or ").append(filed).append(" like '").
                                append(middle).append("%'");
                    }
                }
            }
        }
        String temp = sql.toString();
        if (!"".equals(temp)) {
            temp = temp.substring(3);
            temp = " and (" + temp + ")";
        }
        return temp;
    }
    public static String reString(String filed,String str) {
        StringBuilder sql = new StringBuilder();
        int j = 0;
        if (str != null && !"".equals(str)) {
            String[] arr = str.split(",");
            for (int i = 0; i < arr.length; i++) {
                sql.append(" or ").append(filed).append(" like '").append(arr[i]).append("%'");

            }
        }
        String temp = sql.toString();
        if (!"".equals(temp)) {
            temp = " and (" + temp.substring(3) + ")";
        }
        return temp;
    }



    /**
     * @param numStr String 接受一个数字字符串，并返回格式化后的结果，
     * 如果字符串为 null 或字符串为空或字符串是空白字符或字符串不包含数字，则返回 0
     * @return String 格式化后的字符串
     * */
    public static String getNumber(String numStr) {
        String number = numStr;
        if (null == numStr || "".equals(numStr.trim())) {
            return "0";
        }
        /**
         * [a-z,A-Z,\\s]* 匹配所有英文字母和空白字符
         * (\\+|\\-)?     匹配 0 个或 1 个 + 号或 - 号
         * \\d*           匹配任意多个数字
         * \\.?           匹配 0 个或 1 个 . 号
         * */
        Pattern pattern = Pattern.compile(
                "[a-z,A-Z,\\s]*(\\+|\\-)?\\d*\\.?\\d*[a-z,A-Z,\\s]*");
        Matcher matcher = pattern.matcher(numStr);
        boolean isMatch = matcher.matches();
        if (isMatch) {
            number = Pattern.compile("[a-z,A-Z,\\s]*").matcher(numStr).
                    replaceAll("");
            if (number.equals("")) {
                number = "0";
            }
        } else {
            number = "NaN";
        }
        return number;
    }
    /**
     * 判断是否全数字，如果全部由数字组成或字符串为空则返回 true，否则返回 false
     * */
    public static boolean isNumber(String str){
        if(null == str){
            return false;
        }
        Pattern pattern = Pattern.compile("\\d*");
        Matcher matcher = pattern.matcher(str);
        boolean isMatch = matcher.matches();
        return isMatch;
    }

    //字符集转换
    public static String convertString(String temp) {
        if(temp != null) {
            try {
                temp = URLDecoder.decode(temp,"UTF-8");
            } catch (Exception e){
                e.printStackTrace();
            }
        }
        return temp;
    }
    public static String convertFromGBK(String temp) {
        if(temp != null) {
            try {
                temp = new String(temp.getBytes("ISO8859-1"),"GBK");
            } catch (Exception e){
                e.printStackTrace();
            }
        }
        return temp;
    }
    public static String convertFromGB(String temp) {
        if(temp != null) {
            try {
                temp = new String(temp.getBytes("ISO8859-1"),"GB2312");
            } catch (Exception e){
                e.printStackTrace();
            }
        }
        return temp;
    }

    /**
     * @deprecated 判断是否为空或未初始化
     * @param str
     */
    public static boolean isEmpty(String str) {
        if(str==null||"".equals(str.trim())) {
            return true;
        } else {
            return false;
        }
    }
    /**
     * @deprecated 将查询出来的结果集，按指定要求转化为字符
     * @param list 结果集
     * @param filed 需要取出的字段值
     * @param key 前几个是键
     * @return
     */
    public static String listToString(List list,String filed,int key){
        String[] fileds = filed.split(",");
        StringBuilder sql = new StringBuilder();
        int size = list.size();
        Object obj = null;
        Class cls = null;
        int lens = fileds.length;
        int j = 0;
        Method[] method = new Method[lens];
        StringBuilder keys = new StringBuilder();
        StringBuilder vals = new StringBuilder();
        String value = null;
        for(int i=0; i<size; i++) {
            obj = list.get(i);
            keys = keys.delete(0,keys.length());
            vals = vals.delete(0,vals.length());
            if(cls==null) {
                cls = obj.getClass();
                for(j=0; j<lens; j++) {
                    try {
                        method[j] = cls.getMethod("get"+fileds[j].substring(0,1).toUpperCase()+fileds[j].substring(1));
                    } catch (Exception e) {
                        System.out.println(fileds[j] + " not found  in " + cls.getName());
                    }
                }
            }
            if(i!=0) {
                sql.append(UtilTools.ROW_SPLIT);//换行
            }
            for(j=0; j<lens; j++) {
                if(j>0&&j==key){
                    sql.append("==");//间隔键和值
                }
                try {
                    value = (String)method[j].invoke(obj);
                } catch (Exception e) {
                    System.out.println(method[j].getName() + " is error ");
                }
                if(value==null||"".equals(value) || "0.00".equals(value) || "0.0".equals(value)) {
                    value = " ";
                }
                sql.append(value).append(UtilTools.COL_SPLIT);
            }
        }
        return sql.toString();
    }
    //数组集合转化为字符结果
    public static String arrayListToString(List list){
        StringBuilder sql = new StringBuilder();
        int size = list.size();
        int lens = 0;
        int j = 0;
        StringBuilder vals = new StringBuilder();
        String value = null;
        String[] obj = null;
        for(int i=0; i<size; i++) {
            obj = (String[])list.get(i);

            if(i!=0) {
                sql.append(UtilTools.ROW_SPLIT);//换行
            } else lens = obj.length;
            for(j=0; j<lens; j++) {
                value=obj[j];
                if(value==null||"".equals(value) || "0.00".equals(value) || "0.0".equals(value)) {
                    value = " ";
                }
                sql.append(value).append(UtilTools.COL_SPLIT);
            }
        }
        return sql.toString();
    }
    //数组集合汇总
    public static String arrayCount(List lst) {
        int s = lst==null?0:lst.size();
        int l = -1;
        int j=0;
        String[] arr = null;
        double[] dbl = null;
        for(int i=0; i<s; i++) {
            arr = (String[])lst.get(i);
            if(l==-1){
                l = arr.length;
                dbl = new double[l];
                for(j=0; j<l; j++)dbl[j]=0.00;
            }
            for(j=0; j<l; j++) {
                dbl[j]=UtilTools.addStringNumber(dbl[j],arr[j]);
            }
        }
        StringBuilder sql = new StringBuilder();
        int jd = 2;
        
        for(j=0; j<l; j++) {
            sql.append(UtilTools.formartNumber(dbl[j],jd)).append(UtilTools.COL_SPLIT);
        }
        return sql.toString();
    }
    /**
     * @deprecated 回应信息
     * @param response
     * @param value
     */
    public static void reply(HttpServletResponse response,String value) {
        if(value!=null) {
            javax.servlet.ServletResponse res = (javax.servlet.ServletResponse)response;
            res.setCharacterEncoding("UTF-8");
            try {
                response.getWriter().println(value);
            } catch (Exception e) {

            }
        }
    }
    /**
     * @deprecated 根据传过来的编码求得下一个编码
     * @param value
     * @return
     */
    public static String bmAddOne(String value) {
        int lens = value.length()-1;
        if(value.endsWith("9")) {
            if(lens==0)return "10";
            return bmAddOne(value.substring(0,lens))+"0";
        } else if(value.endsWith("8")) {
            return value.substring(0,lens)+"9";
        } else if(value.endsWith("7")) {
            return value.substring(0,lens)+"8";
        } else if(value.endsWith("6")) {
            return value.substring(0,lens)+"7";
        } else if(value.endsWith("5")) {
            return value.substring(0,lens)+"6";
        } else if(value.endsWith("4")) {
            return value.substring(0,lens)+"5";
        } else if(value.endsWith("3")) {
            return value.substring(0,lens)+"4";
        } else if(value.endsWith("2")) {
            return value.substring(0,lens)+"3";
        } else if(value.endsWith("1")) {
            return value.substring(0,lens)+"2";
        } else if(value.endsWith("0")) {
            return value.substring(0,lens)+"1";
        } else {
            return value;
        }

    }
    /**
     * clear the session
     */
    public static void sessionDestory(HttpSession session) {
        Enumeration enums = session.getAttributeNames();
        if(enums.hasMoreElements()) {
            session.removeAttribute((String)enums.nextElement());
        }
    }
    public static String listToString(List list) {//专门处理一些返一列的结果集的集合
        int size = list==null?0:list.size();
        StringBuilder sql = new StringBuilder();
        for(int i=0;i<size;i++)
            sql.append((String)list.get(i)).append(";");
        return sql.toString();
    }
    //判断该字符串是否数值型
    public static boolean isNumeric(String txt){
        String str = txt;
        if(str.startsWith("-"))str=str.substring(1);//处理负数
        if(str.indexOf(".")==str.lastIndexOf("."))str=str.replaceAll(".","");//处理小数
        return str.matches("\\d*");
    }
    //判断该字符串是否整型
    public static boolean isInteger(String str){
        return str.matches("\\d*");
    }

    public static int sljd = 4;
    public static int jejd = 2;
    public static int djjd = 4;

    public static String findParam(String f_dwid,String f_csmc)  {
        String f_csz = null;
        try {
            f_csz = new SqlServerOperator().queryOneRecorderData("select f_csz from tb"+f_dwid+"_sysparam where f_csmc=?",new String[]{f_csmc});
        } catch (Exception e){
            System.out.println("========findParam is error  "+e.getMessage());
        }
        return f_csz;
    }
    public static int accuracyByType (String lx,String f_dwid) {
        //从数据库取出设置的精度，否则直接返回预设
        int jd = -1;
        String csmc = null;
        if(lx==null||"".equals(lx)||"0".equals(lx)) {
            jd = UtilTools.sljd;
            csmc = Parameter.SLJD;
        } else if("1".equals(lx)) {
            jd = UtilTools.djjd;
            csmc = Parameter.DJJD;
        } else if("2".equals(lx)) {
            jd = UtilTools.jejd;
            csmc = Parameter.JEJD;
        }
        if(csmc==null)return  UtilTools.len;

        try {
            String csz = new SqlServerOperator().queryOneRecorderData("select f_csz from tb"+f_dwid+"_sysparam where f_csmc=?",new String[]{csmc});
            if(csz==null||"".equals(csz)||!UtilTools.isInteger(csz))return jd;
            jd = Integer.parseInt(csz);
        } catch (Exception e ){
            jd = 2;
        }
        return jd;

    }

}
