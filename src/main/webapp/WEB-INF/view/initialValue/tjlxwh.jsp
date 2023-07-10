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
    <title>云平台客户端V1-统计类型维护</title>
    <meta name="description" content="云平台客户端V1-统计类型维护">
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
        .am-scrollable-vertical {
            height: 600px;
        }
    </style>
</head>
<body>
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-12" id="xsdiv">
            <div class="header">
                <div class="am-g">
                    <h1>统计类型维护</h1>
                </div>
            </div>
        </div>

        <div class="am-u-sm-12 am-u-md-12 am-text-right">
            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="addlx()">增加</button>
            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="updatelx()">修改</button>
            <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" onclick="deletelx()">删除</button>
        </div>

        <%--统计类型维护div--%>
        <div class="am-scrollable-horizontal am-scrollable-vertical">
            <table class="am-table am-table-bordered am-text-nowrap">
                <thead>
                    <tr>
                        <td class=\"am-text-middle\">统计类型</td>
                        <td class=\"am-text-middle\">显示序号</td>
                        <td class=\"am-text-middle\">是否种养类型</td>
                        <td class=\"am-text-middle\">是否适用农户</td>
                        <td class=\"am-text-middle\">是否适用大户</td>
                        <td class=\"am-text-middle\">是否适用合作社</td>
                    </tr>
                </thead>
                <tbody id="tjlxwhTable">
                </tbody>
            </table>
        </div>
    </div>

    <%--增加类型div--%>
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="newLxdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">新增类型
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd am-scrollable-vertical" style="min-height: 500px;">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal">
                        <div class="am-form-group">
                            <label for="f_tjlxmc" class="am-u-sm-4 am-form-label">统计类型</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_tjlxmc" placeholder="统计类型">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_flbm" class="am-u-sm-4 am-form-label">显示序号</label>
                            <div class="am-u-sm-7">
                                <input type="text" disabled="disabled" class="am-form-field am-input-sm am-radius" id="f_flbm" required placeholder="显示序号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sfzylx" class="am-u-sm-4 am-form-label">是否种养类型</label>
                            <div class="am-u-sm-7">
                                <div class=\"am-u-sm-12\" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '100%'}" id="f_sfzylx">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sfsynh" class="am-u-sm-4 am-form-label">是否适用农户</label>
                            <div class="am-u-sm-7">
                                <div class=\"am-u-sm-12\" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '100%'}" id="f_sfsynh">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sfsydh" class="am-u-sm-4 am-form-label">是否适用大户</label>
                            <div class="am-u-sm-7">
                                <div class=\"am-u-sm-12\" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '100%'}" id="f_sfsydh">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sfsyhzs" class="am-u-sm-4 am-form-label">是否适用合作社</label>
                            <div class="am-u-sm-7">
                                <div class=\"am-u-sm-12\" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '100%'}" id="f_sfsyhzs">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="button" onclick="savelx()" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeNewLxdiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%--修改类型div--%>
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="updateLxdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">修改类型
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd am-scrollable-vertical" style="min-height: 500px;">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal">
                        <div class="am-form-group">
                            <label for="xgf_tjlxmc" class="am-u-sm-4 am-form-label">统计类型</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_tjlxmc" placeholder="统计类型">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_flbm" class="am-u-sm-4 am-form-label">显示序号</label>
                            <div class="am-u-sm-7">
                                <input type="text" disabled="disabled" class="am-form-field am-input-sm am-radius" id="xgf_flbm" required placeholder="显示序号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_sfzylx" class="am-u-sm-4 am-form-label">是否种养类型</label>
                            <div class="am-u-sm-7">
                                <div class=\"am-u-sm-12\" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '100%'}" id="xgf_sfzylx">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_sfsynh" class="am-u-sm-4 am-form-label">是否适用农户</label>
                            <div class="am-u-sm-7">
                                <div class=\"am-u-sm-12\" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '100%'}" id="xgf_sfsynh">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_sfsydh" class="am-u-sm-4 am-form-label">是否适用大户</label>
                            <div class="am-u-sm-7">
                                <div class=\"am-u-sm-12\" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '100%'}" id="xgf_sfsydh">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_sfsyhzs" class="am-u-sm-4 am-form-label">是否适用合作社</label>
                            <div class="am-u-sm-7">
                                <div class=\"am-u-sm-12\" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '100%'}" id="xgf_sfsyhzs">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="button" onclick="saveUpdatelx()" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeUpdateLxdiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--删除类型div-->
    <div class="am-modal am-modal-confirm" tabindex="-1" id="deleteLxdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-bd">
                确定要删除这条记录吗？
            </div>
            <div class="am-modal-footer">
                <span class="am-modal-btn" data-am-modal-confirm onclick="deleteLxbtn()">确定</span>
                <span class="am-modal-btn" data-am-modal-cancel onclick="closeDeleteLxdiv()">取消</span>
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
        var clickTjlxmc = null;
        var clickFlbm = null;
        var clickSfzylx = null;
        var clickSfsynh = null;
        var clickSfsydh = null;
        var clickSfsyhzs = null;

        $(function(){
            loadTjlxxx();
        });

        //加载统计类型信息
        function loadTjlxxx(){
            $.ajax({
                url: "/initialvalues/getTjlxxx",
                type: "post",
                async: false,
                data: { timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    loadJson = dataJson;
                    if(dataJson.length>0) {
                        var tjlxwhTableHtml = "";
                        for(var i=0;i<dataJson.length;i++){
                            var lxxx=dataJson[i];
                            tjlxwhTableHtml +="<tr  id=\"tr"+lxxx.F_FLBM+"\" onclick='getlxzsxh("+i+")'>\n" +
                                "                <td class=\"am-text-middle\">"+lxxx.F_TJLXMC+"</td>\n" +
                                "                <td class=\"am-text-middle\">"+lxxx.F_FLBM+"</td>\n"
                            if (lxxx.F_SFZYLX == 1){
                                tjlxwhTableHtml += " <td class=\"am-text-middle\">是</td>\n"
                            }else{
                                tjlxwhTableHtml += " <td class=\"am-text-middle\">否</td>\n"
                            }
                            if (lxxx.F_SFSYNH == 1){
                                tjlxwhTableHtml += " <td class=\"am-text-middle\">是</td>\n"
                            }else{
                                tjlxwhTableHtml += " <td class=\"am-text-middle\">否</td>\n"
                            }
                            if (lxxx.F_SFSYDH == 1){
                                tjlxwhTableHtml += " <td class=\"am-text-middle\">是</td>\n"
                            }else{
                                tjlxwhTableHtml += " <td class=\"am-text-middle\">否</td>\n"
                            }
                            if (lxxx.F_SFSYHZS == 1){
                                tjlxwhTableHtml += " <td class=\"am-text-middle\">是</td>\n"
                            }else{
                                tjlxwhTableHtml += " <td class=\"am-text-middle\">否</td>\n"
                            }
                            tjlxwhTableHtml += "</tr>";
                            $('#tjlxwhTable').html(tjlxwhTableHtml);
                        }
                    }else{
                        $('#tjlxwhTable').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        };

        //弹出新增类型div
        function addlx() {
            $.ajax({
                url: "/initialvalues/queryMaxFlbm",
                type: "post",
                async: false,
                data: { timmer: new Date() },
                success:function(data){
                    $("#f_tjlxmc").val("");
                    $("#f_flbm").val(data);
                    $("#f_sfzylx").val("");
                    $("#f_sfsynh").val("");
                    $("#f_sfsydh").val("");
                    $("#f_sfsyhzs").val("");

                    $('#newLxdiv').modal({
                        closeViaDimmer: false,
                        width:580,
                        height:500
                    });
                    $('#newLxdiv').modal('open');
                    $('.am-dimmer').css("z-index","1111");
                    $('#newLxdiv').css("z-index","1119");

                    var lxHtml = "<option value=\"0\">否</option>" +
                    "             <option value=\"1\">是</option>";
                    $("#f_sfzylx").html(lxHtml);
                    $("#f_sfsynh").html(lxHtml);
                    $("#f_sfsydh").html(lxHtml);
                    $("#f_sfsyhzs").html(lxHtml);

                    //关闭还原遮罩蒙板z-index
                    $('#newLxdiv').on('closed.modal.amui', function() {
                        $('.am-dimmer').css("z-index","1100");
                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        //保存新增类型信息
        function savelx() {
            var f_tjlxmc = $("#f_tjlxmc").val();
            var f_flbm = $("#f_flbm").val();
            var f_sfzylx = $("#f_sfzylx").val();
            var f_sfsynh = $("#f_sfsynh").val();
            var f_sfsydh = $("#f_sfsydh").val();
            var f_sfsyhzs = $("#f_sfsyhzs").val();
            $.ajax({
                url: "/initialvalues/addlx",
                type: "post",
                async: false,
                data: { f_tjlxmc:f_tjlxmc,f_flbm:f_flbm,f_sfzylx:f_sfzylx,f_sfsynh:f_sfsynh,f_sfsydh:f_sfsydh, f_sfsyhzs:f_sfsyhzs,timmer: new Date() },
                success: function (data) {
                    if(data == "ok"){
                        alertMsg("保存成功！");
                    }else if(data == "405"){
                        alertMsg("新增类型信息不能为空！");
                    } else if(data == "408"){
                        alertMsg("请先将别的统计类型下的是否种养类型变更为否！");
                    }else if(data == "410"){
                        alertMsg("必须先选择适用的客户类型，才能设置种养类型为是！");
                    }
                    closeNewLxdiv();
                    loadTjlxxx();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }

        //弹出修改类型div
        function updatelx() {
            $('#updateLxdiv').modal({
                closeViaDimmer: false,
                width:580,
                height:500
            });
            $('#updateLxdiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#updateLxdiv').css("z-index","1119");
            //关闭还原遮罩蒙板z-index
            $('#updateLxdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });

            $('#xgf_tjlxmc').val(clickTjlxmc);
            $('#xgf_flbm').val(clickFlbm);

            var lxHtml = "";
            if (clickSfzylx == 1){
                lxHtml = "<option value=\"0\">否</option>" +
                    "     <option value=\"1\" selected>是</option>";
            }else {
                lxHtml = "<option value=\"0\" selected>否</option>" +
                    "     <option value=\"1\">是</option>";
            }
            $("#xgf_sfzylx").html(lxHtml);

            if (clickSfsynh == 1){
                lxHtml = "<option value=\"0\">否</option>" +
                    "     <option value=\"1\" selected>是</option>";
            }else {
                lxHtml = "<option value=\"0\" selected>否</option>" +
                    "     <option value=\"1\">是</option>";
            }
            $("#xgf_sfsynh").html(lxHtml);

            if (clickSfsydh == 1){
                lxHtml = "<option value=\"0\">否</option>" +
                    "     <option value=\"1\" selected>是</option>";
            }else {
                lxHtml = "<option value=\"0\" selected>否</option>" +
                    "     <option value=\"1\">是</option>";
            }
            $("#xgf_sfsydh").html(lxHtml);

            if (clickSfsyhzs == 1){
                lxHtml = "<option value=\"0\">否</option>" +
                    "     <option value=\"1\" selected>是</option>";
            }else {
                lxHtml = "<option value=\"0\" selected>否</option>" +
                    "     <option value=\"1\">是</option>";
            }
            $("#xgf_sfsyhzs").html(lxHtml);
        }


        //保存修改类型信息
        function saveUpdatelx() {
            var tjlxmc = $('#xgf_tjlxmc').val();
            var flbm = $('#xgf_flbm').val();
            var sfzylx = $('#xgf_sfzylx').val();
            var sfsynh = $('#xgf_sfsynh').val();
            var sfsydh = $('#xgf_sfsydh').val();
            var sfsyhzs = $('#xgf_sfsyhzs').val();

            $.ajax({
                url: "/initialvalues/updateLx",
                type: "post",
                async: false,
                data: { tjlxmc:tjlxmc,flbm:flbm,sfzylx:sfzylx,sfsynh:sfsynh,sfsydh:sfsydh,sfsyhzs:sfsyhzs,timmer: new Date() },
                success:function(data){
                    if(data == "ok"){
                        alertMsg("修改成功！");
                    }else if(data == "406"){
                        alertMsg("请输入统计类型！");
                    }else if(data == "409"){
                        alertMsg("请先将别的统计类型下的是否种养类型变更为否！");
                    }else if(data == "411"){
                        alertMsg("必须先选择适用的客户类型，才能设置种养类型为是！");
                    }
                    closeUpdateLxdiv();
                    loadTjlxxx();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        //弹出删除类型div
        function deletelx() {
            $('#deleteLxdiv').modal('open');
        }

        //保存删除类型div
        function deleteLxbtn() {
            $.ajax({
                url: "/initialvalues/deleteLx",
                type: "post",
                async: false,
                data: { flbm: clickFlbm, timeer: new Date() },
                success: function (data, textStatus) {
                    if (data == "ok"){
                        alertMsg("删除成功！");
                    }else if (data == "407"){
                        alertMsg("请选择要删除的统计类型！");
                    }
                    closeDeleteLxdiv();
                    loadTjlxxx();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        function getlxzsxh(index){
            clickTjlxmc = loadJson[index].F_TJLXMC;
            clickFlbm = loadJson[index].F_FLBM;
            clickSfzylx = loadJson[index].F_SFZYLX;
            clickSfsynh = loadJson[index].F_SFSYNH;
            clickSfsydh = loadJson[index].F_SFSYDH;
            clickSfsyhzs = loadJson[index].F_SFSYHZS;
            changeClick();
        }

        //关闭新增类型div
        function closeNewLxdiv(){
            $('#newLxdiv').modal('close');
        }

        //关闭修改类型div
        function closeUpdateLxdiv(){
            $('#updateLxdiv').modal('close');
        }

        //关闭删除类型div
        function closeDeleteLxdiv(){
            $('#deleteLxdiv').modal('close');
        }

        function alertMsg(msg){
            $('#alertcontent ',parent.document).text(msg);
            $('#alertdlg',parent.document).modal('open');
        }

        //点击角色变色显示
        function changeClick(){
            $("#tjlxwhTable tr").css("background-color","white");
            $("#tr"+clickFlbm+"").css("background-color","skyblue");
        }
    </script>
</body>
</html>
