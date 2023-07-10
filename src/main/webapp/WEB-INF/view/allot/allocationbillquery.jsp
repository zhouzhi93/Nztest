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
    String f_qyck=(String)session.getAttribute("f_qyck");
%>
<%--<!DOCTYPE html>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-调拨查询</title>
    <meta name="description" content="云平台客户端V1-调拨查询">
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
    <div class="am-form-inline">
        调拨日期:
        <input type="text" id="f_ksrq" class="am-form-field am-input-sm am-radius" style="width: 150px;" data-am-datepicker readonly placeholder="开始日期">至
        <input type="text" id="f_jsrq" class="am-form-field am-input-sm am-radius" style="width: 150px;" data-am-datepicker readonly placeholder="结束日期">&nbsp;&nbsp;&nbsp;&nbsp;
        查询方式:
        <label class="am-radio-inline">
            <input type="radio" value="0" checked="checked" name="f_cxfs"> 单据汇总
        </label>
        <label class="am-radio-inline">
            <input type="radio" value="1"  name="f_cxfs"> 明细查询
        </label>
    </div>
    <div class="am-form-inline" style="margin-top: 10px;">
        <input type="text" id="khxx" class="am-form-field am-input-sm am-radius" style="width: 230px;" placeholder="在当前条件下搜索调出调入部门名、商品名">&nbsp;
        <button onclick="searchbyDb()" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger">查询</button>
        <button onclick="getexcel()" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger">导出excel</button>
        <%--<button onclick="loadInfo('')" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger" style="margin-left: 10px;background-color: #fff !important;border: 1px solid #e52a33 !important;color: #e52a33 !important;">重新加载</button>--%>
    </div>
    <div class="am-scrollable-horizontal" style="margin-top: 15px;">
        <table class="am-table am-table-bordered am-table-striped am-text-nowrap am-table-centered" id="hztable">
            <thead id="dbcxTitle">

            </thead>
            <tbody id="spgjtable">
            </tbody>
        </table>
        <table class="am-table am-table-bordered am-table-striped am-text-nowrap am-table-centered" id="mxtable" style="display: none;">
            <thead>
            <tr>
                <th class="am-text-middle">单据号</th>
                <th class="am-text-middle">制单日起</th>
                <th class="am-text-middle">商品条码</th>
                <th class="am-text-middle">商品名称</th>
                <th class="am-text-middle">调出部门</th>
                <th class="am-text-middle">调入部门</th>
                <th class="am-text-middle">规格</th>
                <th class="am-text-middle">批号</th>
                <th class="am-text-middle">单位</th>
                <th class="am-text-middle">单价</th>
                <th class="am-text-middle">调拨数量</th>
                <th class="am-text-middle">调拨金额</th>
                <th class="am-text-middle">调拨差价</th>
            </tr>
            </thead>
            <tbody id="spgjMxtable">
            </tbody>
        </table>
    </div>
