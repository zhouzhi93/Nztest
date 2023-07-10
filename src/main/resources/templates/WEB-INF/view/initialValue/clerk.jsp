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
    <title>云平台客户端V1-职员管理</title>
    <meta name="description" content="云平台客户端V1-职员管理">
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
        #zytable input{
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
                    <h1>职员管理</h1>
                </div>
            </div>
        </div>
        <!--选择客户div-->
        <div class="am-container am-" id="chooseZydiv">
            <div>
                <div>
                    <div class="am-container">
                        <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                            <input class="am-radius am-form-field am-input-sm" id="spoption" style="width: 160px;display:initial;" type="text" placeholder="输入职员名称、字母">
                            <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchZy()">搜索</button>
                        </div>
                        <div class="am-u-sm-6 am-u-md-6 am-text-right">
                            <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadZyxx('')" style="border: 1px solid #0E90D2;background: white;color: #0E90D2;">刷新</button>
                            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" id="addzy">新增</button>
                        </div>
                    </div>
                    <div style="margin-top: 10px;" class="am-container am-scrollable-horizontal" id="hovertables">
                        <table class="am-table am-table-bordered am-table-centered am-text-nowrap" >
                            <thead>
                            <tr>
                                <th class="am-text-middle">操作</th>
                                <th class="am-text-middle">职员名称</th>
                                <th class="am-text-middle">职员权限</th>
                                <th class="am-text-middle">所辖部门</th>
                                <th class="am-text-middle">手机号码</th>
                                <th class="am-text-middle">修改日期</th>
                            </tr>
                            </thead>
                            <tbody id="zytable">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--新建职员div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="newZydiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">新增职员
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="addzyform">
                        <div class="am-form-group">
                            <label for="f_zymc" class="am-u-sm-2 am-form-label">职员名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_zymc" required placeholder="职员名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <%--<div class="am-form-group">
                            <label for="f_zyqx" class="am-u-sm-2 am-form-label">职员权限</label>
                            <div class="am-u-sm-10">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select multiple data-am-selected="{btnWidth: '70%',maxHeight: 200,searchBox: 1}" id="f_zyqx" required>
                                    </select>
                                    <span style="color: #5da5fd;cursor: pointer;" onclick="loadzyqx()">刷新</span>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>--%>
                        <div class="am-form-group">
                            <label for="f_zyqx" class="am-u-sm-2 am-form-label">职员权限</label>
                            <div class="am-u-sm-9">
                                <input readonly type="hidden" class="am-form-field am-input-sm am-radius" id="f_zyqx" required placeholder="">
                                <input readonly type="text" class="am-form-field am-input-sm am-radius" id="f_zyqxmc" required placeholder="">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sxbm" class="am-u-sm-2 am-form-label">所辖部门</label>
                            <div class="am-u-sm-10">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select multiple data-am-selected id="f_sxbm" required>
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sjh" class="am-u-sm-2 am-form-label">手机号码</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_sjh" required placeholder="手机号码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_zykl" class="am-u-sm-2 am-form-label">职员口令</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_zykl" required placeholder="职员口令">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="submit" id="addzybtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeNewZydiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--修改客户div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="updateZydiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">修改职员
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="updatezyform">
                        <div class="am-form-group">
                            <label for="xgf_zymc" class="am-u-sm-2 am-form-label">职员名称</label>
                            <div class="am-u-sm-9">
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_zybm" required placeholder="职员编码">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_zymc" required placeholder="职员名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
<%--                        <div class="am-form-group">
                            <label for="xgf_zyqx" class="am-u-sm-2 am-form-label">职员权限</label>
                            <div class="am-u-sm-10">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select multiple  data-am-selected="{btnWidth: '70%',maxHeight: 200,searchBox: 1}" id="xgf_zyqx" required>
                                    </select>
                                    <span style="color: #5da5fd;cursor: pointer;" onclick="loadzyqx()">刷新</span>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>--%>
                        <div class="am-form-group">
                            <label for="xgf_zyqx" class="am-u-sm-2 am-form-label">职员权限</label>
                            <div class="am-u-sm-9">
                                <input readonly type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_zyqx" required placeholder="">
                                <input readonly type="text" class="am-form-field am-input-sm am-radius" id="xgf_zyqxmc" required placeholder="">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_sxbm" class="am-u-sm-2 am-form-label">所辖部门</label>
                            <div class="am-u-sm-10">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select multiple data-am-selected id="xgf_sxbm" required>
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_sjh" class="am-u-sm-2 am-form-label">手机号码</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_sjh" required placeholder="手机号码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_zykl" class="am-u-sm-2 am-form-label">职员口令</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_zykl" placeholder="职员口令">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="submit" id="updatezybtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeUpdateZydiv()">取消</button>
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
        var xzqxmx = null;
        $(function(){
            loadZyxx("");
            //loadzyqx("","");
            loadsxbm();
            //显示新增客户
            $('#addzy').click(function () {

                $("#f_zymc").val("");
                $("#f_sjh").val("");
                $("#f_zykl").val("");
                $('#f_zyqx').val("");
                $('#f_zyqxmc').val("");
                $('#f_sxbm').val("");
                $('#f_sxbm').trigger('changed.selected.amui');

                $('#newZydiv').modal({
                    closeViaDimmer: false,
                    width:580,
                    height:600
                });
                $('#newZydiv').modal('open');
                $('.am-dimmer').css("z-index","1111");
                $('#newZydiv').css("z-index","1119");
            });
            //关闭还原遮罩蒙板z-index
            $('#newZydiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
            //增加职员提交
            $('#addzyform').validator({
                H5validation: false,
                submit: function () {
                    var formValidity = this.isFormValid();
                    if (formValidity) {
                        try {
                            var $subbtn = $("#addzybtn");
                            $subbtn.button('loading');
                            var zymc = $("#f_zymc").val();
                            var sjh = $("#f_sjh").val();
                            var zyqxs = $("#f_zyqx").val();
                            var sxbm = $("#f_sxbm").val();
                            var zykl = $("#f_zykl").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/clerk/addClerk",
                                    type: "post",
                                    async: false,
                                    data: { zymc: zymc,sjh:sjh, zyqx: zyqxs.toString(), zykl: zykl,sxbm:sxbm.toString(), timeer: new Date() },
                                    success: function (data, textStatus) {
                                        if(data == "ok"){
                                            alertMsg("保存成功！");
                                        }
                                        $subbtn.button('reset');
                                        $('#newZydiv').modal('close');
                                        loadZyxx("");
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
            //修改商品提交
            $('#updatezyform').validator({
                H5validation: false,
                submit: function () {
                    var formValidity = this.isFormValid();
                    if (formValidity) {
                        try {
                            var $subbtn = $("#updatezybtn");
                            $subbtn.button('loading');
                            var zybm = $("#xgf_zybm").val();
                            var zymc = $("#xgf_zymc").val();
                            var sjh = $("#xgf_sjh").val();
                            var zyqxs = $("#xgf_zyqx").val();
                            var zykl = $("#xgf_zykl").val();
                            var sxbm = $("#xgf_sxbm").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/clerk/updateClerk",
                                    type: "post",
                                    async: false,
                                    data: { zybm:zybm,zymc: zymc,sjh:sjh, zyqx: zyqxs.toString(), zykl: zykl,sxbm:sxbm.toString(),timeer: new Date() },
                                    success: function (data, textStatus) {
                                        if(data == "ok"){
                                            alertMsg("修改成功！");
                                        }
                                        $subbtn.button('reset');
                                        $('#updateZydiv').modal('close');
                                        loadZyxx("");
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

            //显示选择权限
            $('#f_zyqxmc').click(function () {
                $('#chooseQxdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:600
                });
                loadQxmx("");
                var zyqx = $('#f_zyqx').val();
                if(zyqx != null && zyqx != ''){
                    var zyqxs = zyqx.split(",");
                    for(var i= 0 ; i<zyqxs.length ; i++){
                        $("input:checkbox[value='"+zyqxs[i]+"']").attr('checked','true');
                    }
                }
                $('#chooseQxdiv').modal('open');
                $('#chooseQxdiv').css("z-index","1219");
            });

            //显示选择权限
            $('#xgf_zyqxmc').click(function () {
                $('#chooseQxdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:600
                });
                loadQxmx("");
                var zyqx = $('#xgf_zyqx').val();
                if(zyqx != null && zyqx != ''){
                    var zyqxs = zyqx.split(",");
                    for(var i= 0 ; i<zyqxs.length ; i++){
                        $("input:checkbox[value='"+zyqxs[i]+"']").attr('checked','true');
                    }
                }
                $('#chooseQxdiv').modal('open');
                $('#chooseQxdiv').css("z-index","1219");
            });

/*            $('#f_zyqx').change(function () {
                var zyqxmx = $('#f_zyqx').val();
                if(zyqxmx != ''){
                    var zyqxmxs = zyqxmx.split(",");
                    var jb = parseInt(zyqxmxs[1])+1;
                    if(zyqxmxs[2] == '0'){
                        loadzyqx(zyqxmxs[0],jb);
                        $('#f_zyqx').click();
                    }
                }
            });

            $('#xgf_zyqx').change(function () {
                var zyqxmx = $('#xgf_zyqx').val();
                if(zyqxmx != ''){
                    var zyqxmxs = zyqxmx.split(",");
                    var jb = parseInt(zyqxmxs[1])+1;
                    if(zyqxmxs[2] == '0'){
                        loadzyqx(zyqxmxs[0],jb);
                        $('#xgf_zyqx').click();
                    }
                }
            });*/

            //回写权限
            $('#addqx').click(function () {
                var zyqx = $("input:checkbox[name='qx']:checked").map(function(index,elem) {
                    return $(elem).val();
                }).get().join(',');
                $('#f_zyqx').val(zyqx);
                $('#xgf_zyqx').val(zyqx);
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
                $('#f_zyqxmc').val(zyqxmc);
                $('#xgf_zyqxmc').val(zyqxmc);
                $('#chooseQxdiv').modal('close');
            });

        });



        function searchZy() {
            var jsxx=$('#spoption').val();
            loadZyxx(jsxx);
        };
        //加载商品
        function loadZyxx(jsxx){
            $.ajax({
                url: "/clerk/getClerk",
                type: "post",
                async: false,
                data: {zybm:jsxx, timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    loadJson = dataJson;
                    if(dataJson.length>0) {
                        var zymxhtml="";
                        for(var i=0;i<dataJson.length;i++){
                            var zyda=dataJson[i];
                            if(zymxhtml==""){
                                zymxhtml="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>" +
                                    " &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+zyda.F_ZYBM+"')\">删除</a>" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_ZYMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_QXMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_BMMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_SJH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_XGRQ+"</td>\n" +
                                    "                        </tr>"
                            }else{
                                zymxhtml+="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>" +
                                    " &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+zyda.F_ZYBM+"')\">删除</a>" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_ZYMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_QXMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_BMMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_SJH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_XGRQ+"</td>\n" +
                                    "                        </tr>"
                            }
                        }
                        $('#zytable').html(zymxhtml);
                    }else{
                        $('#zytable').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        };
        function closeNewZydiv(){
            $('#newZydiv').modal('close');
        }
        function closeUpdateZydiv(){
            $('#updateZydiv').modal('close');
        }
        
        function UpdatePage(index) {
            var zyda=loadJson[index];
            var zybm = zyda.F_QXBM;
            $("#xgf_zymc").val(zyda.F_ZYMC);
            $("#xgf_zybm").val(zyda.F_ZYBM);
            //$("#xgf_zykl").val(zyda.F_ZYKL);
            $("#xgf_sjh").val(zyda.F_SJH);
            var bmbm = zyda.F_BMBM.split(",");
            $('#xgf_sxbm').val(bmbm);
            $('#xgf_zyqx').val(zyda.F_QXBM);
            $('#xgf_zyqxmc').val(zyda.F_QXMC);
            $('#xgf_sxbm').trigger('changed.selected.amui');
            
            $('#updateZydiv').modal({
                closeViaDimmer: false,
                width:580,
                height:600
            });
            $('#updateZydiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#updateZydiv').css("z-index","1119");
        }
        
        function deletePage(zybm) {
            $.ajax({
                url: "/clerk/removeClerk",
                type: "post",
                async: false,
                data: { zybm: zybm, timeer: new Date() },
                success: function (data, textStatus) {
                    loadZyxx("");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $subbtn.button('reset');
                }
            });
        }

        function loadzyqx(qxbm,jb){
            $.ajax({
                url: "/character/getQxmx",
                type: "post",
                async: false,
                data: {qxbm:qxbm,jb:jb, timeer: new Date() },
                success: function (data) {
                    var $selected = $('#f_zyqx');
                    var $selected2 = $('#xgf_zyqx');
                    $selected.html("");
                    $selected.append('<option value=""></option>');
                    $selected2.html("");
                    $selected2.append('<option value=""></option>');
                    var dataJson = JSON.parse(data);
                    if(dataJson.length>0) {
                        var splbhtml="";
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
                                        $('#xgf_zyqx').html("");
                                        $('#f_zyqx').html("");
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
                        $('#xgf_zyqx').html("");
                        $('#f_zyqx').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }

        function loadsxbm(){
            $.ajax({
                url: "/stor/getStor",
                type: "post",
                async: false,
                data: {bmxx:"", timeer: new Date() },
                success: function (data) {
                    var $selected = $('#f_sxbm');
                    var $selected2 = $('#xgf_sxbm');
                    $selected.html("");
                    $selected.append('<option value=""></option>');
                    $selected2.html("");
                    $selected2.append('<option value=""></option>');
                    var dataJson = JSON.parse(data);
                    if(dataJson.length>0) {
                        for(var i=0;i<dataJson.length;i++){
                            var sxbmmx=dataJson[i];
                            $selected.append('<option value="'+sxbmmx.F_BMBM+'">'+sxbmmx.F_BMMC+'</option>');
                            $selected2.append('<option value="'+sxbmmx.F_BMBM+'">'+sxbmmx.F_BMMC+'</option>');
                        }
                        $selected.trigger('changed.selected.amui');
                        $selected2.trigger('changed.selected.amui');
                    }else{
                        $('#xgf_zyqx').html("");
                        $('#f_zyqx').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
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
