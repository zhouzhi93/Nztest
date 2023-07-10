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
    String newdata=dateFormat.format(date);
    String ypd = (String) session.getAttribute("f_lxbm");
%>
<%--<!DOCTYPE html>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-仓库报表</title>
    <meta name="description" content="云平台客户端V1-仓库报表">
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
            max-width:100%;
        }
        label{
            font-weight: 500;
            font-size:1.4rem;
        }
        .am-popup{
            z-index: 1200;
        }
        td{
            overflow:hidden;
            text-overflow:ellipsis;
        }
        a{
            color: #333;
        }
        a:focus, a:hover {
            color: #333;
        }
    </style>
</head>
<body>
<div class="am-g">
    <div class="am-u-sm-12 am-u-md-12" id="xsdiv">
        <div class="header">
            <div class="am-g">
                <h1>仓库报表</h1>
            </div>
        </div>
        <div class="am-container am-">
            <div class="am-u-sm-4 am-u-md-4" style="padding-left: 0px;">
                <div class="am-u-sm-3 am-u-md-3" style="padding: 0px;text-align: right;">
                    日期：
                </div>
                <div class="am-u-sm-9 am-u-md-9" style="padding: 0px;">
                    <input id="kcrq" type="text" class="am-radius am-form-field am-input-sm" placeholder="库存日期" data-am-datepicker readonly required />
                </div>
            </div>
            <div class="am-u-sm-3 am-u-md-3 am-text-left">
                部门：   <select data-am-selected="{btnWidth: '60%', btnSize: 'sm'}" id="f_bmbm" multiple placeholder="选择部门">

            </select>
            </div>
            <div class="am-u-sm-3 am-u-md-3 am-text-middle">
                仓库：<select data-am-selected="{btnWidth: '60%', btnSize: 'sm'}" id="f_ckbm" multiple placeholder="选择仓库">

            </select>
            </div>
            <div class="am-u-sm-2 am-u-md-2">
                <span class="am-fr" style="vertical-align: middle;"/>
                <button type="button" onclick="loadInfo(1,10)" class="am-btn am-btn-primary  am-radius am-btn-sm">查询</button>
                <button type="button" onclick="loadlbxx()" class="am-btn am-btn-primary  am-radius am-btn-sm">清空</button>
            </div>
        </div>
        <div class="am-container" style="margin-top: 10px;">
            <div class="am-u-sm-5 am-u-md-5">
                <div class="am-u-sm-3 am-u-md-3" style="padding:0px;text-align: right;">
                    商品名称：
                </div>
                <div class="am-u-sm-9 am-u-md-9">
                    <input id="spmc" type="text" onclick="openSpDiv()" readonly type="text" placeholder="选择商品" class="am-form-field am-input-sm">
                </div>
            </div>
            <div class="am-u-sm-5 am-u-md-5" style="padding-left: 0px;">
                <div class="am-u-sm-3 am-u-md-3" style="padding: 0px;text-align: right;">
                    商品条码：
                </div>
                <div class="am-u-sm-9 am-u-md-9" style="padding: 0px;">
                    <input id="sptm" type="text" onclick="openSpDiv()" readonly type="text" placeholder="选择条码" class="am-form-field am-input-sm">
                </div>
            </div>
            <div class="am-u-sm-2 am-u-md-2">
                <span class="am-fr" style="vertical-align: middle;"/>
                <button type="button" onclick="getexcel()" class="am-btn am-btn-primary  am-radius am-btn-sm">导出excel</button>
            </div>
        </div>
        <div class="am-container" style="margin-top: 10px;padding-left: 0px;;">
            <div class="am-u-sm-10 am-u-md-10">
                <div class="am-u-sm-2 am-u-md-2 am-text-right" style="padding: 0px;margin-left: -55px;">
                    供应商：
                </div>
                <div class="am-u-sm-10 am-u-md-10 am-text-left" style="padding: 0px;">
                    <input id="gysbm" onclick="openGysDiv()" type="hidden">
                    <input id="gysmc" onclick="openGysDiv()" type="text" readonly type="text" placeholder="选择供应商" class="am-form-field am-input-sm">
                </div>
            </div>
            <div class="am-u-sm-2 am-u-md-2">
            </div>
        </div>
        <div class="am-container am-scrollable-horizontal" style="margin-top: 20px;" id="hovertables">
            <table class="am-table am-table-bordered am-table-centered am-text-nowrap" >
                <thead>
                <tr>
                    <th class="am-text-middle">部门</th>
                    <th class="am-text-middle">仓库</th>
                    <th class="am-text-middle">商品条码</th>
                    <th class="am-text-middle">商品名称</th>
                    <th class="am-text-middle">规格</th>
                    <th class="am-text-middle">计量单位</th>
                    <th class="am-text-middle">库存</th>
                    <th class="am-text-middle">成本单价</th>
                    <th class="am-text-middle">成本金额</th>
                </tr>
                </thead>
                <tbody id="sptable">
                </tbody>
            </table>
        </div>
        <div id="pagebar"></div>
    </div>
