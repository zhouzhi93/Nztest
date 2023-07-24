<%--
  Created by IntelliJ IDEA.
  User: tao
  Date: 2018/6/20
  Time: 16:49
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Date date = new Date();
    SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
    String str=dateFormat.format(date);
    String lxbm=(String) session.getAttribute("f_lxbm");
%>
<%--<!DOCTYPE html>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-参数设置</title>
    <meta name="description" content="云平台客户端V1-参数设置">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="apple-touch-icon-precomposed" href="/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="/assets/css/amazeui.min.css"/>
    <link rel="stylesheet" href="/assets/css/iconfont.css"/>
    <link rel="stylesheet" href="/assets/address/amazeui.address.css"/>
    <link rel="stylesheet" href="/tree/amazeui.tree.css"/>
    <link rel="stylesheet" href="/tree/amazeui.tree.min.css"/>
    <style>
        .header
        {
            text-align: center;
        }
        .header h1
        {
            font-size: 200%;
            color: #333;
            margin-top: 10px;
        }
        .am-text-middle input
        {
            border: 0px;width:80px;outline:none;cursor: pointer;text-align:center;
        }
        #sptable input{
            padding-bottom: 5px;
        }
        .am-container{
            padding-left: 0;
            padding-right: 0;
            max-width:100%;
        }
        label{
            font-weight: 500;
            font-size:1.4rem;
        }
    </style>
