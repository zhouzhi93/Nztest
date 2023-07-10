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
    String zdrmc=(String)session.getAttribute("f_zymc");
%>
<%--<!DOCTYPE html>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台供应商端V1-进货退货单</title>
    <meta name="description" content="云平台供应商端V1-进货退货单">
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
    <div class="am-u-sm-12 am-u-md-12" id="xsdiv">
        <div class="header">
            <div class="am-g">
                <h1>进货退货单</h1>
            </div>
        </div>
        <div class="am-container">
            <div class="am-u-sm-6 am-u-md-6">供应商：<input class="am-radius am-form-field am-input-sm" id="csbm" readonly style="width: 140px;display:inline-block;" type="text" placeholder="选择供应商">
                <%--<i class="iconfont icon-htmal5icon26" style="position: relative;left:-30px;vertical-align: middle;"></i>--%>
            </div>
            <div class="am-u-sm-6 am-u-md-6"><span class="am-fr" style="vertical-align: middle;">日期：<%=str%></span></div>
        </div>
        <div class="am-container" style="margin-top: 10px;">
            <div>
                <div class="am-u-sm-6 am-u-md-6">原单据：<input class="am-radius am-form-field am-input-sm" id="JhXx" readonly style="width: 140px;display:inline-block;" type="text" placeholder="选择单据号">
                </div>
            </div>
            <div class="am-u-sm-6 am-u-md-6 am-text-right">
                <select data-am-selected="{btnWidth: '60%', btnSize: 'sm'}" id="f_bmbm">
                </select>
            </div>
        </div>
        <div class="am-container am-scrollable-vertical" style="margin-top: 20px;">
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
                    <td class="am-text-middle" colspan="6">选择需要退货的商品</td>
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
        <div class="am-container">
            <div class="am-fr">
                <input style="vertical-align:middle;" id="f_sfdyxp" type="checkbox"/><span style="font-size: 13px;vertical-align:middle;">保存后立即打印小票</span>
                <button type="button" onclick="savebill()" class="am-btn am-btn-danger  am-radius am-btn-sm">保存</button></div>
        </div>
    </div>
    <!--商品档案选择-->
    <div style="padding-top: 20px;display:none;height: 600px;" id="spdadiv" class="am-scrollable-vertical">
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
<!--选择供应商div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseCsdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">选择供应商
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div class="am-container">
                <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                    <input class="am-radius am-form-field am-input-sm" id="csoption" style="width: 160px;display:initial;" type="text" placeholder="输入供应商名称、字母">
                    <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchKh()">搜索</button>
                </div>
                <div class="am-u-sm-6 am-u-md-6 am-text-right">
                    <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadCsxx('')" style="border: 1px solid red;background: white;color: red;">重新加载</button>
                    <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" id="addcs">新增供应商</button>
                </div>
            </div>
            <div style="margin-top: 10px; height: 400px;" class="am-container am-scrollable-vertical">
                <table class="am-table am-table-bordered am-table-centered" >
                    <thead>
                    <tr>
                        <th class="am-text-middle">供应商名称</th>
                        <th class="am-text-middle">手机号码</th>
                        <th class="am-text-middle">余额</th>
                        <th class="am-text-middle">欠款</th>
                    </tr>
                    </thead>
                    <tbody id="cstable">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!--新建供应商div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="newCSdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">新增供应商
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div style="margin-top: 10px;" class="am-container">
                <form class="am-form am-form-horizontal" id="addcsform">
                    <div class="am-form-group">
                        <label for="f_csmc" class="am-u-sm-3 am-form-label">供应商名称</label>
                        <div class="am-u-sm-8">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_csmc" required placeholder="供应商名称">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>

                    <div class="am-form-group">
                        <label for="f_sjhm" class="am-u-sm-3 am-form-label">联系电话</label>
                        <div class="am-u-sm-8">
                            <input type="number" class="am-form-field am-input-sm am-radius" id="f_sjhm" required placeholder="手机号">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_sfzh"  class="am-u-sm-3 am-form-label">证件号码</label>
                        <div class="am-u-sm-8">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_sfzh" placeholder="身份证号">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_bz" class="am-u-sm-3 am-form-label">备注</label>
                        <div class="am-u-sm-8">
                            <textarea  class="am-form-field am-input-sm am-radius" id="f_bz" placeholder="备注"></textarea>
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label class="am-u-sm-3 am-form-label">状态</label>
                        <div class="am-u-sm-8 am-text-left">
                            <label class="am-radio-inline">
                                <input type="radio"  value="0" name="f_zt"> 启用
                            </label>
                            <label class="am-radio-inline">
                                <input type="radio" value="1" name="f_zt"> 停用
                            </label>
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group am-text-left">
                        <div class="am-u-sm-3">&nbsp;</div>
                        <div class="am-u-sm-9">
                            <button type="submit" id="addcsbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                            <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closenewCSdiv()">取消</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--选择原进货单div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseJhdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">选择原进货单
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div class="am-container">
                <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                    <input class="am-radius am-form-field am-input-sm" id="xsjhOption" style="width: 160px;display:initial;" type="text" placeholder="输入商品名称、字母">
                    <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchJh()">搜索</button>
                </div>
                <div class="am-u-sm-6 am-u-md-6 am-text-right">
                    <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadSpmx()" style="border: 1px solid red;background: white;color: red;">确定</button>
                    <button type="button" class="am-btn am-btn-xs am-radius" onclick="refreshJhxx()" style="border: 1px solid red;background: white;color: red;">重新加载</button>
                </div>
            </div>
            <div style="margin-top: 10px;height: 380px;" class="am-container  am-scrollable-vertical">
                <table class="am-table am-table-bordered am-table-centered"  >
                    <thead>
                    <tr>
                        <th class="am-text-middle">选择</th>
                        <th class="am-text-middle">购进时间</th>
                        <th class="am-text-middle">单据号</th>
                        <th class="am-text-middle">序号</th>
                        <th class="am-text-middle">商品名称</th>
                        <th class="am-text-middle">数量</th>
                        <th class="am-text-middle">计量单位</th>
                        <th class="am-text-middle">金额</th>
                    </tr>
                    </thead>
                    <tbody id="jhtable">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!--选择退货商品批次div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseThpcdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">选择退货商品批次
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div class="am-container">
                <div class="am-u-sm-12 am-u-md-12 am-text-right">
                    <button type="button" class="am-btn am-btn-xs am-radius" onclick="qudingtuihuoshangping()" style="border: 1px solid red;background: white;color: red;">确定</button>
                </div>
            </div>
            <div style="margin-top: 10px;height: 380px;" class="am-container  am-scrollable-vertical">
                <table class="am-table am-table-bordered am-table-centered"  >
                    <thead>
                    <tr>
                        <th class="am-text-middle">批次号</th>
                        <th class="am-text-middle">库存数量</th>
                        <th class="am-text-middle">库存单价</th>
                        <th class="am-text-middle">退货数量</th>
                    </tr>
                    </thead>
                    <tbody id="thtable">
                    </tbody>
                </table>
            </div>
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
<div id="printMain" style="display: none;" >
    <style>
        #page_div{width:680px;border:none;margin:0;padding:0}
        #title_div{width:680px;border:none;margin:0;padding:0;text-align: center;}
        #infol_div{width:680px;border:none;margin:0;padding:0}
        #body_div{width:680px;border:none;margin:0;padding:0}
        #page_div td{font-size:14px;margin:0;padding:0}
        #page_div th{font-size:14px;margin:0;padding:0}
        #page_div table{border-collapse:collapse;jerry:expression(cellSpacing="0");border:0;margin:0px;padding:0px;width:98%;}
        #page_div div{text-align:center;margin:0;padding:0;border:none}
        #title_div	{font-weight:bold;font-size:24px;}
        #infol_div	{margin-top:5px;}
        #page_div td{padding-left:2px;height:22px;}
        /*#infol_tb,#infol_tb td,#infol_tb input{border:0px solid black;text-align:left;height:16px;}*/
        #infol_tb th{font-size:14px;text-align:left;padding-left:4px;width:70px;}
        #page_div input		{border:0px;padding-top:0px;font-size:14px;}
        .PageNext	{page-break-after: always;}
        .td_number{text-align:right;padding:0 2px 0 0;border:1px solid black;}
        #datatb tr{height:25px}
        #datatb{border:1px solid black; margin:0;padding:0;border-collapse:collapse}
        #datatb th{border:1px solid black;font-size:14px;text-align:center;margin:0;padding:0}
        #prt_sp td{border:1px solid black;}
        #ico{position:absolute;left:10px;}
    </style>
    <div id="page_div">
        <div id="title_div">入库验收退单</div>
        <div id="infol_div">
            <table width='100%' id="infol_tb">
                <tr><th>日&#12288;&#12288;期:</th><td><%=str%></td><th>单&nbsp;据&nbsp;号:</th><td><text id="prt_djh"></text></td>
                </tr>
                <%--<tr><th>进货部门:</th><td><text id="prt_djh"></text></td>--%>
                <%--<th>入库仓库:</th><td> 0101仓库</td></tr>--%>
                <tr><th>供应商:</th><td><text id="prt_gys"></text></td>
                    <th>业&#8194;务&#8194;员:</th><td><%=zdrmc%></td></tr>
            </table>
        </div>
        <div id="body_div">
            <table id='datatb' style="float:left;display:inline">
                <tr>
                    <th style="width:360px">品 &nbsp; 名 &nbsp; &nbsp;- &nbsp; &nbsp;规 &nbsp;格</th>
                    <th style="width:65px">单位</th>
                    <th style="width:80px">数量</th>
                    <th style="width:75px">单价</th>
                    <th style="width:90px">金额</th>
                </tr>
                <tbody id="prt_sp">
                </tbody>
                <tr>
                    <th colspan=4>合&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;计</th>
                    <td class="td_number"><text id="prt_hjje"></text></td>
                </tr>

            </table>
        </div>
    </div>
