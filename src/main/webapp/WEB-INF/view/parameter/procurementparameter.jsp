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
    String[] datas = newdata.split("-");
    String ksrq = datas[0]+"-"+datas[1]+"-"+"01";
    String ypd = (String) session.getAttribute("f_lxbm");
%>
<%--<!DOCTYPE html>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-采购台账</title>
    <meta name="description" content="云平台客户端V1-采购台账">
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
    </style>
</head>
<body>
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-12" id="xsdiv">
            <div class="header">
                <div class="am-g">
                    <h1>采购台账</h1>
                </div>
            </div>
            <div class="am-container am-">
                <div class="am-u-sm-4 am-u-md-4" style="padding-left: 0px;">
                    <div class="am-u-sm-3 am-u-md-3" style="padding: 0px;">
                        采购日期：
                    </div>
                    <div class="am-u-sm-4 am-u-md-4" style="padding: 0px;">
                        <input id="ksrq" type="text" class="am-radius am-form-field am-input-sm" placeholder="开始日期" data-am-datepicker readonly required />
                    </div>
                    <div class="am-u-sm-1 am-u-md-1" style="padding: 0px;text-align: center;">
                        至
                    </div>
                    <div class="am-u-sm-4 am-u-md-4" style="padding: 0px;">
                        <input id="jsrq" type="text" class="am-radius am-form-field am-input-sm" placeholder="结束日期" data-am-datepicker readonly required />
                    </div>
                </div>
                <div class="am-u-sm-6 am-u-md-6">
                    <div class="am-u-sm-3 am-u-md-3" style="padding:0px;text-align: right;">
                        商品名称：
                    </div>
                    <div class="am-u-sm-9 am-u-md-9">
                        <input id="spmc" type="text" class="am-form-field am-input-sm">
                    </div>
                </div>
                <div class="am-u-sm-2 am-u-md-2">
                    <span class="am-fr" style="vertical-align: middle;"/>
                    <button type="button" onclick="loadInfo(1,10)" class="am-btn am-btn-primary  am-radius am-btn-sm">查询</button>
                    <button type="button" onclick="loadlbxx()" class="am-btn am-btn-primary  am-radius am-btn-sm">清空</button>
                </div>
            </div>
            <form class="am-form">
                <div class="am-container">
                    <div class="am-u-sm-4 am-u-md-4" style="margin-top: 10px;padding-left: 0px;">
                        <div class="am-u-sm-3 am-u-md-3" style="padding: 0px;">
                            商品条码：
                        </div>
                        <div class="am-u-sm-9 am-u-md-9" style="padding: 0px;">
                            <input id="sptm" type="text" class="am-form-field am-input-sm">
                        </div>
                    </div>
                    <div class="am-u-sm-6 am-u-md-6 xsqxdix" style="margin-top: 10px;">
                        <div class="am-u-sm-3 am-u-md-3" style="padding:0px;text-align: right;">
                            登记号：
                        </div>
                        <div class="am-u-sm-9 am-u-md-9">
                            <input id="djh" type="text" class="am-form-field am-input-sm">
                        </div>
                    </div>
                    <div class="am-u-sm-2 am-u-md-2" style="margin-top: 10px;">
                        <span class="am-fr" style="vertical-align: middle;"/>
                        <button type="button" onclick="getexcel()" class="am-btn am-btn-primary  am-radius am-btn-sm">导出excel</button>
                    </div>
                    <div class="am-u-sm-4 am-u-md-4" id="gysmcdiv" style="margin-top: 10px;padding-left: 0px;">
                        <div class="am-u-sm-3 am-u-md-3" id="gysmcspan" style="padding: 0px;">
                            &nbsp;&nbsp;&nbsp;供应商：
                        </div>
                        <div class="am-u-sm-9 am-u-md-9" id="gysmcinput" style="padding: 0px;">
                            <input id="gysbm" type="hidden">
                            <input id="gysmc" type="text" class="am-form-field am-input-sm">
                        </div>
                    </div>
                    <%--<div class="am-u-sm-6 am-u-md-6 xsqxdix" style="margin-top: 10px;">
                        <div class="am-u-sm-3 am-u-md-3" style="padding: 0px;text-align: right;">
                            生产企业：
                        </div>
                        <div class="am-u-sm-9 am-u-md-9">
                            <input id="scqy" type="text" class="am-form-field am-input-sm">
                        </div>
                    </div>--%>
                    <div class="am-u-sm-2 am-u-md-2">
                    </div>
                </div>
            </form>
            <div class="am-container am-scrollable-horizontal" style="margin-top: 20px;" id="hovertables">
                <table class="am-table am-table-bordered am-table-centered am-text-nowrap">
                    <thead>
                        <tr>
                            <th class="am-text-middle">网点名称</th>
                            <th class="am-text-middle">商品条码</th>
                            <th class="am-text-middle xsqxdix">登记号</th>
                            <th class="am-text-middle">商品名称</th>
                            <th class="am-text-middle">产品规格</th>
                            <%--<th class="am-text-middle xsqxdix">生产企业</th>
                            <th class="am-text-middle xsqxdix">生产许可证</th>--%>
                            <th class="am-text-middle">供应商名称</th>
                            <th class="am-text-middle">联系电话</th>
                            <th class="am-text-middle">采购日期</th>
                            <%--<th class="am-text-middle xsqxdix">生产日期</th>
                            <th class="am-text-middle xsqxdix">生产批次</th>--%>
                            <th class="am-text-middle">计量单位</th>
                            <th class="am-text-middle">数量</th>
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
                <div style="margin-top: 10px;" class="am-container">
                    <table class="am-table am-table-bordered am-table-centered" >
                        <thead>
                        <tr>
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
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseSpdiv">
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
    <!--选择客户div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseQydiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">选择生产企业
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <table class="am-table am-table-bordered am-table-centered" >
                        <thead>
                        <tr>
                            <th class="am-text-middle">企业编码</th>
                            <th class="am-text-middle">企业名称</th>
                            <th class="am-text-middle">生产许可证</th>
                            <th class="am-text-middle">地址</th>
                        </tr>
                        </thead>
                        <tbody id="qytable">
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

        $('#ksrq').datepicker('setValue','<%=ksrq%>');
        $('#jsrq').datepicker('setValue','<%=newdata%>');

        $('.am-gallery-item').click(function () {
            spimgclick(this);
        });
        //显示选择客户
        $('#gysmc').keyup(function (event) {
            if(event.keyCode == 13){
                $('#chooseGysdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:500
                });
                var gysmc = $('#gysmc').val();
                loadKhxx(gysmc,0);
                $('#chooseGysdiv').modal('open');
            }
        });
        //显示选择生产企业
        $('#scqy').keyup(function (event) {
            if(event.keyCode == 13){
                $('#chooseQydiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:500
                });
                var scqy = $('#scqy').val();
                loadKhxx(scqy,2);
                $('#chooseQydiv').modal('open');
            }
        });
        //显示选择商品名称
        $('#spmc').keyup(function (event) {
            if(event.keyCode == 13){
                $('#chooseSpdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:500
                });
                var spmc = $('#spmc').val();
                loadSpxx(spmc);
                $('#chooseSpdiv').modal('open');
            }
        });
        //显示选择商品条码
        $('#sptm').keyup(function (event) {
            if(event.keyCode == 13){
                $('#chooseSpdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:500
                });
                var sptm = $('#sptm').val();
                loadSpxx(sptm,1);
                $('#chooseSpdiv').modal('open');
            }
        });

        $('#hovertables').hover(function(){
            $('#hovertables').css("overflow","auto")
        },function(){
            $('#hovertables').css("overflow","hidden")
        });

        if('<%=ypd%>' != '1'  && "<%=ypd%>" != '0'){
            $('.xsqxdix').hide();
            $('#gysmcdiv').removeClass("am-u-sm-4").addClass("am-u-sm-6");
            $('#gysmcdiv').removeClass("am-u-md-4").addClass("am-u-md-6");
            $('#gysmcspan').css("text-align","right");
            $('#gysmcinput').css("padding","");
        }

    });

    function loadTable(pageIndex) {
        $('#pagebar').html("");
        loadInfo(pageIndex,10);
    }

    function loadInfo(pageIndex,pageSize){
        var ksrq=$('#ksrq').val();
        var jsrq=$('#jsrq').val();
        var spmc=$('#spmc').val();
        var sptm=$('#sptm').val();
        var djh = $('#djh').val();
        var gysbm=$('#gysbm').val();
        var gysmc=$('#gysmc').val();
        var scqy=$('#scqy').val();
        $('#pagebar').html("");
        $.ajax({
            url: "/parameters/getCjtzs",
            type: "post",
            async: false,
            data: {ksrq:ksrq,jsrq:jsrq,spmc:spmc,sptm:sptm,djh:djh,gysbm:gysbm,gysmc:gysmc,qybm:"",pageIndex:pageIndex,pageSize:pageSize},
            success: function (data) {
                var res = JSON.parse(data);
                var spdalist = JSON.parse(res.list);
                $('#sptable').html("");
                var zxl=0;
                if(spdalist.length>0) {
                    for(var i=0;i<spdalist.length;i++){
                        var spjson = spdalist[i];
                        var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                        rowhtml+="<td class=\"am-text-middle am-td-spmc\" title='"+spjson.F_BMMC+"'>"+spjson.F_BMMC+"</td>"
                        rowhtml+="<td class=\"am-text-middle am-td-spmc\" title='"+spjson.F_SPTM+"'>"+spjson.F_SPTM+"</td>"
                        if('<%=ypd%>' == '1' || "<%=ypd%>" == '0'){
                            rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_YPZJH+"'>"+spjson.F_YPZJH+"</td>"
                        }
                        rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_SPMC+"'>"+spjson.F_SPMC+"</td>"
                        rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_GGXH+"'>"+spjson.F_GGXH+"</td>"
                        rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_GYSMC+"'>"+spjson.F_GYSMC+"</td>"
                        rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_DH+"'>"+spjson.F_DH+"</td>"
                        rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_RZRQ+"'>"+spjson.F_RZRQ+"</td>"
                        rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_JLDW+"'>"+spjson.F_JLDW+"</td>"
                        rowhtml+="<td class=\"am-text-middle\" title='"+spjson.F_GJSL+"'>"+spjson.F_GJSL+"</td>"
                        rowhtml+="</tr>";
                        var colspanval=8;
                        if('<%=ypd%>' == '1' || "<%=ypd%>" == '0'){
                            colspanval=9
                        }
                        zxl+=eval(spjson.F_GJSL);
                        $('#sptable').prepend(rowhtml);
                    }
                    rowhtml = "<tr>\n" +
                        "                        <td class=\"am-text-left\" colspan='"+colspanval+"'>合计：</td>\n" +
                        "                        <td class=\"am-text-middle\">" + zxl.toFixed(1) + "</td>\n" +
                        "                    </tr>";

                    $('#sptable').append(rowhtml);
                    pagebar(pageIndex,pageSize,res.total,"pagebar");
                }
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
    //加载客户
    function loadKhxx(khxx,cslx){
        $.ajax({
            url: "/initialvalues/GetKhda",
            type: "post",
            async: false,
            data: {khxx:khxx,cslx:cslx, timeer: new Date() },
            success: function (data) {
                var res = JSON.parse(data);
                var dataJson = JSON.parse(res.list);
                if(dataJson.length>0) {
                    var khdahtml="";
                    for(var i=0;i<dataJson.length;i++){
                        var khda=dataJson[i];
                        if(khdahtml==""){
                            khdahtml+="<tr>\n";
                            if(cslx == 0){
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_LXR+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n";
                            }else{
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_CSBM+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_SCXKZH+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_DZ+"</td>\n";
                            }
                            khdahtml+="                            <td class=\"am-hide\">"+khda.F_CSBM+"</td>\n";
                            khdahtml+="                        </tr>";
                        }else{
                            khdahtml+="<tr>\n";
                            if(cslx == 0){
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_LXR+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n";
                            }else{
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_CSBM+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_SCXKZH+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_DZ+"</td>\n";
                            }
                            khdahtml+="                            <td class=\"am-hide\">"+khda.F_CSBM+"</td>\n";
                            khdahtml+="                        </tr>";
                        }
                    }
                    if(cslx == 0){
                        $('#gystable').html(khdahtml);
                        $('#gystable tr').click(function () {
                            var rowNum=$(this).index();
                            var $table=$(this).parent();
                            var gysmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                            $('#gysmc').val(gysmc);
                            $('#chooseGysdiv').modal('close');
                        });
                    }else{
                        $('#qytable').html(khdahtml);
                        $('#qytable tr').click(function () {
                            var rowNum=$(this).index();
                            var $table=$(this).parent();
                            var qxmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(1)').text();
                            $('#scqy').val(qxmc);
                            $('#chooseQydiv').modal('close');
                        });
                    }

                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    };
    //加载商品
    function loadSpxx(spxx,lx){
        $.ajax({
            url: "/commodity/getSpmx",
            type: "post",
            async: false,
            data: {spxx:spxx, timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var spdahtml="";
                    for(var i=0;i<dataJson.length;i++){
                        var spda=dataJson[i];
                        if(spdahtml==""){
                            spdahtml="<tr>\n" +
                                "                            <td class=\"am-text-middle\">"+spda.F_SPTM+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+spda.F_SPMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+spda.F_GGXH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+spda.F_XSDJ+"</td>\n" +
                                "                        </tr>"
                        }else{
                            spdahtml+="<tr>\n" +
                                "                            <td class=\"am-text-middle\">"+spda.F_SPTM+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+spda.F_SPMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+spda.F_GGXH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+spda.F_XSDJ+"</td>\n" +
                                "                        </tr>"
                        }
                    }
                    $('#spmxtable').html(spdahtml);
                    $('#spmxtable tr').click(function () {
                        var rowNum=$(this).index();
                        var $table=$(this).parent();
                        var spmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(1)').text();
                        var sptm=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                        if(lx == 1){
                            $('#sptm').val(sptm);
                        }else{
                            $('#spmc').val(spmc);
                        }
                        //$('#khxx').attr('sptm',)
                        $('#chooseSpdiv').modal('close');
                    });
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    }

    function getexcel(){
        var ksrq=$('#ksrq').val();
        var jsrq=$('#jsrq').val();
        var spmc=$('#spmc').val();
        var sptm=$('#sptm').val();
        var djh = $('#djh').val();
        var gysbm=$('#gysbm').val();
        var gysmc=$('#gysmc').val();
        toexcel(ksrq,jsrq,spmc,sptm,djh,gysbm,gysmc);
    }
    function toexcel(ksrq,jsrq,spmc,sptm,djh,gysbm,gysmc) {
        window.location.href = "/excel/getProcurementParameterExcel?ksrq="+ksrq+"&jsrq="+jsrq+"&spmc="+spmc+"&sptm="+sptm+"&djh="+djh+"&gysbm="+gysbm+"&gysmc="+gysmc+"&qybm=";
    }

    function loadlbxx(){
        $('#ksrq').datepicker('setValue','<%=ksrq%>');
        $('#jsrq').datepicker('setValue','<%=newdata%>');
        $('#spmc').val("");
        $('#sptm').val("");
        $('#djh').val("");
        $('#gysbm').val("");
        $('#gysmc').val("");
        $('#scqy').val("");
    }
</script>
</html>
