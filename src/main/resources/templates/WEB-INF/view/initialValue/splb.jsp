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
    <title>云平台客户端V1-商品类别管理</title>
    <meta name="description" content="云平台客户端V1-商品类别管理">
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
            max-width:100%;
        }
        label{
            font-weight: 500;
            font-size:1.4rem;
        }
        .am-popup{
            z-index: 1200;
        }
    </style>
</head>
<body>
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-12" id="xsdiv">
            <div class="header">
                <div class="am-g">
                    <h1>商品类别管理</h1>
                </div>
            </div>
        </div>
        <div class="am-container">
            <div class="am-text-left" style="padding-left: 0;padding-right: 0;">
                <div class="am-dropdown" data-am-dropdown>
                    <button id="zjul" class="am-btn am-btn-primary am-btn-xs am-radius am-dropdown-toggle" data-am-dropdown-toggle>增加<span class="am-icon-caret-down"></span></button>
                    <ul class="am-dropdown-content am-btn-xs">
                        <li onclick="addTj()"><a href="#">增加同级</a></li>
                        <li onclick="addZj()"><a href="#">增加子级</a></li>
                    </ul>
                </div>
                <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" onclick="savelb()" id="savesplb">保存</button>
            </div>
        </div>
        <div class="am-container">
            <div class="am-container am-u-sm-3 am-u-md-3 am-scrollable-vertical" id="chooseSplbdiv" style="border: 1px solid #DEDEDE;min-height: 500px;">
                <iframe id="splbTree" height="100%" width="100%" src="/commodity/gotoSplbTree">

                </iframe>
                <%--<ul class="am-tree" id="firstTree">
                    <li class="am-tree-branch am-hide" data-template="treebranch">
                        <div class="am-tree-branch-header">
                            <button class="am-tree-branch-name">
                                <span class="am-tree-icon am-tree-icon-folder"></span>
                                <span class="am-tree-label"></span>
                            </button>
                        </div>
                        <ul class="am-tree-branch-children"></ul>
                        <div class="am-tree-loader"><span class="am-icon-spin am-icon-spinner"></span></div>
                    </li>
                    <li class="am-tree-item am-hide" data-template="treeitem">
                        <button class="am-tree-item-name">
                            <span class="am-tree-icon am-tree-icon-item"></span>
                            <span class="am-tree-label"></span>
                        </button>
                    </li>
                </ul>--%>
            </div>
            <div class="am-container am-u-sm-9 am-u-md-9">
                <div class="am-modal-bd" style="min-height: 500px;border: 1px solid #DEDEDE;">
                    <div style="margin-top: 10px;" class="am-container">
                        <form class="am-form am-form-horizontal" id="addsplbform">
                            <div class="am-form-group">
                                <label for="f_splbbm" class="am-u-sm-2 am-form-label">类别编码</label>
                                <div class="am-u-sm-9">
                                    <input type="text" disabled="disabled" class="am-form-field am-input-sm am-radius" id="f_splbbm" required placeholder="类别编码">
                                </div>
                                <div class="am-u-sm-end"></div>
                            </div>
                            <div class="am-form-group">
                                <label for="f_splbmc" class="am-u-sm-2 am-form-label">类别名称</label>
                                <div class="am-u-sm-9">
                                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_splbmc" required placeholder="类别名称">
                                </div>
                                <div class="am-u-sm-end"></div>
                            </div>
                            <div class="am-form-group">
                                <label for="f_jb" class="am-u-sm-2 am-form-label">级别</label>
                                <div class="am-u-sm-9">
                                    <input type="number" disabled="disabled" class="am-form-field am-input-sm am-radius" id="f_jb" required placeholder="级别">
                                </div>
                                <div class="am-u-sm-end"></div>
                            </div>
                            <div class="am-form-group">
                                <label for="f_bz" class="am-u-sm-2 am-form-label">备注</label>
                                <div class="am-u-sm-9">
                                    <textarea  class="am-form-field am-input-sm am-radius" id="f_bz" placeholder="备注"></textarea>
                                </div>
                                <div class="am-u-sm-end"></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
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
        var loadJson = null;
        var tempsplbbm = null;
        var tempJb = null;
        var splbJson = null;

        //加载客户
        function loadSplbxx(splbbm){
            $.ajax({
                url: "/commodity/getSplbda",
                type: "post",
                async: false,
                data: {splbbm:splbbm, timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    loadJson = dataJson;
                    var result = dataJson[0];
                    $("#f_splbbm").val(result.F_SPLBBM);
                    $("#f_splbmc").val(result.F_SPLBMC);
                    $("#f_jb").val(result.F_JB);
                    $("#f_bz").val(result.F_MEMO);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        };
        
        function savelb() {
            var splbbm = $("#f_splbbm").val();
            var splbmc = $("#f_splbmc").val();
            var jb = $("#f_jb").val();
            var bz = $("#f_bz").val();

            $.ajax({
                url: "/commodity/saveSplbda",
                type: "post",
                async: false,
                data: {splbbm:splbbm,splbmc:splbmc,jb:jb,bz:bz, timeer: new Date() },
                success: function (data) {
                    if(data == "ok"){
                        alertMsg("保存成功！");
                    }
                    $("#f_splbbm").val("");
                    $("#f_splbmc").val("");
                    $("#f_jb").val("");
                    $("#f_bz").val("");
                    document.getElementById('splbTree').contentWindow.location.reload(true);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }

        function addTj(){
            var splbbm = tempsplbbm;
            var jb = tempJb;
            if(jb == '0' || jb == '' || jb == null){
                splbbm = "";
                jb = 0;
            }else{
                splbbm = splbbm.substring(0,splbbm.length-3);
            }
            $.ajax({
                url: "/commodity/getMaxsplb",
                type: "post",
                async: false,
                data: {splbbm:splbbm,jb:jb, timeer: new Date() },
                success: function (data) {
                    $("#f_splbbm").val(data);
                    $("#f_splbmc").val("");
                    $("#f_bz").val("");
                    $("#f_jb").val(jb);
                    $("#zjul").click();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        function addZj(){
            var splbbm = tempsplbbm;
            if(splbbm == '' || splbbm == null){
                alert("请先选择类别！！");
                return;
            }
            var jb = tempJb;
            jb = parseInt(jb)+1;
            $.ajax({
                url: "/commodity/getMaxsplb",
                type: "post",
                async: false,
                data: {splbbm:splbbm,jb:jb, timeer: new Date() },
                success: function (data) {
                    $("#f_splbbm").val(data);
                    $("#f_splbmc").val("");
                    $("#f_bz").val("");
                    $("#f_jb").val(jb);
                    $("#zjul").click();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        function alertMsg(msg){
            $('#alertcontent ',parent.document).text(msg);
            $('#alertdlg',parent.document).modal('open');
        }

    </script>
</body>
</html>
