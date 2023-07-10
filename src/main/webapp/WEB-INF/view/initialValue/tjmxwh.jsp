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
    <title>云平台客户端V1-统计明细维护</title>
    <meta name="description" content="云平台客户端V1-统计明细维护">
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
                <h1>统计明细维护</h1>
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
            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="saveTjmx()" id="savesplb">保存</button>
            <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" onclick="deleteTjmx()" id="deleteTjmx">删除</button>
        </div>
    </div>
    <div class="am-container">
        <%--左侧三级列表--%>
        <div class="am-container am-u-sm-4 am-u-md-4 am-scrollable-vertical" id="chooseSplbdiv" style="border: 1px solid #DEDEDE;min-height: 500px;">
            <iframe id="tjmxwhTree" height="100%" width="100%" src="/initialvalues/gotoTjmxwhTree">

            </iframe>
        </div>
        <%--右侧显示列表--%>
        <div class="am-container am-u-sm-8 am-u-md-8">
            <div class="am-modal-bd" style="min-height: 500px;border: 1px solid #DEDEDE;">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal">
                        <div class="am-form-group">
                            <label for="f_flbm" class="am-u-sm-2 am-form-label">编码</label>
                            <div class="am-u-sm-9">
                                <input type="text" disabled="disabled" class="am-form-field am-input-sm am-radius" id="f_flbm" required placeholder="编码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_flmc" class="am-u-sm-2 am-form-label">名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_flmc" required placeholder="名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_flmx" class="am-u-sm-2 am-form-label">明细</label>
                            <div class="am-u-sm-9">
                                <select data-am-selected="{btnWidth: '100%'}" id="f_flmx">
                                </select>
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
                            <label for="f_mj" class="am-u-sm-2 am-form-label">末级</label>
                            <div class="am-u-sm-9">
                                <input type="text" disabled="disabled" class="am-form-field am-input-sm am-radius" id="f_mj" required placeholder="末级">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group" id="dwmcdiv">
                            <label for="f_dwmc" class="am-u-sm-2 am-form-label">单位</label>
                            <div class="am-u-sm-9">
                                <input type="text" disabled="disabled" class="am-form-field am-input-sm am-radius" id="f_dwmc" required placeholder="单位">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!--删除明细div-->
