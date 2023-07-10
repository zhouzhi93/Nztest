<%@ page import="org.springframework.boot.web.servlet.server.Session" %><%--
  Created by IntelliJ IDEA.
  User: yxs
  Date: 2018/6/15
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String f_zymc= (String) session.getAttribute("f_zymc");
%>
<%--<!DOCTYPE html> &lt;%&ndash;<html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"&ndash;%&gt;--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>盈放云平台管理平台</title>
    <meta name="description" content="盈放云平台管理平台">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="apple-touch-icon-precomposed" href="/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="/assets/css/amazeui.min.css"/>
    <link rel="stylesheet" href="/assets/css/admin.css"/>
</head>
<body>
<!--[if lte IE 9]>
<p class="browsehappy">你正在使用<strong>过时</strong>的浏览器，Amaze UI 暂不支持。 请 <a href="http://browsehappy.com/" target="_blank">升级浏览器</a>
    以获得更好的体验！</p>
<![endif]-->
<header class="am-topbar am-topbar-inverse admin-header">
    <div class="am-topbar-brand">
        <strong>盈放云平台管理平台</strong>
    </div>

    <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}"><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>

    <div class="am-collapse am-topbar-collapse" id="topbar-collapse">

        <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
            <%--<li><a href="javascript:;"><span class="am-icon-envelope-o"></span>收件箱 <span class="am-badge am-badge-warning">5</span></a></li>--%>
            <li class="am-dropdown" data-am-dropdown>
                <a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:void(0);">
                    <span class="am-icon-users"><%=f_zymc%></span>
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
    <div class="admin-sidebar am-offcanvas" id="admin-offcanvas">
        <div class="am-offcanvas-bar admin-offcanvas-bar">
            <ul class="am-list admin-sidebar-list">
                <li class="admin-parent">
                    <a class="am-cf" data-am-collapse="{target: '#collapse-xiaoshou'}"><span class="am-icon-file"></span>&nbsp;&nbsp;&nbsp;&nbsp;人员管理 <span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                    <ul class="am-list am-collapse admin-sidebar-sub" id="collapse-xiaoshou">
                        <li><a href="JavaScript:void(0)" onclick="checkTab(this,'/adminClerk/gotoClerk')" class="am-cf"><span class="am-icon-check"></span>人员管理<span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                    </ul>
                </li>
                <li class="admin-parent">
                    <a class="am-cf" data-am-collapse="{target: '#collapse-jinhuo'}"><span class="am-icon-file"></span>&nbsp;&nbsp;&nbsp;&nbsp;商户管理<span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                    <ul class="am-list am-collapse admin-sidebar-sub" id="collapse-jinhuo">
                        <li><a href="JavaScript:void(0)" onclick="checkTab(this,'/approve/gotoApprove')" class="am-cf"><span class="am-icon-check"></span>商户审批<span class="am-badge am-badge-secondary am-margin-right am-fr"></span></a></li>
                        <%--<li><a href="JavaScript:void(0)" onclick="checkTab(this,'/approve/gotoQuery')" class="am-cf"><span class="am-icon-check"></span>商户查询<span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>--%>
                    </ul>
                </li>
                <li class="admin-parent">
                    <a class="am-cf" data-am-collapse="{target: '#collapse-sunyi'}"><span class="am-icon-file"></span>&nbsp;&nbsp;&nbsp;&nbsp;监管人员设置 <span class="am-icon-angle-right am-fr am-margin-right"></span></a>
                    <ul class="am-list am-collapse admin-sidebar-sub " id="collapse-sunyi">
                        <li><a href="JavaScript:void(0)" onclick="checkTab(this,'/JGClerk/gotoClerk')" class="am-cf"><span class="am-icon-check"></span>监管人员设置<span class="am-icon-star am-fr am-margin-right admin-icon-yellow"></span></a></li>
                    </ul>
                </li>
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
                    <%--<iframe scrolling="yes"  id="saleiframe"  frameborder="0" src="/htmlPage/index"  style="width:100%;height: 90%"></iframe>--%>
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
                    <span class="am-modal-btn">确定</span>
                </div>
            </div>
        </div>
        <%--<footer class="admin-content-footer">--%>
    <%--<hr>--%>
    <%--<p class="am-padding-left">© 2014 AllMobilize, Inc. Licensed under MIT license.</p>--%>
    <%--</footer>--%>
</div>
</div>
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script src="/assets/pageJs/index.js"></script>
<script src="/assets/js/app.js"></script>
</body>
</html>

