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
    <title>云平台客户端V1-销售查询</title>
    <meta name="description" content="云平台客户端V1-销售查询">
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
            <div class="am-form-inline">
                <input type="text" id="khxx" class="am-form-field am-input-sm am-radius" style="width: 230px;" placeholder="在当前条件下搜索客户名、商品名">&nbsp;
                <button onclick="searchbyKh()" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger">搜索</button>
                <%--<button onclick="loadInfo('')" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger" style="margin-left: 10px;background-color: #fff !important;border: 1px solid #e52a33 !important;color: #e52a33 !important;">重新加载</button>--%>
            </div>
        <div class="am-form-inline" style="margin-top: 10px;">
            销售日期:
            <input type="text" id="f_rq" class="am-form-field am-input-sm am-radius" style="width: 150px;" data-am-datepicker readonly placeholder="销售日期">&nbsp;&nbsp;&nbsp;&nbsp;
            查询方式:
            <label class="am-radio-inline">
                <input type="radio" value="0" checked="checked" name="f_cxfs"> 单据汇总
            </label>
            <label class="am-radio-inline">
                <input type="radio" value="1"  name="f_cxfs"> 明细查询
            </label>
        </div>
        <div class="am-scrollable-horizontal" style="margin-top: 15px;">
            <table class="am-table am-table-bordered am-table-striped am-text-nowrap am-table-centered" id="hztable">
                <thead>
                <tr>
                    <th class="am-text-middle">操作</th>
                    <th class="am-text-middle">制单时间</th>
                    <th class="am-text-middle">客户名称</th>
                    <th class="am-text-middle">合计金额</th>
                    <th class="am-text-middle">结算总金额</th>
                    <th class="am-text-middle">付款金额</th>
                </tr>
                </thead>
                <tbody id="saletable">
                </tbody>
            </table>
            <table class="am-table am-table-bordered am-table-striped am-text-nowrap am-table-centered" id="mxtable" style="display: none;">
                <thead>
                <tr>
                    <th class="am-text-middle">单据号</th>
                    <th class="am-text-middle">制单日起</th>
                    <th class="am-text-middle">商品条码</th>
                    <th class="am-text-middle">商品名称</th>
                    <th class="am-text-middle">规格</th>
                    <th class="am-text-middle">单位</th>
                    <th class="am-text-middle">单价</th>
                    <th class="am-text-middle">销售数量</th>
                    <th class="am-text-middle">销售金额</th>
                </tr>
                </thead>
                <tbody id="saleMxtable">
                </tbody>
            </table>
        </div>
    </div>
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="newKhdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">新增客户
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div style="margin-top: 10px;" class="am-container">
                <form class="am-form am-form-horizontal" id="addkhform">
                    <div class="am-form-group">
                        <label for="f_khmc" class="am-u-sm-2 am-form-label">客户名称</label>
                        <div class="am-u-sm-9">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_khmc" required placeholder="客户名称">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>

                    <div class="am-form-group">
                        <label for="f_sjhm" class="am-u-sm-2 am-form-label">手机号</label>
                        <div class="am-u-sm-9">
                            <input type="number" class="am-form-field am-input-sm am-radius" id="f_sjhm" required placeholder="手机号">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_sfzh"  class="am-u-sm-2 am-form-label">身份证号</label>
                        <div class="am-u-sm-9">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_sfzh" placeholder="身份证号">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group" id="address5" data-am-address="{prov:'上海',scrollToCenter:true}">
                        <label for="f_qydz" class="am-u-sm-2 am-form-label">所在地区</label>
                        <div class="am-u-sm-9">
                            <input type="text" id="f_qydz" class="am-form-field am-input-sm am-radius" readonly required  placeholder="请选择地址">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_xxdz" class="am-u-sm-2 am-form-label">详细地址</label>
                        <div class="am-u-sm-9">
                            <input type="text" class="am-form-field am-input-sm am-radius" required id="f_xxdz" placeholder="详细地址">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_bz" class="am-u-sm-2 am-form-label">备注</label>
                        <div class="am-u-sm-9">
                            <textarea  class="am-form-field am-input-sm am-radius" id="f_bz" placeholder="备注"></textarea>
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label class="am-u-sm-2 am-form-label">状态</label>
                        <div class="am-u-sm-9 am-text-left">
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
                        <div class="am-u-sm-2">&nbsp;</div>
                        <div class="am-u-sm-10">
                            <button type="submit" id="addkhbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                            <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeNewKhdiv()">取消</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
    <!--销售单详情-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="xsDetail">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">销售单据详情
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;height: 380px;" class="am-container  am-scrollable-vertical">
                    <table class="am-table am-table-bordered am-table-centered"  >
                        <thead>
                        <tr>
                            <th class="am-text-middle">商品名称</th>
                            <th class="am-text-middle">规格型号</th>
                            <th class="am-text-middle">销售单价</th>
                            <th class="am-text-middle">销售数量</th>
                            <th class="am-text-middle">实收金额</th>
                        </tr>
                        </thead>
                        <tbody id="xsDetailtable">
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
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script src="/assets/js/app.js"></script>
<script src="/assets/address/address.min.js"></script>
<script src="/assets/address/iscroll.min.js"></script>
<script type="text/javascript">
    $(function (){
        var saleList ='${saleList}';
        if(saleList.length==0){
            console.log('暂无销售数据');
        }else {
            var $saletable=$('#saletable');
            saleList=JSON.parse(saleList);
            var salehtml="";
            for(var i=0;i<saleList.length;i++){
                var sale=saleList[i];
                if(salehtml==""){
                    salehtml="<tr>\n" +
                        "                        <td class=\"am-text-middle\"><a href=\"javascript:showDetail('"+sale.F_DJH+"')\" >详情</a> </td>\n" +
                        "                        <td class=\"am-text-middle\">"+sale.F_RZRQ+""+sale.F_XSSJ+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+sale.F_CSMC+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+sale.F_ZFJE+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+sale.F_ZFJE+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+sale.F_ZFJE+"</td>\n" +
                        "                    </tr>";
                }else{
                    salehtml+="<tr>\n" +
                        "                        <td class=\"am-text-middle\"><a href=\"javascript:showDetail('"+sale.F_DJH+"')\" >详情</a> </td>\n" +
                        "                        <td class=\"am-text-middle\">"+sale.F_RZRQ+""+sale.F_XSSJ+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+sale.F_CSMC+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+sale.F_ZFJE+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+sale.F_ZFJE+"</td>\n" +
                        "                        <td class=\"am-text-middle\">"+sale.F_ZFJE+"</td>\n" +
                        "                    </tr>";
                }
            }
            $saletable.html(salehtml);
        }
        var date = new Date();
        var year = date.getFullYear();
        var month = ((date.getMonth() + 1) < 10 ? "0" : "") + (date.getMonth() + 1);
        var day = (date.getDate() < 10 ? "0" : "") + date.getDate();
        $('#f_rq').val(year + "-" + month + "-" + day);
        $('input[type=radio][name=f_cxfs]').change(function(){
            if(this.value=='0'){
                $('#hztable').show();
                $('#mxtable').hide();
            }else{
                $('#mxtable').show();
                $('#hztable').hide();
            }
        });
    })
    function searchbyKh(){
        var cxtj=$('#khxx').val();
        var f_cxfs=$('input[type=radio][name=f_cxfs]:checked').val();
        var f_rq=$('#f_rq').val();
        loadInfo(cxtj,f_cxfs,f_rq);
    }
    function loadInfo(cxtj,f_cxfs,f_rq) {
        if (f_cxfs=="0") {
            var $saletable = $('#saletable');
            $saletable.html('');
            $.ajax({
                url: "/sales/GetBillDetail",
                type: "post",
                async: false,
                data: {cxtj: cxtj,f_rq:f_rq, timeer: new Date()},
                success: function (data) {
                    var saleList = JSON.parse(data);
                    if (saleList.length > 0) {
                        var salehtml = "";
                        for (var i = 0; i < saleList.length; i++) {
                            var sale = saleList[i];
                            if (salehtml == "") {
                                salehtml = "<tr>\n" +
                                    "                        <td class=\"am-text-middle\"><a href=\"javascript:showDetail('" + sale.F_DJH + "')\" >详情</a> </td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_RZRQ + "" + sale.F_XSSJ + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_CSMC + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_ZFJE + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_ZFJE + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_ZFJE + "</td>\n" +
                                    "                    </tr>";
                            } else {
                                salehtml += "<tr>\n" +
                                    "                        <td class=\"am-text-middle\"><a href=\"javascript:showDetail('" + sale.F_DJH + "')\" >详情</a> </td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_RZRQ + "" + sale.F_XSSJ + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_CSMC + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_ZFJE + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_ZFJE + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_ZFJE + "</td>\n" +
                                    "                    </tr>";
                            }
                        }
                        $saletable.html(salehtml);
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
        }else{
            var $saletable = $('#saleMxtable');
            $saletable.html('');
            $.ajax({
                url: "/sales/GetSalesDetail",
                type: "post",
                async: false,
                data: {cxtj: cxtj,f_rq:f_rq, timeer: new Date()},
                success: function (data) {
                    var saleList = JSON.parse(data);
                    if (saleList.length > 0) {
                        var salehtml = "";
                        for (var i = 0; i < saleList.length; i++) {
                            var sale = saleList[i];
                            if (salehtml == "") {
                                salehtml = "<tr>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_DJH + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_RZRQ + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_SPTM + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_SPMC + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_GGXH + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_JLDW + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_XSDJ + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">"+sale.F_XSSL+"</td>\n" +
                                    "                        <td class=\"am-text-middle\">"+sale.F_SSJE+"</td>\n" +
                                    "                    </tr>";
                            } else {
                                salehtml += "<tr>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_DJH + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_RZRQ + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_SPTM + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_SPMC + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_GGXH + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_JLDW + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_XSDJ + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">"+sale.F_XSSL+"</td>\n" +
                                    "                        <td class=\"am-text-middle\">"+sale.F_SSJE+"</td>\n" +
                                    "                    </tr>";
                            }
                        }
                        $saletable.html(salehtml);
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
    }
    //显示单据详情
    function showDetail(f_djh){
        $('#xsDetailtable').html('');
        $('#xsDetail').modal({
            closeViaDimmer: false,
            width:680,
            height:500
        });
        $.ajax({
            url: "/sales/GetSalecbmx",
            type: "post",
            async: false,
            data: {f_djh:f_djh, timeer: new Date() },
            success: function (data) {
                console.log(data);
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var html="";
                    for(var i=0;i<dataJson.length;i++){
                        var spjson=dataJson[i];
                        var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                            +"<td class=\"am-text-middle am-td-spmc\">"+spjson.F_SPMC+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_XSDJ+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_XSSL+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_SSJE+"</td>"
                            +"<td class=\"am-hide\">"+spjson.F_PCH+"</td>"
                            +"</tr>";
                        $('#xsDetailtable').prepend(rowhtml);
                    }
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
    function alertMsg(msg){
        $('#alertcontent').text(msg);
        $('#alertdlg').modal('open');
        $('#alertdlg').css("z-index","1120");
    }
</script>
</body>
</html>