</div>
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script src="/assets/js/app.js"></script>
<script src="/assets/address/address.min.js"></script>
<script src="/assets/address/iscroll.min.js"></script>
<script src="/assets/js/LodopFuncs.js"></script>
<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
    <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
</object>
<script type="text/javascript">
    $(function(){
        $("#morespda").hide();
        var spdalist ='${spdalist}';
        if(spdalist.length==0){
            console.log('暂无商品信息');
        }else {
            var $spul=$('#spdadiv ul');//商品档案展示ul
            spdalist=JSON.parse(spdalist);
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
                        "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\"}</span>\n" +
                        "                        </div>\n" +
                        "                    </li>"
                }else{
                    spdahtml+="<li>\n" +
                        "                        <div class=\"am-gallery-item\">\n" +
                        "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\"/>\n" +
                        "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                        "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                        "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                        "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\"}</span>\n" +
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
        //选择原单据
        $('#JhXx').click(function(){
            var csbm=$('#csbm').attr('csbm');
            if(csbm==undefined||csbm.length<=0){
                alertMsg('请先选择供应商');
                return;
            }
            console.log(csbm);
            $('#chooseJhdiv').modal({
                closeViaDimmer: false,
                width:880,
                height:500
            });
            loadJhxx(csbm,null);
            $('#chooseJhdiv').modal('open');
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
                        var f_xxdz = "";
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
    });



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
    function refreshJhxx(){
        var csbm=$('#csbm').attr('csbm');
        if(csbm==undefined||csbm.length<=0){
            return;
        }
        loadJhxx(csbm,null);
    };
    //查询销售信息
    function loadJhxx(gysbm,spxx){
        var f_bmbm=$('#f_bmbm').val();
        $('#jhtable').html('');
        $.ajax({
            url: "/purchase/GetJhZbxx",
            type: "post",
            async: false,
            data: {f_gysbm:gysbm,f_bmbm:f_bmbm,f_spxx:spxx, timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var html="";
                    for(var i=0;i<dataJson.length;i++){
                        var row=dataJson[i];
                        if(html==""){
                            html="<tr><td class=\"am-text-middle\"><input type=\"checkbox\" name=\"cbx\" value=\""+row.F_DJH+","+row.F_DNXH+"\" data-am-ucheck></td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_RZRQ+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_DJH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_DNXH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_SPMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_GJSL+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_GGXH+"/"+row.F_JLDW+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_GJJE+"</td>\n" +
                                "                            <td class=\"am-hide\">"+row.F_CSMC+"</td>\n" +
                                "                            <td class=\"am-hide\">"+row.F_ZDRMC+"</td>\n" +
                                "                        </tr>";
                        }else{
                            html+="<tr><td class=\"am-text-middle\"><input type=\"checkbox\" name=\"cbx\" value=\""+row.F_DJH+","+row.F_DNXH+"\" data-am-ucheck></td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_RZRQ+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_DJH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_DNXH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_SPMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_GJSL+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_GGXH+"/"+row.F_JLDW+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_GJJE+"</td>\n" +
                                "                            <td class=\"am-hide\">"+row.F_CSMC+"</td>\n" +
                                "                            <td class=\"am-hide\">"+row.F_ZDRMC+"</td>\n" +
                                "                        </tr>";
                        }
                    }
                    $('#jhtable').html(html);
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
    function loadSpmx(){
        //获取input类型是checkBox并且 name="cbx"选中的checkBox的元素
        var data = $('input:checkbox[name="cbx"]:checked').map(function () {
            return $(this).val();
        }).get().join("/");
        $('#sptable').html("");
        $.ajax({
            url: "/purchase/GetJhcbmx",
            type: "post",
            async: false,
            data: {data:data, timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var html="";
                    for(var i=0;i<dataJson.length;i++){
                        var spjson=dataJson[i];
                        var rowhtml="<tr sptm='"+spjson.F_SPTM+"' djh='"+spjson.F_DJH+"' ckbm='"+spjson.F_CKBM+"'>"
                            +"<td class=\"am-text-middle am-td-spmc\">"+spjson.F_SPMC+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" max=\"0\" value=\""+spjson.F_GJSL+"\" onblur=\"resum_row(this)\"/>"+spjson.F_JLDW+"</td>"
                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\""+spjson.F_GJDJ+"\" onblur=\"resum_row(this)\" /></td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_GJDJ+"</td>"
                            +"<td class=\"am-hide\">"+spjson.F_PCH+"</td>"
                            +"<td class=\"am-hide\">"+spjson.F_SGPCH+"</td>"
                            +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                            +"</tr>";
                        $('#sptable').prepend(rowhtml);
                    }
                    recountSppz();
                    $('#chooseJhdiv').modal('close');
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

    function clearAdd(){
        $('#f_khmc').val('');
        $('#f_sjhm').val('');
        $('#f_sfzh').val('');
        $('#f_qydz').val('');
        $('#f_xxdz').val('');
        $('#f_djbz').val('');
    }

    //保存单据
    function savebill(){
        var csbm=$('#csbm').attr('csbm');
        var gysmc=$('#csbm').val();
        if(csbm===undefined|| csbm.length<0){
            alertMsg('请先选择供应商');
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
        $table.find('tr').each(function () {
            var sptm=$(this).attr('sptm');
            var ckbm=$(this).attr('ckbm');
            var spmc=$(this).find('td:eq(0)').text();
            var ggxh=$(this).find('td:eq(1)').text();
            var sphjje=$(this).find('td:eq(4)').text();
            var gjsl=  $(this).find('td:eq(2)').children("input:first-child").val();
            var spdj=$(this).find('td:eq(3)').children("input:first-child").val();
            var pch=$(this).find('td:eq(5)').text();
            var sgpch=$(this).find('td:eq(6)').text();
            var sp="{\"sptm\":\""+sptm+"\",\"ckbm\":\""+ckbm+"\",\"gjdj\":\""+spdj+"\",\"gjsl\":\""+gjsl+"\",\"pch\":\""+pch+"\",\"sgpch\":\""+sgpch+"\"}";
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
        var spxx =spxx+"]";
        var yhje=$('#yhje').val();
        var jsje=$('#jsje').text();
        var f_ydjh=$('#JhXx').val();
        var f_bmbm=$('#f_bmbm').val();
        var f_ckbm = $('#f_ckbm').val();
        setTimeout(function(){
            $.ajax({
                url: "/purchase/SavaBill_refund",
                type: "post",
                async: false,
                data: {f_gysbm:csbm,f_bmbm:f_bmbm,f_ydjh:f_ydjh,yhje:yhje,jsje:jsje,spxx:spxx,timeer: new Date() },
                success: function (data) {
                    var rows=data.split("|");
                    if(rows[0]=="ok"){
                        alertMsg('保存成功！')
                        $('#prt_djh').text(rows[1]);
                        $('#prt_sp').html(prtspHmtl);
                        $('#prt_gys').text(gysmc);
                        $('#prt_hjje').text(jsje);
                        var sfdyxp=$('#f_sfdyxp').attr('checked');
                        if(sfdyxp=="checked"){
                            $('#okbtn').click(function () {
                                $('#alertdlg').modal('close');
                                $('.am-dimmer.am-active').hide();
                                $(this).unbind("click");
                                printBill();
                            })
                        }
                        clearpage();
                    }else {
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
                }
            });
        },10);
    };
    function qudingtuihuoshangping(){
        var $table=$('#thtable');
        var spxx= "";
        var flag=false;
        $table.find('tr').each(function () {
            var kcsl=$(this).find('td:eq(1)').text();
            var lrsl=$(this).find('td:eq(3)').children("input:first-child").val();
            if(eval(kcsl)<eval(lrsl)){
                flag=true;
                return;
            }
        });
        if(flag){
            alertMsg("存在退货数量大于库存数量的批次，请检查！");
            return;
        };
        $table.find('tr').each(function () {
            var pch=$(this).find('td:eq(0)').text();
            var spdj= $(this).find('td:eq(2)').text();
            var gjsl=$(this).find('td:eq(3)').children("input:first-child").val();
            var spmc=$(this).find('td:eq(4)').text();
            var ggxh=$(this).find('td:eq(5)').text();
            var sptm=$(this).find('td:eq(6)').text();
            var jldw=$(this).find('td:eq(7)').text();
            var hj=eval(spdj)*eval(gjsl);
            if(eval(gjsl)!=0) {
                var rowhtml = "<tr sptm='" + sptm + "'>"
                    + "<td class=\"am-text-middle am-td-spmc am-text-truncate\">" + spmc + "</td>"
                    + "<td class=\"am-text-middle\">" + ggxh + "</td>"
                    + "<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" max=\"0\" value=\"" + gjsl + "\" onblur=\"resum_row(this)\"/>" + jldw + "</td>"
                    + "<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\"" + spdj + "\" placeholder='单价' onblur=\"resum_row(this)\" /></td>"
                    + "<td class=\"am-text-middle\">"+hj+"</td>"
                    + "<td class=\"am-hide\">"+pch+"</td>"
                    + "<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                    + "</tr>";
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
        })
        $('#chooseThpcdiv').modal('close');
    }
    function clearpage(){
        $('#csbm').val('').removeAttr('csbm');
        $('#JhXx').val('').removeAttr('djh');
        var tshtml="<tr id=\"tishitr\">\n" +
            "                        <td class=\"am-text-middle\" colspan=\"6\">选择需要出售的商品</td>\n" +
            "                    </tr>";
        $('#sptable').html(tshtml);
        $('#hjpz').text('0');
        $('#hjje').text("0.00");
        $('#jsje').text("0.00");
        $('#hjje').text(resum_hjje());
        $('#f_djbz').val('');
        $('#hjpz').text('0');
        $('#sphj').text('0');
        $('#ssje').val("0.00");
        $('#zlje').text("0.00");

    };
    //商品档案选择界面 选择商品事件
    function spimgclick(evnet){
        var spjson=$(evnet).children("span:last-child").text();
        var f_bmbm=$('#f_bmbm').val();
        spjson=JSON.parse(spjson);
        $.ajax({
            url: "/purchase/GetSpkcBySptm",
            type: "post",
            async: false,
            data: {f_sptm:spjson.spbm,f_bmbm:f_bmbm,timeer: new Date() },
            success: function (data) {
                spkcJson=JSON.parse(data);
                if(spkcJson.length<=0){
                    alertMsg("该商品库存为0,无法退货!")
                }else{
                    $('#chooseThpcdiv').modal({
                        closeViaDimmer: false,
                        width:680,
                        height:500
                    });
                    var kchmtl="";
                    for(var i=0;i<spkcJson.length;i++){
                        var rowhtml="<tr>"
                            +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spkcJson[i].F_PCH+"</td>"
                            +"<td class=\"am-text-middle\">"+spkcJson[i].F_KCSL+"</td>"
                            +"<td class=\"am-text-middle\">"+spkcJson[i].F_KCDJ+"</td>"
                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\"0\" placeholder='数量' /></td>"
                            +"<td class=\"am-hide\">"+spkcJson[i].F_SPMC+"</td>"
                            +"<td class=\"am-hide\">"+spkcJson[i].F_GGXH+"</td>"
                            +"<td class=\"am-hide\">"+spkcJson[i].F_SPTM+"</td>"
                            +"<td class=\"am-hide\">"+spkcJson[i].F_JLDW+"</td>"
                            +"</tr>";
                        kchmtl+=rowhtml;
                    }
                    $('#thtable').html(kchmtl);
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
    function searchKh() {
        var csbm=$('#csoption').val();
        loadCsxx(csbm);
    };
    function searchJh(){
        var csbm=$('#csbm').attr('csbm');
        var spxx = $('#xsjhOption').val();
        loadJhxx(csbm,spxx);
    }
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
                                "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\"/>\n" +
                                "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                                "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                                "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                                "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\"}</span>\n" +
                                "                        </div>\n" +
                                "                    </li>"
                        }else{
                            spdahtml+="<li>\n" +
                                "                        <div class=\"am-gallery-item\">\n" +
                                "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\"/>\n" +
                                "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                                "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                                "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                                "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\"}</span>\n" +
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
        var spdj=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(2)').children("input:first-child").val();
        var xssl=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(3)').children("input:first-child").val();
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
            var spdj=  $(this).find('td:eq(2)').children("input:first-child").val();
            var xssl=$(this).find('td:eq(3)').children("input:first-child").val();
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

    function alertMsg(msg){
        $('#alertcontent').text(msg);
        $('#alertdlg').modal('open');
        $('#alertdlg').css("z-index","1120");
    }

</script>
</body>
</html>
