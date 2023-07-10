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
    <title>云平台客户端V1-移库处理</title>
    <meta name="description" content="云平台客户端V1-移库处理">
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
                <h1>移库处理</h1>
            </div>
        </div>
        <div class="am-container" style="margin-top: 10px;">
            <div class="am-u-sm-4 am-u-md-4 am-text-left">
                部门：   <select data-am-selected="{btnWidth: '60%', btnSize: 'sm'}" id="f_bmbm">

                        </select>
            </div>
            <div class="am-u-sm-4 am-u-md-4 am-text-middle">
                移出仓库：<select data-am-selected="{btnWidth: '60%', btnSize: 'sm'}" id="f_ycck">

                        </select>
            </div>
            <div class="am-u-sm-4 am-u-md-4 am-text-right">
                移入仓库：<select data-am-selected="{btnWidth: '60%', btnSize: 'sm'}" id="f_yrck">

                        </select>
            </div>
        </div>

        <div class="am-container am-scrollable-vertical" style="margin-top: 10px;">
            <table class="am-table am-table-bordered am-table-centered" >
                <thead>
                    <tr>
                        <th class="am-text-middle">商品名称</th>
                        <th class="am-text-middle">规格</th>
                        <th class="am-text-middle">数量</th>
                        <th class="am-text-middle">单价</th>
                        <th class="am-text-middle">金额</th>
                        <th class="am-text-middle">操作</th>
                    </tr>
                </thead>
                <tbody id="sptable">
                    <tr id="tishitr">
                        <td class="am-text-middle" colspan="6">选择需要的商品</td>
                    </tr>
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
                <button type="button" onclick="savebill()" class="am-btn am-btn-danger  am-radius am-btn-sm">调拨</button>&nbsp;&nbsp;
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
    var ckxxJson = null;
    var qyck = <%=f_qyck%>;

    $(function(){
        loadCkxx();

        var spdalist ='${spdalist}';
        if(spdalist.length==0){
            console.log('暂无商品信息');
        }else {
            var $spul=$('#spdadiv ul');//商品档案展示ul
            spdalist=JSON.parse(spdalist);
            console.log(spdalist);
            var spdahtml="";
            for(var i=0;i<spdalist.length;i++){
                var spda=spdalist[i];

                if(spdahtml==""){
                    spdahtml="<li>\n" +
                        "                        <div class=\"am-gallery-item\">\n" +
                        "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\"/>\n" +
                        "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                        "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                        "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                        "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\",\"zhjj\": \""+spda.F_ZHJJ+"\",\"csbm\": \""+spda.F_GYSBM+"\",\"csmc\": \""+spda.F_GYSMC+"\"}</span>\n" +
                        "                        </div>\n" +
                        "                    </li>"
                }else{
                    spdahtml+="<li>\n" +
                        "                        <div class=\"am-gallery-item\">\n" +
                        "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\"/>\n" +
                        "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                        "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                        "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                        "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\",\"zhjj\": \""+spda.F_ZHJJ+"\",\"csbm\": \""+spda.F_GYSBM+"\",\"csmc\": \""+spda.F_GYSMC+"\"}</span>\n" +
                        "                        </div>\n" +
                        "                    </li>"
                }
            }
            $spul.append(spdahtml);
        }
        var sxbmList='${sxbmList}';
        if(sxbmList.length==0){
            console.log("暂无分管部门信息");
        }else{
            var bmList=JSON.parse(sxbmList);
            var bmHtmle="";
            for(var i=0;i<bmList.length;i++){
                bmHtmle+="<option value=\""+bmList[i].F_BMBM+"\">"+bmList[i].F_BMMC+"</option>";
            }
            $("#f_bmbm").html(bmHtmle);
        }
        var show= localStorage.getItem("showSpdivGj");//用户最后一次选择展示还是不展示商品选择
        if(show=="true"){
            $("#xsdiv").removeClass("am-u-sm-12 am-u-md-12").addClass("am-u-sm-6 am-u-md-6");
            $("#spdadiv").addClass("am-u-sm-6 am-u-md-6");
            $("#spdadiv").show();
            $("#morespda").removeClass("am-icon-chevron-left").addClass("am-icon-chevron-right");
        }
        $('.am-gallery-item').click(function () {
            spimgclick(this);
        });
        $('#yhje').keyup(function () {
            var yhje=$(this).val();
            var hjje=$('#hjje').text();
            var res=(hjje-yhje).toFixed(2);
            var jsje=res>0?res:'0.00';
            $('#jsje').text(jsje);
            $('#ssje').val(jsje);
        });
        loadspfl();
        loadGhs();
        //显示选择权限
        $('#f_spflmc').click(function () {
            $('#SPFLdiv').modal({
                closeViaDimmer: false,
                width:680,
                height:550
            });
            $('#SPFLdiv').modal('open');
            $('#SPFLdiv').css("z-index","1219");
        });
        $('#firstTree').on('selected.tree.amui', function (event, data) {
            var flbm = data.target.id;
            var flmc = data.target.title;
            spflbm = flbm;
            spflmc = flmc;
        });
        //增加商品提交
        $("#addspbtn").click(function (){
            var sptm = $("#f_sptm").val();
            var djh = $("#f_djzh").val();
            var spmc = $("#f_spmc").val();
            var spfl = $("#f_spfl").val();

            if(spfl == ''){
                alertMsg('商品分类不能为空！');
                return;
            }
            if(sptm == ''){
                alertMsg('商品条码不能为空！');
                return;
            }
            if(spmc == ''){
                alertMsg('商品名称不能为空！');
                return;
            }
            var ggxh = $("#f_bzgg").val()
            var jldw = $("#primaryUnit").val();
            var xsj = $("#f_xsj").val();
            var jhj = $("#f_jhj").val();
            var jxsl = $("#f_jxsl").val();
            var xxsl = $("#f_xxsl").val();
            //var scqy = $("#f_scqy").val();
            var scqy = "";
            var scxkz = $("#f_scxkz").val();
            var ghs = $("#inputselect").val();
            var splx = $("input[name='f_splx']:checked").val();
            var nybz = $("input[name='f_nybz']:checked").val();
            var nycpdjz = "";
            var nycpbz = "";
            var nycpbq = "";
            var nycpsms = "";
            var zhl = "";
            var jx = "";
            var mbzzl = "";
            var mbzzldw = "";
            var nycpzmwjbh = $("#f_nycpzmwjbh").val();

            if(splx != '1'){
                if(ggxh == ''){
                    alertMsg('包装规格不能为空！');
                    return;
                }
                if(jhj == ''){
                    alertMsg('进价不能为空！');
                    return;
                }
                if(ghs == '' || ghs == null || ghs == '[]'){
                    alertMsg('供货商不能为空！');
                    return;
                }
            }
            if(xsj == ''){
                alertMsg('售价不能为空！');
                return;
            }

            if("<%=lxbm%>" != '1'  && "<%=lxbm%>" != '0'){
                if(jxsl == ''){
                    alertMsg('进项税率不能为空！');
                    return;
                }
                if(xxsl == ''){
                    alertMsg('销项税率不能为空！');
                    return;
                }
            }
            if("<%=lxbm%>" == '1'){
                zhl = $("#f_zhl").val();
                jx = $("#f_jx").val();
                mbzzl = $("#f_mbzzl").val();
                mbzzldw = $("#f_mbzzldw").val();
            }

            if("<%=lxbm%>" == '0'){
                var result = uploadFiles($("#f_nycpdjzFile"));
                nycpdjz = result;
                nycpbz = uploadFiles($("#f_nycpbzFile"));
                nycpbq = uploadFiles($("#f_nycpbqFile"));
                nycpsms = uploadFiles($("#f_nycpsmsFile"));
            }
            /*if(scxkz == ''){
                alertMsg('生产企业不能为空！');
                return;
            }*/

            var $subbtn = $("#addspbtn");
            $subbtn.button('loading');
            if(ghs == null){
                ghs = "";
            }
            $.ajax({
                url: "/commodity/saveSpda",
                type: "post",
                async: false,
                data: { sptm: sptm, djh: djh,spmc:spmc, spfl: spfl, ggxh: ggxh,jldw:jldw,
                    xsj: xsj,jhj:jhj,jxsl:jxsl,xxsl:xxsl,scxkz:scxkz,ghs:ghs.toString(),scqy:scqy,splx:splx,nybz:nybz,
                    nycpdjz:nycpdjz,nycpbz:nycpbz,nycpbq:nycpbq,nycpsms:nycpsms,nycpzmwjbh:nycpzmwjbh,
                    zhl:zhl,jx:jx,mbzzl:mbzzl,mbzzldw:mbzzldw,timeer: new Date() },
                success: function (data, textStatus) {
                    if(data == "ok"){
                        alertMsg("保存成功！");
                    }
                    $subbtn.button('reset');
                    $('#newSpdiv').modal('close');
                    loadSpxx("");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alertMsg(errorThrown + "||" + textStatus);
                    $subbtn.button('reset');
                }
            });

        });

        $('#f_djzh').keypress(function (e) {
            if (e.keyCode == 13) {
                var djzh = $("#f_djzh").val();
                $.ajax({
                    url: "/goodsAnalysis/goodsInfo",
                    type: "post",
                    async: false,
                    data: {url:djzh, timeer: new Date() },
                    success: function (data) {
                        if(data != '' && data != null && data != 'err'){
                            var json = JSON.parse(data);
                            if(json.length > 0){
                                $("#f_spmc").val(json[0].YPMC);
                                $("#f_zhl").val(json[0].YPZJL);
                                $("#f_jx").val(json[0].YPJX);
                                $("#f_spfl").val(json[0].F_SPLBBM);
                                $("#f_spflmc").val(json[0].YPLB);
                                $("#inputselect").val(json[0].DJHSCCJ);
                                $("#f_djzh").val(json[0].YPDJH);
                                setsptm(json[0].F_SPLBBM);
                            }
                        }else{
                            if(data == 'err'){
                                alertMsg("该商品已添加！");
                            }else if(data == '' || data == '[]'){
                                alertMsg("无国家标准农药信息！");
                            }
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alertMsg(errorThrown + "||" + textStatus);
                        $("#savaBtn").button('reset');
                    }
                });
            }
        });
        $('#addFlxz').click(function () {
            $('#SPFLdiv').modal('close');

            $("#f_spfl").val(spflbm);
            $("#f_spflmc").val(spflmc);
            $("#xgf_spfl").val(spflbm);
            $("#xgf_spflmc").val(spflmc);
            setsptm(spflbm);
        });
        if("<%=lxbm%>" == '1'){
            $('.ypdxs').show();
            $('.ypdbxs').hide();
        }
        if("<%=lxbm%>" == '0'){
            $('.nycsxs').show();
        }else{
            $('.nycsxs').hide();
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
        //显示选择供应商
        $('#csbm').click(function () {
            $('#chooseCsdiv').modal({
                closeViaDimmer: false,
                width:680,
                height:500
            });
            loadCsxx('');
            $('#chooseCsdiv').modal('open');
        });
        //显示新增供应商
        $('#addcs').click(function () {
            $('#newCSdiv').modal({
                closeViaDimmer: false,
                width:580,
                height:400
            });
            $('#newCSdiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#newCSdiv').css("z-index","1119");
        });
        //关闭还原遮罩蒙板z-index
        $('#newCSdiv').on('closed.modal.amui', function() {
            $('.am-dimmer').css("z-index","1100");
        });
        //增加供应商提交
        $('#addcsform').validator({
            H5validation: false,
            submit: function () {
                var formValidity = this.isFormValid();
                if (formValidity) {
                    try {
                        var $subbtn = $("#addcsbtn");
                        $subbtn.button('loading');
                        var f_csmc = $("#f_csmc").val();
                        var f_sjhm = $("#f_sjhm").val();
                        var f_xxdz = "";//$("#f_xxdz").val()
                        setTimeout(function () {
                            $.ajax({
                                url: "/purchase/AddCsda",
                                type: "post",
                                async: false,
                                data: { f_csmc: f_csmc, f_sjhm: f_sjhm, f_xxdz: f_xxdz, timeer: new Date() },
                                success: function (data, textStatus) {
                                    if(data.toLowerCase()=="ok"){
                                        alertMsg("新增成功");
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
                                    $("#savaBtn").button('reset');
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

        $('#f_ghs').change(function () {
            var ghs = $('#f_ghs').val();
            if(ghs != null){
                $('#inputselect').val(ghs);
            }else{
                $('#inputselect').val('');
            }
        });
    });


    function closeNewspdiv(){
        $('#newSpdiv').modal('close');
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
    //加载供应商
    function loadGhs(){
        $.ajax({
            url: "/initialvalues/GetKhda",
            type: "post",
            async: false,
            data: {khxx:"",cslx:0, timeer: new Date() },
            success: function (data) {
                var $selected = $('#f_ghs');
                var $selected2 = $('#xgf_ghs');
                $selected.html("");
                $selected.append('<option value=""></option>');
                $selected2.html("");
                $selected2.append('<option value=""></option>');
                var res = JSON.parse(data);
                var dataJson = JSON.parse(res.list);
                if(dataJson.length>0) {
                    for(var i=0;i<dataJson.length;i++){
                        var scqymx=dataJson[i];
                        $selected.append('<option value="'+scqymx.F_CSMC+'">'+scqymx.F_CSMC+'</option>');
                        $selected2.append('<option value="'+scqymx.F_CSMC+'">'+scqymx.F_CSMC+'</option>');
                    }
                    $selected.trigger('changed.selected.amui');
                    $selected2.trigger('changed.selected.amui');
                }else{
                    $('#f_ghs').html("");
                    $('#xgf_ghs').html("");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alertMsg(errorThrown + "||" + textStatus);
            }
        });
    };
    function closeQyxzdiv(){
        $('#SPFLdiv').modal('close');
    }
    //显示新增商品
    function showAddsp(){
        $("#f_spfl").val("");
        $("#f_spflmc").val("");
        $("#f_djzh").val("");
        $("#f_sptm").val("");
        $("#f_spmc").val("");
        $("#f_bzgg").val("");
        $("#primaryUnit").val("");
        $("#f_xsj").val("");
        $("#f_jhj").val("");
        $("#f_jxsl").val("");
        $("#f_xxsl").val("");
        $("#f_scqy").val("");
        $("#f_scxkz").val("");
        $("#f_ghs").val("");

        $('#f_scqy').trigger('changed.selected.amui');
        $('#f_ghs').trigger('changed.selected.amui');

        $('#newSpdiv').modal({
            closeViaDimmer: false,
            width:880,
            height:570
        });
        $('#newSpdiv').modal('open');
        $('.am-dimmer').css("z-index","1111");
        $('#newSpdiv').css("z-index","1119");
    }
    //打印
    function printBill(){
        try {
            var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));
            var html=document.getElementById('printMain').innerHTML;
            //LODOP.ADD_PRINT_HTM(0, 0, 180, 2000, html);
            i=html.indexOf('<style>');
            var j=html.indexOf('</style>');
            var css=html.substring(i,j+8);
            var prtHtml=document.getElementById('page_div').innerHTML;
            LODOP.ADD_PRINT_HTM(0, 0, 180, 2000,css+prtHtml);
            LODOP.PREVIEW();
        } catch(e){
            //window.print();
        }
    }
    //判断输入必须是是正数
    function IsNum(num){
        var reNum=/^\d*$/;
        if(reNum.test(num)) { return true; } else { if(num < 0) { alert("价格不能为负数！"); } else { alert("价格必须为数字！"); } return false; }}

    //保存单据
    function savebill(){
        var ycckbm=$('#f_ycck').val();
        var yrckbm=$('#f_yrck').val();
        if(ycckbm===undefined|| ycckbm.length<0){
            alertMsg('请选择移出仓库');
            return;
        }
        if(yrckbm===undefined|| yrckbm.length<0){
            alertMsg('请选择移入仓库');
            return;
        }

        var spcount=$('#hjpz').text();
        if(spcount<=0){
            alertMsg('请选择商品后再提交');
            return;
        }
        var $table=$('#sptable');
        var spxx= "";
        var prtspHmtl="";
        var kong=false;//进货单价为空!;
        $table.find('tr').each(function () {
            var sptm=$(this).attr('sptm');
            var spdj=$(this).find('td:eq(3)').children("input:first-child").val();
            var spmc=$(this).find('td:eq(0)').text();
            var ggxh=$(this).find('td:eq(1)').text();
            var sphjje=$(this).find('td:eq(4)').text();
            if(spdj.length<=0){
                kong=true;
            }
            var gjsl=  $(this).find('td:eq(2)').children("input:first-child").val();
            var sp="{\"sptm\":\""+sptm+"\",\"gjdj\":\""+spdj+"\",\"gjsl\":\""+gjsl+"\"}";
            if(spxx==""){
                spxx="["+sp;
            }else{
                spxx= spxx+","+sp;
            }
            prtspHmtl+="<tr>\n" +
                "                        <td><div noWrap style=\"text-align:left;width:260px;text-overflow:ellipsis;overflow:hidden;\">"+spmc+"</div></td>\n" +
                "                        <td class=\"td_number\">"+ggxh+"</td>\n" +
                "                        <td class=\"td_number\">"+gjsl+"</td>\n" +
                "                        <td class=\"td_number\">"+spdj+"</td>\n" +
                "                        <td class=\"td_number\">"+sphjje+"</td>\n" +
                "                    </tr>"
        })
        if(kong){
            alertMsg("进货单价不能为空!");
            return;
        }
        spxx =spxx+"]";
        var yhje=$('#yhje').val();
        var jsje=$('#jsje').text();
        var f_bmbm=$('#f_bmbm').val();
        setTimeout(function(){
            $.ajax({
                url: "/repertorys/savaBill",
                type: "post",
                async: false,
                data: {f_bmbm:f_bmbm,yhje:yhje,jsje:jsje,spxx:spxx,ycckbm:ycckbm,yrckbm:yrckbm,timeer: new Date() },
                success: function (data) {
                    if(data=="ok"){
                        alertMsg('保存成功！')
                        clearpage();
                    }else{
                        alertMsg(data);
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
        },10);
    };
    function clearAdd(){
        $('#f_khmc').val('');
        $('#f_sjhm').val('');
        $('#f_sfzh').val('');
        $('#f_qydz').val('');
        $('#f_xxdz').val('');
    }

    //商品档案选择界面 选择商品事件
    function spimgclick(evnet){
        var spjson=$(evnet).children("span:last-child").text();
        spjson=JSON.parse(spjson);
        var flag=checksp(spjson.spbm);
        $('#csbm').val(spjson.csmc);
        $('#csbm').attr('csbm',spjson.csbm);
        //var flag=false;//要求第二次点选不删除已选择商品
        var spcount=0;
        if(!flag){//如果不包含此商品
            var rowhtml="<tr sptm='"+spjson.spbm+"'>"
                +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.spmc+"</td>"
                +"<td class=\"am-text-middle\">"+spjson.ggxh+"</td>"
                +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.jldw+"</td>"
                +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value="+spjson.zhjj+" placeholder='单价' onblur=\"resum_row(this)\" /></td>"
                +"<td class=\"am-text-middle\">"+spjson.zhjj+"</td>"
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
        }else {
            var rowcount=$("#sptable").find('tr').length;
            if(rowcount==0){
                var tshtml="<tr id=\"tishitr\">\n" +
                    "           <td class=\"am-text-middle\" colspan=\"6\">选择需要进货的商品</td>\n" +
                    "       </tr>";
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
        var csbm=$('#csoption').val();
        loadCsxx(csbm);
    };
    function searchSpda(){
        var spxx=$('#spoption').val();
        $.ajax({
            url: "/purchase/GetSpda",
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
                                "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\"/>\n" +
                                "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                                "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                                "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                                "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\",\"zhjj\": \""+spda.F_ZHJJ+"\",\"gysbm\": \""+spda.F_ZHJJ+"\",\"csbm\": \""+spda.F_GYSBM+"\",\"csmc\": \""+spda.F_GYSMC+"\"}</span>\n" +
                                "                        </div>\n" +
                                "                    </li>"
                        }else{
                            spdahtml+="<li>\n" +
                                "                        <div class=\"am-gallery-item\">\n" +
                                "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\"/>\n" +
                                "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                                "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                                "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                                "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\",\"zhjj\": \""+spda.F_ZHJJ+"\",\"gysbm\": \""+spda.F_ZHJJ+"\",\"csbm\": \""+spda.F_GYSBM+"\",\"csmc\": \""+spda.F_GYSMC+"\"}</span>\n" +
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
    //加载供应商
    function loadCsxx(csbm){
        $.ajax({
            url: "/purchase/GetCsda",
            type: "post",
            async: false,
            data: {csxx:csbm, timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var dahtml="";
                    for(var i=0;i<dataJson.length;i++){
                        var csda=dataJson[i];
                        if(dahtml==""){
                            dahtml="<tr>\n" +
                                "                            <td class=\"am-text-middle\">"+csda.F_CSMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+csda.F_DH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">0.00</td>\n" +
                                "                            <td class=\"am-text-middle\">0.00</td>\n" +
                                "                            <td class=\"am-hide\">"+csda.F_CSBM+"</td>\n" +
                                "                        </tr>"
                        }else{
                            dahtml+="<tr>\n" +
                                "                            <td class=\"am-text-middle\">"+csda.F_CSMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+csda.F_DH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">0.00</td>\n" +
                                "                            <td class=\"am-text-middle\">0.00</td>\n" +
                                "                            <td class=\"am-hide\">"+csda.F_CSBM+"</td>\n" +
                                "                        </tr>"
                        }
                    }
                    $('#cstable').html(dahtml);
                    $('#cstable tr').click(function () {
                        var rowNum=$(this).index();
                        var $table=$(this).parent();
                        var csmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                        var csbm=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(4)').text();
                        $('#csbm').val(csmc);
                        $('#csbm').attr('csbm',csbm);
                        $('#chooseCsdiv').modal('close');
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
    };
    function closenewCSdiv(){
        $('#newCSdiv').modal('close');
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
        var rowNum= $(event).parent().parent().index();
        var $table=$(event).parent().parent().parent();
        var xssl=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(2)').children("input:first-child").val();
        var spdj=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(3)').children("input:first-child").val();
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
            localStorage.setItem("showSpdivGj", "true");
        }else{
            $("#spdadiv").hide();
            $("#xsdiv").removeClass("am-u-sm-6 am-u-md-6").addClass("am-u-sm-12 am-u-md-12");
            $("#morespda").removeClass("am-icon-chevron-right").addClass("am-icon-chevron-left");
            localStorage.setItem("showSpdivGj", "false");
        }
    }
    //判断table是否已经含有此商品
    function checksp(spbm){
        var result=false;
        $("#sptable").find('tr').each(function () {
            if($(this).attr("sptm")==spbm)  {
                //$(this).remove();
                var  inp = $(this).find('td:eq(2)').children("input:first-child");
                var sl=eval(inp.val())+1;
                inp.val(sl);resum_row(inp);
                result=true;
                return false; //结束循环
            }
        })
        return result;
    }
    //清除界面值
    function clearpage(){
        $('#csbm').val('').removeAttr('csbm');
        var tshtml="<tr id=\"tishitr\">\n" +
            "                        <td class=\"am-text-middle\" colspan=\"6\">选择需要出售的商品</td>\n" +
            "                    </tr>";
        $('#sptable').html(tshtml);
        $('#hjpz').text('0');
        $('#hjje').text("0.00");
        $('#jsje').text("0.00");
        $('#hjje').text(resum_hjje());
        $('#hjpz').text('0');
        $('#sphj').text('0');
        $('#ssje').val("0.00");
        $('#zlje').text("0.00");
        var ckbmHtml = "";
        if (ckxxJson != null && ckxxJson != "" && ckxxJson != "[]"){
            ckbmHtml += "<option value=''>选择仓库</option>";
            for (var i = 0;i < ckxxJson.length; i++){
                if (ckxxJson[i].F_MJ == "0"){
                    ckbmHtml += "<option disabled value='"+ckxxJson[i].F_CKBM+"'>"+ckxxJson[i].F_CKMC+"</option>";
                }else if (ckxxJson[i].F_MJ == "1"){
                    ckbmHtml += "<option value='"+ckxxJson[i].F_CKBM+"'>"+ckxxJson[i].F_CKMC+"</option>";
                }
            }
        }
        $("#f_ycck").html(ckbmHtml);
        $("#f_yrck").html(ckbmHtml);

    };
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
                    ckbmHtml += "<option value=''>选择仓库</option>";
                    for (var i = 0;i < dataJson.length; i++){
                        if (dataJson[i].F_MJ == "0"){
                            ckbmHtml += "<option disabled value='"+dataJson[i].F_CKBM+"'>"+dataJson[i].F_CKMC+"</option>";
                        }else if (dataJson[i].F_MJ == "1"){
                            ckbmHtml += "<option value='"+dataJson[i].F_CKBM+"'>"+dataJson[i].F_CKMC+"</option>";
                        }
                    }
                }
                $("#f_ycck").html(ckbmHtml);
                $("#f_yrck").html(ckbmHtml);
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
