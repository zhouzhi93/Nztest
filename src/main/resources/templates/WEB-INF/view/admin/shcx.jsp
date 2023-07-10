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
    <title>云平台管理平台-商户查询</title>
    <meta name="description" content="云平台管理平台-商户查询">
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
    </style>
</head>
<body>
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-12" id="xsdiv">
            <div class="header">
                <div class="am-g">
                    <h1>商户查询</h1>
                </div>
            </div>
            <div class="am-container">
                <div class="am-u-sm-4 am-u-md-4" style="padding-left: 0px;">
                    <div class="am-u-sm-3 am-u-md-3" style="padding: 0px;">
                        启用日期：
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
                        商户名称：
                    </div>
                    <div class="am-u-sm-9 am-u-md-9">
                        <input id="xstzSpmc" type="text" class="am-form-field am-input-sm">
                    </div>
                </div>
                <div class="am-u-sm-2 am-u-md-2">
                    <span class="am-fr" style="vertical-align: middle;"/>
                    <button type="button" onclick="getSpmx()" class="am-btn am-btn-primary  am-radius am-btn-sm">查询</button>
                    <button type="button" onclick="loadlbxx()" class="am-btn am-btn-primary  am-radius am-btn-sm">清空</button>
                </div>
            </div>
            <form class="am-form">
                <div class="am-container">
                    <div class="am-u-sm-4 am-u-md-4" style="margin-top: 10px;padding-left: 0px;">
                        <div class="am-u-sm-3 am-u-md-3" style="padding: 0px;">
                            商户编号：
                        </div>
                        <div class="am-u-sm-9 am-u-md-9" style="padding: 0px;">
                            <input id="xstzSptm" type="text" class="am-form-field am-input-sm">
                        </div>
                    </div>
                    <div class="am-u-sm-6 am-u-md-6 xsqxdix" style="margin-top: 10px;">
                        <div class="am-u-sm-3 am-u-md-3" style="padding:0px;text-align: right;">
                            登记号：
                        </div>
                        <div class="am-u-sm-9 am-u-md-9">
                            <input id="xstzDjh" type="text" class="am-form-field am-input-sm">
                        </div>
                    </div>
                    <div class="am-u-sm-2 am-u-md-2">
                    </div>
                    <div class="am-u-sm-4 am-u-md-4" id="khmcdiv" style="margin-top: 10px;padding-left: 0px;">
                        <div class="am-u-sm-3 am-u-md-3" style="padding: 0px;" id="khmcspan">
                            客户名称：
                        </div>
                        <div class="am-u-sm-9 am-u-md-9" style="padding: 0px;" id="khmcinput">
                            <input id="xstzKhbm" type="hidden">
                            <input id="xstzKhmc" type="text" class="am-form-field am-input-sm">
                        </div>
                    </div>
                    <div class="am-u-sm-6 am-u-md-6 xsqxdix" style="margin-top: 10px;">
                        <div class="am-u-sm-3 am-u-md-3" style="padding: 0px;text-align: right;">
                            生产企业：
                        </div>
                        <div class="am-u-sm-9 am-u-md-9">
                            <input id="xstzScqy" type="text" class="am-form-field am-input-sm">
                        </div>
                    </div>
                    <div class="am-u-sm-2 am-u-md-2">
                    </div>
                </div>
            </form>
            <div class="am-container am-scrollable-horizontal" style="margin-top: 20px;" id="hovertables">
                <table class="am-table am-table-bordered am-table-centered am-text-nowrap" >
                    <thead>
                    <tr>
                        <th class="am-text-middle">商户编号</th>
                        <th class="am-text-middle xsqxdix">登记号</th>
                        <th class="am-text-middle">商户名称</th>
                        <th class="am-text-middle">产品规格</th>
                        <th class="am-text-middle xsqxdix">生产企业</th>
                        <th class="am-text-middle xsqxdix">生产许可证</th>
                        <th class="am-text-middle">销售日期</th>
                        <th class="am-text-middle">客户名称</th>
                        <th class="am-text-middle">联系电话</th>
                        <th class="am-text-middle xsqxdix">证件号</th>
                        <th class="am-text-middle">计量单位</th>
                        <th class="am-text-middle">数量</th>
                    </tr>
                    </thead>
                    <tbody id="sptable">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!--选择客户div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseKhdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">选择客户
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <table class="am-table am-table-bordered am-table-centered" >
                        <thead>
                        <tr>
                            <th class="am-text-middle">客户名称</th>
                            <th class="am-text-middle">手机号码</th>
                            <th class="am-text-middle">身份证号</th>
                            <th class="am-text-middle">地址</th>
                        </tr>
                        </thead>
                        <tbody id="khtable">
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
                            <th class="am-text-middle">商户编号</th>
                            <th class="am-text-middle">商户名称</th>
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
        $('#xstzKhmc').keyup(function (event) {
            if(event.keyCode == 13){
                $('#chooseKhdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:500
                });
                var khmc = $('#xstzKhmc').val();
                loadKhxx(khmc,1);
                $('#chooseKhdiv').modal('open');
            }
        });
        //显示选择生产企业
        $('#xstzScqy').keyup(function (event) {
            if(event.keyCode == 13){
                $('#chooseQydiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:500
                });
                var scqy = $('#xstzScqy').val();
                loadKhxx(scqy,2);
                $('#chooseQydiv').modal('open');
            }
        });
        //显示选择商户名称
        $('#xstzSpmc').keyup(function (event) {
            if(event.keyCode == 13){
                $('#chooseSpdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:500
                });
                var spmc = $('#xstzSpmc').val();
                loadSpxx(spmc);
                $('#chooseSpdiv').modal('open');
            }
        });
        //显示选择商户编号
        $('#xstzSptm').keyup(function (event) {
            if(event.keyCode == 13){
                $('#chooseSpdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:500
                });
                var sptm = $('#xstzSptm').val();
                loadSpxx(sptm,1);
                $('#chooseSpdiv').modal('open');
            }
        });

        $('#hovertables').hover(function(){
            $('#hovertables').css("overflow","auto")
        },function(){
            $('#hovertables').css("overflow","hidden")
        });

        if('<%=ypd%>' != '1'){
            $('.xsqxdix').hide();
            $('#khmcdiv').removeClass("am-u-sm-4").addClass("am-u-sm-6");
            $('#khmcdiv').removeClass("am-u-md-4").addClass("am-u-md-6");
            $('#khmcspan').css("text-align","right");
            $('#khmcinput').css("padding","");
        }

    });

    function getSpmx(){
        var ksrq=$('#ksrq').val();
        var jsrq=$('#jsrq').val();
        var spmc=$('#xstzSpmc').val();
        var sptm=$('#xstzSptm').val();
        var djh =$('#xstzDjh').val();
        var khbm=$('#xstzKhbm').val();
        var khmc=$('#xstzKhmc').val();
        var scqy=$('#xstzScqy').val();
        $.ajax({
            url: "/parameters/getXstzs",
            type: "post",
            async: false,
            data: {ksrq:ksrq,jsrq:jsrq,spmc:spmc,sptm:sptm,djh:djh,khbm:khbm,khmc:khmc,qybm:scqy},
            success: function (data) {
                var spdalist = JSON.parse(data);
                $('#sptable').html("");
                if(spdalist.length>0) {
                    for(var i=0;i<spdalist.length;i++){
                        var spjson = spdalist[i];
                        var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                        rowhtml+="<td class=\"am-text-middle am-td-spmc\">"+spjson.F_SPTM+"</td>"
                            if('<%=ypd%>' == '1'){
                                rowhtml+="<td class=\"am-text-middle\">"+spjson.F_YPZJH+"</td>"
                            }
                            rowhtml+="<td class=\"am-text-middle\">"+spjson.F_SPMC+"</td>"
                            rowhtml+="<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                            if('<%=ypd%>' == '1'){
                                rowhtml+="<td class=\"am-text-middle\">"+spjson.F_SCQY+"</td>"
                                rowhtml+="<td class=\"am-text-middle\">"+spjson.F_SCXKZH+"</td>"
                            }
                            rowhtml+="<td class=\"am-text-middle\">"+spjson.F_RZRQ+"</td>"
                            rowhtml+="<td class=\"am-text-middle\">"+spjson.F_KHMC+"</td>"
                            rowhtml+="<td class=\"am-text-middle\">"+spjson.F_DH+"</td>"
                            if('<%=ypd%>' == '1'){
                                rowhtml+="<td class=\"am-text-middle\">"+spjson.F_SFZH+"</td>"
                            }
                            rowhtml+="<td class=\"am-text-middle\">"+spjson.F_JLDWLX+"</td>"
                            rowhtml+="<td class=\"am-text-middle\">"+spjson.F_XSSL+"</td>"
                            rowhtml+="</tr>";
                        $('#sptable').prepend(rowhtml);
                    }
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    }
    //加载客户
    function loadKhxx(khxx,cslx){
        $.ajax({
            url: "/initialvalues/GetKhda",
            type: "post",
            async: false,
            data: {khxx:khxx,cslx:cslx, timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var khdahtml="";
                    for(var i=0;i<dataJson.length;i++){
                        var khda=dataJson[i];
                        if(khdahtml==""){
                            khdahtml+="<tr>\n";

                            if(cslx == 1){
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_SFZH+"</td>\n";
                            }else{
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_CSBM+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_SCXKZH+"</td>\n";
                            }
                            khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_DZ+"</td>\n";
                            khdahtml+="                            <td class=\"am-hide\">"+khda.F_CSBM+"</td>\n";
                            khdahtml+="                        </tr>";
                        }else{
                            khdahtml+="<tr>\n";
                            if(cslx == 1){
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_SFZH+"</td>\n";
                            }else{
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_CSBM+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n";
                                khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_SCXKZH+"</td>\n";
                            }
                            khdahtml+="                            <td class=\"am-text-middle\">"+khda.F_DZ+"</td>\n";
                            khdahtml+="                            <td class=\"am-hide\">"+khda.F_CSBM+"</td>\n";
                            khdahtml+="                        </tr>";
                        }
                    }
                    if(cslx == 1){
                        $('#khtable').html(khdahtml);
                        $('#khtable tr').click(function () {
                            var rowNum=$(this).index();
                            var $table=$(this).parent();
                            var khmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                            $('#xstzKhmc').val(khmc);
                            $('#chooseKhdiv').modal('close');
                        });
                    }else{
                        $('#qytable').html(khdahtml);
                        $('#qytable tr').click(function () {
                            var rowNum=$(this).index();
                            var $table=$(this).parent();
                            var qxmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(1)').text();
                            $('#xstzScqy').val(qxmc);
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
                            spdahtml+="<tr>\n";
                            spdahtml+="                            <td class=\"am-text-middle\">"+spda.F_SPTM+"</td>\n";
                            spdahtml+="                            <td class=\"am-text-middle\">"+spda.F_SPMC+"</td>\n";
                            spdahtml+="                            <td class=\"am-text-middle\">"+spda.F_GGXH+"</td>\n";
                            spdahtml+="                            <td class=\"am-text-middle\">"+spda.F_XSDJ+"</td>\n";
                            spdahtml+="                        </tr>";
                        }else{
                            spdahtml+="<tr>\n";
                            spdahtml+="                            <td class=\"am-text-middle\">"+spda.F_SPTM+"</td>\n";
                            spdahtml+="                            <td class=\"am-text-middle\">"+spda.F_SPMC+"</td>\n";
                            spdahtml+="                            <td class=\"am-text-middle\">"+spda.F_GGXH+"</td>\n";
                            spdahtml+="                            <td class=\"am-text-middle\">"+spda.F_XSDJ+"</td>\n";
                            spdahtml+="                        </tr>";
                        }
                    }
                    $('#spmxtable').html(spdahtml);
                    $('#spmxtable tr').click(function () {
                        var rowNum=$(this).index();
                        var $table=$(this).parent();
                        var spmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(1)').text();
                        var sptm=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                        if(lx == 1){
                            $('#xstzSptm').val(sptm);
                        }else{
                            $('#xstzSpmc').val(spmc);
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

    function loadlbxx(){
        $('#ksrq').datepicker('setValue','<%=ksrq%>');
        $('#jsrq').datepicker('setValue','<%=newdata%>');
        $('#xstzSpmc').val("");
        $('#xstzSptm').val("");
        $('#xstzDjh').val("");
        $('#xstzKhbm').val("");
        $('#xstzKhmc').val("");
        $('#xstzScqy').val("");
    }
</script>
</html>
