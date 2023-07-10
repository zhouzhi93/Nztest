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
                <h1>仓库档案维护</h1>
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
            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="saveCkda()" id="savesplb">保存</button>
            <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" onclick="deleteCkda()" id="deleteCkda">删除</button>
        </div>
    </div>
    <div class="am-container">
        <%--左侧三级列表--%>
        <div class="am-container am-u-sm-4 am-u-md-4 am-scrollable-vertical" id="chooseSplbdiv" style="border: 1px solid #DEDEDE;min-height: 500px;">
            <iframe id="ckdaTree" height="100%" width="100%" src="/initialvalues/gotoCkdaTree">

            </iframe>
        </div>
        <%--右侧显示列表--%>
        <div class="am-container am-u-sm-8 am-u-md-8">
            <div class="am-modal-bd" style="min-height: 500px;border: 1px solid #DEDEDE;">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal">
                        <div class="am-form-group">
                            <label for="f_ckbm" class="am-u-sm-3 am-form-label">仓库编码</label>
                            <div class="am-u-sm-9">
                                <input type="number" disabled="disabled" class="am-form-field am-input-sm am-radius" id="f_ckbm" required placeholder="仓库编码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_ckmc" class="am-u-sm-3 am-form-label">仓库名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_ckmc" required placeholder="仓库名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_ckmj" class="am-u-sm-3 am-form-label">仓库面积(㎡)</label>
                            <div class="am-u-sm-9">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="f_ckmj" required placeholder="仓库面积(㎡)">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_dz" class="am-u-sm-3 am-form-label">地址</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_dz" required placeholder="地址">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_dh" class="am-u-sm-3 am-form-label">电话</label>
                            <div class="am-u-sm-9">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="f_dh" required placeholder="电话">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_fzr" class="am-u-sm-3 am-form-label">负责人</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_fzr" required placeholder="负责人">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_cksx" class="am-u-sm-3 am-form-label">仓库属性</label>
                            <div class="am-u-sm-9">
                                <select data-am-selected="{btnWidth: '100%',btnSize: 'sm'}" id="f_cksx">
                                </select>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!--删除div-->
