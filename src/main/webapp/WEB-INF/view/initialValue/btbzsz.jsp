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
%>
<%--<!DOCTYPE html>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-补贴标准设置</title>
    <meta name="description" content="云平台客户端V1-补贴标准设置">
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
        <div class="am-u-sm-12 am-u-md-12" id="xsdiv">
            <div class="header">
                <div class="am-g">
                    <h1>农药补贴规则</h1>
                </div>
            </div>
        </div>

        <div class="am-u-sm-12 am-u-md-12 am-text-right">
            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="saveJe()">保存</button>
        </div>

        <%--农户补贴基数div--%>
        <div>
            <table class="am-table am-table-bordered am-text-nowrap am-table-hover">
                <thead id="nhbtjsTitle">
                </thead>
                <tbody id="nhbtjsBody">
                </tbody>
            </table>
        </div>

        <%--大户补贴基数div--%>
        <div>
            <table class="am-table am-table-bordered am-text-nowrap am-table-hover">
                <thead id="dhbtjsTitle">
                </thead>
                <tbody id="dhbtjsBody">
                </tbody>
            </table>
        </div>

        <%--合作社补贴基数div--%>
        <div>
            <table class="am-table am-table-bordered am-text-nowrap am-table-hover">
                <thead id="hzsbtjsTitle">
                </thead>
                <tbody id="hzsbtjsBody">
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
        var BtjsJson = null;

        $(function (){
            //农户
            getBtjsTable("0");
            if (BtjsJson != null && BtjsJson != "" && BtjsJson != "[]"){
                var nhbtjsTitleHtml = " <tr> \n" +
                "                           <td class=\"am-text-middle am-text-center\" colspan='2' style='font-weight: bolder;background-color: #eee;'>农户补贴基数</td> \n" +
                "                       </tr>" +
                "                       <tr> \n" +
                "                           <td class=\"am-text-middle am-text-center\" style='font-weight: bolder;background-color: #eee;'>经营品种</td> \n" +
                "                           <td class=\"am-text-middle am-text-center\" style='font-weight: bolder;background-color: #eee;'>每亩金额</td> \n" +
                "                       </tr>";
                $("#nhbtjsTitle").html(nhbtjsTitleHtml);

                var nhbtjsBodyHtml = "";
                for (var i = 0; i < BtjsJson.length; i++){
                    nhbtjsBodyHtml += "     <tr> \n" +
                    "                           <td class=\"am-text-middle\" style='font-size: 8px'><a value=\""+BtjsJson[i].F_FLBM+"\" style='color: #333;'>"+BtjsJson[i].F_FLMC+"</a></td> \n" +
                    "                           <td class=\"am-text-middle\">" +
                    "                               <input type=\"text\" class=\"am-form-field am-input-sm am-radius am-align-right\" value='"+BtjsJson[i].F_MMJE+"' style='margin: 0;padding: 0;font-size: 8px;'>" +
                    "                           </td> \n" +
                    "                       </tr>";
                }
                $("#nhbtjsBody").html(nhbtjsBodyHtml);
            }

            //大户
            getBtjsTable("1");
            if (BtjsJson != null && BtjsJson != "" && BtjsJson != "[]"){
                var dhbtjsTitleHtml = " <tr> \n" +
                "                           <td class=\"am-text-middle am-text-center\" colspan='2' style='font-weight: bolder;background-color: #eee;'>大户补贴基数</td> \n" +
                "                       </tr>" +
                "                       <tr> \n" +
                "                           <td class=\"am-text-middle am-text-center\" style='font-weight: bolder;background-color: #eee;'>经营品种</td> \n" +
                "                           <td class=\"am-text-middle am-text-center\" style='font-weight: bolder;background-color: #eee;'>每亩金额</td> \n" +
                "                       </tr>";
                $("#dhbtjsTitle").html(dhbtjsTitleHtml);

                var dhbtjsBodyHtml = "";
                for (var i = 0; i < BtjsJson.length; i++){
                    dhbtjsBodyHtml += " <tr> \n" +
                        "                           <td class=\"am-text-middle\" style='font-size: 8px'><a value=\""+BtjsJson[i].F_FLBM+"\" style='color: #333;'>"+BtjsJson[i].F_FLMC+"</a></td> \n" +
                        "                           <td class=\"am-text-middle\">" +
                        "                               <input type=\"text\" class=\"am-form-field am-input-sm am-radius am-align-right\" value='"+BtjsJson[i].F_MMJE+"' style='margin: 0;padding: 0;font-size: 8px;'>" +
                        "                           </td> \n" +
                        "                       </tr>";
                }
                $("#dhbtjsBody").html(dhbtjsBodyHtml);
            }

            //合作社
            getBtjsTable("2");
            if (BtjsJson != null && BtjsJson != "" && BtjsJson != "[]"){
                var hzsbtjsTitleHtml = " <tr> \n" +
                "                           <td class=\"am-text-middle am-text-center\" colspan='2' style='font-weight: bolder;background-color: #eee;'>合作社补贴基数</td> \n" +
                "                       </tr>" +
                "                       <tr> \n" +
                "                           <td class=\"am-text-middle am-text-center\" style='font-weight: bolder;background-color: #eee;'>经营品种</td> \n" +
                "                           <td class=\"am-text-middle am-text-center\" style='font-weight: bolder;background-color: #eee;'>每亩金额</td> \n" +
                "                       </tr>";
                $("#hzsbtjsTitle").html(hzsbtjsTitleHtml);

                var hzsbtjsBodyHtml = "";
                for (var i = 0; i < BtjsJson.length; i++){
                    hzsbtjsBodyHtml += " <tr> \n" +
                        "                           <td class=\"am-text-middle\" style='font-size: 8px'><a value=\""+BtjsJson[i].F_FLBM+"\" style='color: #333;'>"+BtjsJson[i].F_FLMC+"</a></td> \n" +
                        "                           <td class=\"am-text-middle\">" +
                        "                               <input type=\"text\" class=\"am-form-field am-input-sm am-radius am-align-right\" value='"+BtjsJson[i].F_MMJE+"' style='margin: 0;padding: 0;font-size: 8px;'>" +
                        "                           </td> \n" +
                        "                       </tr>";
                }
                $("#hzsbtjsBody").html(hzsbtjsBodyHtml);
            }

        });

        //展示补贴基数表格
        function getBtjsTable(khlx){
            $.ajax({
                url: "/initialvalues/getBtjsTable",
                type: "post",
                async: false,
                data: { khlx:khlx,timmer: new Date() },
                success:function(data){
                    var dataJson = JSON.parse(data);
                    BtjsJson = dataJson;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }
        
        //保存金额
        function saveJe() {
            getBtjsTable("0");
            var nhje = "";
            var nhxh = "";
            if (BtjsJson != null && BtjsJson != "" && BtjsJson != "[]"){
                for (var i = 0;i < BtjsJson.length; i++){
                    if (i < BtjsJson.length-1){
                        nhje += $("#nhbtjsBody").find("tr:eq("+i+")").find("input:eq(0)").val();
                        nhje += ",";
                        nhxh += $("#nhbtjsBody").find("tr:eq("+i+")").find("a:eq(0)").attr("value");
                        nhxh += ",";
                    }else {
                        nhje += $("#nhbtjsBody").find("tr:eq("+i+")").find("input:eq(0)").val();
                        nhxh += $("#nhbtjsBody").find("tr:eq("+i+")").find("a:eq(0)").attr("value");
                    }
                }
            }

            getBtjsTable("1");
            var dhje = "";
            var dhxh = "";
            if (BtjsJson != null && BtjsJson != "" && BtjsJson != "[]"){
                for (var i = 0;i < BtjsJson.length; i++){
                    if (i < BtjsJson.length-1){
                        dhje += $("#dhbtjsBody").find("tr:eq("+i+")").find("input:eq(0)").val();
                        dhje += ",";
                        dhxh += $("#dhbtjsBody").find("tr:eq("+i+")").find("a:eq(0)").attr("value");
                        dhxh += ",";
                    }else {
                        dhje += $("#dhbtjsBody").find("tr:eq("+i+")").find("input:eq(0)").val();
                        dhxh += $("#dhbtjsBody").find("tr:eq("+i+")").find("a:eq(0)").attr("value");
                    }
                }
            }

            getBtjsTable("2");
            var hzsje = "";
            var hzsxh = "";
            if (BtjsJson != null && BtjsJson != "" && BtjsJson != "[]"){
                for (var i = 0;i < BtjsJson.length; i++){
                    if (i < BtjsJson.length-1){
                        hzsje += $("#hzsbtjsBody").find("tr:eq("+i+")").find("input:eq(0)").val();
                        hzsje += ",";
                        hzsxh += $("#hzsbtjsBody").find("tr:eq("+i+")").find("a:eq(0)").attr("value");
                        hzsxh += ",";
                    }else {
                        hzsje += $("#hzsbtjsBody").find("tr:eq("+i+")").find("input:eq(0)").val();
                        hzsxh += $("#hzsbtjsBody").find("tr:eq("+i+")").find("a:eq(0)").attr("value");
                    }
                }
            }

            $.ajax({
                url: "/initialvalues/saveJe",
                type: "post",
                async: false,
                data: { nhje:nhje,dhje:dhje,hzsje:hzsje,nhxh:nhxh,dhxh:dhxh,hzsxh:hzsxh,timmer: new Date() },
                success:function(data){
                    if (data == "ok"){
                        alertMsg("保存成功！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
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