</div>
<!--调拨详情-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="xsDetail">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">调拨单据详情
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div style="margin-top: 10px;height: 380px;" class="am-container  am-scrollable-vertical">
                <table class="am-table am-table-bordered am-table-centered"  >
                    <thead>
                    <tr>
                        <th class="am-text-middle">商品名称</th>
                        <th class="am-text-middle">规格型号</th>
                        <th class="am-text-middle">调拨单价</th>
                        <th class="am-text-middle">调拨数量</th>
                        <th class="am-text-middle">调拨金额</th>
                        <th class="am-text-middle">调拨差价</th>
                    </tr>
                    </thead>
                    <tbody id="xsDetailtable">
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
    $(function (){
        var dbcxTitleHtml = "";
        if ("<%=f_qyck%>" == 1){
            dbcxTitleHtml += "<tr>"+
                "<th class=\"am-text-middle\">操作</th>" +
                "<th class=\"am-text-middle\">制单时间</th>" +
                "<th class=\"am-text-middle\">制单人编码</th>" +
                "<th class=\"am-text-middle\">制单人名称</th>" +
                "<th class=\"am-text-middle\">转出部门</th>" +
                "<th class=\"am-text-middle\">转出仓库</th>" +
                "<th class=\"am-text-middle\">转入部门</th>" +
                "<th class=\"am-text-middle\">转入仓库</th>" +
                "<th class=\"am-text-middle\">单据备注</th>" +
                "</tr>" ;
            $("#dbcxTitle").html(dbcxTitleHtml);
        }else {
            dbcxTitleHtml += "<tr>"+
                "<th class=\"am-text-middle\">操作</th>" +
                "<th class=\"am-text-middle\">制单时间</th>" +
                "<th class=\"am-text-middle\">制单人编码</th>" +
                "<th class=\"am-text-middle\">制单人名称</th>" +
                "<th class=\"am-text-middle\">转出部门</th>" +
                "<th class=\"am-text-middle\">转入部门</th>" +
                "<th class=\"am-text-middle\">单据备注</th>" +
                "</tr>" ;
            $("#dbcxTitle").html(dbcxTitleHtml);
        }

        var spzyList ='${spzyList}';
        if(spzyList.length==0){
            console.log('暂无销售数据');
        }else {
            var $spgjtable=$('#spgjtable');
            spzyList=JSON.parse(spzyList);
            var salehtml="";
            for(var i=0;i<spzyList.length;i++){
                var spgj=spzyList[i];
                if ("<%=f_qyck%>" == 1){
                    salehtml += "<tr>\n" +
                        "                        <td class=\"am-text-middle\"><a href=\"javascript:showDetail('" + spgj.F_DJH + "')\" >详情</a> </td>\n" +
                        "                        <td class=\"am-text-middle\">" + spgj.F_ZDRQ + "</td>\n" +
                        "                        <td class=\"am-text-middle\">" + spgj.F_ZDRBM + "</td>\n" +
                        "                        <td class=\"am-text-middle\">" + spgj.F_ZDRMC + "</td>\n" +
                        "                        <td class=\"am-text-middle\">" + spgj.F_ZCBMMC + "</td>\n" +
                        "                        <td class=\"am-text-middle\">" + spgj.F_DCCKMC + "</td>\n" +
                        "                        <td class=\"am-text-middle\">" + spgj.F_ZRBMMC + "</td>\n" +
                        "                        <td class=\"am-text-middle\">" + spgj.F_DRCKMC + "</td>\n" +
                        "                        <td class=\"am-text-middle\">" + spgj.F_DJBZ + "</td>\n" +
                        "                    </tr>";
                }else {
                    salehtml += "<tr>\n" +
                        "                        <td class=\"am-text-middle\"><a href=\"javascript:showDetail('" + spgj.F_DJH + "')\" >详情</a> </td>\n" +
                        "                        <td class=\"am-text-middle\">" + spgj.F_ZDRQ + "</td>\n" +
                        "                        <td class=\"am-text-middle\">" + spgj.F_ZDRBM + "</td>\n" +
                        "                        <td class=\"am-text-middle\">" + spgj.F_ZDRMC + "</td>\n" +
                        "                        <td class=\"am-text-middle\">" + spgj.F_ZCBMMC + "</td>\n" +
                        "                        <td class=\"am-text-middle\">" + spgj.F_ZRBMMC + "</td>\n" +
                        "                        <td class=\"am-text-middle\">" + spgj.F_DJBZ + "</td>\n" +
                        "                    </tr>";
                }
            }
            $spgjtable.html(salehtml);
        }
        var date = new Date();
        var year = date.getFullYear();
        var month = ((date.getMonth() + 1) < 10 ? "0" : "") + (date.getMonth() + 1);
        var day = (date.getDate() < 10 ? "0" : "") + date.getDate();
        $('#f_ksrq').val(year + "-" + month + "-" + day);
        $('#f_jsrq').val(year + "-" + month + "-" + day);
        $('input[type=radio][name=f_cxfs]').change(function(){
            if(this.value=='0'){
                $('#hztable').show();
                $('#mxtable').hide();
            }else{
                $('#mxtable').show();
                $('#hztable').hide();
            }
        });
    });
    function getexcel(){
        var cxtj=$('#khxx').val();
        var f_cxfs=$('input[type=radio][name=f_cxfs]:checked').val();
        var f_ksrq=$('#f_ksrq').val();
        var f_jsrq=$('#f_jsrq').val();
        toexcel(cxtj,f_cxfs,f_ksrq,f_jsrq);
    }
    function toexcel(cxtj,f_cxfs,f_ksrq,f_jsrq) {
        if (f_cxfs=="0") {
            window.location.href = "/excel/getAllotBillExcel?cxtj="+cxtj+"&f_ksrq="+f_ksrq+"&f_jsrq="+f_jsrq;
        }else{
            window.location.href = "/excel/getAllotDetailExcel?cxtj="+cxtj+"&f_ksrq="+f_ksrq+"&f_jsrq="+f_jsrq;
        }
    }
    function searchbyDb(){
        var cxtj=$('#khxx').val();
        var f_cxfs=$('input[type=radio][name=f_cxfs]:checked').val();
        var f_ksrq=$('#f_ksrq').val();
        var f_jsrq=$('#f_jsrq').val();
        loadInfo(cxtj,f_cxfs,f_ksrq,f_jsrq);
    };
    function loadInfo(cxtj,f_cxfs,f_ksrq,f_jsrq) {
        if (f_cxfs == "0") {
            var $spgjtable = $('#spgjtable');
            $spgjtable.html('');
            $.ajax({
                url: "/allot/GetBillDetail",
                type: "post",
                async: false,
                data: {cxtj: cxtj, f_ksrq: f_ksrq,f_jsrq:f_jsrq, timeer: new Date()},
                success: function (data) {
                    var spzyList = JSON.parse(data);
                    if (spzyList.length > 0) {
                        var salehtml = "";
                        if ("<%=f_qyck%>" == 1){
                            for (var i = 0; i < spzyList.length; i++) {
                                var spgj = spzyList[i];
                                salehtml += "<tr>\n" +
                                    "                        <td class=\"am-text-middle\"><a href=\"javascript:showDetail('" + spgj.F_DJH + "')\" >详情</a> </td>\n" +
                                    "                        <td class=\"am-text-middle\">" + spgj.F_ZDRQ + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + spgj.F_ZDRBM + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + spgj.F_ZDRMC + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + spgj.F_ZCBMMC + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + spgj.F_DCCKMC + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + spgj.F_ZRBMMC + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + spgj.F_DRCKMC + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + spgj.F_DJBZ + "</td>\n" +
                                    "                    </tr>";
                            }
                        }else {
                            for (var i = 0; i < spzyList.length; i++) {
                                var spgj = spzyList[i];
                                salehtml += "<tr>\n" +
                                    "                        <td class=\"am-text-middle\"><a href=\"javascript:showDetail('" + spgj.F_DJH + "')\" >详情</a> </td>\n" +
                                    "                        <td class=\"am-text-middle\">" + spgj.F_ZDRQ + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + spgj.F_ZDRBM + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + spgj.F_ZDRMC + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + spgj.F_ZCBMMC + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + spgj.F_ZRBMMC + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + spgj.F_DJBZ + "</td>\n" +
                                    "                    </tr>";
                            }
                        }
                        $spgjtable.html(salehtml);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }else{
            var $spgjtable = $('#spgjMxtable');
            $spgjtable.html('');
            $.ajax({
                url: "/allot/GetSpzyDetail",
                type: "post",
                async: false,
                data: {cxtj: cxtj, f_ksrq: f_ksrq,f_jsrq:f_jsrq, timeer: new Date()},
                success: function (data) {
                    var spzyList = JSON.parse(data);
                    var zsl=0,zje=0;
                    if (spzyList.length > 0) {
                        var salehtml = "";
                        for (var i = 0; i < spzyList.length; i++) {
                            var spgj = spzyList[i];
                            salehtml += "<tr>\n" +
                                "                        <td class=\"am-text-middle\">" + spgj.F_DJH + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + spgj.F_RZRQ + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + spgj.F_SPTM + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + spgj.F_SPMC + "</td>\n";
                            salehtml +="                 <td class=\"am-text-middle\">" + spgj.F_ZCBMMC + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + spgj.F_ZRBMMC + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + spgj.F_GGXH + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + spgj.F_SGPCH + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + spgj.F_JLDW + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + spgj.F_ZYDJ + "</td>\n" +
                                "                        <td class=\"am-text-middle\">"+spgj.F_ZYSL+"</td>\n" +
                                "                        <td class=\"am-text-middle\">"+spgj.F_ZYJE+"</td>\n" +
                                "                        <td class=\"am-text-middle\">"+spgj.F_BCCJ+"</td>\n" +
                                "                    </tr>";
                            zsl+=eval(spgj.F_ZYSL);
                            zje+=eval(spgj.F_ZYJE);
                        }
                        salehtml += "<tr>\n" +
                            "                        <td class=\"am-text-left\" colspan='10'>合计：</td>\n" +
                            "                        <td class=\"am-text-middle\">"+zsl.toFixed(1)+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+zje.toFixed(1)+"</td>\n" +
                            "                    </tr>";
                        $spgjtable.html(salehtml);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }
    }
    //显示单据详情
    function showDetail(f_djh){
        $('#xsDetailtable').html('');
        $('#xsDetail').modal({
            closeViaDimmer: false,
            width:680,
            height:500
        });
        $.ajax({
            url: "/allot/GetZyHzcbmx",
            type: "post",
            async: false,
            data: {f_djh:f_djh, timeer: new Date() },
            success: function (data) {
                console.log(data);
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var html="";
                    for(var i=0;i<dataJson.length;i++){
                        var spjson=dataJson[i];
                        var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                            +"<td class=\"am-text-middle am-td-spmc\">"+spjson.F_SPMC+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_ZYDJ+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_ZYSL+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_ZYJE+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_BCCJ+"</td>"
                            +"<td class=\"am-hide\">"+spjson.F_PCH+"</td>"
                            +"</tr>";
                        $('#xsDetailtable').prepend(rowhtml);
                    }
                }
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
