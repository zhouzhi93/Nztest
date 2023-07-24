<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String f_zymc= (String) session.getAttribute("f_zymc");
    String f_shmc= (String) session.getAttribute("f_shmc");
    String ypd = (String) session.getAttribute("f_lxbm");
    String f_title=(String)session.getAttribute("f_title");
    String f_xTitle=(String)session.getAttribute("f_xTitle");
    String f_cTitle=(String)session.getAttribute("f_cTitle");
    String f_qyck=(String)session.getAttribute("f_qyck");
%>
<%--<!DOCTYPE html> &lt;%&ndash;<html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"&ndash;%&gt;--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1</title>
    <meta name="description" content="云平台客户端V1">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="apple-touch-icon-precomposed" href="/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="/assets/css/amazeui.min.css"/>
    <link rel="stylesheet" href="/assets/css/admin.css"/>
    <style>
        #rollText{font:12px /20px verdana;}
        #rollText div{
            width: 300px;
        }
        .cdkdsz{
            display: inline-block;
            width: 100px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
    </style>
</head>
<body>
<!--[if lte IE 9]>
<p class="browsehappy">你正在使用<strong>过时</strong>的浏览器，Amaze UI 暂不支持。 请 <a href="http://browsehappy.com/" target="_blank">升级浏览器</a>
    以获得更好的体验！</p>
<![endif]-->
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand">
        <strong id="f_title"></strong>&nbsp;&nbsp;&nbsp;&nbsp;
        <strong id="f_xTitle"></strong>&nbsp;&nbsp;&nbsp;&nbsp;
        <strong id="f_cTitle"></strong>
    </div>

    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}"><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>

    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">
        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
            <li>
                <div id="rollAD" style="height:40px; position:relative; width:300px; margin:5px auto;overflow:hidden;">
                    <div id="rollText" style="font-size:12px; line-height:20px;">
                        <%--<a href="http://www.lanrenzhijia.com" target="_parent">·flash+xml全屏整站图片查看效果(适合汽车类网站</a><br />--%>
                        <%--<a href="http://www.lanrenzhijia.com" target="_parent">·简洁实用的jquery图像栅格导航菜单</a><br />--%>
                        <%--<a href="http://www.lanrenzhijia.com" target="_parent">·jquery弹性手风琴(导航菜单)效果</a><br />--%>
                        <%--<a href="http://www.lanrenzhijia.com" target="_parent">·js四屏缩略图焦点幻灯片代码</a><br />--%>
                        <%--<a href="http://www.lanrenzhijia.com" target="_parent">·jquery自动感应多级下拉导航菜单</a><br />--%>
                        <%--<a href="http://www.lanrenzhijia.com" target="_parent">·jquery图片在线拼图效果</a><br />--%>
                        <%--<a href="http://www.lanrenzhijia.com" target="_parent">·带缩略图块状切换支持视频播放的幻灯片</a><br />--%>
                        <%--<a href="http://www.lanrenzhijia.com" target="_parent">·css3图片放大缩小切换幻灯片效果</a><br />--%>
                        <%--<a href="http://www.lanrenzhijia.com" target="_parent">·始终保持背景图片全屏(切换样式可控制)</a><br />--%>
                    </div>
                </div>
            </li>
            <%--<li><a href="javascript:;"><span class="am-icon-envelope-o"></span>收件箱 <span class="am-badge am-badge-warning">5</span></a></li>--%>
            <li >
                <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:void(0);">
                    <span id="onbjkc" class="am-icon-cog" onclick="loadBjkcOpen()">库存预警提醒</span>
                </a>
                <%--<ul class="am-dropdown-content">--%>
                <%--<li><a href="#"><span class="am-icon-user"></span>资料</a></li>--%>
                <%--<li><a href="#"><span class="am-icon-cog"></span>设置</a></li>--%>
                <%--<li><a href="#"><span class="am-icon-power-off"></span>退出</a></li>--%>
                <%--</ul>--%>
            </li>
            <li>
                <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:void(0);">
                    <span id="cdbj" class="am-icon-file-text-o" onclick="openCdbjdiv()">菜单编辑</span>
                </a>
            </li>
            <li class="am-dropdown" data-am-dropdown>
                <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:void(0);">
                    <span class="am-icon-users"><%=f_shmc%><%=f_zymc%></span>
                </a>
                <%--<ul class="am-dropdown-content">--%>
                    <%--<li><a href="#"><span class="am-icon-user"></span>资料</a></li>--%>
                    <%--<li><a href="#"><span class="am-icon-cog"></span>设置</a></li>--%>
                    <%--<li><a href="#"><span class="am-icon-power-off"></span>退出</a></li>--%>
                <%--</ul>--%>
            </li>
            <li class="am-hide-sm-only"><a href="javascript:;" id="admin-fullscreen"><span class="am-icon-arrows-alt"></span><span class="admin-fullText">开启全屏</span></a></li>
        </ul>
    </div>
</header>

<div class="am-cf admin-main">
    <!-- sidebar start -->
    <div class="admin-sidebar am-offcanvas" id="admin-offcanvas" style="width: 230px;">
        <div class="am-offcanvas-bar admin-offcanvas-bar">
            <ul class="am-list admin-sidebar-list">
                <li class="admin-parent am-hide" id="qx01">
                    <a class="am-cf"  data-am-collapse="{target: '#collapse-xiaoshou'}">
                        <span>
                            <img src="/images/title_xs.png" style="width:20px;height: 19px;">
                        </span>
                        <span id="qx01value"></span>
                        <span class="am-icon-angle-right am-fr am-margin-right"></span>
                    </a>
                    <ul class="am-list am-collapse admin-sidebar-sub" id="collapse-xiaoshou">
                        <li class="am-hide"  id="qx0101">
                            <a href="JavaScript:void(0)" onclick="checkTab(this,'/sales/salesbill')" class="am-cf">
                                <span class="am-icon-check"></span>
                                <span id="qx01001value" class="cdkdsz"></span>
                                <span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span>
                            </a>
                        </li>
                        <li class="am-hide" id="qx0102"><a href="JavaScript:void(0)" onclick="checkTab(this,'/sales/salesreturn')" class="am-cf"><span class="am-icon-check"></span><span id="qx01002value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx0103"><a href="JavaScript:void(0)" onclick="checkTab(this,'/sales/salesdetail')"><span class="am-icon-puzzle-piece"></span><span id="qx01003value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx0104"><a href="JavaScript:void(0)" onclick="checkTab(this,'/sales/xjnyxstj')"><span class="am-icon-puzzle-piece"></span><span id="qx01004value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                    </ul>
                </li>
                <li class="admin-parent am-hide" id="qx02">
                    <a class="am-cf" data-am-collapse="{target: '#collapse-jinhuo'}"><span><img src="/images/title_jh.png" style="width:20px;height: 19px;"></span><span id="qx02value"></span><span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                    <ul class="am-list am-collapse admin-sidebar-sub" id="collapse-jinhuo">
                        <li class="am-hide" id="qx0201"><a href="JavaScript:void(0)" onclick="checkTab(this,'/purchase/purchasebill')" class="am-cf"><span class="am-icon-check"></span><span id="qx02001value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx0202"><a href="JavaScript:void(0)" onclick="checkTab(this,'/purchase/purchasereturnbill')" class="am-cf"><span class="am-icon-check"></span><span id="qx02002value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx0203"><a href="JavaScript:void(0)" onclick="checkTab(this,'/purchase/purchasedetail')"><span class="am-icon-puzzle-piece"></span><span id="qx02003value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                    </ul>
                </li>
                <li class="admin-parent am-hide" id="qx09">
                    <a class="am-cf" data-am-collapse="{target: '#collapse-qiankuan'}"><span><img src="/images/title_xs.png" style="width:20px;height: 19px;"></span><span id="qx09value"></span><span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                    <ul class="am-list am-collapse admin-sidebar-sub" id="collapse-qiankuan">
                        <li class="am-hide" id="qx0901"><a href="JavaScript:void(0)" onclick="checkTab(this,'/arrearage/Prrearagedetail')" class="am-cf"><span class="am-icon-check"></span><span id="qx09001value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                    </ul>
                </li>
                <li class="admin-parent am-hide" id="qx03" >
                    <a class="am-cf"data-am-collapse="{target: '#collapse-sunyi'}"><span><img src="/images/title_sy.png" style="width:20px;height: 19px;"></span><span id="qx03value"></span><span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                    <ul class="am-list am-collapse admin-sidebar-sub " id="collapse-sunyi">
                        <li class="am-hide"  id="qx0301"><a href="JavaScript:void(0)" onclick="checkTab(this,'/gainsLosses/gainsLossesbill')" class="am-cf"><span class="am-icon-check"></span><span id="qx03001value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide"  id="qx0302"><a href="JavaScript:void(0)" onclick="checkTab(this,'/gainsLosses/gainsquery')"><span class="am-icon-puzzle-piece"></span><span id="qx03002value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>

                    </ul>
                </li>
                <li class="admin-parent am-hide" id="qx08">
                    <a class="am-cf" data-am-collapse="{target: '#collapse-diaobo'}"><span><img src="/images/title_db.png" style="width:20px;height: 19px;"></span><span id="qx08value"></span><span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                    <ul class="am-list am-collapse admin-sidebar-sub" id="collapse-diaobo">
                        <li class="am-hide" id="qx0801"><a href="JavaScript:void(0)" onclick="checkTab(this,'/allot/allocationBill')" class="am-cf"><span class="am-icon-check"></span><span id="qx08001value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx0802"><a href="JavaScript:void(0)" onclick="checkTab(this,'/allot/allocationBillquery')"><span class="am-icon-puzzle-piece"></span><span id="qx08002value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                    </ul>
                </li>
                <li class="admin-parent am-hide" id="qx00" >
                    <a class="am-cf"data-am-collapse="{target: '#collapse-shengchan'}"><span><img src="/images/title_sc.png" style="width:20px;height: 19px;"></span><span id="qx00value"></span><span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                    <ul class="am-list am-collapse admin-sidebar-sub " id="collapse-shengchan">
                        <li class="am-hide"  id="qx0001"><a href="JavaScript:void(0)" onclick="checkTab(this,'/production/pickupbill')" class="am-cf"><span class="am-icon-check"></span><span id="qx00001value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide"  id="qx0002"><a href="JavaScript:void(0)" onclick="checkTab(this,'/production/pickupdetail')"><span class="am-icon-puzzle-piece"></span><span id="qx00002value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide"  id="qx0003"><a href="JavaScript:void(0)" onclick="checkTab(this,'/production/productsalesbill')" class="am-cf"><span class="am-icon-check"></span><span id="qx00003value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide"  id="qx0004"><a href="JavaScript:void(0)" onclick="checkTab(this,'/production/productsalesdetail')"><span class="am-icon-puzzle-piece"></span><span id="qx00004value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                    </ul>
                </li>
                <li class="admin-parent am-hide" id="qx05">
                    <a class="am-cf" data-am-collapse="{target: '#collapse-taizhang'}"><span><img src="/images/title_tz.png" style="width:20px;height: 19px;"></span><span id="qx05value"></span><span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                    <ul class="am-list am-collapse admin-sidebar-sub" id="collapse-taizhang">
                        <li class="am-hide"  id="qx0501"><a href="JavaScript:void(0)" onclick="checkTab(this,'/parameters/salesparameter')" class="am-cf"><span class="am-icon-check"></span><span id="qx05001value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide"  id="qx0502"><a href="JavaScript:void(0)" onclick="checkTab(this,'/parameters/procurementparameter')" class="am-cf"><span class="am-icon-check"></span><span id="qx05002value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                    </ul>
                </li>
                <li class="admin-parent am-hide"  id="qx06">
                    <a class="am-cf" data-am-collapse="{target: '#collapse-kucun'}"><span><img src="/images/title_kc.png" style="width:20px;height: 19px;"></span><span id="qx06value"></span><span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                    <ul class="am-list am-collapse admin-sidebar-sub" id="collapse-kucun">
                        <li class="am-hide" id="qx0601"><a href="JavaScript:void(0)" onclick="checkTab(this,'/repertorys/gotoRepertory')" class="am-cf"><span class="am-icon-check"></span><span id="qx06001value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <%--库存特殊菜单div--%>
                        <div class="am-list" id="kctscdDiv" style="margin: 0">
                            <li class="am-hide" id="qx0602"><a href="JavaScript:void(0)" onclick="checkTab(this,'/repertorys/gotoYkcl')" class="am-cf"><span class="am-icon-check"></span><span id="qx06002value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                            <li class="am-hide" id="qx0603"><a href="JavaScript:void(0)" onclick="checkTab(this,'/repertorys/gotoCkbb')" class="am-cf"><span class="am-icon-check"></span><span id="qx06003value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        </div>
                    </ul>
                </li>
                <li class="admin-parent" id="qx07">
                    <a class="am-cf" data-am-collapse="{target: '#collapse-ziliao'}"><span><img src="/images/title_zl.png" style="width:20px;height: 19px;"></span><span id="qx07value"></span><span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                    <ul class="am-list am-collapse admin-sidebar-sub" id="collapse-ziliao">
                        <li class="am-hide" id="qx0701"><a href="JavaScript:void(0)" onclick="checkTab(this,'/stor/gotoStor')" class="am-cf"><span class="am-icon-check"></span><span id="qx07001value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx0702"><a href="JavaScript:void(0)" onclick="checkTab(this,'/clerk/gotoClerk')" class="am-cf"><span class="am-icon-check"></span><span id="qx07002value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx0703"><a href="JavaScript:void(0)" onclick="checkTab(this,'/commodity/gotoSplb')" class="am-cf"><span class="am-icon-check"></span><span id="qx07003value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx0704"><a href="JavaScript:void(0)" onclick="checkTab(this,'/commodity/gotoCommodity')" class="am-cf"><span class="am-icon-check"></span><span id="qx07004value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx0705"><a href="JavaScript:void(0)" onclick="checkTab(this,'/initialvalues/gotoSupplier')" class="am-cf"><span class="am-icon-check"></span><span id="qx07005value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx0706"><a href="JavaScript:void(0)" onclick="checkTab(this,'/initialvalues/gotoClient')" class="am-cf"><span class="am-icon-check"></span><span id="qx07006value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx0707"><a href="JavaScript:void(0)" onclick="checkTab(this,'/character/gotoJswh')" class="am-cf"><span class="am-icon-check"></span><span id="qx07007value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>

                        <%--基础档案特殊菜单div--%>
                        <div class="am-list" id="jcdatscdDiv" style="margin: 0">
                            <li class="am-hide" id="qx0711"><a href="JavaScript:void(0)" onclick="checkTab(this,'/initialvalues/gotoTjlxwh')" class="am-cf"><span class="am-icon-check"></span><span id="qx070011value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                            <li class="am-hide" id="qx0712"><a href="JavaScript:void(0)" onclick="checkTab(this,'/initialvalues/gotoTjmxwh')" class="am-cf"><span class="am-icon-check"></span><span id="qx070012value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                            <li class="am-hide" id="qx0713"><a href="JavaScript:void(0)" onclick="checkTab(this,'/initialvalues/gotoBtbzsz')" class="am-cf"><span class="am-icon-check"></span><span id="qx070013value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                            <li class="am-hide" id="qx0714"><a href="JavaScript:void(0)" onclick="checkTab(this,'/initialvalues/gotoJyjsz')" class="am-cf"><span class="am-icon-check"></span><span id="qx070014value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        </div>

                        <li class="am-hide" id="qx0708"><a href="JavaScript:void(0)" onclick="checkTab(this,'/initialvalues/gotoCssz')" class="am-cf"><span class="am-icon-check"></span><span id="qx07008value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx0709"><a href="JavaScript:void(0)" onclick="checkTab(this,'/initialvalues/gotoCkda')" class="am-cf"><span class="am-icon-check"></span><span id="qx07009value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx0710"><a href="JavaScript:void(0)" onclick="checkTab(this,'/initialvalues/gotoGsxx')" class="am-cf"><span class="am-icon-check"></span><span id="qx070010value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                    </ul>
                </li>
                <li class="admin-parent" id="qx10">
                    <a class="am-cf" data-am-collapse="{target: '#collapse-baozhuangwu'}"><span><img src="/images/title_bzw.png" style="width:20px;height: 19px;"></span><span id="qx010value"></span><span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                    <ul class="am-list am-collapse admin-sidebar-sub" id="collapse-baozhuangwu">
                        <li class="am-hide" id="qx1001"><a href="JavaScript:void(0)" onclick="checkTab(this,'/packing/packingspda')" class="am-cf"><span class="am-icon-check"></span><span id="qx010001value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx1002"><a href="JavaScript:void(0)" onclick="checkTab(this,'/packing/packManageRecord')" class="am-cf"><span class="am-icon-check"></span><span id="qx010002value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx1003"><a href="JavaScript:void(0)" onclick="checkTab(this,'/packing/packingdetail')"><span class="am-icon-puzzle-piece"></span><span id="qx010003value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx1004"><a href="JavaScript:void(0)" onclick="checkTab(this,'/packing/bzwbrd')"><span class="am-icon-check"></span><span id="qx010004value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx1005"><a href="JavaScript:void(0)" onclick="checkTab(this,'/packing/bzwbrcx')"><span class="am-icon-puzzle-piece"></span><span id="qx010005value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx1006"><a href="JavaScript:void(0)" onclick="checkTab(this,'/packing/bzwbcd')"><span class="am-icon-check"></span><span id="qx010006value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx1007"><a href="JavaScript:void(0)" onclick="checkTab(this,'/packing/bzwbccx')"><span class="am-icon-puzzle-piece"></span><span id="qx010007value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                    </ul>
                </li>
                <%--信息管理，暂时不用--%>
                <%--<li class="admin-parent am-hide" id="qx11">
                    <a class="am-cf"  data-am-collapse="{target: '#collapse-message'}">
                        <span><img src="/images/title_xs.png" style="width:20px;height: 19px;"></span>
                        <span id="qx011value"></span>
                        <span class="am-icon-angle-right am-fr am-margin-right"></span>
                    </a>
                    <ul class="am-list am-collapse admin-sidebar-sub" id="collapse-message">
                        <li class="am-hide"  id="qx1101">
                            <a href="JavaScript:void(0)" onclick="checkTab(this,'/message/types')" class="am-cf">
                                <span class="am-icon-puzzle-piece"></span>
                                <span id="qx011001value"></span>
                                <span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span>
                            </a>
                        </li>
                        <li class="am-hide" id="qx1102">
                            <a href="JavaScript:void(0)" onclick="checkTab(this,'/message/news')" class="am-cf">
                                <span class="am-icon-check"></span><span id="qx011002value"></span>
                                <span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span>
                            </a>
                        </li>
                    </ul>
                </li>--%>
                <li class="admin-parent" id="qx12">
                    <a class="am-cf" data-am-collapse="{target: '#collapse-baobiao'}"><span><img src="/images/title_bzw.png" style="width:20px;height: 19px;"></span><span id="qx012value"></span><span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                    <ul class="am-list am-collapse admin-sidebar-sub" id="collapse-baobiao">
                        <li class="am-hide" id="qx1201"><a href="JavaScript:void(0)" onclick="checkTab(this,'/report/zhjxccx')" class="am-cf"><span class="am-icon-check"></span><span id="qx012001value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <li class="am-hide" id="qx1202"><a href="JavaScript:void(0)" onclick="checkTab(this,'/report/crkcx')" class="am-cf"><span class="am-icon-check"></span><span id="qx012002value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        <%--销售季报表div--%>
                        <div class="am-list" id="xsjbbDiv" style="margin: 0">
                            <li class="am-hide" id="qx1203"><a href="JavaScript:void(0)" onclick="checkTab(this,'/report/gotoXsjbb')" class="am-cf"><span class="am-icon-check"></span><span id="qx012003value" class="cdkdsz"></span><span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                        </div>
                    </ul>
                </li>
                <li><a href="javascript:void (0)" onclick="signout()"><span><img src="/images/title_zx.png" style="width:20px;height: 19px;"></span><span>&nbsp;&nbsp;&nbsp;注销</span></a></li>
            </ul>
        </div>
    </div>
    <!-- sidebar end -->

    <!-- content start -->
    <div class="admin-content" style="overflow-y: hidden;">
        <div class="admin-content-body">
        <div class="am-tabs"  data-am-tabs="{noSwipe: 1}" id="doc-tab-demo-1">
            <ul class="am-tabs-nav am-nav am-nav-tabs">
                <li class="am-active"><a href="javascript: void(0)">首页</a></li>
            </ul>
            <div class="am-tabs-bd">
                <div class="am-tab-panel am-active">
                    <iframe scrolling="yes"  id="saleiframe"  frameborder="0" src="/htmlPage/index"  style="width:100%;height: 90%"></iframe>
                </div>
            </div>
        </div>
        </div>
        <div class="am-modal am-modal-alert" tabindex="-1" id="alertdlg">
            <div class="am-modal-dialog">
                <div class="am-modal-hd">提示</div>
                <div class="am-modal-bd" id="alertcontent">

                </div>
                <div class="am-modal-footer">
                    <span class="am-modal-btn" id="okbtn">确定</span>
                </div>
            </div>
        </div>
        <div class="am-modal am-modal-alert" tabindex="-1" id="nesalertdlg">
            <div class="am-modal-dialog">
                <div class="am-modal-hd">消息详情</div>
                <div class="am-modal-bd" id="newscontent" style="border: 1px dashed #1babff;margin: 5px 20px 5px 20px;font-weight: 500;font-size: 2.2rem;">
                </div>
                <div class="am-modal-footer">
                    <span class="am-modal-btn" id="newsokbtn">确定</span>
                </div>
            </div>
        </div>
        <%--<footer class="admin-content-footer">--%>
    <%--<hr>--%>
    <%--<p class="am-padding-left">© 2014 AllMobilize, Inc. Licensed under MIT license.</p>--%>
    <%--</footer>--%>
</div>

    <!--报警库存div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseBjkcdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">报警库存
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px; height: 400px;" class="am-container am-scrollable-vertical">
                    <table class="am-table am-table-bordered am-table-centered" >
                        <thead>
                            <tr>
                                <th width="15%" class="am-text-middle">网点名称</th>
                                <th class="am-text-middle xsqxdix">登记号</th>
                                <th class="am-text-middle">商品名称</th>
                                <th class="am-text-middle">产品规格</th>
                                <th class="am-text-middle">计量单位</th>
                                <th class="am-text-middle">报警库存</th>
                                <th class="am-text-middle">当前库存</th>
                                <th class="am-text-middle">供货商</th>
                            </tr>
                        </thead>
                        <tbody id="bjkctable">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%--菜单编辑div--%>
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="cdbjdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">菜单编辑
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="cdbjform">
                        <div class="am-form-group">
                            <label for="yjcd" class="am-u-sm-4 am-form-label" style="text-align:left;">一级菜单（必选）</label>
                            <div class="am-u-sm-8">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select data-am-selected id="yjcd">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="ejcd" class="am-u-sm-4 am-form-label" style="text-align:left;">二级菜单（可选）</label>
                            <div class="am-u-sm-8">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select data-am-selected id="ejcd">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="newcd" class="am-u-sm-4 am-form-label" style="text-align:left;">修改后的名称</label>
                            <div class="am-u-sm-8">
                                <input type="tel" class="am-form-field am-input-sm am-radius" id="newcd" required placeholder="菜单名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="submit" id="savecdbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closecdbjdiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script src="/assets/pageJs/index.js"></script>
<script src="/assets/js/app.js"></script>
<script>
    var qyck = <%=f_qyck%>;
    var yjqxList = null;

    queryEjqx();
    queryTscd();

    $(function(){
        //notice();
        var bjkclist = null;
        var timer = null;
        var qxlist='${zyqxlist}';
        qxlist=JSON.parse(qxlist);
        for(var i=0;i<qxlist.length;i++){
            idname="qx"+qxlist[i]["F_QXBM"];
            $('#'+idname.substr(0,4)).removeClass('am-hide');//给父菜单显示
            $('#'+idname).removeClass('am-hide');
        }
        var msgList='${msgList}';
        var msgHtml="";
        msgList=JSON.parse(msgList);
        for(var j=0;j<msgList.length;j++){
            msgHtml+="<a href=\"javascript:void(0);\" onclick=\"showNews('"+msgList[j].F_XXNR+"')\">"+msgList[j].F_TITLE+"</a><br />"
        }
        $('#rollText').html(msgHtml);
        var textDiv = document.getElementById("rollText");
        var textList = textDiv.getElementsByTagName("a");
        if(textList.length > 2){
            var textDat = textDiv.innerHTML;
            var br = textDat.toLowerCase().indexOf("<br",textDat.toLowerCase().indexOf("<br")+3);
            //var textUp2 = textDat.substr(0,br);
            textDiv.innerHTML = textDat+textDat+textDat.substr(0,br);
            textDiv.style.cssText = "position:absolute; top:0";
            var textDatH = textDiv.offsetHeight;MaxRoll();
        }
        var minTime,maxTime,divTop,newTop=0;
        function MinRoll(){
            newTop++;
            if(newTop<=divTop+40){
                textDiv.style.top = "-" + newTop + "px";
            }else{
                clearInterval(minTime);
                maxTime = setTimeout(MaxRoll,2000);
            }
        }
        function MaxRoll(){
            divTop = Math.abs(parseInt(textDiv.style.top));
            if(divTop>=0 && divTop<textDatH-40){
                minTime = setInterval(MinRoll,1);
            }else{
                textDiv.style.top = 0;divTop = 0;newTop=0;MaxRoll();
            }
        }

        $('#okbtn').click(function () {
            /*$.ajax({
                url: "/signout",
                type: "post",
                async: false,
                success: function (data) {
                    if(data=="ok"){
                        alertMsg("注销成功！")
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
                    var sessionstatus = XMLHttpRequest.getResponseHeader("sessionstatus");
                    if (sessionstatus == "logintimeout") {
                        alertMsg("登录超时，请重新登录！");
                        $('#okbtn').click(function () {
                            var win = window;
                            while (win != win.top){
                                win = win.top;
                            }
                            win.location = "/login";
                        });
                    }else{
                        alertMsg("请求异常");
                    }
                    $("#savaBtn").button('reset');
                }
            });*/
        });

        if('<%=ypd%>' != '1' && "<%=ypd%>" != '0'){
            $('.xsqxdix').hide();
        }

        $("#f_title").html("<%=f_title%>");
        $("#f_xTitle").html("<%=f_xTitle%>");
        $("#f_cTitle").html("<%=f_cTitle%>");
    });
    
    function loadBjkcOpen() {
        event.stopPropagation();
        $('#chooseBjkcdiv').modal({
            closeViaDimmer: false,
            width:980,
            height:500
        });
        loadBjkc();
        $('#chooseBjkcdiv').modal('open');
    }

    function signout() {
        $.ajax({
            url: "/signout",
            type: "post",
            async: false,
            success: function (data) {
                if(data=="ok"){
                    alertMsg("注销成功！")
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
                var sessionstatus = XMLHttpRequest.getResponseHeader("sessionstatus");
                if (sessionstatus == "logintimeout") {
                    alertMsg("登录超时，请重新登录！");
                    $('#okbtn').click(function () {
                        var win = window;
                        while (win != win.top){
                            win = win.top;
                        }
                        win.location = "/login";
                    });
                }else{
                    alertMsg("请求异常");
                }
                $("#savaBtn").button('reset');
            }
        });
    }
    function loadBjkc(){
        if(bjkclist != null){
            var spdalist = bjkclist;
            $('#bjkctable').html("");
            if(spdalist.length>0) {
                for(var i=0;i<spdalist.length;i++){
                    var spjson = spdalist[i];
                    var rowhtml="";
                    /*if(spjson.F_BJKC != undefined && spjson.F_BJKC != '' && parseFloat(spjson.F_BJKC) != 0 ){
                        if(parseFloat(spjson.F_BJKC) > parseFloat(spjson.F_KCSL)){
                            rowhtml+="<tr sptm='"+spjson.F_SPTM+"' class='am-danger'>"
                        }else{
                            rowhtml+="<tr sptm='"+spjson.F_SPTM+"'>"
                        }
                    }else{
                        rowhtml+="<tr sptm='"+spjson.F_SPTM+"'>"
                    }*/
                    rowhtml+="<tr sptm='"+spjson.F_SPTM+"'>";
                    rowhtml+="<td class=\"am-text-middle am-td-spmc\" title='"+spjson.F_BMMC+"'>"+spjson.F_BMMC+"</td>"
                    if('<%=ypd%>' == '1' || "<%=ypd%>" == '0'){
                        rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_YPZJH+"'>"+spjson.F_YPZJH+"</td>"
                    }
                    rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_SPMC+"'>"+spjson.F_SPMC+"</td>"
                    rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_GGXH+"'>"+spjson.F_GGXH+"</td>"
                    rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_JLDW+"'>"+spjson.F_JLDW+"</td>"
                    rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_BJKC+"'>"+spjson.F_BJKC+"</td>"
                    rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_KCSL+"'>"+spjson.F_KCSL+"</td>"
                    rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_GYSMC+"'>"+spjson.F_GYSMC+"</td>"
                    rowhtml+="</tr>";
                    $('#bjkctable').prepend(rowhtml);
                }
            }
            clearTimeout(timer);
            $('#onbjkc').css("color","White");
        }
/*        $.ajax({
            url: "/repertorys/getKctzsBj",
            type: "post",
            async: false,
            data: {},
            success: function (data) {
                var res = JSON.parse(data);

            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });*/
    }
    function alertMsg(msg){
        $('#alertcontent').text(msg);
        $('#alertdlg').modal('open');
        $('#alertdlg').css("z-index","1120");
    }
    function alertLoad(msg){
        loadcd();
        location.reload(true);
        $('#alertcontent').text(msg);
        $('#alertdlg').modal('open');
        $('#alertdlg').css("z-index","1120");
    }
    function showNews(msg){
        $('#newscontent').text(msg);
        $('#nesalertdlg').modal('open');
    }
    var flag = false;

    function notice(){
        $.ajax({
            url: "/repertorys/getKctzsBj",
            type: "post",
            async: false,
            data: {},
            success: function (data) {
                var res = JSON.parse(data);
                if(res.length>0){
                    bjkclist = res;
                    colorred();
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    }

    function colorred(){
        var notice = document.getElementById('onbjkc');
        if(!flag){
            notice.style.color = "red";
            flag = true;
        }else{
            notice.style.color = "#000";
            flag = false;
        }
        timer = setTimeout("colorred()",500);
    }

    //查询所有一级权限
    function queryYjqx() {
        var qxyjid = "";
        $.ajax({
            url: "/repertorys/getQxxx",
            type: "post",
            async: false,
            data: {f_JB:'1',f_Qxbm:''},
            success: function (data) {
                var dataJson = JSON.parse(data);
                yjqxList = dataJson;
                for (var i = 0; i < dataJson.length; i++){
                    qxyjid = "#qx0"+i+"value";
                    $(qxyjid).html("&nbsp;&nbsp;&nbsp;"+dataJson[i].F_QXMC);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    }

    //查询所有二级权限
    function queryEjqx() {
        queryYjqx();
        var qxejid = "";
        for (var i = 0;i < yjqxList.length; i++){
            var f_Qxbm = yjqxList[i].F_QXBM;
            $.ajax({
                url: "/repertorys/getQxxx",
                type: "post",
                async: false,
                data: {f_JB:'2',f_Qxbm:f_Qxbm},
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    for (var j = 0; j < dataJson.length; j++){
                        qxejid = "#qx0"+i+"00"+(j+1)+"value";
                        $(qxejid).html(dataJson[j].F_QXMC);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }
    }

    //展示特殊菜单
    function queryTscd() {
        if ("<%=ypd%>" == "12" || "<%=ypd%>" == "13" || "<%=ypd%>" == "14"){
            $("#jcdatscdDiv").show();

            $("#xsjbbDiv").show();
        }

        if (qyck == 1){
            $("#kctscdDiv").show();
        }
    }

    //点击菜单编辑弹出div
    function openCdbjdiv(){
        $('#yjcd').val("");
        $('#yjcd').trigger('changed.selected.amui');
        $('#ejcd').val("");
        $('#ejcd').trigger('changed.selected.amui');
        $('#newcd').val("");

        $('#cdbjdiv').modal({
            closeViaDimmer: false,
            width:580,
            height:300
        });

        $('#cdbjdiv').modal('open');
        $('.am-dimmer').css("z-index","1111");
        $('#cdbjdiv').css("z-index","1119");

        loadcd();
        savecd();
    }

    //加载菜单
    function loadcd() {
        var yjcdSelected = "<option>请选择</option>";
        for (var i = 0;i < yjqxList.length; i++){
            yjcdSelected += "<option value='"+yjqxList[i].F_QXBM+"'>"+yjqxList[i].F_QXMC+"</option>";
        }
        $('#yjcd').html(yjcdSelected);

        $('#yjcd').change(function (){
            var yjcdValue = $('#yjcd').val();
            $.ajax({
                url: "/repertorys/getQxxx",
                type: "post",
                async: false,
                data: {f_JB:'2',f_Qxbm:yjcdValue},
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    var ejcdSelected = "<option>请选择</option>";
                    for (var i = 0;i < dataJson.length; i++){
                        ejcdSelected += "<option value='"+dataJson[i].F_QXBM+"'>"+dataJson[i].F_QXMC+"</option>";
                    }
                    $('#ejcd').html(ejcdSelected);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        });
    }

    //保存修改菜单
    function savecd() {
        $('#cdbjform').validator({
            H5validation: false,
            submit: function () {
                var formValidity = this.isFormValid();
                if (formValidity) {
                    try {
                        var $subbtn = $("#savecdbtn");
                        $subbtn.button('loading');
                        var yjcd = $("#yjcd").val();
                        var ejcd = $("#ejcd").val();
                        var newcd = $("#newcd").val();
                        if(yjcd == '' || yjcd == null || yjcd == undefined){
                            alertMsg("请选择一级菜单！");
                            $('#cdbjdiv').modal('open');
                            return;
                        }
                        if(newcd == '' || newcd == null || newcd == undefined){
                            alertMsg("请输入修改后的菜单名称！");
                            $('#cdbjdiv').modal('open');
                            return;
                        }
                        setTimeout(function () {
                            $.ajax({
                                url: "/repertorys/savecd",
                                type: "post",
                                async: false,
                                data: { yjcd: yjcd,ejcd:ejcd, newcd: newcd},
                                success: function (data, textStatus) {
                                    if(data == "ok"){
                                        alertLoad("保存成功！");
                                    }else if (data == "405"){
                                        alertMsg("请联系管理员修改菜单！");
                                    } else{
                                        alertMsg(data);
                                    }
                                    $subbtn.button('reset');
                                    $('#cdbjdiv').modal('close');
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    alert(errorThrown + "||" + textStatus);
                                    $subbtn.button('reset');
                                }
                            });
                        }, 10);
                    }
                    catch (e) {
                        alert(e.name);
                    }
                } else {
                    // 验证失败的逻辑
                }
                //阻止原生form提交
                return false;
            }
        });

        //关闭还原遮罩蒙板z-index
        $('#updateZydiv').on('closed.modal.amui', function() {
            $('.am-dimmer').css("z-index","1100");
        });
    }

    //关闭菜单编辑div
    function closecdbjdiv(){
        $('#cdbjdiv').modal('close');
    }
</script>
</body>
</html>

