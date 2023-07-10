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
    <title>云平台客户端V1-角色管理</title>
    <meta name="description" content="云平台客户端V1-角色管理">
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
        .am-gallery-item-boder{
            border:1px solid red;
            padding: 1px;
        }
        .am-td-spmc{
            max-width: 150px;
            font-size: 1.4rem;
        }
        #jstable input{
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
                    <h1>角色管理</h1>
                </div>
            </div>
        </div>
        <!--选择角色div-->
        <div class="am-container am-" id="choosejsdiv">
            <div>
                <div>
                    <div class="am-container">
                        <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                            <input class="am-radius am-form-field am-input-sm" id="spoption" style="width: 160px;display:initial;" type="text" placeholder="输入角色名称、字母">
                            <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchJs()">搜索</button>
                        </div>
                        <div class="am-u-sm-6 am-u-md-6 am-text-right">
                            <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadJsxx('')" style="border: 1px solid #0E90D2;background: white;color: #0E90D2;">刷新</button>
                            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" id="addjs">新增</button>
                        </div>
                    </div>
                    <div style="margin-top: 10px;" class="am-container am-scrollable-horizontal" id="hovertables">
                        <table class="am-table am-table-bordered am-table-centered am-text-nowrap" >
                            <thead>
                            <tr>
                                <th class="am-text-middle">操作</th>
                                <th class="am-text-middle">角色名称</th>
                                <th class="am-text-middle">角色类型</th>
                                <th class="am-text-middle">权限名称</th>
                            </tr>
                            </thead>
                            <tbody id="jstable">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--新建商品div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="newJsdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">新增角色
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="addjsform">
                        <div class="am-form-group">
                            <label for="f_jsmc" class="am-u-sm-2 am-form-label">角色名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_jsmc" required placeholder="角色名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_jslx" class="am-u-sm-2 am-form-label">角色类型</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_jslx" required placeholder="角色类型">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <%--<div class="am-form-group">
                            <label for="f_jsqx" class="am-u-sm-2 am-form-label">角色权限</label>
                            <div class="am-u-sm-10">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select multiple data-am-selected="{btnWidth: '70%',maxHeight: 200,searchBox: 1}" id="f_jsqx" required>
                                    </select>
                                    <span style="color: #5da5fd;cursor: pointer;" onclick="loadjsqx()">刷新</span>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>--%>
                        <div class="am-form-group">
                            <label for="f_jsqx" class="am-u-sm-2 am-form-label">角色权限</label>
                            <div class="am-u-sm-9">
                                <input readonly type="hidden" class="am-form-field am-input-sm am-radius" id="f_jsqx" required placeholder="">
                                <input readonly type="text" class="am-form-field am-input-sm am-radius" id="f_jsqxmc" required placeholder="">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label class="am-u-sm-2 am-form-label">状态</label>
                            <div class="am-u-sm-9 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="1" name="f_sfkj"> 可见
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="0" name="f_sfkj"> 不可见
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="submit" id="addjsbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeNewJsdiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--修改客户div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="updateJsdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">修改角色
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="updatejsform">
                        <div class="am-form-group">
                            <label for="xgf_jsmc" class="am-u-sm-2 am-form-label">角色名称</label>
                            <div class="am-u-sm-9">
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_jsbm" required placeholder="角色编码">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_jsmc" required placeholder="角色名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_jslx" class="am-u-sm-2 am-form-label">角色类型</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_jslx" required placeholder="角色类型">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <%--<div class="am-form-group">
                            <label for="xgf_jsqx" class="am-u-sm-2 am-form-label">角色权限</label>
                            <div class="am-u-sm-10">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select multiple data-am-selected="{btnWidth: '70%',maxHeight: 200,searchBox: 1}" id="xgf_jsqx" required>
                                    </select>
                                    <span style="color: #5da5fd;cursor: pointer;" onclick="loadjsqx()">刷新</span>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>--%>
                        <div class="am-form-group">
                            <label for="xgf_jsqx" class="am-u-sm-2 am-form-label">职员权限</label>
                            <div class="am-u-sm-9">
                                <input readonly type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_jsqx" required placeholder="">
                                <input readonly type="text" class="am-form-field am-input-sm am-radius" id="xgf_jsqxmc" required placeholder="">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label class="am-u-sm-2 am-form-label">状态</label>
                            <div class="am-u-sm-9 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="1" name="xgf_sfkj"> 可见
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="0" name="xgf_sfkj"> 不可见
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="submit" id="updatejsbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeUpdateJsdiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--选择权限div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseQxdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">选择职员权限
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div class="am-container">
                    <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                        <input class="am-radius am-form-field am-input-sm" id="qxoption" style="width: 160px;display:initial;" type="text" placeholder="输入权限名称、字母">
                        <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchQx()">搜索</button>
                    </div>
                    <div class="am-u-sm-6 am-u-md-6 am-text-right">
                        <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" id="addqx">确认</button>
                    </div>
                </div>
                <div style="margin-top: 10px;" class="am-container">
                    <table class="am-table am-table-bordered am-table-centered" >
                        <thead>
                        <tr>
                            <th style="width: 50px;">选择</th>
                            <th class="am-text-middle">权限名称</th>
                        </tr>
                        </thead>
                        <tbody id="qxtable">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>


    <script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
    <script src="/assets/js/amazeui.min.js"></script>
    <script src="/assets/js/app.js"></script>
    <script src="/assets/address/address.min.js"></script>
    <script src="/assets/address/iscroll.min.js"></script>
    <script type="text/javascript">
        var loadJson = null;
        $(function(){
            loadJsxx("");
            //loadjsqx("","");
            //显示新增客户
            $('#addjs').click(function () {
                $("#f_jsmc").val("");
                $("#f_jsbm").val("");
                $("#f_jslx").val("");
                $("input[name='f_sfkj']").each(function() {
                    if ($(this).val() == 1) {
                        $(this).prop("checked", true);
                    }
                });
                $('#f_jsqx').val("");
                $('#f_jsqxmc').val("");

                $('#newJsdiv').modal({
                    closeViaDimmer: false,
                    width:580,
                    height:600
                });
                $('#newJsdiv').modal('open');
                $('.am-dimmer').css("z-index","1111");
                $('#newJsdiv').css("z-index","1119");
            });
            //关闭还原遮罩蒙板z-index
            $('#newJsdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
            //增加客户提交
            $('#addjsform').validator({
                H5validation: false,
                submit: function () {
                    var formValidity = this.isFormValid();
                    if (formValidity) {
                        try {
                            var $subbtn = $("#addjsbtn");
                            $subbtn.button('loading');
                            var jsmc = $("#f_jsmc").val();
                            var jslx = $("#f_jslx").val();
                            var jsqxs = $("#f_jsqx").val();
                            var sfkj = $("input[name='f_sfkj']:checked").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/character/addJsmx",
                                    type: "post",
                                    async: false,
                                    data: { jsmc: jsmc,jslx:jslx, jsqx: jsqxs.toString(), sfkj: sfkj, timeer: new Date() },
                                    success: function (data, textStatus) {
                                        if(data == "ok"){
                                            alertMsg("保存成功！");
                                        }
                                        $subbtn.button('reset');
                                        $('#newJsdiv').modal('close');
                                        loadJsxx("");
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
            $('#updateJsdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
            //修改商品提交
            $('#updatejsform').validator({
                H5validation: false,
                submit: function () {
                    var formValidity = this.isFormValid();
                    if (formValidity) {
                        try {
                            var $subbtn = $("#updatejsbtn");
                            $subbtn.button('loading');
                            var jsbm = $("#xgf_jsbm").val();
                            var jsmc = $("#xgf_jsmc").val();
                            var jslx = $("#xgf_jslx").val();
                            var jsqxs = $("#xgf_jsqx").val();
                            var sfkj = $("input[name='xgf_sfkj']:checked").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/character/updateJsmx",
                                    type: "post",
                                    async: false,
                                    data: { jsbm:jsbm,jsmc: jsmc,jslx:jslx, jsqx: jsqxs.toString(), sfkj: sfkj,timeer: new Date() },
                                    success: function (data, textStatus) {
                                        if(data == "ok"){
                                            alertMsg("修改成功！");
                                        }
                                        $subbtn.button('reset');
                                        $('#updateJsdiv').modal('close');
                                        loadJsxx("");
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


            $('#hovertables').hover(function(){
                $('#hovertables').css("overflow","auto")
            },function(){
                $('#hovertables').css("overflow","hidden")
            });

/*            $('#f_jsqx').change(function () {
                var jsqxmx = $('#f_jsqx').val();
                if(jsqxmx != ''){
                    var jsqxmxs = jsqxmx.split(",");
                    var jb = parseInt(jsqxmxs[1])+1;
                    if(jsqxmxs[2] == '0'){
                        loadjsqx(jsqxmxs[0],jb);
                        $('#f_jsqx').click();
                    }
                }
            });

            $('#xgf_jsqx').change(function () {
                var jsqxmx = $('#xgf_jsqx').val();
                if(jsqxmx != ''){
                    var jsqxmxs = jsqxmx.split(",");
                    var jb = parseInt(jsqxmxs[1])+1;
                    if(jsqxmxs[2] == '0'){
                        loadjsqx(jsqxmxs[0],jb);
                        $('#xgf_jsqx').click();
                    }
                }
            });*/

//显示选择权限
            $('#f_jsqxmc').click(function () {
                $('#chooseQxdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:600
                });
                loadQxmx("");
                var zyqx = $('#f_jsqx').val();
                if(zyqx != null && zyqx != ''){
                    var jsqxs = zyqx.split(",");
                    for(var i= 0 ; i<jsqxs.length ; i++){
                        $("input:checkbox[value='"+jsqxs[i]+"']").attr('checked','true');
                    }
                }
                $('#chooseQxdiv').modal('open');
                $('#chooseQxdiv').css("z-index","1219");
            });

            //显示选择权限
            $('#xgf_jsqxmc').click(function () {
                $('#chooseQxdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:600
                });
                loadQxmx("");
                var zyqx = $('#xgf_jsqx').val();
                if(zyqx != null && zyqx != ''){
                    var jsqxs = zyqx.split(",");
                    for(var i= 0 ; i<jsqxs.length ; i++){
                        $("input:checkbox[value='"+jsqxs[i]+"']").attr('checked','true');
                    }
                }
                $('#chooseQxdiv').modal('open');
                $('#chooseQxdiv').css("z-index","1219");
            });

            //回写权限
            $('#addqx').click(function () {
                var zyqx = $("input:checkbox[name='qx']:checked").map(function(index,elem) {
                    return $(elem).val();
                }).get().join(',');
                $('#f_jsqx').val(zyqx);
                $('#xgf_jsqx').val(zyqx);
                var zyqxmc = "";
                for(var i = 0 ; i<xzqxmx.length ; i++){
                    var qxmx=xzqxmx[i];
                    var zyqxs = zyqx.split(",");
                    for(var j = 0 ; j<xzqxmx.length ; j++){
                        if(qxmx.F_QXBM == zyqxs[j]){
                            zyqxmc+=qxmx.F_QXMC+",";
                        }
                    }

                }
                zyqxmc = zyqxmc.substring(0,zyqxmc.length-1);
                $('#f_jsqxmc').val(zyqxmc);
                $('#xgf_jsqxmc').val(zyqxmc);
                $('#chooseQxdiv').modal('close');
            });

        });



        function searchJs() {
            var jsxx=$('#spoption').val();
            loadJsxx(jsxx);
        };
        //加载商品
        function loadJsxx(jsxx){
            $.ajax({
                url: "/character/getChara",
                type: "post",
                async: false,
                data: {jsbm:jsxx, timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    loadJson = dataJson;
                    if(dataJson.length>0) {
                        var splbhtml="";
                        for(var i=0;i<dataJson.length;i++){
                            var jsda=dataJson[i];
                            if(splbhtml==""){
                                splbhtml="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>" +
                                    " &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+jsda.F_JSBM+"')\">删除</a>" +
                                    "                            <td class=\"am-text-middle\">"+jsda.F_JSMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+jsda.F_JSLX+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+jsda.F_QXMC+"</td>\n" +
                                    "                        </tr>"
                            }else{
                                splbhtml+="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>" +
                                    " &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+jsda.F_JSBM+"')\">删除</a>" +
                                    "                            <td class=\"am-text-middle\">"+jsda.F_JSMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+jsda.F_JSLX+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+jsda.F_QXMC+"</td>\n" +
                                    "                        </tr>"
                            }
                        }
                        $('#jstable').html(splbhtml);
                        $('#jstable tr').click(function () {
                            var rowNum=$(this).index();
                            var $table=$(this).parent();
                            var khmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                            $('#khxx').val(khmc);
                            $('#choosejsdiv').modal('close');
                        });
                    }else{
                        $('#jstable').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        };
        function closeNewJsdiv(){
            $('#newJsdiv').modal('close');
        }
        function closeUpdateJsdiv(){
            $('#updateJsdiv').modal('close');
        }
        
        function UpdatePage(index) {
            var jsda=loadJson[index];
            var splbbm = jsda.F_QXBM;
            $("#xgf_jsmc").val(jsda.F_JSMC);
            $("#xgf_jsbm").val(jsda.F_JSBM);
            $("#xgf_jslx").val(jsda.F_JSLX);
            $("input[name='xgf_sfkj']").each(function() {
                if ($(this).val() == jsda.F_SFKJ) {
                    $(this).prop("checked", true);
                }
            });

            $('#xgf_jsqx').val(jsda.F_QXBM);
            $('#xgf_jsqxmc').val(jsda.F_QXMC);
            
            $('#updateJsdiv').modal({
                closeViaDimmer: false,
                width:580,
                height:600
            });
            $('#updateJsdiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#updateJsdiv').css("z-index","1119");
        }
        
        function deletePage(jsbm) {
            $.ajax({
                url: "/character/removeJsmx",
                type: "post",
                async: false,
                data: { jsbm: jsbm, timeer: new Date() },
                success: function (data, textStatus) {
                    loadJsxx("");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $subbtn.button('reset');
                }
            });
        }

        function loadjsqx(qxbm,jb){
            $.ajax({
                url: "/character/getQxmx",
                type: "post",
                async: false,
                data: {qxbm:qxbm,jb:jb, timeer: new Date() },
                success: function (data) {
                    var $selected = $('#f_jsqx');
                    var $selected2 = $('#xgf_jsqx');
                    $selected.html("");
                    $selected.append('<option value=""></option>');
                    $selected2.html("");
                    $selected2.append('<option value=""></option>');
                    var dataJson = JSON.parse(data);
                    if(dataJson.length>0) {
                        var splbhtml="";
/*                        for(var i=0;i<dataJson.length;i++){
                            var jsqxmx=dataJson[i];
                            var splbxx = jsqxmx.F_QXBM+","+jsqxmx.F_JB+","+jsqxmx.F_SFMJ;
                            $selected.append('<option value="'+splbxx+'">'+jsqxmx.F_QXMC+'</option>');
                            $selected2.append('<option value="'+splbxx+'">'+jsqxmx.F_QXMC   +'</option>');
                        }*/
                        for(var i=0;i<dataJson.length;i++) {
                            var jsqxmx=dataJson[i];
                            $.ajax({
                                url: "/character/getQxmx",
                                type: "post",
                                async: false,
                                data: {qxbm:jsqxmx.F_QXBM,jb:(parseInt(jsqxmx.F_JB)+1), timeer: new Date() },
                                success: function (data) {
                                    var dataJson = JSON.parse(data);
                                    if(dataJson.length>0) {
                                        var splbhtml="";
                                        for(var i=0;i<dataJson.length;i++){
                                            var jsqxmx=dataJson[i];
                                            var splbxx = jsqxmx.F_QXBM+"-"+jsqxmx.F_JB+"-"+jsqxmx.F_SFMJ;
                                            splbhtml += "<option value='"+splbxx+"'>"+jsqxmx.F_QXMC+"</option>";
                                        }
                                        $selected.append('<optgroup label="'+jsqxmx.F_QXMC+'">' + splbhtml + '</optgroup>');
                                        $selected2.append('<optgroup label="'+jsqxmx.F_QXMC+'">' + splbhtml + '</optgroup>');

                                    }else{
                                        $('#xgf_jsqx').html("");
                                        $('#f_jsqx').html("");
                                    }
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    alert(errorThrown + "||" + textStatus);
                                    $("#savaBtn").button('reset');
                                }
                            });
                        }
                        $selected.trigger('changed.selected.amui');
                        $selected2.trigger('changed.selected.amui');
                    }else{
                        $('#xgf_jsqx').html("");
                        $('#f_jsqx').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }

        //加载客户
        function loadQxmx(qxxx){

            $.ajax({
                url: "/character/getQxmx",
                type: "post",
                async: false,
                data: {qxbm:qxxx,timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    if(dataJson.length>0) {
                        xzqxmx = dataJson;
                        var qxtable="";
                        for(var i=0;i<dataJson.length;i++){
                            var qxmx=dataJson[i];
                            if(qxtable==""){
                                qxtable+="<tr>\n";
                                qxtable+="                            <td class=\"am-text-middle\" style=\"width: 50px;\"><label class=\"am-checkbox-inline\"> " +
                                    "<input type=\"checkbox\" name='qx' value=\""+qxmx.F_QXBM+"\" data-am-ucheck></label></td>\n";
                                qxtable+="                            <td class=\"am-text-middle\">"+qxmx.F_QXMC+"</td>\n";
                                qxtable+="                        </tr>";
                            }else{
                                qxtable+="<tr>\n";
                                qxtable+="                            <td class=\"am-text-middle\"><label class=\"am-checkbox-inline\"> " +
                                    "<input type=\"checkbox\" name='qx' value=\""+qxmx.F_QXBM+"\" data-am-ucheck></label></td>\n";
                                qxtable+="                            <td class=\"am-text-middle\">"+qxmx.F_QXMC+"</td>\n";
                                qxtable+="                        </tr>";
                            }
                        }
                        $('#qxtable').html(qxtable);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        };

        function searchQx() {
            var qxxx=$('#qxoption').val();
            loadQxmx(qxxx);
        };

        function alertMsg(msg){
            $('#alertcontent ',parent.document).text(msg);
            $('#alertdlg',parent.document).modal('open');
        }

    </script>
</body>
</html>
