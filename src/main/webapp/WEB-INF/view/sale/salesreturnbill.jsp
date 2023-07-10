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
    <title>云平台客户端V1-销售退货单</title>
    <meta name="description" content="云平台客户端V1-销售退货单">
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
                <h1>销售退货单</h1>
            </div>
        </div>
        <div class="am-container">
            <div class="am-u-sm-7 am-u-md-7">客&nbsp;&nbsp;&nbsp;&nbsp;户：<input class="am-radius am-form-field am-input-sm" id="khbm" readonly style="width: 160px;display:inline-block;" type="text" placeholder="选择客户">
                <%--<i class="iconfont icon-htmal5icon26" style="position: relative;left:-30px;vertical-align: middle;"></i>--%>
            </div>
            <div class="am-u-sm-5 am-u-md-5"><span class="am-fr" style="vertical-align: middle;">开票日期：<%=str%></span></div>
        </div>
        <div class="am-container"  style="margin-top: 10px;">
            <div class="am-u-sm-6 am-u-md-6">原单据：<input class="am-radius am-form-field am-input-sm" id="saleXx" readonly style="width: 160px;display:inline-block;" type="text" placeholder="选择原单据">
                <%--<i class="iconfont icon-htmal5icon26" style="position: relative;left:-30px;vertical-align: middle;"></i>--%>
            </div>
            <div class="am-u-sm-6 am-u-md-6 am-text-right">
                <select data-am-selected="{btnWidth: '60%', btnSize: 'sm'}" id="f_bmbm">
                </select>
            </div>
        </div>
        <%--<div class="am-container am-">--%>
            <%--<div class="am-u-sm-6 am-u-md-6">客户：<input class="am-radius am-form-field am-input-sm" id="khxx" readonly style="width: 160px;display:initial;" type="text" placeholder="">--%>
                <%--<i class="iconfont icon-htmal5icon26" style="position: relative;left:-30px;vertical-align: middle;"></i></div>--%>
            <%--<div class="am-u-sm-6 am-u-md-6"><span class="am-fr" style="vertical-align: middle;">开票日期：<%=str%></span></div>--%>
        <%--</div>--%>
        <div class="am-container am-scrollable-vertical" style="margin-top: 20px;">
            <table class="am-table am-table-bordered am-table-centered" >
                <thead>
                <tr>
                    <th class="am-text-middle">退货商品</th>
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
            <div class="am-fr am-text-right" style="margin-top: 10px;margin-right: 10px;">
                <%--优惠金额：<input id="yhje" class="am-radius am-form-field am-input-sm" min="0" style="width: 120px;display:initial;" type="number" placeholder="">元--%>
                <%--<br>--%>
                结算总额：<span id="jsje" style="color: #E72A33;">0.00</span> 元
            </div>
        </div>

        <hr/>
        <div class="am-container">
            <div class="am-form" style="clear: both;display: none;">
                <div style="margin-top:10px;"class="am-form-group">
                    备注：<textarea class="" style="width: 100%;display: block;" rows="3" id="f_djbz" placeholder="备注内容"></textarea>
                </div>
            </div>
            <div>
            </div>
        </div>
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
<i class="am-icon-chevron-left" style="position: fixed;right: 0px;top: 50%;display: none;" id="morespda" onclick="spdadivshow()"></i>
<!--选择客户div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseKhdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">选择客户
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div class="am-container">
                <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                    <input class="am-radius am-form-field am-input-sm" id="khoption" style="width: 160px;display:initial;" type="text" placeholder="输入客户名称、字母">
                    <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchKh()">搜索</button>
                </div>
                <div class="am-u-sm-6 am-u-md-6 am-text-right">
                    <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadKhxx('')" style="border: 1px solid red;background: white;color: red;">重新加载</button>
                    <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" id="addkh">新增客户</button>
                </div>
            </div>
            <div style="margin-top: 10px; height: 400px;" class="am-container am-scrollable-vertical">
                <table class="am-table am-table-bordered am-table-centered" >
                    <thead>
                    <tr>
                        <th class="am-text-middle">客户名称</th>
                        <th class="am-text-middle">手机号码</th>
                        <th class="am-text-middle">余额</th>
                        <th class="am-text-middle">欠款</th>
                    </tr>
                    </thead>
                    <tbody id="khtable">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!--新建客户div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="newKhdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">新增客户
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div style="margin-top: 10px;" class="am-container">
                <form class="am-form am-form-horizontal" id="addkhform">
                    <div class="am-form-group">
                        <label for="f_khmc" class="am-u-sm-3 am-form-label">客户名称</label>
                        <div class="am-u-sm-8">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_khmc" required placeholder="客户名称">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_sjhm" class="am-u-sm-3 am-form-label">联系电话</label>
                        <div class="am-u-sm-8">
                            <input type="number" class="am-form-field am-input-sm am-radius" id="f_sjhm" required placeholder="联系电话">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_sfzh"  class="am-u-sm-3 am-form-label">证件号码</label>
                        <div class="am-u-sm-8">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_sfzh" placeholder="证件号码">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <%--<div class="am-form-group" id="address5" data-am-address="{prov:'上海',scrollToCenter:true}">--%>
                    <%--<label for="f_qydz" class="am-u-sm-2 am-form-label">所在地区</label>--%>
                    <%--<div class="am-u-sm-9">--%>
                    <%--<input type="text" id="f_qydz" class="am-form-field am-input-sm am-radius" readonly required  placeholder="请选择地址">--%>
                    <%--</div>--%>
                    <%--<div class="am-u-sm-end"></div>--%>
                    <%--</div>--%>
                    <%--<div class="am-form-group">--%>
                    <%--<label for="f_xxdz" class="am-u-sm-2 am-form-label">详细地址</label>--%>
                    <%--<div class="am-u-sm-9">--%>
                    <%--<input type="text" class="am-form-field am-input-sm am-radius" required id="f_xxdz" placeholder="详细地址">--%>
                    <%--</div>--%>
                    <%--<div class="am-u-sm-end"></div>--%>
                    <%--</div>--%>
                    <div class="am-form-group">
                        <label for="f_djbz" class="am-u-sm-3 am-form-label">备注</label>
                        <div class="am-u-sm-8">
                            <textarea  class="am-form-field am-input-sm am-radius" id="f_djbz1" placeholder="备注"></textarea>
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
                            <button type="submit" id="addkhbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                            <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeNewKhdiv()">取消</button>
                            <input type="reset" name="reset" style="display: none;" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--选择销售单-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseXsdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">选择原销售单
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div class="am-container">
                <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                    <input class="am-radius am-form-field am-input-sm" id="xsspOption" style="width: 160px;display:initial;" type="text" placeholder="输入商品名称、字母">
                    <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchSale()">搜索</button>
                </div>
                <div class="am-u-sm-6 am-u-md-6 am-text-right">
                    <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadSpmx()" style="border: 1px solid red;background: white;color: red;">确定</button>
                    <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadSale('')" style="border: 1px solid red;background: white;color: red;">重新加载</button>
                </div>
            </div>
            <div style="margin-top: 10px;height: 380px;" class="am-container  am-scrollable-vertical">
                <table class="am-table am-table-bordered am-table-centered"  >
                    <thead>
                    <tr>
                        <th class="am-text-middle">选择</th>
                        <th class="am-text-middle">销售时间</th>
                        <th class="am-text-middle">单据号</th>
                        <th class="am-text-middle">序号</th>
                        <th class="am-text-middle">商品名称</th>
                        <th class="am-text-middle">数量</th>
                        <th class="am-text-middle">计量单位</th>
                        <th class="am-text-middle">金额</th>
                    </tr>
                    </thead>
                    <tbody id="salestable">
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
        <p class="PageNext"></p><!--进行分页//下一页的头部门--->
        <div id="td_t1">制单人名称</div>

        <div>
            <table style="float:left;display:inline" class="tablePrt">
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
                <tr><td colspan=4 style='text-align:left'><span style='font-weight:bold;'>现金:</span><text id="prt_xj"></text></td></tr>
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
<script src="/assets/js/LodopFuncs.js"></script>
<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
    <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
