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
    <title>云平台客户端V1-欠款查询</title>
    <meta name="description" content="云平台客户端V1-进货查询">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="apple-touch-icon-precomposed" href="/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="/assets/css/amazeui.min.css"/>
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
        欠款日期:
        <%--<input type="text" id="f_ksrq" class="am-form-field am-input-sm am-radius" style="width: 150px;" data-am-datepicker readonly placeholder="开始日期">至--%>
        <input type="text" id="f_jsrq" class="am-form-field am-input-sm am-radius" style="width: 150px;" data-am-datepicker readonly placeholder="结束日期">&nbsp;&nbsp;&nbsp;&nbsp;
        <%--查询方式:
        <label class="am-radio-inline">
            <input type="radio" value="0" checked="checked" name="f_cxfs"> 单据汇总
        </label>
        <label class="am-radio-inline">
            <input type="radio" value="1"  name="f_cxfs"> 明细查询
        </label>--%>
    </div>
    <div class="am-form-inline" style="margin-top: 10px;">
        <input type="text" id="khxx" class="am-form-field am-input-sm am-radius" style="width: 230px;" placeholder="在当前条件下搜索客户名">&nbsp;
        <button onclick="searchbyKh()" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger">查询</button>
        <%--<button onclick="getexcel()" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger">导出excel</button>--%>
        <%--<button onclick="loadInfo('')" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger" style="margin-left: 10px;background-color: #fff !important;border: 1px solid #e52a33 !important;color: #e52a33 !important;">重新加载</button>--%>
    </div>
    <div class="am-scrollable-horizontal" style="margin-top: 15px;">
        <table class="am-table am-table-bordered am-table-striped am-text-nowrap am-table-centered" id="hztable">
            <thead>
            <tr>
                <th class="am-text-middle">操作</th>
                <th class="am-text-middle">客户名称</th>
                <th class="am-text-middle">身份证号</th>
                <th class="am-text-middle">手机号</th>
                <th class="am-text-middle">欠款日期</th>
                <th class="am-text-middle">销售单号</th>
                <th class="am-text-middle">欠款金额</th>
                <th class="am-text-middle">已收金额</th>
                <th class="am-text-middle">剩余欠款金额</th>
            </tr>
            </thead>
            <tbody id="spqktable">
            </tbody>
        </table>
    </div>
</div>

