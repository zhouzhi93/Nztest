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
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-综合进销存查询</title>
    <meta name="description" content="云平台客户端V1-综合进销存查询">
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
            padding-bottom: 10px;
        }
        label{
            font-weight: 500;
            font-size:1.4rem;
        }
        .am-popup{
            z-index: 1200;
        }
        #ksrq,#jsrq{
            width:120px;
            display: inline-block;
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
    <div class="am-container">
        <div class="am-u-sm-7 am-u-md-7">部门：<select data-am-selected id="xzbm"></select></div>
    </div>

    <div class="am-container">
        <div class="am-u-sm-6 am-u-md-6">
            日期范围：<input id="ksrq" type="text" class="am-radius am-form-field am-input-sm" placeholder="开始日期" data-am-datepicker readonly required />
            ~ <input id="jsrq" type="text" class="am-radius am-form-field am-input-sm" placeholder="结束日期" data-am-datepicker readonly required />
        </div>

        <div class="am-u-sm-6 am-u-md-6">
            <label class="am-checkbox" style="font-size: 15px;">
                <input type="checkbox" value="" data-am-ucheck id="xzsj"> 税金
            </label>
        </div>
    </div>

    <div class="am-container">
        <div class="am-u-sm-5 am-u-md-5">
            <div class="am-form-group">
                <label for="f_spfl" class="am-u-sm-2 am-form-label" style="padding: 0px;font-size: 15px;">商品类别:</label>
                <div class="am-u-sm-9">
                    <input readonly type="hidden" class="am-form-field am-input-sm am-radius" id="f_spfl" required>
                    <input readonly type="text" class="am-form-field am-input-sm am-radius" id="f_spflmc" placeholder="">
                </div>
                <div class="am-u-sm-end"></div>
            </div>
        </div>

        <div class="am-u-sm-5 am-u-md-5">
            <div class="am-u-sm-3 am-u-md-3" style="padding:0px;text-align: right;">
                商品：
            </div>
            <div class="am-u-sm-9 am-u-md-9">
                <input id="xzsp" type="text" onclick="openSpDiv()" readonly type="text" placeholder="选择商品" class="am-form-field am-input-sm">
            </div>
        </div>

        <div class="am-u-sm-2 am-u-md-2">
            <button onclick="loadInfo(1,10)" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger">查询</button>
        </div>
    </div>

    <div class="am-container am-scrollable-horizontal" style="margin-top: 20px;" id="hovertables">
        <table class="am-table am-table-bordered am-table-centered am-text-nowrap" >
            <thead>
            <tr>
                <th class="am-text-middle">商品编码</th>
                <th class="am-text-middle">商品名称</th>
                <th class="am-text-middle">规格</th>
                <th class="am-text-middle">售价</th>
                <th class="am-text-middle">期初数量</th>
                <th class="am-text-middle">期初金额</th>
                <th class="am-text-middle am-hiden">期初税金</th>
                <th class="am-text-middle am-hiden">期初无税金额</th>
                <th class="am-text-middle">进货数量</th>
                <th class="am-text-middle">进货金额</th>
                <th class="am-text-middle am-hiden">进货税金</th>
                <th class="am-text-middle am-hiden">进货无税金额</th>
                <th class="am-text-middle">拨入数量</th>
                <th class="am-text-middle">拨入金额</th>
                <th class="am-text-middle am-hiden">拨入税金</th>
                <th class="am-text-middle am-hiden">拨入无税金额</th>
                <th class="am-text-middle">升益数量</th>
                <th class="am-text-middle">升益金额</th>
                <th class="am-text-middle am-hiden">升益税金</th>
                <th class="am-text-middle am-hiden">升益无税金额</th>
                <th class="am-text-middle">销售数量</th>
                <th class="am-text-middle">销售金额</th>
                <th class="am-text-middle am-hiden">销售税金</th>
                <th class="am-text-middle am-hiden">销售无税金额</th>
                <th class="am-text-middle">拨出数量</th>
                <th class="am-text-middle">拨出金额</th>
                <th class="am-text-middle am-hiden">拨出税金</th>
                <th class="am-text-middle am-hiden">拨出无税金额</th>
                <th class="am-text-middle">损耗数量</th>
                <th class="am-text-middle">损耗金额</th>
                <th class="am-text-middle am-hiden">损耗税金</th>
                <th class="am-text-middle am-hiden">损耗无税金额</th>
                <th class="am-text-middle">期末数量</th>
                <th class="am-text-middle">期末金额</th>
                <th class="am-text-middle am-hiden">期末税金</th>
                <th class="am-text-middle am-hiden">期末无税金额</th>
            </tr>
            </thead>
            <tbody id="sptable">
            </tbody>
        </table>
    </div>
    <div id="pagebar"></div>