</div>
<!--选择客户div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseGysdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">选择供应商
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div class="am-container">
                <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                </div>
                <div class="am-u-sm-6 am-u-md-6 am-text-right">
                    <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" onclick="addgys()">确认</button>
                </div>
            </div>
            <div style="margin-top: 10px;" class="am-container">
                <table class="am-table am-table-bordered am-table-centered" >
                    <thead>
                    <tr>
                        <th style="width: 50px;">选择</th>
                        <th class="am-text-middle">供应商名称</th>
                        <th class="am-text-middle">联系人</th>
                        <th class="am-text-middle">联系方式</th>
                    </tr>
                    </thead>
                    <tbody id="gystable">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!--选择商品div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseKcdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">选择商品
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div class="am-container">
                <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                </div>
                <div class="am-u-sm-6 am-u-md-6 am-text-right">
                    <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" onclick="addsp()">确认</button>
                </div>
            </div>
            <div class="am-container am-scrollable-vertical" style="margin-top: 10px;height: 400px;">
                <table class="am-table am-table-bordered am-table-centered" >
                    <thead>
                    <tr>
                        <th style="width: 50px;">选择</th>
                        <th class="am-text-middle">商品条码</th>
                        <th class="am-text-middle">商品名称</th>
                        <th class="am-text-middle">规格</th>
                        <th class="am-text-middle">单价</th>
                    </tr>
                    </thead>
                    <tbody id="spmxtable">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!--显示批次详情div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="choosePcdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">选择商品
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div style="margin-top: 10px;" class="am-container">
                <table class="am-table am-table-bordered am-table-centered" >
                    <thead>
                    <tr>
                        <th class="am-text-middle">商品条码</th>
                        <th class="am-text-middle">商品名称</th>
                        <th class="am-text-middle">批次号</th>
                        <th class="am-text-middle">库存数量</th>
                        <th class="am-text-middle">成本单价</th>
                        <th class="am-text-middle">成本金额</th>
                    </tr>
                    </thead>
                    <tbody id="pctable">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script src="/assets/js/app.js"></script>