</object>
<script type="text/javascript">
    $(function(){
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
                        "                                <img src='/images/default.png'  alt=\""+spda.F_SPMC+"\"/>\n" +
                        "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                        "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                        "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                        "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\"}</span>\n" +
                        "                        </div>\n" +
                        "                    </li>"
                }else{
                    spdahtml+="<li>\n" +
                        "                        <div class=\"am-gallery-item\">\n" +
                        "                                <img src='/images/default.png'  alt=\""+spda.F_SPMC+"\"/>\n" +
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
        var show= localStorage.getItem("showSpthdiv");//用户最后一次选择展示还是不展示商品选择
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
        //显示选择客户
        $('#khbm').click(function () {
            $('#chooseKhdiv').modal({
                closeViaDimmer: false,
                width:680,
                height:500
            });
            loadKhxx('');
            $('#chooseKhdiv').modal('open');
        });
        //显示原销售单
        $('#saleXx').click(function(){
            var khbm=$('#khbm').attr('khbm');
            if(khbm==undefined||khbm.length<=0){
                alertMsg('请先选择销售客户');
                return;
            }
            $('#chooseXsdiv').modal({
                closeViaDimmer: false,
                width:880,
                height:500
            });
            loadSalexx(khbm,null);
            $('#chooseXsdiv').modal('open');
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
        //关闭还原遮罩蒙板z-index
        $('#newKhdiv').on('closed.modal.amui', function() {
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
                        var f_xxdz = "";
                        setTimeout(function () {
                            $.ajax({
                                url: "/sales/AddKhda",
                                type: "post",
                                async: false,
                                data: { f_khmc: f_khmc, f_sjhm: f_sjhm, f_xxdz: f_xxdz, timeer: new Date() },
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
    function clearpage(){
    $('#khbm').val('').removeAttr('khbm');
    $('#saleXx').val('').removeAttr('djh');
    var tshtml="<tr id=\"tishitr\">\n" +
        "                        <td class=\"am-text-middle\" colspan=\"6\">选择需要退货的商品</td>\n" +
        "                    </tr>";
    $('#sptable').html(tshtml);
    $('#f_djbz').val('');
    $('#hjpz').text('0');
    $('#hjje').text("0.00");
    $('#jsje').text("0.00");
    $('#hjje').text(resum_hjje());
    $('#hjpz').text('0');
    $('#sphj').text('0');
    $('#ssje').val("0.00");
    $('#zlje').text("0.00");
    };
    function clearAdd(){
        $('#f_khmc').val('');
        $('#f_sjhm').val('');
        $('#f_sfzh').val('');
        $('#f_qydz').val('');
        $('#f_xxdz').val('');
        $('#f_djbz').val('');
    }
    //打印
    function printBill(){
        try {
            var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));
            var html=document.getElementById('printDiv').innerHTML;
            LODOP.ADD_PRINT_HTM(0, 0, 180, 2000, html);
            LODOP.PREVIEW();
            //LODOP.PRINTA();//
            self.close();
            //LODOP.PRINT();
        } catch(e){
            //window.print();
        }
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
    //保存单据
    function savebill(){
        var f_djh=$('#saleXx').attr('djh');
        if(f_djh===undefined|| f_djh.length<0){
            alertMsg('请先选择销售单据');
            return;
        }
        var spcount=$('#hjpz').text();
        if(spcount<=0){
            alertMsg('暂无退货商品');
            return;
        }
        var $table=$('#sptable');
        var spxx= "";
        var prtspHmtl="";
        $table.find('tr').each(function () {
            var sptm=$(this).attr('sptm');
            var djh = $(this).attr('djh');
            console.log(sptm);
            var spmc=$(this).find('td:eq(0)').text();
            var sphjje=$(this).find('td:eq(4)').text();
            var xssl=  $(this).find('td:eq(2)').children("input:first-child").val();
            var spdj=$(this).find('td:eq(3)').children("input:first-child").val();
            var pch=$(this).find('td:eq(5)').text();
            var sgpch=$(this).find('td:eq(6)').text();
            var sp="{\"djh\":\""+djh+"\",\"sptm\":\""+sptm+"\",\"spdj\":\""+spdj+"\",\"xssl\":\""+xssl+"\",\"pch\":\""+pch+"\",\"sgpch\":\""+sgpch+"\"}";
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
        setTimeout(function(){
            $.ajax({
                url: "/sales/SavaBill_Refund",
                type: "post",
                async: false,
                data: {f_djh:f_djh,yhje:yhje,jsje:jsje,spxx:spxx,timeer: new Date() },
                success: function (data) {
                    var rows=data.split("|");
                    if(rows[0]=="ok"){
                        alertMsg("保存成功！");
                        $('#prt_djh').text(rows[1]);
                        $('#prt_sp').html(prtspHmtl);
                        $('#prt_xjje').text(jsje);
                        $('#prt_ysje').text(jsje);
                        $('#prt_ssje').text(jsje);
                        $('#prt_xj').text(jsje);
                        var dxje=toUper(jsje);
                        $('#prt_dxje').text(dxje);
                        var jysk=new Date().Format("yyyy-MM-dd hh:mm:ss");
                        $('#prt_jysk').text(jysk)
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
                    }
                    else{
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
                    //$("#savaBtn").button('reset');
                }
            });
        },10);
    };

    //商品档案选择界面 选择商品事件
    function spimgclick(evnet){
        var spjson=$(evnet).children("span:last-child").text();
        spjson=JSON.parse(spjson);
        var flag=false;//要求第二次点选不删除已选择商品
        var spcount=0;
        if(!flag){//如果不包含此商品
            var rowhtml="<tr sptm='"+spjson.spbm+"'>"
                +"<td class=\"am-text-middle am-td-spmc\">"+spjson.spmc+"</td>"
                +"<td class=\"am-text-middle\">"+spjson.ggxh+"</td>"
                +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" max=\"0\" value=\"-1\" onblur=\"resum_row(this)\"/>"+spjson.jldw+"</td>"
                +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\""+spjson.spdj.toFixed(2)+"\" onblur=\"resum_row(this)\" /></td>"
                +"<td class=\"am-text-middle\">"+spjson.spdj+"</td>"
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
                    "                        <td class=\"am-text-middle\" colspan=\"6\">选择需要退货的商品</td>\n" +
                    "                    </tr>";
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
        loadKhxx(khxx);
    };
    function searchSale(){
        var khbm=$('#khbm').attr('khbm');
        var spxx = $('#xsspOption').val();
        loadSalexx(khbm,spxx);
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
                                "                                <img src='/images/default.png'  alt=\""+spda.F_SPMC+"\"/>\n" +
                                "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                                "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                                "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                                "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\"}</span>\n" +
                                "                        </div>\n" +
                                "                    </li>"
                        }else{
                            spdahtml+="<li>\n" +
                                "                        <div class=\"am-gallery-item\">\n" +
                                "                                <img src='/images/default.png'  alt=\""+spda.F_SPMC+"\"/>\n" +
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
    //加载客户
    function loadKhxx(khxx){
        $.ajax({
            url: "/sales/GetKhda",
            type: "post",
            async: false,
            data: {khxx:khxx, timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var khdahtml="";
                    for(var i=0;i<dataJson.length;i++){
                        var khda=dataJson[i];
                        if(khdahtml==""){
                            khdahtml="<tr>\n" +
                                "                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">0.00</td>\n" +
                                "                            <td class=\"am-text-middle\">0.00</td>\n" +
                                "                            <td class=\"am-hide\">"+khda.F_CSBM+"</td>\n" +
                                "                        </tr>"
                        }else{
                            khdahtml+="<tr>\n" +
                                "                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">0.00</td>\n" +
                                "                            <td class=\"am-text-middle\">0.00</td>\n" +
                                "                            <td class=\"am-hide\">"+khda.F_CSBM+"</td>\n" +
                                "                        </tr>"
                        }
                    }
                    $('#khtable').html(khdahtml);
                    $('#khtable tr').click(function () {
                        var rowNum=$(this).index();
                        var $table=$(this).parent();
                        var khmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                        var khbm=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(4)').text();
                        $('#khbm').val(khmc);
                        $('#khbm').attr('khbm',khbm);
                        $('#chooseKhdiv').modal('close');
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
    //查询销售信息
    function loadSalexx(khxx,spxx){
        var f_bmbm=$('#f_bmbm').val();
        $('#salestable').html("");
        $.ajax({
            url: "/sales/saleZbxx",
            type: "post",
            async: false,
            data: {f_khxx:khxx,f_bmbm:f_bmbm,f_spxx:spxx, timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var html="";
                    for(var i=0;i<dataJson.length;i++){
                        var row=dataJson[i];
                        if(html==""){
                            html="<tr>\n" +
                                "<td class=\"am-text-middle\"><input type=\"checkbox\" name=\"cbx\" value=\""+row.F_DJH+","+row.F_DNXH+"\" data-am-ucheck></td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_RZRQ+row.F_XSSJ+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_DJH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_DNXH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_SPMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_XSSL+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_GGXH+"/"+row.F_JLDW+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_SSJE+"</td>\n" +
                                "                            <td class=\"am-hide\">"+row.F_CSMC+"</td>\n" +
                                "                            <td class=\"am-hide\">"+row.F_SYYMC+"</td>\n" +
                                "                        </tr>"
                        }else{
                            html+="<tr>\n" +
                                "<td class=\"am-text-middle\"><input type=\"checkbox\" name=\"cbx\" value=\""+row.F_DJH+","+row.F_DNXH+"\" data-am-ucheck></td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_RZRQ+row.F_XSSJ+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_DJH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_DNXH+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_SPMC+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_XSSL+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_GGXH+"/"+row.F_JLDW+"</td>\n" +
                                "                            <td class=\"am-text-middle\">"+row.F_SSJE+"</td>\n" +
                                "                            <td class=\"am-hide\">"+row.F_CSMC+"</td>\n" +
                                "                            <td class=\"am-hide\">"+row.F_SYYMC+"</td>\n" +
                                "                        </tr>"
                        }
                    }
                    $('#salestable').html(html);
                    /*$('#salestable tr').click(function () {
                        var rowNum=$(this).index();
                        var $table=$(this).parent();
                        var khmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(1)').text();
                        var djh=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(1)').text();
                        $('#saleXx').val(djh);
                        $('#saleXx').attr('djh',djh);
                        $('#sptable').html("");
                        $.ajax({
                            url: "/sales/GetSalecbmx",
                            type: "post",
                            async: false,
                            data: {f_djh:djh, timeer: new Date() },
                            success: function (data) {
                                var dataJson = JSON.parse(data);
                                if(dataJson.length>0) {
                                    var html="";
                                    for(var i=0;i<dataJson.length;i++){
                                        var spjson=dataJson[i];
                                        var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                                            +"<td class=\"am-text-middle am-td-spmc\">"+spjson.F_SPMC+"</td>"
                                            +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" max=\"0\" value=\""+spjson.F_XSSL+"\" onblur=\"resum_row(this)\"/>"+spjson.F_JLDW+"</td>"
                                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\""+spjson.F_XSDJ+"\" onblur=\"resum_row(this)\" /></td>"
                                            +"<td class=\"am-text-middle\">"+spjson.F_XSDJ+"</td>"
                                            +"<td class=\"am-hide\">"+spjson.F_PCH+"</td>"
                                            +"<td class=\"am-hide\">"+spjson.F_SGPCH+"</td>"
                                            +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                            +"</tr>";
                                        $('#sptable').prepend(rowhtml);
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
                        $('#chooseXsdiv').modal('close');
                    });*/
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
        var rowNum= $(event).parent().parent().index();
        var $table=$(event).parent().parent().parent();
        var xssl=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(2)').children("input:first-child").val();
        if(eval(xssl)<=0){
            alertMsg("退货数量不能小于0");
            $table.find('tr:eq(' + (rowNum) + ')').find('td:eq(2)').children("input:first-child").val("1.00");
            return;
        }
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
            localStorage.setItem("showSpthdiv", "true");
        }else{
            $("#spdadiv").hide();
            $("#xsdiv").removeClass("am-u-sm-6 am-u-md-6").addClass("am-u-sm-12 am-u-md-12");
            $("#morespda").removeClass("am-icon-chevron-right").addClass("am-icon-chevron-left");
            localStorage.setItem("showSpthdiv", "false");
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
    function loadSpmx(){
        //获取input类型是checkBox并且 name="cbx"选中的checkBox的元素
        var data = $('input:checkbox[name="cbx"]:checked').map(function () {
            return $(this).val();
        }).get().join("/");
        $('#sptable').html("");
        $.ajax({
            url: "/sales/GetSalecbmx",
            type: "post",
            async: false,
            data: {data:data, timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var html="";
                    for(var i=0;i<dataJson.length;i++){
                        var spjson=dataJson[i];
                        var rowhtml="<tr sptm='"+spjson.F_SPTM+"' djh='"+spjson.F_DJH+"'>"
                            +"<td class=\"am-text-middle am-td-spmc\">"+spjson.F_SPMC+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" max=\"0\" value=\""+spjson.F_XSSL+"\" onblur=\"resum_row(this)\"/>"+spjson.F_JLDW+"</td>"
                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\""+spjson.F_XSDJ+"\" onblur=\"resum_row(this)\" /></td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_XSDJ+"</td>"
                            +"<td class=\"am-hide\">"+spjson.F_PCH+"</td>"
                            +"<td class=\"am-hide\">"+spjson.F_SGPCH+"</td>"
                            +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                            +"</tr>";
                        $('#sptable').prepend(rowhtml);
                        $('#saleXx').val(spjson.F_DJH);
                        $('#saleXx').attr('djh',spjson.F_DJH);
                    }
                    recountSppz();
                    $('#chooseXsdiv').modal('close');
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
</script>
</body>
</html>
