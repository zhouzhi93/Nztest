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
    String lxbm=(String)session.getAttribute("f_lxbm");
    String zdrmc=(String)session.getAttribute("f_zymc");
    String f_qyck=(String)session.getAttribute("f_qyck");
%>
<%--<!DOCTYPE html>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-调拨单</title>
    <meta name="description" content="云平台客户端V1-调拨单">
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
    <%--<script src="https://cdn.webrtc-experiment.com/MediaStreamRecorder.js"></script>
    <script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>--%>
    <script src="../../recorder/MediaStreamRecorder.js"></script>
    <script src="../../recorder/adapter-latest.js"></script>
    <script src="../../recorder/recorder-core.js"></script> <!--已包含recorder-core和mp3格式支持-->
    <script src="../../recorder/mp3.js"></script> <!--已包含recorder-core和mp3格式支持-->
    <script src="../../recorder/mp3-engine.js"></script> <!--已包含recorder-core和mp3格式支持-->
    <script src="../../recorder/ztest-codemirror.min.5.48.4.js"></script>
    <script src="../../recorder/ztest-jquery.min-1.9.1.js"></script>
    <script src="../../recorder/ztest-rsa.js"></script>
    <script src="../../recorder/waveview.js"></script>
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
        .am-form-group {
            margin-bottom: 1.1rem;
        }
    </style>
</head>
<body>
<div class="am-g">
    <div class="am-u-sm-12 am-u-md-12" id="xsdiv">
        <div class="header">
            <div class="am-g">
                <h1>调&nbsp;&nbsp;拨&nbsp;&nbsp;单</h1>
            </div>
        </div>
        <div class="am-container" style="margin-top: 10px;">
            <div class="am-u-sm-6 am-u-md-6 am-text-left">
                调出部门：<select data-am-selected="{btnWidth: '60%', btnSize: 'sm'}" id="f_dcbmbm">
                </select>
            </div>
            <div class="am-u-sm-6 am-u-md-6 am-text-right">
                调入部门：<select data-am-selected="{btnWidth: '60%', btnSize: 'sm'}" id="f_drbmbm">
                </select>
            </div>
        </div>
        <div class="am-container" style="margin-top: 10px;">
            <div class="am-u-sm-6 am-u-md-6 am-text-left">
                <div id="ckmcDiv">

                </div>
            </div>
            <div class="am-u-sm-6 am-u-md-6 am-text-right">
                调拨类型：<select data-am-selected="{btnWidth: '60%', btnSize: 'sm'}" id="f_dblx">
                <option value="1"selected>成本价</option>
                <option value="2" >售价</option>
                <option value="3">自定义价格</option>
            </select>
            </div>
        </div>

        <div class="am-container" style="margin-top: 10px;">
            <div class="am-u-sm-6 am-u-md-6 am-text-left">
                <div id="drbmckDiv">

                </div>
            </div>
            <div class="am-u-sm-6 am-u-md-6">

            </div>
        </div>

        <div class="am-container am-scrollable-vertical" style="margin-top: 10px;">
            <table class="am-table am-table-bordered am-table-centered" >
                <thead id="sptableTitle">

                </thead>
                <tbody id="sptable">

                </tbody>
            </table>
        </div>
        <div class="am-container">
            <div class="am-u-sm-6 am-u-md-6"><div class="am-cf">
                共<span onclick="resum_hjje()" id="hjpz" style="color: #E72A33;">0</span>种商品
            </div></div>
            <div class="am-u-sm-6 am-u-md-6"><div class="am-fr">
                合计：<span id="hjje" style="color: #E72A33;">0.00</span> 元
            </div></div>
            <div class="am-fr am-text-right am-hide" style="margin-top: 10px;margin-right: 10px;">
                优惠金额：<input id="yhje" class="am-radius am-form-field am-input-sm" min="0" style="width: 120px;display:initial;" type="number" placeholder="">元
                <br>
                结算总额：<span id="jsje" style="color: #E72A33;">0.00</span> 元
            </div>
        </div>

        <hr/>
        <div class="am-container">
            <div class="am-fr">
                <%--<input style="vertical-align:middle;" id="f_sfdyxp" type="checkbox"/><span style="font-size: 13px;vertical-align:middle;">打印</span>--%>
                <button type="button" onclick="savebill()" class="am-btn am-btn-danger  am-radius am-btn-sm">调拨</button>&nbsp;&nbsp;
                <%--<button type="button" onclick="getwxSpxx(this)" class="am-btn am-btn-primary am-btn-sm am-radius">调入</button>--%>
            </div>
        </div>
    </div>
    <!--商品档案选择-->
    <div style="padding-top: 20px;display:none;height: 600px;" id="spdadiv" class="am-scrollable-vertical">
        <%--<button type="button" onclick="showAddsp()" class="am-btn am-btn-default am-radius am-btn-sm">新增商品</button>--%>
        <div class="am-fr">
            您已经选择了<span id="sphj" style="color: #E72A33;">0</span>种商品<input class="am-radius am-form-field am-input-sm" id="spoption" style="width: 240px;display:initial;" type="text" placeholder="">
            <button type="button" onclick="searchSpda()" class="am-btn am-btn-default am-radius am-btn-sm">搜索</button>
        </div>
        <div class="am-g" style="margin-top: 20px;">
            <ul data-am-widget="gallery" class="am-gallery am-avg-sm-3
  am-avg-md-3 am-avg-lg-4 am-gallery-default" data-am-gallery="{ pureview: false }">
            </ul>
        </div>
    </div>
</div>
<!-- 按钮触发器， 需要指定 target -->
<i class="am-icon-chevron-left" style="position: fixed;right: 0px;top: 50%;" id="morespda" onclick="spdadivshow()"></i>