<div class="am-modal am-modal-confirm" tabindex="-1" id="deleteCkdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-bd">
            确定要删除这条记录吗？
        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn" data-am-modal-confirm onclick="deleteCkbtn()">确定</span>
            <span class="am-modal-btn" data-am-modal-cancel onclick="closeDeleteCkdiv()">取消</span>
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
    var tempckbm = null;
    var tempJb = null;
    var ckmxJson = null;

    //加载客户
    function loadckdaxx(f_ckbm){
        $.ajax({
            url: "/initialvalues/getCkda",
            type: "post",
            async: false,
            data: {f_ckbm:f_ckbm, timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                loadJson = dataJson;
                var result = dataJson[0];
                $("#f_ckbm").val(result.F_CKBM);
                $("#f_ckmc").val(result.F_CKMC);
                $("#f_ckmj").val(result.F_CKMJ);
                $("#f_dz").val(result.F_DZ);
                $("#f_dh").val(result.F_DH);
                $("#f_fzr").val(result.F_FZR);

                var cksxHtml = "";
                if (result.F_CKSX == 0){
                    cksxHtml = "<option value=\"0\" selected>正常仓库</option>" +
                        "       <option value=\"1\">退货仓库</option>" +
                        "       <option value=\"2\">原料仓库</option>";
                }else if (result.F_CKSX == 1){
                    cksxHtml = "<option value=\"0\">正常仓库</option>" +
                        "       <option value=\"1\" selected>退货仓库</option>" +
                        "       <option value=\"2\">原料仓库</option>";
                }else if (result.F_CKSX == 2){
                    cksxHtml = "<option value=\"0\">正常仓库</option>" +
                        "       <option value=\"1\">退货仓库</option>" +
                        "       <option value=\"2\" selected>原料仓库</option>";
                }
                $("#f_cksx").html(cksxHtml);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    };

    function saveCkda() {
        var f_ckbm = $("#f_ckbm").val();
        var f_ckmc = $("#f_ckmc").val();
        var f_ckmj = $("#f_ckmj").val();
        var f_dz = $("#f_dz").val();
        var f_dh = $("#f_dh").val();
        var f_fzr = $("#f_fzr").val();
        var f_cksx = $("#f_cksx").val();

        $.ajax({
            url: "/initialvalues/saveCkda",
            type: "post",
            async: false,
            data: {f_ckbm:f_ckbm,f_ckmc:f_ckmc,f_ckmj:f_ckmj,f_dz:f_dz,f_dh:f_dh,f_fzr:f_fzr,f_cksx:f_cksx, timeer: new Date() },
            success: function (data) {
                if(data == "ok"){
                    alertMsg("保存成功！");
                    $("#f_ckbm").val(data);
                    $("#f_ckmc").val("");
                    $("#f_ckmj").val("");
                    $("#f_dz").val("");
                    $("#f_dh").val("");
                    $("#f_fzr").val("");
                    var cksxHtml = "";
                    cksxHtml = "<option value=\"0\" selected>正常仓库</option>" +
                        "       <option value=\"1\">退货仓库</option>" +
                        "       <option value=\"2\">原料仓库</option>";
                    $("#f_cksx").html(cksxHtml);
                    document.getElementById('ckdaTree').contentWindow.location.reload(true);
                }else if (data == "412"){
                    alertMsg("仓库中已有数据存在，无法新建或删除！");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    }

    //弹出删除明细div
    function deleteCkda() {
        $('#deleteCkdiv').modal('open');
    }

    function deleteCkbtn() {
        var f_ckbm = $("#f_ckbm").val();
        if(f_ckbm == '' || f_ckbm == null){
            alert("请先选择仓库！！");
            return;
        }
        $.ajax({
            url: "/initialvalues/deleteCkda",
            type: "post",
            async: false,
            data: {f_ckbm:f_ckbm, timeer: new Date() },
            success: function (data) {
                if(data == "ok"){
                    alertMsg("删除成功！");
                    $("#f_ckbm").val("");
                    $("#f_ckmc").val("");
                    $("#f_ckmj").val("");
                    $("#f_dz").val("");
                    $("#f_dh").val("");
                    $("#f_fzr").val("");
                    var cksxHtml = "";
                    cksxHtml = "<option value=\"0\" selected>正常仓库</option>" +
                        "       <option value=\"1\">退货仓库</option>" +
                        "       <option value=\"2\">原料仓库</option>";
                    $("#f_cksx").html(cksxHtml);
                    document.getElementById('ckdaTree').contentWindow.location.reload(true);
                } else if (data == "412"){
                    alertMsg("仓库中已有数据存在，无法新建或删除！");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    }

    function addTj(){
        var ckbm = tempckbm;
        var jb = tempJb;
        if(jb == '1' || jb == '' || jb == null){
            ckbm = "";
            jb = 1;
        }else{
            ckbm = ckbm.substring(0,ckbm.length-1);
        }
        $.ajax({
            url: "/initialvalues/getMaxCkda",
            type: "post",
            async: false,
            data: {ckbm:ckbm,jb:jb, timeer: new Date() },
            success: function (data) {
                $("#f_ckbm").val(data);
                $("#f_ckmc").val("");
                $("#f_ckmj").val("");
                $("#f_dz").val("");
                $("#f_dh").val("");
                $("#f_fzr").val("");
                var cksxHtml = "";
                cksxHtml = "<option value=\"0\" selected>正常仓库</option>" +
                    "       <option value=\"1\">退货仓库</option>" +
                    "       <option value=\"2\">原料仓库</option>";
                $("#f_cksx").html(cksxHtml);
                $("#zjul").click();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }

    function addZj(){
        var ckbm = tempckbm;
        if(ckbm == '' || ckbm == null){
            alert("请先选择仓库！！");
            return;
        }
        var jb = tempJb;
        if(jb == 3){
            alert("不能继续添加仓库！！");
            return;
        }
        jb = parseInt(jb)+1;
        $.ajax({
            url: "/initialvalues/getMaxCkda",
            type: "post",
            async: false,
            data: {ckbm:ckbm,jb:jb, timeer: new Date() },
            success: function (data) {
                $("#f_ckbm").val(data);
                $("#f_ckmc").val("");
                $("#f_ckmj").val("");
                $("#f_dz").val("");
                $("#f_dh").val("");
                $("#f_fzr").val("");
                var cksxHtml = "";
                cksxHtml = "<option value=\"0\" selected>正常仓库</option>" +
                    "       <option value=\"1\">退货仓库</option>" +
                    "       <option value=\"2\">原料仓库</option>";
                $("#f_cksx").html(cksxHtml);
                $("#zjul").click();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }

    //关闭删除类型div
    function closeDeleteCkdiv(){
        $('#deleteCkdiv').modal('close');
    }

    function alertMsg(msg){
        $('#alertcontent ',parent.document).text(msg);
        $('#alertdlg',parent.document).modal('open');
    }

</script>
</body>
</html>
