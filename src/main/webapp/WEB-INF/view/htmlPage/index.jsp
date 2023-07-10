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
    <title>云平台客户端V1-首页</title>
    <meta name="description" content="云平台客户端V1-首页">
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
<div class="am-g" style="margin-top: 10px;">
    <ul data-am-widget="gallery" class="am-gallery am-avg-sm-3
  am-avg-md-3 am-avg-lg-4 am-gallery-default am-no-layout" data-am-gallery="{ pureview: false }">
        <li>
            <div class="am-gallery-item am-text-center">
                <img src="/images/xs.png" style="width: 80px;height: auto;" alt="销售单" onclick="opentable('销售单','/sales/salesbill')">
                <div class="am-gallery-desc" style="font-size: 1.8rem;font-weight: 400;"><a onclick="opentable('销售单','/sales/salesbill')">销售单</a></div>
            </div>
        </li>
        <li>
            <div class="am-gallery-item am-text-center">
                <img src="/images/xsth.png" style="width: 80px;height: auto;" alt="销售退货" onclick="opentable('销售退货','/sales/salesreturn')">
                <div class="am-gallery-desc" style="font-size: 1.8rem;font-weight: 400;"><a onclick="opentable('销售退货','/sales/salesreturn')">销售退货</a></div>
            </div>
        </li>
        <li>
            <div class="am-gallery-item am-text-center">
                <img src="/images/jh.png" style="width: 80px;height: auto;" alt="进货单" onclick="opentable('进货单','/purchase/purchasebill')">
                <div class="am-gallery-desc" style="font-size: 1.8rem;font-weight: 400;"><a onclick="opentable('进货单','/purchase/purchasebill')">进货单</a></div>
            </div>
        </li>
        <li>
            <div class="am-gallery-item am-text-center">
                <img src="/images/jhth.png" style="width: 80px;height: auto;" alt="进货退货" onclick="opentable('进货退货','/purchase/purchasereturnbill')">
                <div class="am-gallery-desc" style="font-size: 1.8rem;font-weight: 400;"><a onclick="opentable('进货退货','/purchase/purchasereturnbill')">进货退货</a></div>
            </div>
        </li>
    </ul>
    <ul data-am-widget="gallery" class="am-gallery am-avg-sm-3
  am-avg-md-3 am-avg-lg-4 am-gallery-default am-no-layout" data-am-gallery="{ pureview: false }">

        <li>
            <div class="am-gallery-item am-text-center">
                <img src="/images/spda.png" style="width: 80px;height: auto;" alt="商品资料" onclick="opentable('商品资料','/commodity/gotoCommodity')">
                <div class="am-gallery-desc" style="font-size: 1.8rem;font-weight: 400;"><a onclick="opentable('商品资料','/commodity/gotoCommodity')">商品资料</a></div>
            </div>
        </li>
        <li>
            <div class="am-gallery-item am-text-center">
                <img src="/images/gys.png" style="width: 80px;height: auto;" alt="供应商资料" onclick="opentable('供应商资料','/initialvalues/gotoSupplier')">
                <div class="am-gallery-desc" style="font-size: 1.8rem;font-weight: 400;"><a onclick="opentable('供应商资料','/initialvalues/gotoSupplier')">供应商资料</a></div>
            </div>
        </li>
        <li>
            <div class="am-gallery-item am-text-center">
                <img src="/images/qkcx.png" style="width: 80px;height: auto;" alt="欠款查询" onclick="opentable('欠款查询','/arrearage/Prrearagedetail')">
                <div class="am-gallery-desc" style="font-size: 1.8rem;font-weight: 400;"><a onclick="opentable('欠款查询','/arrearage/Prrearagedetail')">欠款查询</a></div>
            </div>
        </li>
        <li>
            <div class="am-gallery-item am-text-center">
                <img src="/images/nybqcx.png" style="width: 80px;height: auto;" alt="农药标签检查" onclick="opentable('农药标签检查','/infolsearch/certsearch')">
                <div class="am-gallery-desc" style="font-size: 1.8rem;font-weight: 400;"><a onclick="opentable('农药标签检查','/infolsearch/certsearch')">农药标签检查</a></div>
            </div>
        </li>
    </ul>
</div>
<div class="am-g">
    <div data-am-widget="list_news" class="am-list-news am-list-news-default" >
        <!--列表标题-->
        <div class="am-list-news-hd am-cf">
            <!--带更多链接-->
            <a href="javascript:void (0);" onclick="opentable('行业资讯','/htmlPage/news')" class="">
                <h2>行业资讯</h2>
                <span class="am-list-news-more am-fr">更多 &raquo;</span>
            </a>
        </div>
        <div class="am-list-news-bd">
            <ul class="am-list" id="newsUl">
                <li class="am-g am-list-item-dated">
                    <a href="/static/news1.html" target="_blank" class="am-list-item-hd ">淡季不淡，市场供需博弈加剧　农药原药价格持...</a>
                    <span class="am-list-date">2018-07-26</span>
                </li>
                <li class="am-g am-list-item-dated">
                    <a href="/static/news2.html" target="_blank" class="am-list-item-hd ">本周杀菌剂原药和中间体市场行情分析涓</a>
                    <span class="am-list-date">2018-07-26</span>
                </li>
                <li class="am-g am-list-item-dated">
                    <a href="/static/news3.html" target="_blank" class="am-list-item-hd ">本周杀虫剂原药市场行情分析</a>
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
                    <div class="am-infol-value" style="color: #838FA1;"id="bnxs">
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
                    <div class="am-infol-value"  id="bncb">
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
                    <div class="am-infol-value" id="bnml">
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
                    <div class="am-infol-value" id="bnjh">
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
                    <div class="am-infol-value" style="color: #838FA1;" id="snxs">
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
                    <div class="am-infol-value" id="sncb">
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
                    <div class="am-infol-value" id="snml">
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
                    <div class="am-infol-value" id="snjh">
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
       tjdata=JSON.parse(tjdata);
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
        //本年
        $('#bnxs').text(tjdata.bnxs);
        $('#bncb').text(tjdata.bncb);
        $('#bnml').text(tjdata.bnml);
        $('#bnjh').text(tjdata.bnjh);

        //上年
        $('#snxs').text(tjdata.snxs);
        $('#sncb').text(tjdata.sncb);
        $('#snml').text(tjdata.snml);
        $('#snjh').text(tjdata.snjh);

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
            if(i>3){
                break;
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