<script src="/assets/address/address.min.js"></script>
<script src="/assets/address/iscroll.min.js"></script>
<script type="text/javascript">
    $(function(){
        loadlbxx();
        loadBm();
        loadCk();
    });

    function loadTable(pageIndex) {
        $('#pagebar').html("");
        loadInfo(pageIndex,10);
    }

    function loadInfo(pageIndex,pageSize){
        var kcrq=$('#kcrq').val();
        var sptm=$('#sptm').val();
        var gysbm = $('#gysbm').val();
        $('#pagebar').html("");
        var f_bmbm = "";
        var f_ckbm = "";
        var bmbmList=$('#f_bmbm').val();
        var ckbmList=$('#f_ckbm').val();
        if (bmbmList != null){
            for(var i = 0; i < bmbmList.length; i++){
                if (i == bmbmList.length -1){
                    f_bmbm += bmbmList[i];
                }else {
                    f_bmbm += bmbmList[i] + ",";
                }
            }
        }

        if (ckbmList != null){
            for(var i = 0; i < ckbmList.length; i++){
                if (i == ckbmList.length -1){
                    f_ckbm += ckbmList[i];
                }else {
                    f_ckbm += ckbmList[i] + ",";
                }
            }
        }

        $.ajax({
            url: "/repertorys/loadCkbb",
            type: "post",
            async: false,
            data: {kcrq:kcrq,f_bmbm:f_bmbm,f_ckbm:f_ckbm,sptm:sptm,gysbm:gysbm,pageIndex:pageIndex,pageSize:pageSize},
            success: function (data) {
                var res = JSON.parse(data);
                var spdalist = JSON.parse(res.list);
                $('#sptable').html("");
                if(spdalist.length>0) {
                    for(var i=0;i<spdalist.length;i++){
                        var spjson = spdalist[i];
                        var rowhtml="";
                        rowhtml+="<tr sptm='"+spjson.F_SPTM+"'>"
                        rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_BMMC+"'>"+spjson.F_BMMC+"</td>"
                        rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_CKMC+"'>"+spjson.F_CKMC+"</td>"
                        rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_SPTM+"'>"+spjson.F_SPTM+"</td>"
                        rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_SPMC+"'>"+spjson.F_SPMC+"</td>"
                        rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_GGXH+"'>"+spjson.F_GGXH+"</td>"
                        rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_JLDW+"'>"+spjson.F_JLDW+"</td>"
                        rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_KCSL+"'>"+spjson.F_KCSL+"</td>"
                        rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_KCDJ+"'>"+spjson.F_KCDJ+"</td>"
                        rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_KCJE+"'>"+spjson.F_KCJE+"</td>"
                        rowhtml+="</tr>";
                        $('#sptable').prepend(rowhtml);
                        pagebar(pageIndex,pageSize,res.total,"pagebar");
                    }
                }
                $('#sptable tr').dblclick(function () {
                    var rowNum=$(this).index();
                    var $table=$(this).parent();
                    var sptm=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(1)').text();
                    $('#choosePcdiv').modal({
                        closeViaDimmer: false,
                        width:880,
                        height:500
                    });
                    loadPcmx(sptm);
                    $('#choosePcdiv').modal('open');
                });
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    }

    function pagebar(pageIndex,pageSize,totalCount,parbarid){
        pageIndex=parseInt(pageIndex);
        pageSize=parseInt(pageSize);
        totalCount=parseInt(totalCount);
        pageSize = pageSize == 0 ? 50 : pageSize;
        var pageCount = parseInt((totalCount + pageSize - 1) / pageSize); //总页数
        var template="<div id='totalCount' class='am-cf'>共{0}条记录<div class='am-fr'>";
        var output=template.format(totalCount);
        if(pageCount>1){
            output+="<ul class='am-pagination am-pagination-centered'>";
            if (pageIndex <= 1)
            {//处理上一页的连接
                output+=(" <li class='am-disabled'><a href='javascript:void(0);'>&laquo;</a></li>");
            }
            else {
                template=("<li><a href='javascript:void(0);'onclick=\"loadTable({0})\">&laquo;</a></li>");
                output+=template.format(pageIndex - 1);
            }
            var start = pageIndex - 5;
            start = start < 1 ? 1 : start;
            var end = start + 9;
            end = end > pageCount ? pageCount : end;
            if(end==pageCount){
                start = end - 9;
                start = start < 1 ? 1 : start;
            }
            for (var i = start; i <= end; i++)
            {
                if (i == pageIndex)
                {
                    template="<li  class='am-active'><a href='javascript:void(0);'>{0}</a></li>";
                    output+=template.format(i);
                }
                else
                {
                    template="<li><a href='javascript:void(0);'onclick=\"loadTable({0})\">{1}</a></li>", i,i;
                    output+=template.format(i,i);
                }
            }
            if(end<pageCount){
                output+="<li><span>...</span></li>";
                template="<li><a href='javascript:void(0);'onclick=\"loadTable({0})\">{1}</a></li>";
                output+=template.format(pageCount,pageCount);
            }
            if (pageIndex < pageCount)
            {//处理下一页的链接
                template="<li><a href='javascript:void(0);'onclick=\"loadTable({0})\">&raquo;</a></li>";
                output+=template.format(pageIndex + 1);
            }
            else {
                output+="<li><a class='am-disabled' href='javascript:void(0);'>&raquo;</a></li>";
            }
        }
        output+="</div></div>";
        $('#'+parbarid).html(output);
    }
    String.prototype.format = function(args)
    {
        if (arguments.length > 0)
        {
            var result = this;
            if (arguments.length == 1 && typeof (args) == "object")
            {
                for (var key in args)
                {
                    var reg = new RegExp("({" + key + "})", "g");
                    result = result.replace(reg, args[key]);
                }
            }
            else
            {
                for (var i = 0; i < arguments.length; i++)
                {
                    if (arguments[i] == undefined)
                    {
                        return "";
                    }
                    else
                    {
                        var reg = new RegExp("({[" + i + "]})", "g");
                        result = result.replace(reg, arguments[i]);
                    }
                }
            }
            return result;
        }
        else
        {
            return this;
        }
    }

    //加载部门
    function loadBm(){
        $.ajax({
            url: "/repertorys/loadBm",
            type: "post",
            async: false,
            data: {},
            success: function (data) {
                var dataJson = JSON.parse(data);
                var bmbmHtml = "";
                if (dataJson != null && dataJson != "" && dataJson != "[]"){
                    for (var i = 0; i < dataJson.length; i++){
                        bmbmHtml += "<option value='"+dataJson[i].F_BMBM+"'>"+dataJson[i].F_BMMC+"</option>";
                    }
                    $("#f_bmbm").html(bmbmHtml);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }

    //加载仓库
    function loadCk(){
        $.ajax({
            url: "/repertorys/loadCk",
            type: "post",
            async: false,
            data: {},
            success: function (data) {
                var dataJson = JSON.parse(data);
                var ckbmHtml = "";
                if (dataJson != null && dataJson != "" && dataJson != "[]"){
                    for (var i = 0; i < dataJson.length; i++){
                        if (dataJson[i].F_MJ == "0"){
                            ckbmHtml += "<option disabled value='"+dataJson[i].F_CKBM+"'>"+dataJson[i].F_CKMC+"</option>";
                        }else if (dataJson[i].F_MJ == "1"){
                            ckbmHtml += "<option value='"+dataJson[i].F_CKBM+"'>"+dataJson[i].F_CKMC+"</option>";
                        }
                    }
                    $("#f_ckbm").html(ckbmHtml);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }

    //打开商品div
    function openSpDiv(){
        $('#chooseKcdiv').modal({
            closeViaDimmer: false,
            width:680,
            height:500
        });
        $("#chooseKcdiv").modal('open');

        //加载商品
        loadSp();
    }

    //加载商品
    function loadSp() {
        $.ajax({
            url: "/repertorys/loadSp",
            type: "post",
            async: false,
            data: {timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var spdahtml="";
                    for(var i=0;i<dataJson.length;i++){
                        var spda=dataJson[i];
                        spdahtml+="<tr>\n" +
                            "<td class=\"am-text-middle\" style=\"width: 50px;\"><label class=\"am-checkbox-inline\"> " +
                            "<input type=\"checkbox\" name='sp' value=\""+spda.F_SPTM+"\" data-am-ucheck></label></td>\n"+
                            "                            <td class=\"am-text-middle\"><a value='"+spda.F_SPTM+"'>"+spda.F_SPTM+"</a></td>\n" +
                            "                            <td class=\"am-text-middle\"><a value='"+spda.F_SPMC+"'>"+spda.F_SPMC+"</a></td>\n" +
                            "                            <td class=\"am-text-middle\">"+spda.F_GGXH+"</td>\n" +
                            "                            <td class=\"am-text-middle\">"+spda.F_XSDJ+"</td>\n" +
                            "                        </tr>"
                    }
                    $('#spmxtable').html(spdahtml);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    }

    function addsp(){
        var checkInp = $("#spmxtable").find("tr").find("td:eq(0)").find("input:checkbox[name='sp']:checked");
        var rowNum = checkInp.length;
        var sptm = "";
        var spmc = "";
        for (var i = 0; i < rowNum; i++){
            var checkedTr = checkInp.eq(i).parent().parent().parent();
            if (i == rowNum-1){
                sptm += checkedTr.find("td:eq(1)").find("a:eq(0)").attr("value");
                spmc += checkedTr.find("td:eq(2)").find("a:eq(0)").attr("value");
            }else {
                sptm += checkedTr.find("td:eq(1)").find("a:eq(0)").attr("value");
                sptm += ",";
                spmc += checkedTr.find("td:eq(2)").find("a:eq(0)").attr("value");
                spmc += ",";
            }
        }
        $('#sptm').val(sptm);
        $('#spmc').val(spmc);
        $("#chooseKcdiv").modal('close');
    }

    //打开商品div
    function openGysDiv(){
        $('#chooseGysdiv').modal({
            closeViaDimmer: false,
            width:680,
            height:500
        });
        $("#chooseGysdiv").modal('open');

        //加载商品
        loadGys();
    }

    //加载商品
    function loadGys() {
        $.ajax({
            url: "/repertorys/loadGys",
            type: "post",
            async: false,
            data: {timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var gyshtml="";
                    for(var i=0;i<dataJson.length;i++){
                        var gysda=dataJson[i];
                        gyshtml+="<tr>\n" +
                            "<td class=\"am-text-middle\" style=\"width: 50px;\"><label class=\"am-checkbox-inline\"> " +
                            "<input type=\"checkbox\" name='gys' value=\""+gysda.F_CSBM+"\" data-am-ucheck></label></td>\n"+
                            "                            <td class=\"am-text-middle\"><a value='"+gysda.F_CSMC+"'>"+gysda.F_CSMC+"</a></td>\n" +
                            "                            <td class=\"am-text-middle\">"+gysda.F_LXR+"</td>\n" +
                            "                            <td class=\"am-text-middle\">"+gysda.F_DH+"</td>\n" +
                            "                        </tr>"
                    }
                    $('#gystable').html(gyshtml);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    }

    function addgys(){
        var checkInp = $("#gystable").find("tr").find("td:eq(0)").find("input:checkbox[name='gys']:checked");
        var rowNum = checkInp.length;
        var gysbm = "";
        var gysmc = "";
        for (var i = 0; i < rowNum; i++){
            var checkedTr = checkInp.eq(i).parent().parent().parent();
            if (i == rowNum-1){
                gysbm += checkedTr.find("td:eq(0)").find("input:eq(0)").val();
                gysmc += checkedTr.find("td:eq(1)").find("a:eq(0)").attr("value");
            }else {
                gysbm += checkedTr.find("td:eq(0)").find("input:eq(0)").val();
                gysbm += ",";
                gysmc += checkedTr.find("td:eq(1)").find("a:eq(0)").attr("value");
                gysmc += ",";
            }
        }
        $('#gysbm').val(gysbm);
        $('#gysmc').val(gysmc);
        $("#chooseGysdiv").modal('close');
    }

    function loadlbxx(){
        $('#kcrq').datepicker('setValue','<%=newdata%>');
        loadBm();
        loadCk();
        $('#spmc').val("");
        $('#sptm').val("");
        $('#gysmc').val("");
        $('#gysbm').val("");
    }

    function getexcel(){

        var kcrq=$('#kcrq').val();
        var spmc=$('#spmc').val();
        var sptm=$('#sptm').val();
        var djh = $('#djh').val();
        var gysmc=$('#gysmc').val();
        var gysbm = $('#gysbm').val();
        toexcel(kcrq,spmc,sptm,djh,gysbm,gysmc);
    }
    function toexcel(kcrq,spmc,sptm,djh,gysbm,gysmc) {
        window.location.href = "/excel/getRepertoryStatementExcel?kcrq="+kcrq+"&spmc="+spmc+"&sptm="+sptm+"&djh="+djh+"&gysbm="+gysbm+"&gysmc="+gysmc;
    }

    function loadPcmx(sptm){
        var kcrq=$('#kcrq').val();
        var sptm=sptm;
        $.ajax({
            url: "/repertorys/getKcpcmx",
            type: "post",
            async: false,
            data: {kcrq:kcrq,sptm:sptm},
            success: function (data) {
                var pclisttable = JSON.parse(data);
                $('#pctable').html("");
                if(pclisttable.length>0) {
                    for(var i=0;i<pclisttable.length;i++){
                        var pcjson = pclisttable[i];
                        var rowhtml="<tr sptm='"+pcjson.F_SPTM+"'>"
                            +"<td class=\"am-text-middle am-td-spmc\">"+pcjson.F_SPTM+"</td>"
                            +"<td class=\"am-text-middle\">"+pcjson.F_SPMC+"</td>"
                            +"<td class=\"am-text-middle\">"+pcjson.F_PCH+"</td>"
                            +"<td class=\"am-text-middle\">"+pcjson.F_KCSL+"</td>"
                            +"<td class=\"am-text-middle\">"+pcjson.F_CBDJ+"</td>"
                            +"<td class=\"am-text-middle\">"+pcjson.F_CBJE+"</td>"
                            +"</tr>";
                        $('#pctable').prepend(rowhtml);
                    }
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }

</script>
</html>
