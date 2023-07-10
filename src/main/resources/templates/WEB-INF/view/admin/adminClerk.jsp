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
    <title>云平台管理平台-人员管理</title>
    <meta name="description" content="云平台管理平台-人员管理">
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
                    <h1>人员管理</h1>
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
                                <th class="am-text-middle">职员编码</th>
                                <th class="am-text-middle">职员名称</th>
                                <th class="am-text-middle">口令</th>
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

    <script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
    <script src="/assets/js/amazeui.min.js"></script>
    <script src="/assets/js/app.js"></script>
    <script src="/assets/address/address.min.js"></script>
    <script src="/assets/address/iscroll.min.js"></script>
    <script type="text/javascript">
        var loadJson = null;
        $(function() {
            loadZyxx("");
            //显示新增客户
            $('#addzy').click(function () {

                $("#f_zymc").val("");
                $("#f_sjh").val("");
                $("#f_zykl").val("");

                $('#newZydiv').modal({
                    closeViaDimmer: false,
                    width: 580,
                    height: 600
                });
                $('#newZydiv').modal('open');
                $('.am-dimmer').css("z-index", "1111");
                $('#newZydiv').css("z-index", "1119");
            });
            //关闭还原遮罩蒙板z-index
            $('#newZydiv').on('closed.modal.amui', function () {
                $('.am-dimmer').css("z-index", "1100");
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
                            var zykl = $("#f_zykl").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/adminClerk/addClerk",
                                    type: "post",
                                    async: false,
                                    data: {zymc: zymc, sjh: sjh, zykl: zykl, timeer: new Date()},
                                    success: function (data, textStatus) {
                                        if (data == "ok") {
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
            $('#updateZydiv').on('closed.modal.amui', function () {
                $('.am-dimmer').css("z-index", "1100");
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
                            var zykl = $("#xgf_zykl").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/adminClerk/updateClerk",
                                    type: "post",
                                    async: false,
                                    data: {zybm: zybm, zymc: zymc, sjh: sjh, zykl: zykl, timeer: new Date()},
                                    success: function (data, textStatus) {
                                        if (data == "ok") {
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


            $('#hovertables').hover(function () {
                $('#hovertables').css("overflow", "auto")
            }, function () {
                $('#hovertables').css("overflow", "hidden")
            });

        });

        function searchZy() {
            var jsxx=$('#spoption').val();
            loadZyxx(jsxx);
        };
        //加载人员
        function loadZyxx(jsxx){
            $.ajax({
                url: "/adminClerk/getClerk",
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
                                    "                            <td class=\"am-text-middle\">"+zyda.F_ZYMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_ZYKL+"</td>\n" +
                                    "                        </tr>"
                            }else{
                                zymxhtml+="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>" +
                                    " &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+zyda.F_ZYBM+"')\">删除</a>" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_ZYMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_ZYMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_ZYKL+"</td>\n" +
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
                url: "/adminClerk/removeClerk",
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

        function alertMsg(msg){
            $('#alertcontent ',parent.document).text(msg);
            $('#alertdlg',parent.document).modal('open');
        }

    </script>
</body>
</html>