</div>

<!--分类选择div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="SPFLdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">分类选择
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-g am-scrollable-vertical" style="min-height: 400px;">
            <div class="am-container">
                <ul class="am-tree am-tree-folder-select" role="tree" id="firstTree" style="text-align: left;">
                    <li class="am-tree-branch am-hide" data-template="treebranch" role="treeitem" aria-expanded="false">
                        <div class="am-tree-branch-header">
                            <button class="am-tree-icon am-tree-icon-caret am-icon-caret-right"><span class="am-sr-only">Open</span></button>
                            <button class="am-tree-branch-name">
                                <span class="am-tree-icon am-tree-icon-folder"></span>
                                <span class="am-tree-label"></span>
                            </button>
                        </div>
                        <ul class="am-tree-branch-children" role="group"></ul>
                        <div class="am-tree-loader" role="alertMsg">Loading...</div>
                    </li>
                    <li class="am-tree-item am-hide" data-template="treeitem" role="treeitem">
                        <button class="am-tree-item-name">
                            <span class="am-tree-icon am-tree-icon-item"></span>
                            <span class="am-tree-label"></span>
                        </button>
                    </li>
                </ul>
            </div>
        </div>
        <div class="am-form-group am-text-left">
            <div class="am-u-sm-4">&nbsp;</div>
            <div class="am-u-sm-8">
                <button type="submit" id="addFlxz" class="am-btn am-btn-danger am-btn-xs">确认</button>&nbsp;&nbsp;
                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeQyxzdiv()">取消</button>
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