<div class="am-modal am-modal-confirm" tabindex="-1" id="deleteMxdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-bd">
            确定要删除这条记录吗？
        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn" data-am-modal-confirm onclick="deleteMxbtn()">确定</span>
            <span class="am-modal-btn" data-am-modal-cancel onclick="closeDeleteMxdiv()">取消</span>
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
    var tempflbm = null;
    var tempJb = null;
    var lxmxJson = null;

    //加载客户
    function loadTjlxxx(flbm){
        $.ajax({
            url: "/initialvalues/getTjmxda",
            type: "post",
            async: false,
            data: {flbm:flbm, timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                loadJson = dataJson;
                var result = dataJson[0];
                $("#f_flbm").val(result.F_FLBM);
                $("#f_flmc").val(result.F_FLMC);
                var flmxHtml = "";
                if (result.F_FLMX == 1){
                    flmxHtml = "<option value=\"0\">否</option>" +
                        "     <option value=\"1\" selected>是</option>";
                }else {
                    flmxHtml = "<option value=\"0\" selected>否</option>" +
                        "       <option value=\"1\">是</option>";
                }
                $("#f_flmx").html(flmxHtml);
                $("#f_jb").val(result.F_JB);
                if (result.F_MJ == 1){
                    $("#f_mj").val("是");
                }else{
                    $("#f_mj").val("否");
                }
                if (result.F_JB == 2){
                    $("#dwmcdiv").show();
                    $("#f_dwmc").val(result.F_DWMC);
                }else {
                    $("#dwmcdiv").hide();
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    };

    function saveTjmx() {
        var flbm = $("#f_flbm").val();
        var flmc = $("#f_flmc").val();
        var flmx = $("#f_flmx").val();
        var jb = $("#f_jb").val();
        if ($("#f_mj").val() == "是"){
            var mj = "1";
        }else {
            var mj = "0";
        }
        if (jb == 2){
            var dwmc = $("#f_dwmc").val();
        }

        $.ajax({
            url: "/initialvalues/saveTjmxda",
            type: "post",
            async: false,
            data: {flbm:flbm,flmc:flmc,flmx:flmx,jb:jb,mj:mj,dwmc:dwmc, timeer: new Date() },
            success: function (data) {
                if(data == "ok"){
                    alertMsg("保存成功！");
                }
                $("#f_flbm").val("");
                $("#f_flmc").val("");
                var flmxHtml = "";
                flmxHtml = "<option value=\"0\" selected>否</option>" +
                    "       <option value=\"1\">是</option>";
                $("#f_flmx").html(flmxHtml);
                $("#f_jb").val("");
                $("#f_mj").val("");
                $("#f_dwmc").val("亩");
                document.getElementById('tjmxwhTree').contentWindow.location.reload(true);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    }

    //弹出删除明细div
    function deleteTjmx() {
        $('#deleteMxdiv').modal('open');
    }

    function deleteMxbtn() {
        var flbm = $("#f_flbm").val();
        var jb = $("#f_jb").val();
        if(flbm == '' || flbm == null){
            alert("请先选择分类！！");
            return;
        }
        $.ajax({
            url: "/initialvalues/deleteTjmxda",
            type: "post",
            async: false,
            data: {flbm:flbm, jb:jb,timeer: new Date() },
            success: function (data) {
                if(data == "ok"){
                    alertMsg("删除成功！");
                }
                $("#f_flbm").val("");
                $("#f_flmc").val("");
                var flmxHtml = "";
                flmxHtml = "<option value=\"0\" selected>否</option>" +
                    "       <option value=\"1\">是</option>";
                $("#f_flmx").html(flmxHtml);
                $("#f_jb").val("");
                $("#f_mj").val("");
                $("#f_dwmc").val("亩");
                document.getElementById('tjmxwhTree').contentWindow.location.reload(true);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    }

    function addTj(){
        var flbm = tempflbm;
        var jb = tempJb;
        if(jb == '1' || jb == '' || jb == null){
            flbm = "";
            jb = 1;
        }else{
            flbm = flbm.substring(0,flbm.length-1);
        }
        $.ajax({
            url: "/initialvalues/getMaxtjmx",
            type: "post",
            async: false,
            data: {flbm:flbm,jb:jb, timeer: new Date() },
            success: function (data) {
                $("#f_flbm").val(data);
                $("#f_flmc").val("");
                var flmxHtml = "";
                flmxHtml = "<option value=\"0\" selected>否</option>" +
                    "       <option value=\"1\">是</option>";
                $("#f_flmx").html(flmxHtml);
                $("#f_jb").val(jb);
                $("#f_mj").val("是");
                if (jb == 2){
                    $("#dwmcdiv").show();
                    $("#f_dwmc").val("亩");
                }else {
                    $("#dwmcdiv").hide();
                }
                $("#zjul").click();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }

    function addZj(){
        var flbm = tempflbm;
        if(flbm == '' || flbm == null){
            alert("请先选择分类！！");
            return;
        }
        var jb = tempJb;
        if(jb == 3){
            alert("不能继续添加分类！！");
            return;
        }
        jb = parseInt(jb)+1;
        $.ajax({
            url: "/initialvalues/getMaxtjmx",
            type: "post",
            async: false,
            data: {flbm:flbm,jb:jb, timeer: new Date() },
            success: function (data) {
                $("#f_flbm").val(data);
                $("#f_flmc").val("");
                var flmxHtml = "";
                flmxHtml = "<option value=\"0\" selected>否</option>" +
                    "       <option value=\"1\">是</option>";
                $("#f_flmx").html(flmxHtml);
                $("#f_jb").val(jb);
                $("#f_mj").val("是");
                if (jb == 2){
                    $("#dwmcdiv").show();
                    $("#f_dwmc").val("亩");
                }else {
                    $("#dwmcdiv").hide();
                }
                $("#zjul").click();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }

    //关闭删除类型div
    function closeDeleteMxdiv(){
        $('#deleteMxdiv').modal('close');
    }

    function alertMsg(msg){
        $('#alertcontent ',parent.document).text(msg);
        $('#alertdlg',parent.document).modal('open');
    }

</script>
</body>
</html>