<!--选择商品-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseSpdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">请选择商品
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div style="margin-top: 10px;height: 360px;" class="am-container  am-scrollable-vertical">
                <table class="am-table am-table-bordered am-table-centered"  >
                    <thead>
                    <tr>
                        <th class="am-text-middle">商品条码</th>
                        <th class="am-text-middle">商品名称</th>
                        <th class="am-text-middle">规格型号</th>
                        <th class="am-text-middle">调拨单价</th>
                    </tr>
                    </thead>
                    <tbody id="chooseSptable">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!--购买人详情div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="queryKhdiv">
    <div class="am-modal-dialog">
        <div>
            <div class="am-modal-hd">购买人信息
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-u-sm-4">
                <span id="q_gmrxm"></span>
            </div>
            <div class="am-u-sm-4">
                <span id="q_gmrsfzh"></span>
            </div>
            <hr data-am-widget="divider" style="" class="am-divider am-divider-default" />
        </div>
        <div id="queryztxx">
            <div class="am-modal-hd" style="padding-top: 0px;">主体信息</div>
            <hr data-am-widget="divider" style="" class="am-divider am-divider-default" />
        </div>
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
<div style="display: none;" id="printDiv">
    <style>
        .td_rht	{text-align:right;}
        #td_t1{font-size:14px;font-weight:bold;text-align:center;}
        #printMain div,#printMain td,#printMain th,#printMain span.font{font-size:12px;text-align:left;margin:0;padding:0;}
        #printMain table{border-collapse:collapse;jerry:expression(cellSpacing="0");border:0;margin:0px;padding:0px;width:100%;}
        #printMain td{padding-left:2px;}
        #page_div	{width:180px;border-width:0px;margin:0px auto;}
        #td_t1{font-size:14px;font-weight:bold;text-align:center;}
        #printMain th{font-size:12px}
        #printMain td{font-size:12px}
        #td_t2{font-size:14px;font-family:楷体;text-align:center;font-weight:bold;}
        #infol_div{width:100%;border:0px solid red;margin-top:15px;}
        #datatb{width:100%; margin:0;padding:0;border-collapse:collapse;border:2px solid gray;border-width:2px 0;table-layout:fixed;}
        #printMain tr{height:20px;}

        #datatb td,#datatb th{border:0px solid gray;text-align:right;font-size:12.5px;}
        #datatb th{text-align:center;}
        #printMain div span{line-height:18px;}
        #hjl td{border-width:1px 0;border-style:dotted;border-color:gray;height:20px;}
    </style>
    <div id="page_div" style="font-size:12px;text-align:left;margin:0;padding:0;">	<%
        int ps=1;
        int cp=1;
    %>
    </div>
    <div id="printMain">
        <div id="td_t1">调拨单</div>
        <div>
            <table style="float:left;display:inline" class="tablePrt">
                <tr><td style='text-align:left'>网点:<text id="prt_wd"></text></td></tr>
                <tr><td style='text-align:left'>日期:<%=str%></td></tr>
                <tr><td style='text-align:left'>单据号:<text id="prt_djh"></text></td></tr>
                <tr><td style='text-align:left'>顾客:<text id="prt_kh"></text></td></tr>
                <tr><td style='text-align:left'>收银员:<%=zdrmc%></td></tr>
            </table>
            <table id='datatb' style="display:inline;width:100%;">
                <tr><th style='width:26%'>名称</th>
                    <th style='width:24%'>数量</th>
                    <th style='width:24%'>单价</th>
                    <th style='width:26%'>金额</th></tr>
                <tbody id="prt_sp">

                </tbody>

                <tr id='hjl'><td colspan=4><span style='font-weight:bold;'>小计:</span>
                    <text id="prt_xjje"></text>&nbsp;
                    <span style='font-weight:bold;'>应收:</span><text id="prt_ysje"></text></td></tr>
                <tr><th colspan=4>交易时刻:<text id="prt_jysk"></text></th></tr>
                <tr><td colspan=4 style='text-align:left'><span style='font-weight:bold;'>实收:</span><text id="prt_ssje"></text></td></tr>
                <tr><td colspan=4 style='text-align:left'><span style='font-weight:bold;'>应收:</span><text id="prt_xj"></text></td></tr>
                <tr><td colspan=4 style='text-align:left'><span style='font-weight:bold;'>找零:</span><text id="prt_zl"></text></td></tr>
                <tr><td colspan=4 style='text-align:left'><span style='font-weight:bold;'>大写:</span><text id="prt_dxje"></text></td></tr>
                <tr><th colspan=4 >请妥善保管此票据</th></tr>
            </table>
        </div>
        <div>
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
<script src="/assets/js/LodopFuncs.js"></script>
<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
    <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