<!--进货详情-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="xsDetail">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">销售单据详情
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div style="margin-top: 10px;height: 380px;" class="am-container  am-scrollable-vertical am-scrollable-horizontal">
                <table class="am-table am-table-bordered am-table-centered am-text-nowrap"  >
                    <thead>
                    <tr>
                        <th class="am-text-middle">单据号</th>
                        <th class="am-text-middle">制单日起</th>
                        <th class="am-text-middle">商品条码</th>
                        <th class="am-text-middle">商品名称</th>
                        <th class="am-text-middle">商品属性</th>
                        <th class="am-text-middle">规格</th>
                        <th class="am-text-middle">批号</th>
                        <th class="am-text-middle">单位</th>
                        <th class="am-text-middle">单价</th>
                        <th class="am-text-middle">销售数量</th>
                        <th class="am-text-middle">销售金额</th>
                    </tr>
                    </thead>
                    <tbody id="qkDetailtable">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!--收款金额div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="Skjediv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd"><h1>收款金额</h1>
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div style="margin-top: 10px;" class="am-container">
                <form class="am-form am-form-horizontal" id="skjeform">
                    <div class="am-form-group">
                        <label for="f_skje" class="am-u-sm-3" style="font-size: 2.6rem;">收款金额</label>
                        <div class="am-u-sm-8">
                            <input type="number" class="am-form-field am-input-lg am-radius" id="f_skje" required placeholder="收款金额">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group am-text-left">
                        <div class="am-u-sm-3">&nbsp;</div>
                        <div class="am-u-sm-8">
                            <button type="submit" id="addqkbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '收款...', resetText: '收款'}" class="am-btn am-btn-danger am-btn-xl">收款</button>&nbsp;&nbsp;
                            <button type="button" class="am-btn am-btn-default am-btn-xl" onclick="closeNewQkdiv()">取消</button>
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
    var spqkmxJson = null;
    $(function (){
        var spqkList ='${spqkList}';
        if(spqkList.length==0){
            console.log('暂无欠款数据');
        }else {
            var $spqktable=$('#spqktable');
            spqkList=JSON.parse(spqkList);
            spqkmxJson = spqkList;
            var salehtml="";
            for(var i=0;i<spqkList.length;i++){
                var spgj=spqkList[i];
                if(salehtml==""){
                    salehtml="<tr ondblclick='showDetail("+spgj.F_DJH+")'>\n" +
                        "                        <td class=\"am-text-middle\">" +
                        "&nbsp;&nbsp;&nbsp;<a class=\"redlink\" onclick=\"proceeds("+i+")\">收款</a>" +
                        "&nbsp;&nbsp;&nbsp;<a class=\"redlink\" onclick=\"Dept("+i+")\">催款</a> </td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_KHMC+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_SFZH+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_DH+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_QKRQ+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_DJH+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_QKJE+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_YSJE+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_SYJE+"</td>\n" +
                        "                    </tr>";
                }else{
                    salehtml+="<tr ondblclick='showDetail("+spgj.F_DJH+")'>\n" +
                        "                        <td class=\"am-text-middle\">" +
                        "&nbsp;&nbsp;&nbsp;<a class=\"redlink\" onclick=\"proceeds("+i+")\">收款</a>" +
                        "&nbsp;&nbsp;&nbsp;<a class=\"redlink\" onclick=\"Dept("+i+")\">催款</a> </td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_KHMC+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_SFZH+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_DH+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_QKRQ+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_DJH+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_QKJE+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_YSJE+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+spgj.F_SYJE+"</td>\n" +
                        "                    </tr>";
                }
            }
            $spqktable.html(salehtml);
        }
        var date = new Date();
        var year = date.getFullYear();
        var month = ((date.getMonth() + 1) < 10 ? "0" : "") + (date.getMonth() + 1);
        var day = (date.getDate() < 10 ? "0" : "") + date.getDate();
        $('#f_ksrq').val(year + "-" + month + "-" + day);
        $('#f_jsrq').val(year + "-" + month + "-" + day);
        //关闭还原遮罩蒙板z-index
        $('#Skjediv').on('closed.modal.amui', function() {
            $('.am-dimmer').css("z-index","1100");
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
            window.location.href = "/excel/getPurchaqseBillExcel?cxtj="+cxtj+"&f_ksrq="+f_ksrq+"&f_jsrq="+f_jsrq;
        }else{
            window.location.href = "/excel/getSpgjDetailExcel?cxtj="+cxtj+"&f_ksrq="+f_ksrq+"&f_jsrq="+f_jsrq;
        }
    }

    function searchbyKh(){
        var cxtj=$('#khxx').val();
        var f_ksrq=$('#f_ksrq').val();
        var f_jsrq=$('#f_jsrq').val();
        loadInfo(cxtj,f_ksrq,f_jsrq);
    }

    function loadInfo(cxtj,f_ksrq,f_jsrq) {
        var $spqktable = $('#spqktable');
        $spqktable.html('');
        $.ajax({
            url: "/arrearage/GetBillDetail",
            type: "post",
            async: false,
            data: {cxtj: cxtj, f_ksrq: f_ksrq,f_jsrq:f_jsrq, timeer: new Date()},
            success: function (data) {
                var spqkList = JSON.parse(data);
                spqkmxJson = spqkList;
                if (spqkList.length > 0) {
                    var salehtml = "";
                    for (var i = 0; i < spqkList.length; i++) {
                        var spgj = spqkList[i];
                        salehtml += "<tr ondblclick='showDetail("+spgj.F_DJH+")'>\n" +
                            "                        <td class=\"am-text-middle\">" +
                            "&nbsp;&nbsp;&nbsp;<a class=\"redlink\" onclick=\"proceeds("+i+")\">收款</a>" +
                            "&nbsp;&nbsp;&nbsp;<a class=\"redlink\" onclick=\"Dept("+i+")\">催款</a> </td>\n" +
                            "                        <td class=\"am-text-middle\">"+spgj.F_KHMC+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+spgj.F_SFZH+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+spgj.F_DH+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+spgj.F_QKRQ+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+spgj.F_DJH+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+spgj.F_QKJE+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+spgj.F_YSJE+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+spgj.F_SYJE+"</td>\n" +
                            "                    </tr>";
                    }
                    $spqktable.html(salehtml);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    }
    //显示单据详情
    function showDetail(f_djh){
        $('#xsDetail').modal({
            closeViaDimmer: false,
            width:980,
            height:500
        });
        var $qxtjtable = $('#qkDetailtable');
        $qxtjtable.html('');
        $.ajax({
            url: "/sales/GetSalesDetailByDjh",
            type: "post",
            async: false,
            data: {djh: f_djh, timeer: new Date()},
            success: function (data) {
                var saleList = JSON.parse(data);
                if (saleList.length > 0) {
                    var salehtml = "";
                    var zje=0,zxl=0;
                    for (var i = 0; i < saleList.length; i++) {
                        var sale = saleList[i];
                        salehtml += "<tr>\n" +
                            "                        <td class=\"am-text-middle\">" + sale.F_DJH + "</td>\n" +
                            "                        <td class=\"am-text-middle\">" + sale.F_RZRQ + "</td>\n" +
                            "                        <td class=\"am-text-middle\">" + sale.F_SPTM + "</td>\n" +
                            "                        <td class=\"am-text-middle\">" + sale.F_SPMC + "</td>\n";
                        if(sale.F_NYBZ=="0"){
                            salehtml +=   "                        <td class=\"am-text-middle\">禁限农药</td>\n";
                        }else{
                            salehtml +=   "                        <td class=\"am-text-middle\">非禁限农药</td>\n";
                        }
                        salehtml += "                        <td class=\"am-text-middle\">" + sale.F_GGXH + "</td>\n" +
                            "                        <td class=\"am-text-middle\">" + sale.F_SGPCH + "</td>\n" +
                            "                        <td class=\"am-text-middle\">" + sale.F_JLDW + "</td>\n" +
                            "                        <td class=\"am-text-middle\">" + sale.F_XSDJ + "</td>\n" +
                            "                        <td class=\"am-text-middle\">"+sale.F_XSSL+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+sale.F_SSJE+"</td>\n" +
                            "                    </tr>";
                        zje+=eval(sale.F_SSJE);
                        zxl+=eval(sale.F_XSSL);
                    }
                    salehtml += "<tr>\n" +
                        "                        <td class=\"am-text-left\" colspan='9'>合计：</td>\n" +
                        "                        <td class=\"am-text-middle\">" + zxl.toFixed(1) + "</td>\n" +
                        "                        <td class=\"am-text-middle\">" + zje.toFixed(1) + "</td>\n" +
                        "                    </tr>";
                    $qxtjtable.html(salehtml);
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
    
    function proceeds(index) {
        var jsons = spqkmxJson[index];
        $('#Skjediv').modal({
            closeViaDimmer: false,
            width:580,
            height:300
        });
        $('#Skjediv').modal('open');
        $("#f_skje").val(jsons.F_SYJE);

        //收款提交
        $('#addqkbtn').click(function () {
            var f_skje = $("#f_skje").val();
            var json = spqkmxJson[index];
            var f_djh = json.F_DJH;
            var f_bmbm = json.F_BMBM;
            var f_qkje = json.F_QKJE;
            var f_syje = json.F_SYJE;
            if(parseInt(f_skje) <= 0){
                alertMsg("请输入正确的收款金额！");
                return false;
            }
            if(parseInt(f_skje) > f_syje){
                alertMsg("收款金额大于剩余金额！");
                return false;
            }
            $.ajax({
                url: "/arrearage/proceeds",
                type: "post",
                async: false,
                data: { f_djh: f_djh,f_bmbm: f_bmbm,f_qkje: f_qkje,f_skje: f_skje,f_syje: f_syje, timeer: new Date() },
                success: function (data) {
                    if(data == "ok"){
                        alertMsg("收款成功！");
                    }
                    $('#Skjediv').modal('close');
                    searchbyKh();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $subbtn.button('reset');
                }
            });
        });
    }
    function closeNewQkdiv(){
        $('#Skjediv').modal('close');
    }

    function Dept(index) {
        var json = spqkmxJson[index];
        $.ajax({
            url: "/arrearage/dept",
            type: "post",
            async: false,
            data: {khmc:json.F_KHMC,dh:json.F_DH,qkrq:json.F_QKRQ,bmmc:json.F_BMMC,bmdh:json.F_BMDH},
            success: function (data) {
                if(data == "ok"){
                    alertMsg("短信已发送！");
                }else{
                    alertMsg(data);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }
    function alertMsg(msg){
        parent.alertMsg(msg);
    }
</script>
</body>
</html>
