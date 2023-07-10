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
    <title>云平台客户端V1-商品类别树</title>
    <meta name="description" content="云平台客户端V1-商品类别树">
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
        <div class="am-container">
            <ul class="am-tree" id="firstTree">
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
            </ul>
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
        var splbJson = null;
        $(function(){
            loadsplb();

            $('#firstTree').on('selected.tree.amui', function (event, data) {
                parent.tempsplbbm = data.target.id;
                parent.tempJb = (data.target.id.length/2);
                window.parent.loadSplbxx(data.target.id);
            });

            $('#firstTree').on('deselected.tree.amui', function (event, data) {
                parent.tempsplbbm = data.target.id;
                parent.tempJb = (data.target.id.length/2);
                window.parent.loadSplbxx(data.target.id);
            });

            $('#firstTree').on('disclosedFolder.tree.amui', function (event, data) {
                parent.tempsplbbm = data.id;
                parent.tempJb = (data.id.length/2);
                window.parent.loadSplbxx(data.id);
            });

            $('#firstTree').on('closed.tree.amui', function (event, data) {
                parent.tempsplbbm = data.id;
                parent.tempJb = (data.id.length/2);
                window.parent.loadSplbxx(data.id);
            });

        });


        function loadsplb(){
            $.ajax({
                url: "/commodity/getSplbda",
                type: "post",
                async: false,
                data: {splbbm:'', timeer: new Date() },
                success: function (data) {
                    splbJson = data;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });


            $('#firstTree').tree({
                dataSource: function(options, callback) {
                    // 模拟异步加载
                    setTimeout(function() {
                        var json = JSON.parse(splbJson);
                        callback({data: options.products || json});
                    }, 400);
                },
                multiSelect: false,
                cacheItems: false,
                folderSelect: false
            });
        }

        function alertMsg(msg){
            $('#alertcontent ',parent.document).text(msg);
            $('#alertdlg',parent.document).modal('open');
        }

    </script>
</body>
</html>
