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
    <title>云平台客户端V1-角色维护</title>
    <meta name="description" content="云平台客户端V1-角色维护">
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
        #jszs tr:hover{
            background-color: skyblue;
        }
    </style>
</head>
<body>
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-12" id="xsdiv">
            <div class="header">
                <div class="am-g">
                    <h1>角色维护</h1>
                </div>
            </div>
        </div>

        <%--功能按钮--%>
        <div class="am-container">
            <div class="am-text-left" style="padding-left: 0;padding-right: 0;">
                <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="addjs()">增加</button>
                <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="updatejs()">修改</button>
                <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" onclick="deletejs()">删除</button>
                <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="changeDyyh()" id="dyyhbtn">对应用户</button>
                <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="sqbtn()">授权</button>
                <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="checkAllBox()">全选</button>
                <button type="button" id="checkNoBoxBtn" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="checkNoBox()">全不选</button>
            </div>
        </div>

        <div class="am-container">
            <%--左侧角色名称--%>
            <div class="am-container am-u-sm-4 am-u-md-4 am-scrollable-vertical" id="chooseSplbdiv" style="border: 1px solid #DEDEDE;min-height: 500px;">
                <div class="am-g">
                    <div class="am-container">
                        <table class="am-table" id="jszs">

                        </table>
                    </div>
                </div>
            </div>

            <%--右侧角色权限和对应用户--%>
            <div class="am-container am-u-sm-8 am-u-md-8 am-scrollable-vertical"  style="border: 1px solid #DEDEDE;min-height: 500px;">
                <%--角色权限table--%>
                <table class="am-table am-table-bordered am-table-striped am-text-nowrap" id="jsqx">

                </table>
                <%--对应用户table--%>
                <table class="am-table am-table-bordered am-table-striped am-text-nowrap" id="dyyh">

                </table>
            </div>
        </div>
    </div>

    <%--增加角色div--%>
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="newJsdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">新增角色
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd am-scrollable-vertical" style="min-height: 500px;">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal">
                        <div class="am-form-group">
                            <label for="f_jsbm" class="am-u-sm-2 am-form-label">角色编码</label>
                            <div class="am-u-sm-9">
                                <input type="text" disabled="disabled" class="am-form-field am-input-sm am-radius" id="f_jsbm" required placeholder="角色编码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_jsmc" class="am-u-sm-2 am-form-label">角色名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_jsmc" placeholder="角色名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="button" onclick="savejs()" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeNewJsdiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--修改角色div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="updateJsdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">修改角色
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd am-scrollable-vertical" style="min-height: 400px;">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal">
                        <div class="am-form-group">
                            <label for="xgf_jsbm" class="am-u-sm-2 am-form-label">角色编码</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_jsbm" disabled="disabled" required placeholder="角色编码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_jsmc" class="am-u-sm-2 am-form-label">角色名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_jsmc" required placeholder="角色名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="submit" onclick="saveUpdatejs()" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeUpdateJsdiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--删除角色div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="deleteJsdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">删除角色
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd am-scrollable-vertical" style="min-height: 400px;">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal">
                        <div class="am-form-group">
                            <label for="scf_jsbm" class="am-u-sm-2 am-form-label">角色编码</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="scf_jsbm" required placeholder="角色编码" disabled>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="scf_jsmc" class="am-u-sm-2 am-form-label">角色名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="scf_jsmc" required placeholder="角色名称" disabled>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="button" onclick="saveDeletejs()" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeDeleteJsdiv()">取消</button>
                            </div>
                        </div>
                    </form>
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
        var jsdaJson = null;
        var clickjsbm = null;
        var clickjsmc = null;
        var allqxJson = null;
        var allzyJson = null;

        $(function (){
            //加载角色信息
            loadjswh();
            //加载全部角色权限
            loadJsqxda();
        });


        /*加载角色信息*/
        function loadjswh() {
            $.ajax({
                url: "/character/getJsdab",
                type: "post",
                async: "false",
                data: {jsbm: '', timmer: new Date()},
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    jsdaJson = dataJson;
                    if (dataJson.length > 0) {
                        var jsxxHtml = "";
                        for (var i = 0; i < dataJson.length; i++) {
                            var jsxx = dataJson[i];
                            if (jsxxHtml == "") {
                                jsxxHtml = "<tr id=\"tr"+jsxx.F_JSBM+"\">\n" +
                                    "                  <td class=\"am-text-middle\" onclick=\"getJsqxzy("+i+")\" id=\"zsf_jsbm\">" + jsxx.F_JSBM + "</td>\n" +
                                    "                  <td class=\"am-text-middle\" onclick=\"getJsqxzy("+i+")\" id=\"zsf_jsmc\">" + jsxx.F_JSMC + "</td>\n" +
                                    "       </tr>"
                            } else {
                                jsxxHtml += "<tr id=\"tr"+jsxx.F_JSBM+"\">\n" +
                                    "                  <td class=\"am-text-middle\" onclick=\"getJsqxzy("+i+")\" id=\"zsf_jsbm\">" + jsxx.F_JSBM + "</td>\n" +
                                    "                  <td class=\"am-text-middle\" onclick=\"getJsqxzy("+i+")\" id=\"zsf_jsmc\">" + jsxx.F_JSMC + "</td>\n" +
                                    "       </tr>"
                            }
                        }
                        $('#jszs').html(jsxxHtml);
                    } else {
                        $('#jszs').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            })
        }

        //加载所有权限
        function loadJsqxda(){
            $.ajax({
                url:"/character/queryAllJsqx",
                type:"post",
                async: "false",
                data: {timmer: new Date()},
                success:function (data) {
                    var dataJson = JSON.parse(data);
                    allqxJson = dataJson;
                    if (dataJson.length>0){
                        var qxxxHtml = "";
                        for (var i = 0; i < dataJson.length; i++){
                            var jsqx = dataJson[i];
                            var F_JB = jsqx.F_JB;
                            if(F_JB == 1){
                                qxxxHtml += "<tr>\n" +
                                    "           <td>" +
                                    "               <input type=\"checkbox\" name=\"qxItems\" value=\""+jsqx.F_QXBM+"\" style=\"width: 40px\">" +
                                    jsqx.F_QXMC +
                                    "           </td>\n" +
                                    "       </tr>"
                            }else {
                                qxxxHtml += "<tr>\n" +
                                    "           <td style=\"padding-left: 20px\">" +
                                    "               <input type=\"checkbox\" name=\"qxItems\" value=\""+jsqx.F_QXBM+"\" style=\"width: 40px\">" +
                                    jsqx.F_QXMC +
                                    "           </td>\n" +
                                    "       </tr>"
                            }
                        }
                        $('#jsqx').html(qxxxHtml);
                    }else {
                        $('#jsqx').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }

        //角色实际拥有的权限和职员
        function getJsqxzy(index){
            clickjsbm = jsdaJson[index].F_JSBM;
            clickjsmc = jsdaJson[index].F_JSMC;
            changeClick();


            if ($("#dyyhbtn").text()=='对应用户'){
                getJsqx();
            }else {
                getjszy();
            }
        }

        //角色实际拥有的权限
        function getJsqx(){
            var jsbm = clickjsbm;
            var allqxjson = allqxJson;
            //和实际拥有的权限进行对照，如果拥有，将复选框状态更改为勾选状态
            $.ajax({
                url:"/character/getJsqx",//通过jsbm查询所有拥有的qxbm
                type:"post",
                async: "false",
                data: {jsbm:jsbm, timmer: new Date()},
                success:function (data) {
                    var dataJson = JSON.parse(data);
                    if (dataJson.length>0){
                        var qxbm = "";
                        for (var i = 0; i < allqxjson.length; i++){
                            $("#jsqx input:eq("+i+")").prop("checked",false);
                            for (var j = 0; j < dataJson.length; j++){
                                qxbm = dataJson[j].F_QXBM;
                                //实际拥有的qxbm存在
                                if (qxbm == allqxjson[i].F_QXBM){
                                    if (jsbm == "1000000001"){
                                        //将角色编码为1000000001时，所拥有的权限的复选框锁定
                                        $("#jsqx input:eq("+i+")").prop("disabled",true);
                                        //修改复选框状态为已勾选
                                        $("#jsqx input:eq("+i+")").prop("checked",true);
                                        //将全不选锁定
                                        $("#checkNoBoxBtn").prop("disabled",true);
                                    }else {
                                        //别的角色时，解锁权限复选框
                                        $("#jsqx input").prop("disabled",false);
                                        //修改复选框状态为已勾选
                                        $("#jsqx input:eq("+i+")").prop("checked",true);
                                        //将全不选解锁
                                        $("#checkNoBoxBtn").prop("disabled",false);
                                    }
                                }
                            }
                        }
                    }else{
                        $("#jsqx input").prop("checked",false);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        };

        //角色实际拥有的职员
        function getjszy() {
            var jsbm = clickjsbm;
            var allzyjson = allzyJson;
            //和实际拥有的职员进行对照，如果拥有，将复选框状态更改为勾选状态
            $.ajax({
                url:"/character/getZyda",//通过jsbm查询所有拥有的qxbm
                type:"post",
                async: "false",
                data: {jsbm:jsbm, timmer: new Date()},
                success:function (data) {
                    var dataJson = JSON.parse(data);
                    if (dataJson.length>0){
                        var zybm = "";
                        for (var i = 0; i < allzyjson.length; i++){
                            $("#dyyh input:eq("+i+")").prop("checked",false);
                            for (var j = 0; j < dataJson.length; j++){
                                zybm = dataJson[j].F_ZYBM;
                                //实际拥有的zybm存在
                                if (zybm == allzyjson[i].F_ZYBM){
                                    if (jsbm == "1000000001"){
                                        //修改复选框状态为已勾选
                                        $("#dyyh input:eq("+i+")").prop("checked",true);
                                        //将全不选锁定
                                        $("#checkNoBoxBtn").prop("disabled",true);
                                    }else {
                                        //修改复选框状态为已勾选
                                        $("#dyyh input:eq("+i+")").prop("checked",true);
                                        //将全不选解锁
                                        $("#checkNoBoxBtn").prop("disabled",false);
                                    }
                                }
                            }
                        }
                    }else{
                        $("#dyyh input").prop("checked",false);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }

        //授权
        function sqbtn(){
            if ($("#dyyhbtn").text()=="对应用户"){
                sqqx();
            }else {
                sqzy();
            }
        }

        //权限授权
        function sqqx() {
            var jsbm = clickjsbm;
            var qxItem = "";
            var noqxItem = "";

            $("input[name='qxItems']:checked").each(function() {
                //遍历选中的复选框，并转换成一个数组
                qxItem += $(this).val()+",";
            });

            $("input[name='qxItems']").not("input:checked").each(function() {
                //遍历未选中的复选框，并转换成一个数组
                noqxItem += $(this).val()+",";
            });

            //ajax将数组传给后端添加数据库
            $.ajax({
                url:"/character/updateJsqx",
                type:"post",
                async: "false",
                data: {jsbm:jsbm,qxbmList:qxItem,noqxbmList:noqxItem,timmer: new Date()},
                success:function (data) {
                    if (data == "ok"){
                        alertMsg("保存成功！");
                        $("input[name='qxItems']:checked").attr("checked","checked");
                        loadjswh();
                    }else if (data == "408"){
                        alertMsg("请联系管理员修改角色权限！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }

        //职员授权
        function sqzy() {
            var jsbm = clickjsbm;
            var zyItem = "";
            var nozyItem = "";

            $("input[name='zyItems']:checked").each(function() {
                //遍历选中的复选框，并转换成一个数组
                zyItem += $(this).val()+",";
            });

            $("input[name='zyItems']").not("input:checked").each(function() {
                //遍历未选中的复选框，并转换成一个数组
                nozyItem += $(this).val()+",";
            });

            //ajax将数组传给后端添加数据库
            $.ajax({
                url:"/character/updateJszy",
                type:"post",
                async: "false",
                data: {jsbm:jsbm,zybmList:zyItem,nozybmList:nozyItem,timmer: new Date()},
                success:function (data) {
                    if (data == "ok"){
                        alertMsg("保存成功！");
                    }else if (data == "409"){
                        alertMsg("请联系管理员修改角色！");
                    }
                    $("input[name='zyItems']:checked").attr("checked","checked");
                    loadjswh();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }

        //弹出新增角色div
        function addjs() {
            $('f_jsbm').val('');
            $('f_jsmc').val('');

            $('#newJsdiv').modal({
                closeViaDimmer: false,
                width:580,
                height:300
            });
            $('#newJsdiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#newJsdiv').css("z-index","1119");
            //关闭还原遮罩蒙板z-index
            $('#newJsdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });

            $.ajax({
                url: "/character/queryMaxJsbm",
                type: "post",
                async: false,
                data: { timmer: new Date() },
                success:function(data){
                    $('#f_jsbm').val(data);
                    $('#f_jsmc').val('');
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        //保存新增角色信息
        function savejs() {
            var jsbm = $("#f_jsbm").val();
            var jsmc = $("#f_jsmc").val();
            $.ajax({
                url: "/character/addjs",
                type: "post",
                async: false,
                data: { jsbm:jsbm,jsmc:jsmc, timmer: new Date() },
                success: function (data) {
                    if(data == "ok"){
                        alertMsg("保存成功！");
                    }else if (data == "405"){
                        alertMsg("请联系管理员添加角色！");
                    }
                    closeNewJsdiv();
                    loadjswh();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }



        //弹出修改角色div
        function updatejs() {
            $('#updateJsdiv').modal({
                closeViaDimmer: false,
                width:580,
                height:300
            });
            $('#updateJsdiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#updateJsdiv').css("z-index","1119");
            //关闭还原遮罩蒙板z-index
            $('#updateJsdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });

            var jsbm = clickjsbm;
            var jsmc = clickjsmc;

            $('#xgf_jsbm').val(jsbm);
            $('#xgf_jsmc').val(jsmc);
        }


        //保存修改角色信息
        function saveUpdatejs() {
            var jsbm = $("#xgf_jsbm").val();
            var jsmc = $("#xgf_jsmc").val();

            $.ajax({
                url: "/character/updateJs",
                type: "post",
                async: false,
                data: { jsbm:jsbm,jsmc:jsmc,timmer: new Date() },
                success:function(data){
                    if(data == "ok"){
                        alertMsg("修改成功！");
                    }else if (data == "406"){
                        alertMsg("请联系管理员修改角色！");
                    }
                    closeUpdateJsdiv();
                    loadjswh();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        //弹出删除角色div
        function deletejs() {
            var jsbm = clickjsbm;
            var jsmc = clickjsmc;

            $('#deleteJsdiv').modal({
                closeViaDimmer: false,
                width:580,
                height:300
            });
            $('#deleteJsdiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#deleteJsdiv').css("z-index","1119");
            //关闭还原遮罩蒙板z-index
            $('#deleteJsdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });

            $('#scf_jsbm').val(jsbm);
            $('#scf_jsmc').val(jsmc);
        }


        //保存删除角色信息
        function saveDeletejs() {
            var jsbm = clickjsbm;

            $.ajax({
                url: "/character/deleteJs",
                type: "post",
                async: false,
                data: { jsbm:jsbm,timmer: new Date() },
                success:function(data){
                    if(data == "ok"){
                        alertMsg("删除成功！");
                    }else if (data == "410"){
                        alertMsg("无法删除该角色！");
                    }else if (data == "407"){
                        alertMsg("请联系管理员删除角色！");
                    }
                    closeUpdateJsdiv();
                    loadjswh();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        //切换对应用户页面
        function changeDyyh(){
            $.ajax({
                url:"/character/getZyda",
                type:"post",
                async: "false",
                data: {jsbm:'', timmer: new Date()},
                success:function (data) {
                    var dataJson = JSON.parse(data);
                    allzyJson = dataJson;
                    var zyxxHtml = "<tr>\n" +
                        "           <td> </td>\n" +
                        "           <td>职员名称</td>\n" +
                        "           <td>所辖部门</td>\n" +
                        "           <td>手机号</td>\n" +
                        "       </tr>";
                    for (var i =0;i<dataJson.length;i++){
                        if (i == 0){
                            zyxxHtml += "<tr>\n" +
                                "           <td><input type=\"checkbox\" name=\"zyItems\" value=\""+dataJson[i].F_ZYBM+"\" disabled style=\"width: 40px\"></td>\n" +
                                "           <td>"+dataJson[i].F_ZYMC+"</td>\n" +
                                "           <td>"+dataJson[i].F_BMMC+"</td>\n" +
                                "           <td>"+dataJson[i].F_SJH+"</td>\n" +
                                "       </tr>"
                        }else {
                            zyxxHtml += "<tr>\n" +
                                "           <td><input type=\"checkbox\" name=\"zyItems\" value=\""+dataJson[i].F_ZYBM+"\" style=\"width: 40px\"></td>\n" +
                                "           <td>"+dataJson[i].F_ZYMC+"</td>\n" +
                                "           <td>"+dataJson[i].F_BMMC+"</td>\n" +
                                "           <td>"+dataJson[i].F_SJH+"</td>\n" +
                                "       </tr>"
                        }
                    }
                    $("#dyyh").html(zyxxHtml);

                    if ($("#dyyhbtn").text()=='对应用户'){
                        $("#jsqx").hide();
                        $("#dyyh").show();
                        $("#dyyhbtn").text('对应权限');
                        getjszy();
                    }else {
                        $("#dyyh").hide();
                        $("#jsqx").show();
                        $("#dyyhbtn").text('对应用户');
                        getJsqx();
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }
        
        //全选
        function checkAllBox() {
            $("input[name='qxItems']").attr("checked",true);
            $("input[name='zyItems']").attr("checked",true);
        }

        //全不选
        function checkNoBox() {
            $("input[name='qxItems']").attr("checked",false);
            $("input[name='zyItems']").attr("checked",false);
        }

        //关闭新增角色div
        function closeNewJsdiv(){
            $('#newJsdiv').modal('close');
        }

        //关闭修改角色div
        function closeUpdateJsdiv(){
            $('#updateJsdiv').modal('close');
        }

        //关闭删除角色div
        function closeDeleteJsdiv(){
            $('#deleteJsdiv').modal('close');
        }

        //弹出提示框
        function alertMsg(msg){
            $('#alertcontent ',parent.document).text(msg);
            $('#alertdlg',parent.document).modal('open');
        }

        //点击角色变色显示
        function changeClick(){
            $("#jszs tr").css("background-color","white");
            $("#tr"+clickjsbm+"").css("background-color","skyblue");
        }
    </script>
</body>
</html>
