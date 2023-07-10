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
    String f_shbm= (String) session.getAttribute("f_shbm");
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
                            <thead id="zytableTitle">
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
                        <div class="am-form-group">
                            <label for="f_zyqx" class="am-u-sm-2 am-form-label">职员权限</label>
                            <div class="am-u-sm-9">
                                <input readonly type="hidden" class="am-form-field am-input-sm am-radius" id="f_zyqx" required placeholder="">
                                <input readonly type="text" class="am-form-field am-input-sm am-radius" id="f_zyqxmc" placeholder="">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_zyjs" class="am-u-sm-2 am-form-label">职员角色</label>
                            <div class="am-u-sm-9">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '100%'}" id="f_zyjs">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sxbm" class="am-u-sm-2 am-form-label">所辖部门</label>
                            <div class="am-u-sm-9">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select multiple data-am-selected="{btnWidth: '100%'}" id="f_sxbm" required>
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sjh" class="am-u-sm-2 am-form-label">手机号码</label>
                            <div class="am-u-sm-9">
                                <input type="tel" class="am-form-field am-input-sm am-radius" id="f_sjh" required placeholder="手机号码">
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
            <div class="am-modal-bd am-scrollable-vertical" style="min-height: 400px;">
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
                        <div class="am-form-group">
                            <label for="xgf_zyqx" class="am-u-sm-2 am-form-label">职员权限</label>
                            <div class="am-u-sm-9">
                                <input readonly type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_zyqx" required placeholder="">
                                <input readonly type="text" class="am-form-field am-input-sm am-radius" id="xgf_zyqxmc" required placeholder="">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_zyjs" class="am-u-sm-2 am-form-label">职员角色</label>
                            <div class="am-u-sm-9">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '100%'}" id="xgf_zyjs">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_sxbm" class="am-u-sm-2 am-form-label">所辖部门</label>
                            <div class="am-u-sm-9">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select multiple data-am-selected="{btnWidth: '100%'}" id="xgf_sxbm" required>
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_sjh" class="am-u-sm-2 am-form-label">手机号码</label>
                            <div class="am-u-sm-9">
                                <input type="tel" class="am-form-field am-input-sm am-radius" id="xgf_sjh" required placeholder="手机号码">
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

    <!--删除客户div-->
    <div class="am-modal am-modal-confirm" tabindex="-1" id="deleteZydiv">
        <div class="am-modal-dialog">
            <div class="am-modal-bd">
                确定要删除这条记录吗？
            </div>
            <div class="am-modal-footer">
                <span class="am-modal-btn" data-am-modal-confirm onclick="deletezybtn()">确定</span>
                <span class="am-modal-btn" data-am-modal-cancel onclick="closeDeleteZydiv()">取消</span>
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
                <div style="margin-top: 10px;min-height: 400px;" class="am-container am-scrollable-vertical">
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

    <!--权限展示div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseQxzsdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">职员明细
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div class="am-container">
                    <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                        <input class="am-radius am-form-field am-input-sm" id="qxzsoption" style="width: 160px;display:initial;" type="text" placeholder="输入权限名称">
                        <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchQxzs()">搜索</button>
                    </div>
                </div>
                <div style="margin-top: 10px;min-height: 400px;" class="am-container am-scrollable-vertical">
                    <table class="am-table am-table-bordered am-table-centered" >
                        <thead>
                        <tr>
                            <th class="am-text-middle">权限名称</th>
                        </tr>
                        </thead>
                        <tbody id="qxzstable">
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
        var jsdaJson = null;
        var allqx = null;
        var deletezybm = null;
        var qxzsZybm = null;
        var qxzsQxmc = null;
        var loadQxxx = null;
        var clickZybm = null;

        $(function(){
            loadZyxx("");
            loadzyjs();
            loadsxbm();
            loadQxmx();
            allQx();

            //显示新增客户
            $('#addzy').click(function () {
                $("#f_zymc").val("");
                $("#f_sjh").val("");
                $("#f_zykl").val("");
                $('#f_sxbm').val("");
                $('#f_sxbm').trigger('changed.selected.amui');
                $('#f_zyqx').val("");
                $('#f_zyqxmc').val("");
                $('#f_zyjs').val("");
                $('#f_zyjs').trigger('changed.selected.amui');

                $('#newZydiv').modal({
                    closeViaDimmer: false,
                    width:580,
                    height:500
                });

                $('#newZydiv').modal('open');
                $('.am-dimmer').css("z-index","1111");
                $('#newZydiv').css("z-index","1119");


                //所有的权限前方复选框解锁
                $("#qxtable input:checkbox").attr('disabled',false);
                //所有的权限前方复选框设为未选中
                $("#qxtable input:checkbox").attr('checked',false);

                loadjsqx();
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
                            var sxbm = $("#f_sxbm").val();
                            var zykl = $("#f_zykl").val();
                            var zyjs = $("#f_zyjs").val();
                            var zyqxs = $("#f_zyqx").val();
                            if(zyjs == '' || zyjs == null || zyjs == undefined){
                                alertMsg("请选择职员角色！");
                                $('#newZydiv').modal('open');
                                return;
                            }
                            if(zyqxs == '' || zyqxs == null || zyqxs == undefined){
                                alertMsg("请选择职员权限！");
                                $('#newZydiv').modal('open');
                                return;
                            }
                            setTimeout(function () {
                                $.ajax({
                                    url: "/clerk/addClerk",
                                    type: "post",
                                    async: false,
                                    data: { zymc: zymc,sjh:sjh, zyqx: zyqxs.toString(), zykl: zykl,sxbm:sxbm.toString(),zyjs:zyjs, timeer: new Date() },
                                    success: function (data, textStatus) {
                                        if(data == "ok"){
                                            alertMsg("保存成功！");
                                        }else{
                                            alertMsg(data);
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
                            var zyjs = $("#xgf_zyjs").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/clerk/updateClerk",
                                    type: "post",
                                    async: false,
                                    data: { zybm:zybm,zymc: zymc,sjh:sjh, zyqx: zyqxs.toString(), zykl: zykl,sxbm:sxbm.toString(),zyjs:zyjs,timeer: new Date() },
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
                    height:500
                });
                $('#chooseQxdiv').modal('open');
                $('#chooseQxdiv').css("z-index","1219");

            });

            //显示选择权限
            $('#xgf_zyqxmc').click(function () {
                $('#chooseQxdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:500
                });
                var zyqx = $('#xgf_zyqx').val();
                if(zyqx != null && zyqx != ''){
                    var zyqxs = zyqx.split(",");
                    for(var i= 0 ; i<zyqxs.length ; i++){
                        //商户管理员只允许添加自己的权限，不能删除自己权限
                        if (clickZybm == "<%=f_shbm%>"+"01"){
                            //拥有的权限前方复选框勾选
                            $("input:checkbox[value='"+zyqxs[i]+"']").attr('checked','true');
                            //拥有的权限前方复选框锁定
                            $("input:checkbox[value='"+zyqxs[i]+"']").attr('disabled',true);
                        }else {
                            //拥有的权限前方复选框勾选
                            $("input:checkbox[value='"+zyqxs[i]+"']").attr('checked','true');
                            //所有的权限前方复选框解锁
                            $("#qxtable input:checkbox").attr('disabled',false);
                        }
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
                        var zymxTitleHtml = "";
                        var zymxhtml = "";
                        zymxTitleHtml = "<tr>\n" +
                            "                <td class=\"am-text-middle\">操作</td>\n" +
                            "                <td class=\"am-text-middle\">商户名称</td>\n" +
                            "                <td class=\"am-text-middle\">职员名称</td>\n" +
                            "                <td class=\"am-text-middle\">职员权限</td>\n" +
                            "                <td class=\"am-text-middle\">所辖部门</td>\n" +
                            "                <td class=\"am-text-middle\">手机号码</td>\n" +
                            "                <td class=\"am-text-middle\">修改日期</td>\n" +
                            "            </tr>"
                        for(var i=0;i<dataJson.length;i++){
                            var zyda=dataJson[i];
                            zymxhtml+="<tr>\n" +
                                "                            <td class=\"am-text-middle\">" +
                                "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>" +
                                " &nbsp;&nbsp;&nbsp; " +
                                "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+zyda.F_ZYBM+"')\">删除</a>" +
                                "                            <td class=\"am-text-middle\">"+zyda.F_SHMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+zyda.F_ZYMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">" +
                                "<a href=\"#\" class=\"redlink\" onclick=\"QxmxPage("+i+")\">权限明细</a></td>\n" +
                                "                            <td class=\"am-text-middle\">"+zyda.F_BMMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+zyda.F_SJH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+zyda.F_XGRQ+"</td>\n" +
                                "                        </tr>"
                        }
                        $('#zytableTitle').html(zymxTitleHtml);
                        $('#zytable').html(zymxhtml);
                        $('#spoption').val('');
                    }else{
                        $('#zytableTitle').html(zymxTitleHtml);
                        $('#zytable').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        };

        //加载权限信息
        function loadQx() {
            $.ajax({
                url: "/clerk/getZyqx",
                type: "post",
                async: false,
                data: {zybm:"",qxxx:"",timeer: new Date() },
                success: function (data) {
                    var zyqx = JSON.parse(data);
                    loadQxxx = zyqx;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }
        
        function closeNewZydiv(){
            $('#newZydiv').modal('close');
        }
        function closeUpdateZydiv(){
            $('#updateZydiv').modal('close');
        }

        function closeDeleteZydiv(){
            $('#deleteZydiv').modal('close');
        }
        
        function UpdatePage(index) {
            loadQx();
            var qxxx = loadQxxx[index];
            var zyda=loadJson[index];

            $('#updateZydiv').modal({
                closeViaDimmer: false,
                width:590,
                height:500
            });
            $('#updateZydiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#updateZydiv').css("z-index","1119");

            $("#xgf_zymc").val(zyda.F_ZYMC);
            clickZybm = zyda.F_ZYBM;
            $("#xgf_zybm").val(zyda.F_ZYBM);
            $("#xgf_sjh").val(zyda.F_SJH);
            $('#xgf_zyqx').val(qxxx.F_QXBM);
            $('#xgf_zyqxmc').val(qxxx.F_QXMC);
            var bmbm = zyda.F_BMBM.split(",");
            $('#xgf_sxbm').val(bmbm);
            $('#xgf_sxbm').trigger('changed.selected.amui');
            $('#xgf_zyjs').val(qxxx.F_JSBM);
            $('#xgf_zyjs').trigger('changed.selected.amui');
            if (zyda.F_ZYBM == "<%=f_shbm%>"+"01"){
                $('#xgf_zyjs').selected('disable');
            }else {
                $('#xgf_zyjs').selected('enable');
            }

            loadxgjsqx(index);
        }

        //删除按钮弹出确认框
        function deletePage(zybm) {
            deletezybm = zybm;
            $('#deleteZydiv').modal('open');
        }

        //点击确认删除职员
        function deletezybtn(){
            $.ajax({
                url: "/clerk/removeClerk",
                type: "post",
                async: false,
                data: { zybm: deletezybm, timeer: new Date() },
                success: function (data, textStatus) {
                    if (data == "ok"){
                        alertMsg("删除成功！");
                    }else if (data == "407"){
                        alertMsg("请联系管理员删除！");
                    }else if (data == "408"){
                        alertMsg("无法删除管理员！");
                    }
                    loadZyxx("");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $subbtn.button('reset');
                }
            });
        }

        //加载角色权限
        function loadjsqx(){
            $('#f_zyqx').val("");
            $('#f_zyqxmc').val("");

            $("#f_zyjs").change(function(){
                var jsbm = $("#f_zyjs").val();
                $.ajax({
                    url: "/character/getJsqx",
                    type: "post",
                    async: false,
                    data: {jsbm:jsbm, timeer: new Date() },
                    success: function (data) {
                        var dataJson = JSON.parse(data);
                        $('#f_zyqxmc').val("");
                        $("#qxtable input").attr("checked",false);
                        if (dataJson.length > 0){
                            var qxmcs = "";
                            var qxbms = "";
                            for (var i = 0;i< dataJson.length; i++){
                                if (i >= dataJson.length-1){
                                    qxmcs += dataJson[i].F_QXMC;
                                    qxbms += dataJson[i].F_QXBM;
                                }else{
                                    qxmcs += dataJson[i].F_QXMC+",";
                                    qxbms += dataJson[i].F_QXBM+",";
                                }
                            }
                            $('#f_zyqxmc').val(qxmcs);
                            $('#f_zyqx').val(qxbms);

                            var inps = $("#qxtable");
                            var obj=null;
                            for (var i = 0; i < dataJson.length; i++){
                                obj = inps.find('input[value='+dataJson[i].F_QXBM+']');
                                obj.attr("checked",true);
                            }
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert(errorThrown + "||" + textStatus);
                    }
                });
            });
        }

        //加载修改角色权限
        function loadxgjsqx(index){
            var qxxx = loadQxxx[index];
            $('#xgf_zyqx').val(qxxx.F_QXBM);
            $('#xgf_zyqxmc').val(qxxx.F_QXMC);

            $("#xgf_zyjs").change(function(){
                var jsbm = $("#xgf_zyjs").val();
                $.ajax({
                    url: "/character/getJsqx",
                    type: "post",
                    async: false,
                    data: {jsbm:jsbm, timeer: new Date() },
                    success: function (data) {
                        var dataJson = JSON.parse(data);
                        if (dataJson.length > 0){
                            var qxmcs = "",qxbms=[];
                            for (var i = 0;i< dataJson.length; i++){
                                if (i >= dataJson.length-1){
                                    qxmcs += dataJson[i].F_QXMC;
                                }else{
                                    qxmcs += dataJson[i].F_QXMC+",";
                                }
                                qxbms[i]=dataJson[i].F_QXBM;
                            }
                            $('#xgf_zyqxmc').val(qxmcs);
                            $('#xgf_zyqx').val(qxbms.join(','));
                            $("#qxtable").find("input:checkbox").attr("checked",false);

                            var obj=null;
                            for (var i = 0; i < dataJson.length; i++){
                                obj = $("#qxtable").find('input[value='+dataJson[i].F_QXBM+']');
                                obj.attr("checked",true);
                            }
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert(errorThrown + "||" + textStatus);
                    }
                });
            });
        }
        
        //加载职员角色
        function loadzyjs() {
            $.ajax({
                url: "/character/getJsdab",
                type: "post",
                async: false,
                data: {jsbm:"", timeer: new Date() },
                success: function (data) {
                    var $selected = $('#f_zyjs');
                    var $selected2 = $('#xgf_zyjs');
                    $selected.html("");
                    $selected.append('<option value=""></option>');
                    $selected2.html("");
                    $selected2.append('<option value=""></option>');
                    var dataJson = JSON.parse(data);
                    jsdaJson = dataJson;
                    if(dataJson.length>0) {
                        for(var i=0;i<dataJson.length;i++){
                            var jsxx=dataJson[i];
                            $selected.append('<option value="'+jsxx.F_JSBM+'">'+jsxx.F_JSMC+'</option>');
                            $selected2.append('<option value="'+jsxx.F_JSBM+'">'+jsxx.F_JSMC+'</option>');
                        }
                        $selected.trigger('changed.selected.amui');
                        $selected2.trigger('changed.selected.amui');
                    }else{
                        $('#xgf_zyjs').html("");
                        $('#f_zyjs').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        //加载所辖部门
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

        //加载权限
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
        }

        //权限展示
        function loadQxzsmx(qxmx){
            var dataJson = qxmx.split(",");
            var qxtable="";
            for(var i=0;i<dataJson.length;i++){
                var qxmx=dataJson[i];
                if(qxtable==""){
                    qxtable+="<tr>\n";
                    qxtable+="                            <td class=\"am-text-middle\">"+qxmx+"</td>\n";
                    qxtable+="                        </tr>";
                }else{
                    qxtable+="<tr>\n";
                    qxtable+="                            <td class=\"am-text-middle\">"+qxmx+"</td>\n";
                    qxtable+="                        </tr>";
                }
            }
            $('#qxzstable').html(qxtable);
        }

        function QxmxPage(index){
            $.ajax({
                url: "/clerk/getZyqx",
                type: "post",
                async: false,
                data: {zybm:"",qxxx:"",timeer: new Date() },
                success: function (data) {
                    var zyqx = JSON.parse(data);
                    var zyda=zyqx[index];
                    $('#chooseQxzsdiv').modal({
                        closeViaDimmer: false,
                        width:680,
                        height:500
                    });
                    loadQxzsmx(zyda.F_QXMC);
                    qxzsQxmc = zyda.F_QXMC;
                    qxzsZybm = zyda.F_ZYBM;
                    $('#chooseQxzsdiv').modal('open');
                    $('#chooseQxzsdiv').css("z-index","1219");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }

        function searchQx() {
            var qxxx=$('#qxoption').val();
            loadQxmx(qxxx);
        };

        function searchQxzs() {
            var qxxx = $('#qxzsoption').val();
            var zybm = qxzsZybm;
            if (qxxx == null || qxxx == ""){
                loadQxzsmx(qxzsQxmc);
            }else{
                $.ajax({
                    url: "/clerk/getZyqx",
                    type: "post",
                    async: false,
                    data: {zybm:zybm,qxxx:qxxx,timeer: new Date() },
                    success: function (data) {
                        var zyda = JSON.parse(data);
                        loadQxzsmx(zyda[0].F_QXMC);
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert(errorThrown + "||" + textStatus);
                        $("#savaBtn").button('reset');
                    }
                });
            }
        };

        function alertMsg(msg){
            $('#alertcontent ',parent.document).text(msg);
            $('#alertdlg',parent.document).modal('open');
        }

        //全部权限
        function allQx() {
            $.ajax({
                url: "/character/queryAllJsqx",
                type: "post",
                async: false,
                data: {timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    allqx = dataJson;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }

    </script>
</body>
</html>
