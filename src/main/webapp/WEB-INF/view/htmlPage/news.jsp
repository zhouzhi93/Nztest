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
    <title>云平台客户端V1-x行业资讯</title>
    <meta name="description" content="云平台客户端V1-销售查询">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="apple-touch-icon-precomposed" href="/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="/assets/css/amazeui.min.css"/>
    <link rel="stylesheet" href="/assets/css/iconfont.css"/>
    <link rel="stylesheet" href="/assets/css/app.css"/>
    <style>
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
        label{
            font-weight: 500;
            font-size:1.4rem;
        }
        .doc-am-g>[class*=am-u-] {
            border: 1px solid #1a1a1a;
            padding: 50px;
        }
    </style>
</head>
<body>
<div class="am-g">
    <div data-am-widget="list_news" class="am-list-news am-list-news-default" >
        <!--列表标题-->
        <div class="am-list-news-hd am-cf">
            <!--带更多链接-->
            <a href="javascript:void (0);" class="">
                <h2>行业资讯</h2>
                <span class="am-list-news-more am-fr">更多 &raquo;</span>
            </a>
        </div>
        <div class="am-list-news-bd">
            <ul class="am-list" id="newsUl">
            </ul>
        </div>
    </div>
</div>
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script type="text/javascript">
    $(function(){
        var newsList='${newsList}';
        newsList=JSON.parse(newsList);
        var newshmtl="";
        for(var i=0;i<newsList.length;i++){
            if(newsList[i]["url"]!="#"){
            newshmtl+="<li class=\"am-g am-list-item-dated\">\n" +
                "                    <a href=\""+newsList[i]["url"]+"\" target=\"_blank\" class=\"am-list-item-hd \">"+newsList[i]["title"]+"</a>\n" +
                "                    <span class=\"am-list-date\">"+newsList[i]["date"]+"</span>\n" +
                "                </li>"
            }
        }
        $('#newsUl').html(newshmtl);
    })
    function opentable(tabname,url) {
        parent.window.checkTab(tabname,url);
    }
</script>
</body>
</html>
