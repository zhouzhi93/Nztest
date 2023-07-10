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
    <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-证书查询</title>
    <meta name="description" content="云平台客户端V1-证书查询">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="apple-touch-icon-precomposed" href="/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="/assets/css/amazeui.min.css"/>
    <link rel="stylesheet" href="/assets/css/iconfont.css"/>
    <link rel="stylesheet" href="/assets/address/amazeui.address.css"/>
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
        .style4 {
            font-size: 16px;
            font-weight: bold;
        }
        .style7 {font-size: 14px}
        .style10 {
            font-size: 36px;
            font-weight: bold;
        }
        .style13 {
            font-size: 25px;
            font-weight: bold;
        }
        .style11 {
            font-size: 20px;
            font-weight: bold;
        }
        .style14 {
            font-size: 28px;
            font-weight: bold;
        }
        .style12 {color: #FF0000}
        .kuang {
            border: 1px solid #000000;
        }
        table tr td .style7 img{
            width:40px;
            height:40px;
        }
        .style16 {
            font-family: "华文仿宋";
            font-size: 12px;
        }
    </style>
</head>
<body>
<div class="am-g">
    <div class="am-form-inline"  style="margin-top: 10px;">
        农药登记证号：<input type="text" id="nydjh" class="am-form-field am-input-sm am-radius" style="width: 230px;" placeholder="农药登记证号">&nbsp;
        <button onclick="search()" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger">查询</button>
        <%--<button onclick="loadInfo('')" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger" style="margin-left: 10px;background-color: #fff !important;border: 1px solid #e52a33 !important;color: #e52a33 !important;">刷新</button>--%>
    </div>
    <div id="main">

    </div>
    <%--<iframe id="main_iframe" scrolling="auto" frameborder="0" style="width:100%;height:91%;margin-top: 10px;" src="http://www.chinapesticide.org.cn/myquery/tagdetail?pdno=PD20083797"></iframe>--%>
</div>
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script src="/assets/js/app.js"></script>
<script type="text/javascript">

    function search(){
        var nydjh = $("#nydjh").val()
        $.ajax({
            url: "/htmlPage/certsearch",
            type: "post",
            async: false,
            data: {nydjh:nydjh, timeer: new Date() },
            success: function (data) {
                $("#main").html(data);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alertMsg("请求异常");
            }
        });
    }

    function alertMsg(msg){
        $('#alertcontent').text(msg);
        $('#alertdlg').modal('open');
        $('#alertdlg').css("z-index","1120");
    }
</script>
</body>
</html>