<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script src="/assets/js/app.js"></script>
<script src="/assets/address/address.min.js"></script>
<script src="/assets/address/iscroll.min.js"></script>
<script src="/tree/amazeui.tree.js"></script>
<script src="/tree/amazeui.tree.min.js"></script>
<script src="/cropper/js/cropper.min.js"></script>
<script type="text/javascript">
    $(function (){
        loadBm();
        loadspfl();

        $('#ksrq').val('<%=str.substring(0,8)%>01');
        $('#jsrq').val('<%=str%>');


        $('#f_spflmc').click(function () {
            $('#SPFLdiv').modal({
                closeViaDimmer: false,
                width:680,
                height:550
            });
            $('#SPFLdiv').modal('open');
            $('#SPFLdiv').css("z-index","1219");
        });

        $('#addFlxz').click(function () {
            $('#SPFLdiv').modal('close');
        });

        $('#firstTree').on('selected.tree.amui', function (event, data) {
            var flbm = data.target.id;
            var flmc = data.target.title;
            spflbm = flbm;
            spflmc = flmc;
        });

        $('#addFlxz').click(function () {
            $('#SPFLdiv').modal('close');

            $("#f_spfl").val(spflbm);
            $("#f_spflmc").val(spflmc);
            setsptm(spflbm);
        });

        $(".am-hiden").hide();
    })

    //加载部门
    function loadBm() {
        $.ajax({
            url: "/report/loadBm",
            type: "post",
            async: false,
            data: {timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                var xzbmHtml= "";
                for (var i = 0; i < dataJson.length; i++){
                    var bmda = dataJson[i];
                    xzbmHtml += "<option value='"+bmda.F_BMBM+"'>"+bmda.F_BMMC+"</option>"
                }
                $("#xzbm").html(xzbmHtml);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }

    function setsptm(splbbm){
        $.ajax({
            url: "/commodity/getMaxSptm",
            type: "post",
            async: false,
            data: {splbbm:splbbm},
            success: function (data) {
                if(data != ''){
                    $('#f_sptm').val(data);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alertMsg(errorThrown + "||" + textStatus);
            }
        });
    }

    //加载客户
    function loadspfl(){
        $.ajax({
            url: "/commodity/getSplbda",
            type: "post",
            async: false,
            data: {splbbm:'',timeer: new Date() },
            success: function (data) {
                splbJson = data;
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alertMsg(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });


        $('#firstTree').tree({
            dataSource: function(options, callback) {
                // 模拟异步加载
                setTimeout(function() {
                    var json = JSON.parse(splbJson);
                    callback({data: options.products || json});
                }, 400);
            },
            multiSelect: false,
            cacheItems: false,
            folderSelect: true
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
        $('#xzsp').attr("sptm",sptm);
        $('#xzsp').val(spmc);
        $("#chooseKcdiv").modal('close');
    }

    function loadTable(pageIndex) {
        $('#pagebar').html("");
        loadInfo(pageIndex,10);
    }

    function loadInfo(pageIndex,pageSize){
        var bmbm = $("#xzbm").val();
        var ksrq = $("#ksrq").val();
        var jsrq = $("#jsrq").val();
        var spflbm = $("#f_spfl").val();
        var sptm = $("#xzsp").attr("sptm");


        $.ajax({
            url: "/report/loadZhjxc",
            type: "post",
            async: false,
            data: {bmbm:bmbm,ksrq:ksrq,jsrq:jsrq,spflbm:spflbm,sptm:sptm,pageIndex:pageIndex,pageSize:pageSize},
            success: function (data) {
                if (data == "410"){
                    alertMsg("请选择日期！");
                }else{
                    var res = JSON.parse(data);
                    var spdalist = JSON.parse(res.list);
                    $('#sptable').html("");
                    if(spdalist.length>0) {
                        var rowhtml="";
                        for(var i=0;i<spdalist.length;i++){
                            var spjson = spdalist[i];
                            rowhtml+="<tr>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_SPTM+"'>"+spjson.F_SPTM+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_SPMC+"'>"+spjson.F_SPMC+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_GGXH+"'>"+spjson.F_GGXH+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_XSDJ+"'>"+spjson.F_XSDJ+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_QCSL+"'>"+Math.round(spjson.F_QCSL*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_QCJE+"'>"+Math.round(spjson.F_QCJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_QCSJ+"'>"+Math.round(spjson.F_QCSJ*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_QCWSJE+"'>"+Math.round(spjson.F_QCWSJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_GJSL+"'>"+Math.round(spjson.F_GJSL*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_GJJE+"'>"+Math.round(spjson.F_GJJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_GJSJ+"'>"+Math.round(spjson.F_GJSJ*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_GJWSJE+"'>"+Math.round(spjson.F_GJWSJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_BRSL+"'>"+Math.round(spjson.F_BRSL*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_BRJE+"'>"+Math.round(spjson.F_BRJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_BRSJ+"'>"+Math.round(spjson.F_BRSJ*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_BRWSJE+"'>"+Math.round(spjson.F_BRWSJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_SYSL+"'>"+Math.round(spjson.F_SYSL*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_SYJE+"'>"+Math.round(spjson.F_SYJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_SYSJ+"'>"+Math.round(spjson.F_SYSJ*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_SYWSJE+"'>"+Math.round(spjson.F_SYWSJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_XSSL+"'>"+Math.round(spjson.F_XSSL*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_XSJE+"'>"+Math.round(spjson.F_XSJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_XSSJ+"'>"+Math.round(spjson.F_XSSJ*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_XSWSJE+"'>"+Math.round(spjson.F_XSWSJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_BCSL+"'>"+Math.round(spjson.F_BCSL*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_BCJE+"'>"+Math.round(spjson.F_BCJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_BCSJ+"'>"+Math.round(spjson.F_BCSJ*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_BCWSJE+"'>"+Math.round(spjson.F_BCWSJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_SHSL+"'>"+Math.round(spjson.F_SHSL*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_SHJE+"'>"+Math.round(spjson.F_SHJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_SHSJ+"'>"+Math.round(spjson.F_SHSJ*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_SHWSJE+"'>"+Math.round(spjson.F_SHWSJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_QMSL+"'>"+Math.round(spjson.F_QMSL*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_QMJE+"'>"+Math.round(spjson.F_QMJE*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_QMSJ+"'>"+Math.round(spjson.F_QMSJ*10)/10+"</td>"
                            rowhtml+="  <td class=\"am-text-middle am-hiden\" title='"+spjson.F_QMWSJE+"'>"+Math.round(spjson.F_QMWSJE*10)/10+"</td>"
                            rowhtml+="</tr>";
                        }
                        $('#sptable').html(rowhtml);
                        if ($("#xzsj").is(':checked') == true){
                            $(".am-hiden").show();
                        }else if ($("#xzsj").is(':checked') == false){
                            $(".am-hiden").hide();
                        }
                        pagebar(pageIndex,pageSize,res.total,"pagebar");
                    }
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

    function closeQyxzdiv(){
        $('#SPFLdiv').modal('close');
    }




</script>
</body>
</html>