</object>
<script type="text/javascript">
    var redioid = null;
    var rediobolb = null;
    var khxxobj = null;
    var ckxxJson = null;
    var qyck = <%=f_qyck%>;

    $(function(){
        loadCkcs();

        var spdalist ='${spdalist}';
        if(spdalist.length==0){

        }else {
            var $spul=$('#spdadiv ul');//商品档案展示ul
            spdalist=JSON.parse(spdalist);
            var spdahtml="";
            for(var i=0;i<spdalist.length;i++){
                var spda= spdalist[i];
                if(spdahtml==""){
                    spdahtml="<li>\n" +
                        "                        <div class=\"am-gallery-item\">\n" +
                        "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\" style='height: 150px;'/>\n" +
                        "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                        "                            <div class=\"am-gallery-desc\">进价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_ZHJJ+"元</span></div>\n" +
                        "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                        "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                        "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\",\"zhjj\": \""+spda.F_ZHJJ+"\"}</span>\n" +
                        "                        </div>\n" +
                        "                    </li>"
                }else{
                    spdahtml+="<li>\n" +
                        "                        <div class=\"am-gallery-item\">\n" +
                        "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\" style='height: 150px;'/>\n" +
                        "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                        "                            <div class=\"am-gallery-desc\">进价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_ZHJJ+"元</span></div>\n" +
                        "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                        "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                        "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\",\"zhjj\": \""+spda.F_ZHJJ+"\"}</span>\n" +
                        "                        </div>\n" +
                        "                    </li>"
                }
            }
            $spul.append(spdahtml);
        }
        var dcsxbmList='${sxbmList}';
        var drsxbmList = '${drsxbmList}';
        if(dcsxbmList.length==0){
            console.log("暂无分管部门信息");
        }else{
            var bmList=JSON.parse(dcsxbmList);
            var bmHtmle="";
            for(var i=0;i<bmList.length;i++){
                bmHtmle+="<option value=\""+bmList[i].F_BMBM+"\">"+bmList[i].F_BMMC+"</option>";
            }
            $("#f_dcbmbm").html(bmHtmle);
        }
        if(drsxbmList.length==0){
            console.log("暂无分管部门信息");
        }else{
            var bmList=JSON.parse(drsxbmList);
            var bmHtmle="";
            for(var i=0;i<bmList.length;i++){
                bmHtmle+="<option value=\""+bmList[i].F_BMBM+"\">"+bmList[i].F_BMMC+"</option>";
            }
            $("#f_drbmbm").html(bmHtmle);
        }
        var lxbm= '<%=lxbm%>';
        if(lxbm=="1"){
            $('#smmc').text("农药登记号：");
            $('#sptmScan').attr('placeholder',"扫描二维码/输入登记号");
        };
        var show= localStorage.getItem("showSpdiv");//用户最后一次选择展示还是不展示商品选择
        if(show=="true"){
            $("#xsdiv").removeClass("am-u-sm-12 am-u-md-12").addClass("am-u-sm-6 am-u-md-6");
            $("#spdadiv").addClass("am-u-sm-6 am-u-md-6");
            $("#spdadiv").show();
            $("#morespda").removeClass("am-icon-chevron-left").addClass("am-icon-chevron-right");
        }
        $('.am-gallery-item').click(function () {
            spimgclick(this);
        });
        $('#sptmScan').keypress(function (e) {
            if (e.keyCode == 13) {
                var tm=$('#sptmScan').val();
                var dcbmbm = $('#f_dcbmbm').val();
                var dblx = $('#f_dblx').val();
                $.ajax({
                    url: "/sales/GetSpda_PD",
                    type: "post",
                    async: false,
                    data: {url:tm, timeer: new Date() },
                    success: function (data) {
                        var spJarr=JSON.parse(data);
                        if(spJarr.length<=0){return;}
                        if(spJarr.length==1){
                            var spjson=spJarr[0];
                            //var flag=checksp(spjson.F_SPTM);
                            var flag=false;
                            var spcount=0;
                            if(!flag){//如果不包含此商品
                                var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                                    +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.F_SPMC+"</td>"
                                    +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                    +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.F_JLDW+"</td>";

                                        if(dblx == 1){
                                            $.ajax({
                                                url: "/allot/GetSpkccbdj",
                                                type: "post",
                                                async: false,
                                                data: { f_xssl: 1, f_sptm: spjson.F_SPTM,f_dcbmbm:dcbmbm, timeer: new Date() },
                                                success: function (data) {
                                                    rowhtml+="<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\""+data+"\" onblur=\"resum_row(this)\" /></td>";
                                                    rowhtml+="<td class=\"am-text-middle\">"+data+"</td>";
                                                },
                                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                                    alert(errorThrown + "||" + textStatus);
                                                    $subbtn.button('reset');
                                                }
                                            });

                                        }else if(dblx == 2){
                                            rowhtml+="<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\""+spjson.F_XSDJ+"\" onblur=\"resum_row(this)\" /></td>";
                                            rowhtml+="<td class=\"am-text-middle\">"+spjson.F_XSDJ+"</td>";
                                        }else if(dblx == 3){
                                            rowhtml+="<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\""+spjson.F_ZHJJ+"\" onblur=\"resum_row(this)\" /></td>";
                                            rowhtml+="<td class=\"am-text-middle\">"+spjson.F_ZHJJ+"</td>";
                                        }
                                rowhtml+="<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>";
                                rowhtml+="</tr>";
                                $('#sptable').prepend(rowhtml);
                                if($("#tishitr")!=undefined) {//删除请选择 提示行
                                    $("#tishitr").remove();
                                };
                                spcount=$("#sptable").find('tr').length;
                                $(this).addClass("am-gallery-item-boder");
                                var hjje=resum_hjje();
                                $('#hjje').text(hjje);
                                $('#jsje').text(hjje);
                                $('#ssje').val(hjje);
                                $('#hjpz').text(spcount);
                                $('#sphj').text(spcount);
                            }
                            recountSppz();
                        }else
                        {
                            var html="";
                            for(var i=0;i<spJarr.length;i++){
                                var row=spJarr[i];
                                html+="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">"+row.F_SPTM+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+row.F_SPMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+row.F_GGXH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+row.F_XSDJ+"</td>\n" +
                                    "                        </tr>"
                            }
                            $('#chooseSptable').html(html);
                            $('#chooseSptable tr').click(function () {
                                var rowNum=$(this).index();
                                var $table=$(this).parent();
                                var sptm=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                                var spmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(1)').text();
                                var ggxh=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(2)').text();
                                var xsdj=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(3)').text();
                                var rowhtml="<tr sptm='"+sptm+"'>"
                                    +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spmc+"</td>"
                                    +"<td class=\"am-text-middle\">"+ggxh+"</td>"
                                    +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+ggxh+"</td>"
                                    +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\""+xsdj+"\" onblur=\"resum_row(this)\" /></td>"
                                    +"<td class=\"am-text-middle\">"+xsdj+"</td>"
                                    +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                    +"</tr>";
                                $('#sptable').prepend(rowhtml);
                                if($("#tishitr")!=undefined) {//删除请选择 提示行
                                    $("#tishitr").remove();
                                };
                                spcount=$("#sptable").find('tr').length;
                                $(this).addClass("am-gallery-item-boder");
                                var hjje=resum_hjje();
                                $('#hjje').text(hjje);
                                $('#jsje').text(hjje);
                                $('#ssje').val(hjje);
                                $('#hjpz').text(spcount);
                                $('#sphj').text(spcount);
                                $('#chooseSpdiv').modal('close');
                            });
                            $('#chooseSpdiv').modal({
                                closeViaDimmer: false,
                                width:680,
                                height:420
                            });
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
        });
        $('#yhje').keyup(function () {
            var yhje=$(this).val();
            var hjje=$('#hjje').text();
            var res=(hjje-yhje).toFixed(2);
            var jsje=res>0?res:'0.00';
            $('#jsje').text(jsje);
            $('#ssje').val(jsje);
        });
        if("<%=lxbm%>" == '1'){
            $('.ypdxs').show();
            $('.ypdbxs').hide();
        }
        $('#ssje').blur(function () {
            var ssje=$(this).val();
            var jsje= $('#jsje').text();
            var res=(ssje-jsje).toFixed(2);
            var zlje=res>0?res:'0.00';
            ssje=eval(ssje)>eval(jsje)?ssje:jsje;
            $(this).val(ssje);
            $('#zlje').text(zlje);
        });
        //显示选择客户
        $('#khxx').click(function () {
            var sxbmList='${sxbmList}';
            var bmList=JSON.parse(sxbmList);
            for(var i=0;i<bmList.length;i++) {
                if (bmList[i].F_YJMM != '1') {
                    //显示选择客户
                    /*$('#khxx').click(function () {
                        $('#chooseKhdiv').modal({
                            closeViaDimmer: false,
                            width:680,
                            height:500
                        });
                        loadKhxx('',null);
                        $('#chooseKhdiv').modal('open');
                    });*/
                    $('#khoption').val("");
                    var khthhtml="<tr>\n" +
                        "                            <th class=\"am-text-middle\">客户名称</th>\n" +
                        "                            <th class=\"am-text-middle\">联系电话</th>\n";
                    khthhtml += "                        </tr>";
                    $('#khth').html(khthhtml);
                    $('#chooseKhdiv').modal({
                        closeViaDimmer: false,
                        width:680,
                        height:500
                    });
                    loadKhxx('',null,null);
                    $('#chooseKhdiv').modal('open');
                    break;
                }
            }
        });
        //显示新增客户
        $('#addkh').click(function () {
            $('#newKhdiv').modal({
                closeViaDimmer: false,
                width:580,
                height:400
            });
            $('#newKhdiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#newKhdiv').css("z-index","1119");
        });
        //显示客户详情
        $('#querykhxx').click(function () {

            if(khxxobj != null){
                $('#q_gmrxm').html(khxxobj.name);
                $('#q_gmrsfzh').html(khxxobj.identity);
                var queryhtml = "";
                for(var i = 0 ; i<khxxobj.detailInfoList.length ; i++){
                    var datailInfoList = khxxobj.detailInfoList[i];
                    var plotInfoList = datailInfoList.plotInfoList;
                    queryhtml += "<div class=\"am-modal-hd\" style=\"padding-top: 0px;\">主体信息</div>\n"+
                        "                <div>\n" +
                        "                    <div class=\"am-u-sm-4\">\n" +
                        "                        <span>"+datailInfoList.entName+"</span>\n" +
                        "                    </div>\n" +
                        "                    <div class=\"am-u-sm-4\">\n" +
                        "                        <span>"+datailInfoList.entCode+"</span>\n" +
                        "                    </div>\n" +
                        "                    <div class=\"am-u-sm-end\"></div>\n" +
                        "                </div>\n" +
                        "                <div>\n" +
                        "                    <div class=\"am-u-sm-4\">\n" +
                        "                        <span>"+datailInfoList.entLeader+"</span>\n" +
                        "                    </div>\n" +
                        "                    <div class=\"am-u-sm-4\">\n" +
                        "                        <span>"+datailInfoList.entLeaderCid+"</span>\n" +
                        "                    </div>\n" +
                        "                    <div class=\"am-u-sm-4\">\n" +
                        "                        <span>"+datailInfoList.entLeaderTel+"</span>\n" +
                        "                    </div>\n" +
                        "                </div>\n";
                    for(var j = 0 ; j<plotInfoList.length ; j++){
                        queryhtml +="                <div>\n" +
                            "                    <div class=\"am-u-sm-4\">\n" +
                            "                        <span>"+plotInfoList[j].sclass+"</span>\n" +
                            "                    </div>\n" +
                            "                    <div class=\"am-u-sm-4\">\n" +
                            "                        <span>"+plotInfoList[j].bookArea+"</span>\n" +
                            "                    </div>\n" +
                            "                    <div class=\"am-u-sm-end\"></div>\n" +
                            "                </div>\n";

                    }
                    queryhtml += "                <hr data-am-widget=\"divider\" class=\"am-divider am-divider-default\" />";
                }
                $('#queryztxx').html(queryhtml);
            }

            $('#queryKhdiv').modal({
                closeViaDimmer: false,
                width:880,
                height:400
            });
            $('#queryKhdiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#queryKhdiv').css("z-index","1119");
        });
        //关闭还原遮罩蒙板z-index
        $('#newKhdiv').on('closed.modal.amui', function() {
            $('.am-dimmer').css("z-index","1100");
        });
        //关闭还原遮罩蒙板z-index
        $('#newSpdiv').on('closed.modal.amui', function() {
            $('.am-dimmer').css("z-index","1100");
        });
        //关闭还原遮罩蒙板z-index
        $('#queryKhdiv').on('closed.modal.amui', function() {
            $('.am-dimmer').css("z-index","1100");
        });
        //增加客户提交
        $('#addkhform').validator({
            H5validation: false,
            submit: function () {
                var formValidity = this.isFormValid();
                if (formValidity) {
                    try {
                        var $subbtn = $("#addkhbtn");
                        $subbtn.button('loading');
                        var f_khmc = $("#f_khmc").val();
                        var f_sjhm = $("#f_sjhm").val();
                        var f_sfzh = $("#f_sfzh").val();
                        var f_djbz = $("#f_djbz").val();
                        var f_zt = $("#f_zt").val();
                        var f_xxdz = "";
                        setTimeout(function () {
                            $.ajax({
                                url: "/sales/AddKhda",
                                type: "post",
                                async: false,
                                data: { f_khmc: f_khmc, f_sjhm: f_sjhm,f_sfzh:f_sfzh,f_bzxx: f_djbz, f_xxdz: f_xxdz, timeer: new Date() },
                                success: function (data, textStatus) {
                                    if(data.toLowerCase()=="ok"){
                                        alertMsg("客户添加成功");
                                        clearAdd();
                                    }else
                                    {
                                        alertMsg(data);
                                    }
                                    $subbtn.button('reset');
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
                                    $subbtn.button('reset');
                                }
                            });
                        }, 10);
                    }
                    catch (e) {
                        alertMsg(e.name);
                    }
                } else {
                    // 验证失败的逻辑
                }
                //阻止原生form提交
                return false;
            }
        });

        $('#chooseCameradiv').on('close.modal.amui', function(){
            console.log('第一个演示弹窗打开了');
            mediaRecorder.stop();
        });


        var ckbmHtml = "";
        if (ckxxJson != null && ckxxJson != "" && ckxxJson != "[]"){
            ckbmHtml += "<option value='' selected>选择仓库</option>";
            for (var i = 0;i < ckxxJson.length; i++){
                if (ckxxJson[i].F_MJ == "0"){
                    ckbmHtml += "<option disabled value='"+ckxxJson[i].F_CKBM+"'>"+ckxxJson[i].F_CKMC+"</option>";
                }else if (ckxxJson[i].F_MJ == "1"){
                    ckbmHtml += "<option value='"+ckxxJson[i].F_CKBM+"'>"+ckxxJson[i].F_CKMC+"</option>";
                }
            }
        }

        $("#f_ckbm").change(function (){
            if ($('#sptable').find('tr').find('td').length <= 1){
                //如果商品数量小于1，弹窗
                alertMsg("请先选择商品！");
                $("#f_ckbm").html(ckbmHtml);
                return;
            }else{
                var f_ckbm = $("#f_ckbm").val();
                if(f_ckbm != null && f_ckbm != ""){
                    //把下面的下拉框锁定
                    $(".ddckbm").trigger('changed.selected.amui');//手动渲染
                    $(".ddckbm").val(f_ckbm);
                    $(".ddckbm").attr("disabled","disabled");
                }else {
                    //下方下拉框解锁
                    $(".ddckbm").trigger('changed.selected.amui');//手动渲染
                    $(".ddckbm").val("");
                    $(".ddckbm").removeAttr("disabled");
                }
            }
        });

        $("#f_drckbm").change(function (){
            if ($('#sptable').find('tr').find('td').length <= 1){
                //如果商品数量小于1，弹窗
                alertMsg("请先选择商品！");
                $("#f_drckbm").html(ckbmHtml);
                return;
            }else{
                var f_drckbm = $("#f_drckbm").val();
                if(f_drckbm != null && f_drckbm != ""){
                    //把下面的下拉框锁定
                    $(".drckbm").trigger('changed.selected.amui');//手动渲染
                    $(".drckbm").val(f_drckbm);
                    $(".drckbm").attr("disabled","disabled");
                }else {
                    //下方下拉框解锁
                    $(".drckbm").trigger('changed.selected.amui');//手动渲染
                    $(".drckbm").val("");
                    $(".drckbm").removeAttr("disabled");
                }
            }
        });
    });


    function closeNewspdiv(){
        $('#newSpdiv').modal('close');
    }
    function closeQyxzdiv(){
        $('#SPFLdiv').modal('close');
    }
    //打印
    function printBill(){
        try {
            var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));
            var html=document.getElementById('printDiv').innerHTML;
            LODOP.ADD_PRINT_HTM(0, 0, 180, 2000, html);
            LODOP.PREVIEW();
            //LODOP.PRINTA();//
            //LODOP.PRINT();
        } catch(e){
            //window.print();
        }
    }
    //获取微信扫描商品
    function getwxSpxx(event){
        $.ajax({
            url: "/sales/GetWxsp",
            type: "post",
            async: false,
            data: {f_djlx:0, timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var html="";
                    for(var i=0;i<dataJson.length;i++){
                        var spjson=dataJson[i];
                        if (qyck == 0){
                            var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                                +"<td class=\"am-text-middle am-td-spmc\">"+spjson.F_SPMC+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.F_JLDW+"</td>"
                                +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\""+spjson.F_XSDJ+"\" onblur=\"resum_row(this)\" /></td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_XSDJ+"</td>"
                                +"<td class=\"am-hide\">"+spjson.F_PCH+"</td>"
                                +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                +"</tr>";
                            $('#sptable').prepend(rowhtml);
                        }else if (qyck == 1){
                            var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                                +"<td class=\"am-text-middle am-td-spmc\">"+spjson.F_SPMC+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.F_JLDW+"</td>"
                                +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\""+spjson.F_XSDJ+"\" onblur=\"resum_row(this)\" /></td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_XSDJ+"</td>"
                                +"<td class=\"am-hide\">"+spjson.F_PCH+"</td>"
                                +"<td class=\"am-text-middle\" style='padding: 0;'>"
                                +"  <select class='ddckbm' data-am-selected=\"{btnWidth: '100%',btnSize: 'sm',maxHeight:'100px',}\" style='width: 100%;height:43px;border: 0px;text-align: center;'>"
                                +"  </select>"
                                +"</td>"
                                +"<td class=\"am-text-middle\" style='padding: 0;'>"
                                +"  <select class='drckbm' data-am-selected=\"{btnWidth: '100%',btnSize: 'sm',maxHeight:'100px',}\" style='width: 100%;height:43px;border: 0px;text-align: center;'>"
                                +"  </select>"
                                +"</td>"
                                +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                +"</tr>";
                            $('#sptable').prepend(rowhtml);

                            var ckbmHtml = "";
                            if (ckxxJson != null && ckxxJson != "" && ckxxJson != "[]"){
                                ckbmHtml += "<option value='' selected>选择仓库</option>";
                                for (var i = 0;i < ckxxJson.length; i++){
                                    if (ckxxJson[i].F_MJ == "0"){
                                        ckbmHtml += "<option disabled value='"+ckxxJson[i].F_CKBM+"'>"+ckxxJson[i].F_CKMC+"</option>";
                                    }else if (ckxxJson[i].F_MJ == "1"){
                                        ckbmHtml += "<option value='"+ckxxJson[i].F_CKBM+"'>"+ckxxJson[i].F_CKMC+"</option>";
                                    }
                                }
                            }
                            $(".ddckbm").html(ckbmHtml);
                            $(".drckbm").html(ckbmHtml);
                        }

                        if($("#tishitr")!=undefined) {//删除请选择 提示行
                            $("#tishitr").remove();
                        };
                    }
                    recountSppz();
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

    function savebill(){
        var spcount=$('#hjpz').text();
        if(spcount<=0){
            alertMsg('请选择商品后再提交');
            return;
        }

        var f_dcckbm = "";
        var f_drckbm = "";
        if (qyck == 1){
            var dccksl = $("#sptable").find("tr").find("select").eq(0);
            for (var i = 0;i < dccksl.length; i++){
                f_dcckbm = dccksl.eq(i).val();
                if (f_dcckbm == null || f_dcckbm == "" || f_dcckbm == undefined){
                    alertMsg('请选择仓库!');
                    return;
                }
            }
            var drcksl = $("#sptable").find("tr").find("select").eq(1);
            for (var i = 0;i < drcksl.length; i++){
                f_drckbm = drcksl.eq(i).val();
                if (f_drckbm == null || f_drckbm == "" || f_drckbm == undefined){
                    alertMsg('请选择仓库!');
                    return;
                }
            }
        }

        var $table=$('#sptable');
        var spxx= "";
        var prtspHmtl="";
        $table.find('tr').each(function () {
            var sptm=$(this).attr('sptm');
            var spmc=$(this).find('td:eq(0)').text();
            var sphjje=$(this).find('td:eq(4)').text();
            var xssl=$(this).find('td:eq(2)').children("input:first-child").val();
            var spdj=$(this).find('td:eq(3)').children("input:first-child").val();
            var dcckbm=$(this).find('td:eq(5)').children("select:first-child").val();
            var drckbm=$(this).find('td:eq(6)').children("select:first-child").val();
            var sp="{\"sptm\":\""+sptm+"\",\"spdj\":\""+spdj+"\",\"xssl\":\""+xssl+"\",\"dcckbm\":\""+dcckbm+"\",\"drckbm\":\""+drckbm+"\"}";
            if(spxx==""){
                spxx="["+sp;
            }else{
                spxx= spxx+","+sp;
            }
            prtspHmtl+="<tr><td colspan=4 style='text-align:left'>"+spmc+"</td></tr>\n" +
                "                    <tr><td>&nbsp;</td>\n" +
                "                        <td>"+xssl+"</td>\n" +
                "                        <td>"+spdj+"</td>\n" +
                "                        <td>"+sphjje+"</td>\n" +
                "                    </tr>"
        })
        var spxx =spxx+"]";
        var yhje=$('#yhje').val();
        var jsje=$('#jsje').text();
        var f_dcbmbm=$('#f_dcbmbm').val();
        var f_drbmbm=$('#f_drbmbm').val();
        var dblx = $('#f_dblx').val();

        $.ajax({
            url: "/allot/SavaBill",
            type: "post",
            async: false,
            data: {f_dcbmbm:f_dcbmbm,f_drbmbm:f_drbmbm,yhje:yhje,jsje:jsje,spxx:spxx,dblx:dblx,timeer: new Date() },
            success: function (data) {
                var rows=data.split("|");
                if(rows[0]=="ok"){
                    alertMsg('调拨成功！')
                    clearpage();
                    var filename = $('#f_dcbmbm').text()+"_"+rows[1];
                }
                else {
                    alertMsg(data)
                }
                rediobolb = null;
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
                //$("#savaBtn").button('reset');
            }
        });

    }
    Date.prototype.Format = function (fmt) { // author: meizz
        var o = {
            "M+": this.getMonth() + 1, // 月份
            "d+": this.getDate(), // 日
            "h+": this.getHours(), // 小时
            "m+": this.getMinutes(), // 分
            "s+": this.getSeconds(), // 秒
            "q+": Math.floor((this.getMonth() + 3) / 3), // 季度
            "S": this.getMilliseconds() // 毫秒
        };
        if (/(y+)/.test(fmt))
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
    //金额转中文大写
    function toUper(v){
        v+="";
        var s=v.length;
        var j=v.indexOf(".");
        if(j==-1){v+=".00";j=v.indexOf(".");s+=3;}
        var c="";
        var s_=new Array("毫","厘","分","角","元","拾","佰","仟","万","拾","佰","仟","亿","拾","佰","仟","兆","拾","佰","仟","京","拾","佰","仟");
        var n_=new Array("零","壹","贰","叁","肆","伍","陆","柒","捌","玖");
        var r="",d=null,w=false;;
        for(var i=0;i<s;i++){
            if(j-i+4<0)break;//只能到毫
            c=v.substring(i,i+1);
            if(".".indexOf(c)!=-1)continue;
            else if("-".indexOf(c)!=-1)r+="负";
            else {
                d=s_[j-i+(j<i?4:3)];
                w="万亿兆京".indexOf(d)!=-1;
                if(c=="0"&&(w||r.substring(r.length-1)=="零"))r+="";
                else r+=n_[c];
                if(c!="0"||w)r+=d;
            }
        }
        while((j=r.indexOf("零分"))!=-1)r=r.substring(0,j)+r.substring(j+1);
        while((j=r.indexOf("零角"))!=-1)r=r.substring(0,j)+r.substring(j+1);
        while((j=r.indexOf("零元"))!=-1)r=r.substring(0,j)+r.substring(j+1);
        while((j=r.indexOf("零拾"))!=-1)r=r.substring(0,j)+r.substring(j+1);
        while((j=r.indexOf("零佰"))!=-1)r=r.substring(0,j)+r.substring(j+1);
        while((j=r.indexOf("零仟"))!=-1)r=r.substring(0,j)+r.substring(j+1);
        while((j=r.indexOf("零万"))!=-1)r=r.substring(0,j)+r.substring(j+1);
        while((j=r.indexOf("零亿"))!=-1)r=r.substring(0,j)+r.substring(j+1);
        while((j=r.indexOf("零兆"))!=-1)r=r.substring(0,j)+r.substring(j+1);
        while((j=r.indexOf("零京"))!=-1)r=r.substring(0,j)+r.substring(j+1);
        while((j=r.indexOf("京兆"))!=-1)r=r.substring(0,j+1)+n_[0]+r.substring(j+2);
        while((j=r.indexOf("兆亿"))!=-1)r=r.substring(0,j+1)+n_[0]+r.substring(j+2);
        while((j=r.indexOf("亿万"))!=-1)r=r.substring(0,j+1)+n_[0]+r.substring(j+2);
        if(r.substring(r.length-1)==n_[0])r=r.substring(0,r.length-1);
        if(r.indexOf("角")==-1&&r.indexOf("分")==-1){
            if(r.indexOf("元")==-1)r+="元";
            r+="整";
        }
        return r;
    }
    //商品档案选择界面 选择商品事件
    function spimgclick(evnet){
        var spjson=$(evnet).children("span:last-child").text();
        var dblx = $('#f_dblx').val();
        var dcbmbm = $('#f_dcbmbm').val();
        spjson=JSON.parse(spjson);
        //var flag=checksp(spjson.spbm);
        var flag=false;//要求第二次点选不删除已选择商品
        var spcount=0;
        if(!flag){//如果不包含此商品
            var cfflag = false;
            var $table=$('#sptable');
            $table.find('tr').each(function () {
                var sptm=$(this).attr('sptm');
                console.log(sptm);
                if(sptm == spjson.spbm){
                    alertMsg("该商品已选择不可重复选择！");
                    cfflag = true;
                    return;
                }
            });

            if(cfflag){
                return;
            }

            if (qyck == 0){
                var rowhtml="<tr sptm='"+spjson.spbm+"'>"
                    +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.spmc+"</td>"
                    +"<td class=\"am-text-middle\">"+spjson.ggxh+"</td>"
                    +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.jldw+"</td>";
                if(dblx == 1){
                    $.ajax({
                        url: "/allot/GetSpkccbdj",
                        type: "post",
                        async: false,
                        data: { f_xssl: 1, f_sptm: spjson.spbm,f_dcbmbm:dcbmbm, timeer: new Date() },
                        success: function (data) {
                            rowhtml+="<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\""+data+"\" onblur=\"resum_row(this)\" /></td>";
                            rowhtml+="<td class=\"am-text-middle\">"+data+"</td>";
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alert(errorThrown + "||" + textStatus);
                            $subbtn.button('reset');
                        }
                    });
                }else if(dblx == 2){
                    rowhtml+="<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input readonly type=\"text\" min=\"1\" value=\""+spjson.spdj+"\" onblur=\"resum_row(this)\" /></td>";
                    rowhtml+="<td class=\"am-text-middle\">"+spjson.spdj+"</td>";
                }else if(dblx == 3){
                    rowhtml+="<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\""+spjson.zhjj+"\" onblur=\"resum_row(this)\" /></td>";
                    rowhtml+="<td class=\"am-text-middle\">"+spjson.zhjj+"</td>";
                }
                rowhtml+="<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>";
                rowhtml+="</tr>";
                $('#sptable').prepend(rowhtml);
            }else if (qyck == 1){
                var rowhtml="<tr sptm='"+spjson.spbm+"'>"
                    +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.spmc+"</td>"
                    +"<td class=\"am-text-middle\">"+spjson.ggxh+"</td>"
                    +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.jldw+"</td>";
                if(dblx == 1){
                    $.ajax({
                        url: "/allot/GetSpkccbdj",
                        type: "post",
                        async: false,
                        data: { f_xssl: 1, f_sptm: spjson.spbm,f_dcbmbm:dcbmbm, timeer: new Date() },
                        success: function (data) {
                            rowhtml+="<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\""+data+"\" onblur=\"resum_row(this)\" /></td>";
                            rowhtml+="<td class=\"am-text-middle\">"+data+"</td>";
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alert(errorThrown + "||" + textStatus);
                            $subbtn.button('reset');
                        }
                    });
                }else if(dblx == 2){
                    rowhtml+="<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input readonly type=\"text\" min=\"1\" value=\""+spjson.spdj+"\" onblur=\"resum_row(this)\" /></td>";
                    rowhtml+="<td class=\"am-text-middle\">"+spjson.spdj+"</td>";
                }else if(dblx == 3){
                    rowhtml+="<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\""+spjson.zhjj+"\" onblur=\"resum_row(this)\" /></td>";
                    rowhtml+="<td class=\"am-text-middle\">"+spjson.zhjj+"</td>";
                }
                rowhtml+="  <td class=\"am-text-middle\" style='padding: 0;width: 17%;'>"
                +"              <select class='ddckbm' data-am-selected=\"{btnWidth: '100%',btnSize: 'sm',maxHeight:'100px',}\" style='width: 100%;height:43px;border: 0px;text-align: center;'>"
                +"              </select>"
                +"          </td>";
                rowhtml+="  <td class=\"am-text-middle\" style='padding: 0;width: 17%;'>"
                    +"              <select class='drckbm' data-am-selected=\"{btnWidth: '100%',btnSize: 'sm',maxHeight:'100px',}\" style='width: 100%;height:43px;border: 0px;text-align: center;'>"
                    +"              </select>"
                    +"          </td>";
                rowhtml+="<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>";
                rowhtml+="</tr>";
                $('#sptable').prepend(rowhtml);

                var ckbmHtml = "";
                if (ckxxJson != null && ckxxJson != "" && ckxxJson != "[]"){
                    ckbmHtml += "<option value='' selected>选择仓库</option>";
                    for (var i = 0;i < ckxxJson.length; i++){
                        if (ckxxJson[i].F_MJ == "0"){
                            ckbmHtml += "<option disabled value='"+ckxxJson[i].F_CKBM+"'>"+ckxxJson[i].F_CKMC+"</option>";
                        }else if (ckxxJson[i].F_MJ == "1"){
                            ckbmHtml += "<option value='"+ckxxJson[i].F_CKBM+"'>"+ckxxJson[i].F_CKMC+"</option>";
                        }
                    }
                }
                $(".ddckbm").html(ckbmHtml);
                $(".drckbm").html(ckbmHtml);
            }

            if($("#tishitr")!=undefined) {//删除请选择 提示行
                $("#tishitr").remove();
            };
            spcount=$("#sptable").find('tr').length;
            $(this).addClass("am-gallery-item-boder");
            var hjje=resum_hjje();
            $('#hjje').text(hjje);
            $('#jsje').text(hjje);
            $('#ssje').val(hjje);
            $('#hjpz').text(spcount);
            $('#sphj').text(spcount);
        }else {
            var rowcount=$("#sptable").find('tr').length;
            var tshtml= "";
            if(rowcount==0){
                if (qyck == 1){
                    tshtml+="<tr id=\"tishitr\">\n" +
                        "                        <td class=\"am-text-middle\" colspan=\"8\">选择需要调拨的商品</td>\n" +
                        "                    </tr>";
                }else {
                    tshtml+="<tr id=\"tishitr\">\n" +
                        "                        <td class=\"am-text-middle\" colspan=\"6\">选择需要调拨的商品</td>\n" +
                        "                    </tr>";
                }
                $('#sptable').prepend(tshtml);
                $('#hjpz').text(rowcount);
                $('#hjje').text("0.00");
                $('#jsje').text("0.00");
            }
            $(this).removeClass("am-gallery-item-boder");
            $('#hjje').text(resum_hjje());
            $('#hjpz').text(rowcount);
            $('#sphj').text(rowcount);
        }
    };
    function searchKh() {
        var khxx=$('#khoption').val();
        loadKhxx(khxx,null,null);
    };
    function searchSpda(){
        var spxx=$('#spoption').val();
        $.ajax({
            url: "/sales/GetSpda",
            type: "post",
            async: false,
            data: {spxx:spxx, timeer: new Date() },
            success: function (data) {
                var spdalist = JSON.parse(data);
                if(spdalist.length>0) {
                    var $spul=$('#spdadiv ul');//商品档案展示ul
                    var spdahtml="";
                    for(var i=0;i<spdalist.length;i++){
                        var spda=spdalist[i];
                        if(spdahtml==""){
                            spdahtml="<li>\n" +
                                "                        <div class=\"am-gallery-item\">\n" +
                                "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\" style='height: 150px;'/>\n" +
                                "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                                "                            <div class=\"am-gallery-desc\">进价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_ZHJJ+"元</span></div>\n" +
                                "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                                "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                                "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\",\"zhjj\": \""+spda.F_ZHJJ+"\"}</span>\n" +
                                "                        </div>\n" +
                                "                    </li>"
                        }else{
                            spdahtml+="<li>\n" +
                                "                        <div class=\"am-gallery-item\">\n" +
                                "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\" style='height: 150px;'/>\n" +
                                "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                                "                            <div class=\"am-gallery-desc\">进价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_ZHJJ+"元</span></div>\n" +
                                "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                                "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                                "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\",\"zhjj\": \""+spda.F_ZHJJ+"\"}</span>\n" +
                                "                        </div>\n" +
                                "                    </li>"
                        }
                    }
                    $spul.html(spdahtml);
                    $('#spdadiv .am-gallery-item').click(function () {
                        spimgclick(this);
                    });
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
    //清除界面值
    function clearpage(){
        $('#khxx').val('').removeAttr('sptm');
        var tshtml = "";
        if (qyck == 1){
            tshtml+="<tr id=\"tishitr\">\n" +
                "                        <td class=\"am-text-middle\" colspan=\"8\">选择需要调拨的商品</td>\n" +
                "                    </tr>";
        }else{
            tshtml+="<tr id=\"tishitr\">\n" +
                "                        <td class=\"am-text-middle\" colspan=\"6\">选择需要调拨的商品</td>\n" +
                "                    </tr>";
        }
        $('#sptable').html(tshtml);
        $('#hjpz').text('0');
        $('#hjje').text("0.00");
        $('#jsje').text("0.00");
        $('#hjje').text(resum_hjje());
        $('#hjpz').text('0');
        $('#f_djbz').val('');
        $('#sphj').text('0');
        $('#ssje').val("0.00");
        $('#zlje').text("0.00");
        $('#sptmScan').val("");

    };
    //清楚增加客户界面
    function clearAdd(){
        $("input[type=reset]").trigger("click");
//            $('#f_khmc').val('');
//            $('#f_sjhm').val('');
//            $('#f_sfzh').val('');
//            $('#f_qydz').val('');
//            $('#f_xxdz').val('');
//            $('#f_djbz').val('');
    }
    //加载客户
    function loadKhxx(khxx,identity,obj){
        var getData;
        var sxbmList='${sxbmList}';
        var bmList=JSON.parse(sxbmList);
        if(khxx.length == 18){
            for(var i=0;i<bmList.length;i++){
                if(bmList[i].F_BMBM == $("#f_dcbmbm").val()){
                    if(0 == bmList[i].F_JHGSBM){
                        $.ajax({type: "post", url: "<%=path%>/cardreader/identity",
                            data : {identity:khxx},
                            success: function (data) {
                                try {
                                    var obj=eval('(' + $.trim(data) + ')');
                                } catch(e) {
                                    alertMsg(data);
                                    //return false;
                                }
                                var flag = loadKhxx(obj.name,obj.identity,obj);
                                if(!flag){
                                    setTimeout(function () {
                                        $.ajax({
                                            url: "/initialvalues/AddKhda",
                                            type: "post",
                                            async: false,
                                            data: { f_khmc: obj.name, f_sjhm: obj.mobile,f_sfzh:obj.identity, f_qydz: "", f_xxdz: "", f_bzxx: "",cslx:1, timeer: new Date() },
                                            success: function (data) {
                                                if(data == "ok"){
                                                    var flag2 = loadKhxx(obj.name,obj.identity,obj);
                                                    $('#khoption').val(obj.identity);
                                                }else{
                                                    alertMsg(data);
                                                }
                                            },
                                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                                alert(errorThrown + "||" + textStatus);
                                                $subbtn.button('reset');
                                            }
                                        });
                                    }, 10);
                                }else{
                                    $('#khoption').val(obj.identity);
                                }
                            }
                        })
                    }
                }
            }
        }else{
            $.ajax({
                url: "/sales/GetKhda",
                type: "post",
                async: false,
                data: {khxx:khxx,identity:identity, timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    if(dataJson.length>0) {

                        //客户标题
                        if(obj != null && obj != ''){
                            var khthhtml = "";
                            khthhtml="<tr>\n" +
                                "                            <th class=\"am-text-middle\">客户名称</th>\n" +
                                "                            <th class=\"am-text-middle\">联系电话</th>\n";
                            for(var i = 0 ; i<obj.detailInfoList.length ; i++){
                                var plotInfoList = obj.detailInfoList[i].plotInfoList;
                                for(var j = 0 ; j<plotInfoList.length ; j++){
                                    khthhtml += "                            <th class=\"am-text-middle\">种养殖类型</th>\n";
                                }
                            }
                            khthhtml += "                        </tr>";
                            $('#khth').html(khthhtml);
                            khxxobj = obj;
                        }

                        //客户数据
                        var khdahtml="";
                        for(var i=0;i<dataJson.length;i++){
                            var khda=dataJson[i];
                            if(khdahtml==""){
                                khdahtml="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n" +
                                    /*"                            <td class=\"am-text-middle\">0.00</td>\n" +
                                    "                            <td class=\"am-text-middle\">0.00</td>\n" +*/
                                    "                            <td class=\"am-hide\">"+khda.F_CSBM+"</td>\n";
                                if(obj != null && obj != ''){
                                    for(var i = 0 ; i<obj.detailInfoList.length ; i++){
                                        var plotInfoList = obj.detailInfoList[i].plotInfoList;
                                        for(var j = 0 ; j<plotInfoList.length ; j++){
                                            khdahtml += "                            <td class=\"am-text-middle\">"+plotInfoList[j].sclass+"/"+plotInfoList[j].bookArea+"</td>\n";
                                        }
                                    }
                                }
                                khdahtml +=    "                        </tr>";
                            }else{
                                khdahtml+="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n" +
                                    /*"                            <td class=\"am-text-middle\">0.00</td>\n" +
                                    "                            <td class=\"am-text-middle\">0.00</td>\n" +*/
                                    "                            <td class=\"am-hide\">"+khda.F_CSBM+"</td>\n";
                                if(obj != null && obj != ''){
                                    for(var i = 0 ; i<obj.detailInfoList.length ; i++){
                                        var plotInfoList = obj.detailInfoList[i].plotInfoList;
                                        for(var j = 0 ; j<plotInfoList.length ; j++){
                                            khdahtml += "                            <td class=\"am-text-middle\">"+plotInfoList[j].sclass+"/"+plotInfoList[j].bookArea+"</td>\n";
                                        }
                                    }
                                }
                                khdahtml +=    "                        </tr>";
                            }
                        }
                        $('#khtable').html(khdahtml);
                        $('#khtable tr').click(function () {
                            var rowNum=$(this).index();
                            var $table=$(this).parent();
                            var khmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                            var khbm=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(2)').text();
                            $('#khxx').val(khmc);
                            $('#khxx').attr('sptm',khbm);
                            $('#prt_kh').text(khmc);//设置打印客户信息
                            $('#chooseKhdiv').modal('close');
                        });
                        getData = true;
                    }else{
                        getData = false;
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
        return getData;
    };
    function closeNewKhdiv(){
        $('#newKhdiv').modal('close');
    }
    //删除
    function deleteSelf(event){
        var sptm= $(event).parent().parent().attr('sptm');
        $(event).parent().parent().remove();
        recountSppz();
        checksp_spda(sptm);
    }
    //重新计算界面商品选择品种
    function recountSppz(){
        var spcount=$("#sptable").find('tr').length;
        var hjje=resum_hjje();
        $('#hjje').text(hjje);
        $('#jsje').text(hjje);
        $('#ssje').val(hjje);
        $('#hjpz').text(spcount);
        $('#sphj').text(spcount);
    }
    //鼠标进入td 激活input
    function GetFocus(event){
        //$(event).children("input:first-child").focus();
    }
    //重新计算每行小计
    function resum_row(event){
        var dblx = $('#f_dblx').val();
        var dcbmbm = $("#f_dcbmbm").val();
        var rowNum= $(event).parent().parent().index();
        var $table=$(event).parent().parent().parent();
        var sptm= $(event).parent().parent().attr('sptm');
        var xssl=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(2)').children("input:first-child").val();
        var spdj = 0;
        if(dblx == 1){
            $.ajax({
                url: "/allot/GetSpkccbdj",
                type: "post",
                async: false,
                data: { f_xssl: xssl, f_sptm: sptm,f_dcbmbm:dcbmbm, timeer: new Date() },
                success: function (data) {
                    $table.find('tr:eq(' + (rowNum) + ')').find('td:eq(3)').children("input:first-child").val(data);
                    spdj = data;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $subbtn.button('reset');
                }
            });
        }else{
            spdj=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(3)').children("input:first-child").val();
        }

        var result=eval(spdj)*eval(xssl);
        $table.find('tr:eq(' + (rowNum) + ')').find('td:eq(4)').text(result.toFixed(2));
        var hjje=resum_hjje();
        $('#hjje').text(hjje);
        $('#jsje').text(hjje);
        $('#ssje').val(hjje);
    }
    //计算总合计金额
    function resum_hjje() {
        var $table=$('#sptable');
        var hjje=0;
        $table.find('tr').each(function () {
            var xssl=  $(this).find('td:eq(2)').children("input:first-child").val();
            var spdj=$(this).find('td:eq(3)').children("input:first-child").val();
            var rowhj=0;
            if(spdj===undefined){
                rowhj=0;
            }else{
                rowhj=eval(spdj)*eval(xssl);
            }
            hjje+=rowhj;
        })
        return hjje.toFixed(2);
    }
    //显示/影藏商品选择界面
    function spdadivshow() {
        if($("#spdadiv").is(":hidden")){
            $("#xsdiv").removeClass("am-u-sm-12 am-u-md-12").addClass("am-u-sm-6 am-u-md-6");
            $("#spdadiv").addClass("am-u-sm-6 am-u-md-6");
            $("#spdadiv").show();
            $("#morespda").removeClass("am-icon-chevron-left").addClass("am-icon-chevron-right");
            localStorage.setItem("showSpdiv", "true");
        }else{
            $("#spdadiv").hide();
            $("#xsdiv").removeClass("am-u-sm-6 am-u-md-6").addClass("am-u-sm-12 am-u-md-12");
            $("#morespda").removeClass("am-icon-chevron-right").addClass("am-icon-chevron-left");
            localStorage.setItem("showSpdiv", "false");
        }
    }
    //判断table是否已经含有此商品
    function checksp(spbm){
        var result=false;
        $("#sptable").find('tr').each(function () {
            if($(this).attr("sptm")==spbm)
            {
                $(this).remove();
                result=true;
                return false; //结束循环
            }
        })
        return result;
    }
    //判断spdadiv是否已经含有此商品
    function checksp_spda(spbm){
        var result=false;
        $("#spdadiv").find('li').each(function () {
            var spjson=$(this).find('.am-gallery-item').children("span:last-child").text();
            spjson=JSON.parse(spjson);
            if(spjson.spbm==spbm)
            {
                $(this).find('.am-gallery-item').removeClass('am-gallery-item-boder');
                result=true;
                return false; //结束循环
            }
        })
        return result;
    }

    //加载仓库参数
    function loadCkcs() {
        var ckHtml = "";
        var drbmckHtml = "";
        var sptableTitleHtml = "";
        var sptableHtml = "";
        if (qyck == 1){
            ckHtml += "     <label for=\"f_ckbm\" style=\"font-size: 16px;\">调出部门仓库：</label> \n" +
                "           <span>"+
                "               <select id=\"f_ckbm\" data-am-selected=\"{btnWidth: '59%',btnSize: 'sm'}\" style='width: 59%;border: 1px solid #ddd;padding: 7px;font-size: 1.4rem;color: #444;'>" +
                "               </select>"+
                "           </span>";
            $("#ckmcDiv").html(ckHtml);

            drbmckHtml += "     <label for=\"f_drckbm\" style=\"font-size: 16px;\">调入部门仓库：</label> \n" +
                "           <span>"+
                "               <select id=\"f_drckbm\" data-am-selected=\"{btnWidth: '59%',btnSize: 'sm'}\" style='width: 59%;border: 1px solid #ddd;padding: 7px;font-size: 1.4rem;color: #444;'>" +
                "               </select>"+
                "           </span>";
            $("#drbmckDiv").html(drbmckHtml);
            loadCkxx();

            sptableTitleHtml += "   <tr>"+
                "                       <th class=\"am-text-middle\">商品名称</th>"+
                "                       <th class=\"am-text-middle\">规格</th>"+
                "                       <th class=\"am-text-middle\">数量</th>"+
                "                       <th class=\"am-text-middle\">单价</th>"+
                "                       <th class=\"am-text-middle\">金额</th>"+
                "                       <th class=\"am-text-middle\">调出仓库</th>"+
                "                       <th class=\"am-text-middle\">调入仓库</th>"+
                "                       <th class=\"am-text-middle\">操作</th>"+
                "                   </tr>";

            sptableHtml += "<tr id=\"tishitr\">"+
                "               <td class=\"am-text-middle\" colspan=\"8\">选择需要调拨的商品</td>"+
                "           </tr>";
            $("#sptableTitle").html(sptableTitleHtml);
            $("#sptable").html(sptableHtml);
        }else {
            sptableTitleHtml += "   <tr>"+
                "                       <th class=\"am-text-middle\">商品名称</th>"+
                "                       <th class=\"am-text-middle\">规格</th>"+
                "                       <th class=\"am-text-middle\">数量</th>"+
                "                       <th class=\"am-text-middle\">单价</th>"+
                "                       <th class=\"am-text-middle\">金额</th>"+
                "                       <th class=\"am-text-middle\">操作</th>"+
                "                   </tr>";

            sptableHtml += "<tr id=\"tishitr\">"+
                "               <td class=\"am-text-middle\" colspan=\"6\">选择需要调拨的商品</td>"+
                "           </tr>";
            $("#sptableTitle").html(sptableTitleHtml);
            $("#sptable").html(sptableHtml);
        }
    }

    //加载仓库信息
    function loadCkxx() {
        $.ajax({
            url: "/purchase/loadCkxx",
            type: "post",
            async: false,
            data: { timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                ckxxJson = dataJson;
                var ckbmHtml = "";
                if (dataJson != null && dataJson != "" && dataJson != "[]"){
                    ckbmHtml += "<option value='' selected>选择仓库</option>";
                    for (var i = 0;i < dataJson.length; i++){
                        if (dataJson[i].F_MJ == "0"){
                            ckbmHtml += "<option disabled value='"+dataJson[i].F_CKBM+"'>"+dataJson[i].F_CKMC+"</option>";
                        }else if (dataJson[i].F_MJ == "1"){
                            ckbmHtml += "<option value='"+dataJson[i].F_CKBM+"'>"+dataJson[i].F_CKMC+"</option>";
                        }
                    }
                }
                $("#f_ckbm").html(ckbmHtml);
                $("#f_drckbm").html(ckbmHtml);
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

    function alertMsg(msg){
        $('#alertcontent').text(msg);
        $('#alertdlg').modal('open');
        $('#alertdlg').css("z-index","1120");
    }

</script>

</body>
</html>
