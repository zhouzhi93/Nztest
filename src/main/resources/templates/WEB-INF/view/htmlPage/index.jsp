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
    <title>云平台客户端V1-销售查询</title>
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
        .am-gallery-item-boder{
            border:1px solid red;
            padding: 1px;
        }
        .am-td-spmc{
            max-width: 150px;
            font-size: 1.4rem;
        }
        #sptable input{
            padding-bottom: 5px;
        }
        .am-container{
            padding-left: 0;
            padding-right: 0;
        }
        label{
            font-weight: 500;
            font-size:1.4rem;
        }
        .am-popup{
            z-index: 1200;
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
            <a href="##" class="">
                <h2>农技资讯</h2>
                <%--<span class="am-list-news-more am-fr">更多 &raquo;</span>--%>
            </a>
        </div>
        <div class="am-list-news-bd">
            <ul class="am-list">
                <li class="am-g am-list-item-dated">
                    <a href="##" class="am-list-item-hd ">淡季不淡，市场供需博弈加剧　农药原药价格持...</a>
                    <span class="am-list-date">2018-07-26</span>
                </li>
                <li class="am-g am-list-item-dated">
                    <a href="##" class="am-list-item-hd ">本周杀菌剂原药和中间体市场行情分析涓</a>
                    <span class="am-list-date">2018-07-26</span>
                </li>
                <li class="am-g am-list-item-dated">
                    <a href="##" class="am-list-item-hd ">本周杀虫剂原药市场行情分析</a>
                    <span class="am-list-date">2018-07-26</span>
                </li>
            </ul>
        </div>

    </div>
</div>
<%--<div class="am-g am-text-left">--%>
    <%--<div class="am-u-sm-12 am-u-md-12">--%>
    <%--<span style="background-color: #D8D8D8">业务台账</span>--%>
    <%--</div>--%>
<%--</div>--%>
<div class="row-content am-cf">
    <div class="am-infol-row  am-cf">
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf whitediv">
                <div class="am-infol-header">
                    今日销售
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value" style="color: #838FA1;" id="jrxs">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf bluediv">
                <div class="am-infol-header">
                    今日成本
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value" id="jrcb">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf purplediv">
                <div class="am-infol-header">
                    今日毛利
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value" id="jrml">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf otherdiv">
                <div class="am-infol-header">
                    今日进货
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value" id="jrjh">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
    </div>
    <div class="am-infol-row  am-cf">
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf whitediv">
                <div class="am-infol-header">
                    本月销售
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value" style="color: #838FA1;" id="byxs">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf bluediv">
                <div class="am-infol-header">
                    本月成本
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value" id="bycb">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf purplediv">
                <div class="am-infol-header">
                    本月毛利
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value" id="byml">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf otherdiv">
                <div class="am-infol-header">
                    本月进货
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value" id="byjh">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
    </div>
    <div class="am-infol-row  am-cf">
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf whitediv">
                <div class="am-infol-header">
                    上月销售
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value" style="color: #838FA1;" id="syxs">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf bluediv">
                <div class="am-infol-header">
                    上月成本
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value" id="sycb">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf purplediv">
                <div class="am-infol-header">
                    上月毛利
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value" id="syml">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf otherdiv">
                <div class="am-infol-header">
                    上月进货
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value" id="syjh">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
    </div>
    <div class="am-infol-row  am-cf">
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf whitediv">
                <div class="am-infol-header">
                    本年销售
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value" style="color: #838FA1;">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf bluediv">
                <div class="am-infol-header">
                    本年成本
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf purplediv">
                <div class="am-infol-header">
                    本年毛利
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf otherdiv">
                <div class="am-infol-header">
                    本年进货
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
    </div>
    <div class="am-infol-row  am-cf">
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf whitediv">
                <div class="am-infol-header">
                    上年销售
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value" style="color: #838FA1;">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf bluediv">
                <div class="am-infol-header">
                    上年成本
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf purplediv">
                <div class="am-infol-header">
                    上年毛利
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-6 am-u-lg-3">
            <div class="widget widget-primary am-cf otherdiv">
                <div class="am-infol-header">
                    上年进货
                </div>
                <div class="widget-statistic-body">
                    <div class="am-infol-value">
                        ￥27,294
                    </div>
                    <div class="widget-statistic-description">
                        &nbsp;
                    </div>
                    <%--<span class="am-infol-icon am-icon-credit-card-alt"></span>--%>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script type="text/javascript">
    $(function(){
       var tjdata='${tjdata}';
       var tjdata=JSON.parse(tjdata);
       //本日
       $('#jrxs').text(tjdata.jrxs);
       $('#jrcb').text(tjdata.jrcb);
       $('#jrml').text(tjdata.jrml);
       $('#jrjh').text(tjdata.jrjh);
        //本月
        $('#byxs').text(tjdata.byxs);
        $('#bycb').text(tjdata.bycb);
        $('#byml').text(tjdata.byml);
        $('#byjh').text(tjdata.byjh);
        //上月
        $('#syxs').text(tjdata.syxs);
        $('#sycb').text(tjdata.sycb);
        $('#syml').text(tjdata.syml);
        $('#syjh').text(tjdata.syjh);
    })
</script>
</body>
</html>