</head>
<body>
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-12">
            <div class="header">
                <div class="am-g">
                    <h1>参数设置</h1>
                </div>
            </div>
        </div>

        <div class="am-u-sm-12 am-u-md-12 am-text-right">
            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="resetCs()">重置</button>
            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="saveCs()">保存</button>
        </div>

        <%--参数设置div--%>
        <div>
            <table class="am-table am-table-bordered am-text-nowrap am-table-hover">
                <thead>
                <tr>
                    <td class="am-text-middle am-text-center" style='font-weight: bolder;background-color: #eee;'>参数名称</td>
                    <td class="am-text-middle am-text-center" style='font-weight: bolder;background-color: #eee;'>参数值</td>
                </tr>
                </thead>
                <tbody id="csszBody">
                </tbody>
            </table>
        </div>
    </div>




    <script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
    <script src="/assets/js/amazeui.min.js"></script>
    <script src="/assets/js/app.js"></script>
    <script src="/assets/address/address.min.js"></script>
    <script src="/assets/address/iscroll.min.js"></script>
    <script src="/tree/amazeui.tree.js"></script>
    <script src="/tree/amazeui.tree.min.js"></script>
    <script type="text/javascript">
        var loadCssz = null;

        $(function (){
            getCsszTable();

        });

        //展示参数设置表格
        function getCsszTable(){
            var f_lxbm = "<%=lxbm%>";
            $.ajax({
                url: "/initialvalues/getCsszTable",
                type: "post",
                async: false,
                data: { f_lxbm:f_lxbm,timmer: new Date() },
                success:function(data){
                    var dataJson = JSON.parse(data);
                    loadCssz = dataJson;
                    if (dataJson != null && dataJson != "" && dataJson != "[]"){
                        var csszBodyHtml = "";
                        for (var i = 0; i < dataJson.length; i++){
                            if (dataJson[i].F_CSLX == 0){
                                csszBodyHtml += "   <tr> \n" +
                                    "                   <td class=\"am-text-middle\">"+dataJson[i].F_CSMC+"</td> \n" +
                                    "                   <td class=\"am-text-middle\">" +
                                    "                       <input type=\"text\" class=\"am-form-field am-input-sm am-radius am-align-left\" value='"+dataJson[i].F_CSZ+"' style='margin: 0;padding: 0;width: 100%;text-align:left;'>" +
                                    "                   </td> \n" +
                                    "               </tr>\n";
                            }else if (dataJson[i].F_CSLX == 1){
                                csszBodyHtml += "   <tr> \n" +
                                    "                   <td class=\"am-text-middle\">"+dataJson[i].F_CSMC+"</td> \n" +
                                    "                   <td class=\"am-text-middle\">" +
                                    "                       <input type=\"number\" class=\"am-form-field am-input-sm am-radius am-align-left\" value='"+dataJson[i].F_CSZ+"' style='margin: 0;padding: 0;width: 100%;text-align:left;'>" +
                                    "                   </td> \n" +
                                    "               </tr>\n";
                            }else if (dataJson[i].F_CSLX == 2){
                                var csxzList = dataJson[i].F_CSXZ;
                                var csxzs = csxzList.split(";");
                                csszBodyHtml += "   <tr> \n" +
                                    "                   <td class=\"am-text-middle\">"+dataJson[i].F_CSMC+"</td> \n" +
                                    "                   <td class=\"am-text-middle\" style='padding: 0px;'> \n" +
                                    "                       <select data-am-selected=\"{btnWidth: '100%'}\" style='width: 100%;height: 40px;border: 0px;'>";
                                    for (var j = 0; j < csxzs.length; j++){
                                        var csxz = csxzs[j].split(",");
                                        if (csxz[0] == dataJson[i].F_CSZ){
                                            csszBodyHtml += "<option value='"+csxz[0]+"' selected>"+csxz[1]+"</option>";
                                        }else {
                                            csszBodyHtml += "<option value='"+csxz[0]+"'>"+csxz[1]+"</option>";
                                        }
                                    }
                                csszBodyHtml += "           </select>";
                            }
                        }
                        $("#csszBody").html(csszBodyHtml);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }
        
        //保存参数
        function saveCs() {
            var csbmList = "";
            var cszList = "";
            for (var i = 0; i < loadCssz.length; i++){
                var f_csbm = loadCssz[i].F_CSBM;

                if (loadCssz[i].F_CSLX == 2){
                    var f_csz = $("#csszBody").find("tr:eq("+i+")").find("select:eq(0)").val();
                }else{
                    var f_csz = $("#csszBody").find("tr:eq("+i+")").find("input:eq(0)").val();
                }


                if (i == loadCssz.length-1){
                    csbmList += f_csbm;
                    cszList += f_csz;
                }else {
                    csbmList += f_csbm + ",";
                    cszList += f_csz + ",";
                }
            }

            $.ajax({
                url: "/initialvalues/saveCs",
                type: "post",
                async: false,
                data: { csbmList:csbmList,cszList:cszList,timmer: new Date() },
                success:function(data){
                    if (data == "ok"){
                        alertMsg("保存成功，请重新登录！");
                        $('#okbtn').click(function () {
                            var win = window;
                            while (win != win.top){
                                win = win.top;
                            }
                            win.location = "/login";
                        });
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        //重置
        function resetCs() {
            if (loadCssz != null && loadCssz != "" && loadCssz != "[]"){
                var csszBodyHtml = "";
                for (var i = 0; i < loadCssz.length; i++){
                    if (loadCssz[i].F_CSLX == 0){
                        csszBodyHtml += "   <tr> \n" +
                            "                   <td class=\"am-text-middle\">"+loadCssz[i].F_CSMC+"</td> \n" +
                            "                   <td class=\"am-text-middle\">" +
                            "                       <input type=\"text\" class=\"am-form-field am-input-sm am-radius am-align-left\" value='' style='margin: 0;padding: 0;width: 100%;text-align:left;'>" +
                            "                   </td> \n" +
                            "               </tr>\n";
                    }else if (loadCssz[i].F_CSLX == 1){
                        csszBodyHtml += "   <tr> \n" +
                            "                   <td class=\"am-text-middle\">"+loadCssz[i].F_CSMC+"</td> \n" +
                            "                   <td class=\"am-text-middle\">" +
                            "                       <input type=\"number\" class=\"am-form-field am-input-sm am-radius am-align-left\" value='0' style='margin: 0;padding: 0;width: 100%;text-align:left;'>" +
                            "                   </td> \n" +
                            "               </tr>\n";
                    }else if (loadCssz[i].F_CSLX == 2){
                        var csxzList = loadCssz[i].F_CSXZ;
                        var csxzs = csxzList.split(";");
                        csszBodyHtml += "   <tr> \n" +
                            "                   <td class=\"am-text-middle\">"+loadCssz[i].F_CSMC+"</td> \n" +
                            "                   <td class=\"am-text-middle\" style='padding: 0px;'> \n" +
                            "                       <select data-am-selected=\"{btnWidth: '100%'}\" style='width: 100%;height: 40px;border: 0px;'>";
                        for (var j = 0; j < csxzs.length; j++){
                            var csxz = csxzs[j].split(",");
                            if (csxz[0] == "0"){
                                csszBodyHtml += "<option value='"+csxz[0]+"' selected>"+csxz[1]+"</option>";
                            }else {
                                csszBodyHtml += "<option value='"+csxz[0]+"'>"+csxz[1]+"</option>";
                            }
                        }
                        csszBodyHtml += "           </select>";
                    }
                }
                $("#csszBody").html(csszBodyHtml);
            }
        }

        function alertMsg(msg){
            $('#alertcontent ',parent.document).text(msg);
            $('#alertdlg',parent.document).modal('open');
            $('#okbtn',parent.document).click(function (){
                location.reload(true);
                $('#alertdlg',parent.document).modal('close');
            });
        }

    </script>
</body>
</html>
