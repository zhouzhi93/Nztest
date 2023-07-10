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
%>
<%--<!DOCTYPE html>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-库存报表</title>
    <meta name="description" content="云平台客户端V1-库存报表">
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
                <h1>库存报表</h1>
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
                <button type="button" onclick="getKcmx()" class="am-btn am-btn-primary  am-radius am-btn-sm">查询</button>
                <button type="button" onclick="loadlbxx()" class="am-btn am-btn-primary  am-radius am-btn-sm">清空</button>
            </div>
        </div>
        <form class="am-form">
            <div class="am-container" style="margin-top: 10px;">
                <div class="am-u-sm-4 am-u-md-4" style="padding-left: 0px;">
                    <div class="am-u-sm-3 am-u-md-3" style="padding: 0px;text-align: right;">
                        商品条码：
                    </div>
                    <div class="am-u-sm-9 am-u-md-9" style="padding: 0px;">
                        <input id="sptm" type="text" class="am-form-field am-input-sm">
                    </div>
                </div>
                <div class="am-u-sm-6 am-u-md-6">
                    <div class="am-u-sm-3 am-u-md-3" style="padding:0px;text-align: right;">
                        登记号：
                    </div>
                    <div class="am-u-sm-9 am-u-md-9">
                        <input id="djh" type="text" class="am-form-field am-input-sm">
                    </div>
                </div>
                <div class="am-u-sm-2 am-u-md-2">
                </div>
            </div>
            <div class="am-container" style="margin-top: 10px;">
                <div class="am-u-sm-10 am-u-md-10">
                    <div class="am-u-sm-1 am-u-md-1" style="padding: 0px;">
                        供应商：
                    </div>
                    <div class="am-u-sm-11 am-u-md-11" style="padding-left: ">
                        <input id="gysbm" type="hidden">
                        <input id="gysmc" type="text" class="am-form-field am-input-sm">
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
                    <th class="am-text-middle">商品条码</th>
                    <th class="am-text-middle">登记号</th>
                    <th class="am-text-middle">商品名称</th>
                    <th class="am-text-middle">产品规格</th>
                    <th class="am-text-middle">计量单位</th>
                    <th class="am-text-middle">库存数量</th>
                    <th class="am-text-middle">成本单价</th>
                    <th class="am-text-middle">成本金额</th>
                </tr>
                </thead>
                <tbody id="sptable">
                </tbody>
            </table>
        </div>
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
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseKcdiv">
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

        $('#kcrq').datepicker('setValue','<%=newdata%>');

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
        //显示选择商品名称
        $('#spmc').keyup(function (event) {
            if(event.keyCode == 13){
                $('#chooseKcdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:500
                });
                var spmc = $('#spmc').val();
                loadSpxx(spmc);
                $('#chooseKcdiv').modal('open');
            }
        });
        //显示选择商品条码
        $('#sptm').keyup(function (event) {
            if(event.keyCode == 13){
                $('#chooseKcdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:500
                });
                var sptm = $('#sptm').val();
                loadSpxx(sptm,1);
                $('#chooseKcdiv').modal('open');
            }
        });

        $('#hovertables').hover(function(){
            $('#hovertables').css("overflow","auto")
        },function(){
            $('#hovertables').css("overflow","hidden")
        });

    });

    function getKcmx(){
        var kcrq=$('#kcrq').val();
        var spmc=$('#spmc').val();
        var sptm=$('#sptm').val();
        var djh = $('#djh').val();
        var khbm=$('#khbm').val();
        var gysmc=$('#gysmc').val();
        var gysbm = $('#gysbm').val();

        $.ajax({
            url: "/repertorys/getKctzs",
            type: "post",
            async: false,
            data: {kcrq:kcrq,spmc:spmc,sptm:sptm,djh:djh,khbm:khbm,gysmc:gysmc,gysbm:gysbm},
            success: function (data) {
                var spdalist = JSON.parse(data);
                $('#sptable').html("");
                if(spdalist.length>0) {
                    for(var i=0;i<spdalist.length;i++){
                        var spjson = spdalist[i];
                        var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                            +"<td class=\"am-text-middle am-td-spmc\">"+spjson.F_SPTM+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_YPZJH+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_SPMC+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_JLDW+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_KCSL+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_CBDJ+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_CBJE+"</td>"
                            +"</tr>";
                        $('#sptable').prepend(rowhtml);
                    }
                }
                $('#sptable tr').dblclick(function () {
                    var rowNum=$(this).index();
                    var $table=$(this).parent();
                    var sptm=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
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
                            khdahtml="<tr>\n" +
                                "                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+khda.F_LXR+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n" +
                                "                            <td class=\"am-hide\">"+khda.F_CSBM+"</td>\n" +
                                "                        </tr>"
                        }else{
                            khdahtml+="<tr>\n" +
                                "                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+khda.F_LXR+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n" +
                                "                            <td class=\"am-hide\">"+khda.F_CSBM+"</td>\n" +
                                "                        </tr>"
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
                        $('#chooseKcdiv').modal('close');
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
        $('#kcrq').datepicker('setValue','<%=newdata%>');
        $('#spmc').val("");
        $('#sptm').val("");
        $('#djh').val("");
        $('#khbm').val("");
        $('#gysmc').val("");
        $('#gysbm').val("");
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
