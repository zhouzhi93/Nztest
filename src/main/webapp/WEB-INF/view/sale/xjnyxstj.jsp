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
    <title>云平台客户端V1-限禁农药销售统计</title>
    <meta name="description" content="云平台客户端V1-限禁农药销售统计">
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
        #sptable input{
            padding-bottom: 5px;
        }
        .am-container{
            padding-left: 0;
            padding-right: 0;
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
            <div class="am-form-inline">
                <div class="am-u-sm-5 am-u-md-5">
                    日期:
                    <input type="text" id="f_ksrq" class="am-form-field am-input-sm am-radius" style="width: 150px;" data-am-datepicker readonly placeholder="开始日期">至
                    <input type="text" id="f_jsrq" class="am-form-field am-input-sm am-radius" style="width: 150px;" data-am-datepicker readonly placeholder="结束日期">&nbsp;&nbsp;&nbsp;&nbsp;
                </div>
                <div class="am-u-sm-2 am-u-md-2">
                    <div class="am-form-inline">
                        <button onclick="cxjxnyxstj()" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger">查询</button>
                    </div>
                </div>
                <div class="am-u-sm-5 am-u-md-5">
                    <div class="am-u-sm-4 am-u-md-4">
                        <label class="am-radio-inline">
                            <input type="radio" value="0" checked="checked" name="f_cxfs"> 禁限农药
                        </label>
                    </div>
                    <div class="am-u-sm-8 am-u-md-8">
                        <div id="jxxzDiv">
                            <label class="am-radio-inline">
                                <input type="radio" value="0" checked="checked" name="f_jxxz"> 全部
                            </label>
                            <label class="am-radio-inline">
                                <input type="radio" value="1"  name="f_jxxz"> 禁止
                            </label>
                            <label class="am-radio-inline">
                                <input type="radio" value="2"  name="f_jxxz"> 限用
                            </label>
                        </div>
                    </div>
                    <br/>
                    <div class="am-u-sm-4 am-u-md-4">
                        <label class="am-radio-inline">
                            <input type="radio" value="1"  name="f_cxfs"> 施用作物
                        </label>
                    </div>
                    <div class="am-u-sm-8 am-u-md-8">
                        <div id="syzwxzDiv" style="display: none">
                            <label class="am-checkbox">
                                <input type="checkbox" value="豇豆" data-am-ucheck  checked="checked" name="syzwCheck"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;豇豆
                            </label>
                            <%--<label class="am-checkbox">
                                <input type="checkbox" value="水稻" data-am-ucheck  checked="checked" name="syzwCheck"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;水稻
                            </label>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="am-scrollable-horizontal" style="margin-top: 15px;">
            <table class="am-table am-table-bordered am-table-striped am-text-nowrap am-table-centered" id="jxnytjTitle">
                <thead>
                <tr>
                    <th class="am-text-middle">销售日期</th>
                    <th class="am-text-middle">销售网点</th>
                    <th class="am-text-middle">销售单号</th>
                    <th class="am-text-middle">农药名称</th>
                    <th class="am-text-middle">购买数量</th>
                    <th class="am-text-middle">购买人</th>
                    <th class="am-text-middle">手机号</th>
                    <th class="am-text-middle">身份证号</th>
                    <th class="am-text-middle">禁限类型</th>
                    <th class="am-text-middle">防治对象</th>
                    <th class="am-text-middle">施用作物</th>
                </tr>
                </thead>
                <tbody id="jxnytjTable">
                </tbody>
            </table>
            <table class="am-table am-table-bordered am-table-striped am-text-nowrap am-table-centered" id="syzwtjTitle" style="display: none;">
                <thead>
                <tr>
                    <th class="am-text-middle">销售日期</th>
                    <th class="am-text-middle">销售网点</th>
                    <th class="am-text-middle">销售单号</th>
                    <th class="am-text-middle">农药名称</th>
                    <th class="am-text-middle">购买数量</th>
                    <th class="am-text-middle">购买人</th>
                    <th class="am-text-middle">手机号</th>
                    <th class="am-text-middle">身份证号</th>
                    <th class="am-text-middle">防治对象</th>
                    <th class="am-text-middle">施用作物</th>
                </tr>
                </thead>
                <tbody id="syzwtjTable">
                </tbody>
            </table>
        </div>
    </div>
    <div class="am-modal am-modal-alert" tabindex="-1" id="alertdlg">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">提示</div>
            <div class="am-modal-bd" id="alertcontent">

            </div>
            <div class="am-modal-footer">
                <span class="am-modal-btn" id="okbtn">确定</span>
            </div>
        </div>
    </div>
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script src="/assets/js/app.js"></script>
<script src="/assets/address/address.min.js"></script>
<script src="/assets/address/iscroll.min.js"></script>
<script type="text/javascript">
    $(function (){
        //加载开始和结束日期
        var date = new Date();
        var year = date.getFullYear();
        var month = ((date.getMonth() + 1) < 10 ? "0" : "") + (date.getMonth() + 1);
        var day = (date.getDate() < 10 ? "0" : "") + date.getDate();
        $('#f_ksrq').val(year + "-" + month + "-" + day);
        $('#f_jsrq').val(year + "-" + month + "-" + day);

        //选择查询方式
        $('input[type=radio][name=f_cxfs]').change(function(){
            if(this.value=='0'){
                $('#jxxzDiv').show();
                $('#syzwxzDiv').hide();
                $('#jxnytjTitle').show();
                $('#syzwtjTitle').hide();
            }else{
                $('#jxxzDiv').hide();
                $('#syzwxzDiv').show();
                $('#jxnytjTitle').hide();
                $('#syzwtjTitle').show();
            }
        });

    })

    function cxjxnyxstj(){
        var f_cxfs=$('input[type=radio][name=f_cxfs]:checked').val();
        var f_ksrq=$('#f_ksrq').val();
        var f_jsrq=$('#f_jsrq').val();
        loadInfo(f_cxfs,f_ksrq,f_jsrq);
    }

    function loadInfo(f_cxfs,f_ksrq,f_jsrq) {
        //禁限农药
        if (f_cxfs=="0") {
            var $saletable = $('#jxnytjTable');
            $saletable.html('');

            var f_jxxz = $('input[type=radio][name=f_jxxz]:checked').val();

            $.ajax({
                url: "/sales/queryByJxny",
                type: "post",
                async: false,
                data: {f_jxxz:f_jxxz,f_ksrq:f_ksrq,f_jsrq:f_jsrq, timeer: new Date()},
                success: function (data) {
                    var res = JSON.parse(data);
                    var saleList = JSON.parse(res.list);
                    var syfwList = res.syfw;
                    if (saleList.length > 0) {
                        var salehtml = "";
                        for (var i = 0; i < saleList.length; i++) {
                            var sale = saleList[i];
                            var syfw = syfwList[i];
                            salehtml += "<tr>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_RZRQ + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_BMMC + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_DJH + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_SPMC + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_XSSL + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_CSMC + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_DH + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_SFZH + "</td>\n";
                            if (sale.F_NYBZ == 1){
                                salehtml += "<td class=\"am-text-middle\">禁止</td>\n";
                            }else if (sale.F_NYBZ == 2){
                                salehtml += "<td class=\"am-text-middle\">限用</td>\n";
                            }
                            if (sale.F_FZDX == undefined){
                                salehtml += "<td class=\"am-text-middle\"></td>\n";
                            }else {
                                salehtml += "<td class=\"am-text-middle\">" + sale.F_FZDX + "</td>\n";
                            }
                            salehtml += "<td class=\"am-text-middle\">" + syfw + "</td>\n" +
                                "                    </tr>";
                        }
                        $saletable.html(salehtml);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    var sessionstatus = XMLHttpRequest.getResponseHeader("sessionstatus");
                    if (sessionstatus == "logintimeout") {
                        alertMsg("登录超时，请重新登录！");
                        $('#okbtn').click(function () {
                            var win = window;
                            while (win != win.top){
                                win = win.top;
                            }
                            win.location = "/login";
                        });
                    }else{
                        alertMsg("请求异常");
                    }
                    $("#savaBtn").button('reset');
                }
            });
        }else{  //施用作物
            var syzwList = "";
            var syzwcount = $('#syzwxzDiv').find('label').length;
            for (var i = 0;i < syzwcount; i++){
                var syzwVal = $('#syzwxzDiv').find("label:eq("+i+")").find('input[type=checkbox][name=syzwCheck]:checked').val();
                if (i == syzwcount -1){
                    if (syzwVal != undefined){
                        syzwList += syzwVal;
                    }
                }else {
                    if (syzwVal != undefined){
                        syzwList += syzwVal + ",";
                    }
                }
            }
            var $saletable = $('#syzwtjTable');
            $saletable.html('');
            $.ajax({
                url: "/sales/queryBySyzw",
                type: "post",
                async: false,
                data: {f_syzw: syzwList,f_ksrq:f_ksrq,f_jsrq:f_jsrq, timeer: new Date()},
                success: function (data) {
                    var res = JSON.parse(data);
                    var saleList = JSON.parse(res.list);
                    var syfwList = res.syfw;
                    if (saleList.length > 0) {
                        var salehtml = "";
                        for (var i = 0; i < saleList.length; i++) {
                            var sale = saleList[i];
                            var syfw = syfwList[i];
                            salehtml += "<tr>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_RZRQ + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_BMMC + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_DJH + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_SPMC + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_XSSL + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_CSMC + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_DH + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + sale.F_SFZH + "</td>\n";
                            if (sale.F_FZDX == undefined){
                                salehtml += "<td class=\"am-text-middle\"></td>\n";
                            }else {
                                salehtml += "<td class=\"am-text-middle\">" + sale.F_FZDX + "</td>\n";
                            }
                            salehtml += "<td class=\"am-text-middle\">" + syfw + "</td>\n" +
                                "                    </tr>";
                        }
                        $saletable.html(salehtml);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    var sessionstatus = XMLHttpRequest.getResponseHeader("sessionstatus");
                    if (sessionstatus == "logintimeout") {
                        alertMsg("登录超时，请重新登录！");
                        $('#okbtn').click(function () {
                            var win = window;
                            while (win != win.top){
                                win = win.top;
                            }
                            win.location = "/login";
                        });
                    }else{
                        alertMsg("请求异常");
                    }
                    $("#savaBtn").button('reset');
                }
            });
        }
    }

    function alertMsg(msg){
        $('#alertcontent').text(msg);
        $('#alertdlg').modal('open');
        $('#alertdlg').css("z-index","1120");
    }
</script>
</body>
</html>
