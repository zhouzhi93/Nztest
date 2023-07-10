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
    <title>云平台客户端V1-包装物查询</title>
    <meta name="description" content="云平台客户端V1-包装物查询">
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
        #ksrq,#jsrq{width:92px;}
        thead{background:#EdEdEd;}
        #tabmx td{font-size:1.4rem}
    </style>
</head>
<body>
<div class="am-g">
    <div class="am-form-inline" style="margin-top: 10px;">
        查询模式:<select data-am-selected id="cxms" style="width:90px">
        <option value=0 selected>汇总查询</option>
        <option value=1>明细查询</option>
    </select>日期范围：
        <input id="ksrq" type="text" class="am-radius am-form-field am-input-sm" placeholder="开始日期" data-am-datepicker readonly required />
        ~ <input id="jsrq" type="text" class="am-radius am-form-field am-input-sm" placeholder="结束日期" data-am-datepicker readonly required />
        <input type="text" id="khxx" class="am-form-field am-input-sm am-radius" style="width: 230px;" placeholder="在当前条件下搜索客户名、商品名">&nbsp;
        <button onclick="searchbyKh()" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger">查询</button>

    </div>
    <div class="am-scrollable-horizontal" style="margin-top: 15px;" id="tabmx">
        <table class="am-table am-table-bordered am-table-striped am-text-nowrap am-table-centered" id="hztable">
            <thead>
            <tr>
                <th class="am-text-middle">操作</th>
                <th class="am-text-middle">制单时间</th>
                <th class="am-text-middle">客户名称</th>
                <th class="am-text-middle">制单人编码</th>
                <th class="am-text-middle">制单人名称</th>
                <th class="am-text-middle">单据备注</th>
                <th class="am-text-middle">状态</th>
            </tr>
            </thead>
            <tbody id="spgjtable">
            </tbody>
        </table>
        <table class="am-table am-table-bordered am-table-striped am-text-nowrap am-table-centered" id="mxtable" style="display: none;">
            <thead>
            <tr>
                <th class="am-text-middle">单据号</th>
                <th class="am-text-middle">制单日起</th>
                <th class="am-text-middle">包装物条码</th>
                <th class="am-text-middle">包装物名称</th>
                <th class="am-text-middle">规格</th>
                <th class="am-text-middle">单位</th>
                <th class="am-text-middle">单价</th>
                <th class="am-text-middle">数量</th>
                <th class="am-text-middle">金额</th>
            </tr>
            </thead>
            <tbody id="spgjMxtable">
            </tbody>
        </table>
    </div>
</div>

<!--包装物详情-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="xsDetail">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">单据详情
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div style="margin-top: 10px;height: 380px;" class="am-container  am-scrollable-vertical">
                <table class="am-table am-table-bordered am-table-centered"  >
                    <thead>
                    <tr>
                        <th class="am-text-middle">包装物</th>
                        <th class="am-text-middle">规格型号</th>
                        <th class="am-text-middle">单价</th>
                        <th class="am-text-middle">数量</th>
                        <th class="am-text-middle">金额</th>
                    </tr>
                    </thead>
                    <tbody id="xsDetailtable">
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
<script type="text/javascript">
    $(function (){
        $('#ksrq').val('<%=str.substring(0,8)%>01');
        $('#jsrq').val('<%=str%>');
        $('select').bind('change',function(){
            if($(this).val()=='0'){
                $('#hztable').show();
                $('#mxtable').hide();
            }else{
                $('#mxtable').show();
                $('#hztable').hide();
            }
        });
        searchbyKh();
    })
    function searchbyKh(){
        var cxtj=$('#khxx').val();
        loadInfo(cxtj);
    };
    function loadInfo(cxtj,f_rq) {
        var ksrq=$('#ksrq').val().replace('-','').replace('-','');
        var jsrq=$('#jsrq').val().replace('-','').replace('-','');
        var cxfs=$('#cxms').val();
            var $spgjtable = cxfs=='0'?$('#spgjtable'):$('#spgjMxtable');
            $spgjtable.html('');
            var salehtml = "";
            $.ajax({
                url: "/packing/packQuery",type: "post",async: false,
                data: {cxms: cxfs,cxtj: cxtj, f_ksrq: ksrq,f_jsrq: jsrq, timeer: new Date()},
                success: function (data) {
                    var spgjList = JSON.parse(data);
                    if (spgjList.length > 0) {
                        for (var i = 0; i < spgjList.length; i++) {
                            var spgj = spgjList[i];
                            if(cxfs=='0'){
                                salehtml += "<tr>\n<td class=\"am-text-middle\"><a href=\"javascript:showDetail('" + spgj.F_DJH + "')\" >详情</a> </td>\n" +
                                    "<td class=\"am-text-left\">" + spgj.F_ZDRQ + "</td>\n" +
                                    "<td class=\"am-text-left\">" + spgj.F_CSMC + "</td>\n" +
                                    "<td class=\"am-text-left\">" + spgj.F_ZDRBM + "</td>\n" +
                                    "<td class=\"am-text-left\">" + spgj.F_ZDRMC + "</td>\n" +
                                    "<td class=\"am-text-left\">" + spgj.F_DJBZ + "</td>\n" +
                                    "<td class=\"am-text-left\">" + spgj.F_STATE + "</td>\n</tr>";
                            } else {
                                salehtml += "<tr>\n<td class=\"am-text-middle\">" + spgj.F_DJH + "</td>\n" +
                                    " <td class=\"am-text-left\">" + spgj.F_RZRQ + "</td>\n" +
                                    " <td class=\"am-text-left\">" + spgj.F_SPTM + "</td>\n" +
                                    " <td class=\"am-text-left\">" + spgj.F_SPMC + "</td>\n" +
                                    " <td class=\"am-text-left\">" + spgj.F_GGXH + "</td>\n" +
                                    " <td class=\"am-text-left\">" + spgj.F_JLDW + "</td>\n" +
                                    " <td class=\"am-text-right\">" + spgj.F_GJDJ + "</td>\n" +
                                    " <td class=\"am-text-right\">"+spgj.F_GJSL+"</td>\n" +
                                    " <td class=\"am-text-right\">"+spgj.F_GJJE+"</td>\n</tr>";
                            }
                        }
                        $spgjtable.html(salehtml);
                    }
                }, error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
    }
    //显示单据详情
    function showDetail(f_djh){
        $('#xsDetailtable').html('');
        $('#xsDetail').modal({closeViaDimmer: false,width:680,height:500});
        $.ajax({
            url: "/packing/packingcbmx",type: "post",async: false,
            data: {f_djh:f_djh, timeer: new Date() },
            success: function (data) {
                console.log(data);
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var html="";
                    for(var i=0;i<dataJson.length;i++){
                        var spjson=dataJson[i];
                        var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                            +"<td class=\"am-text-left am-td-spmc\">"+spjson.F_SPMC+"</td>"
                            +"<td class=\"am-text-left\">"+spjson.F_GGXH+"</td>"
                            +"<td class=\"am-text-right\">"+spjson.F_GJDJ+"</td>"
                            +"<td class=\"am-text-right\">"+spjson.F_GJSL+"</td>"
                            +"<td class=\"am-text-right\">"+spjson.F_GJJE+"</td>"
                            +"<td class=\"am-hide\">"+spjson.F_PCH+"</td>"
                            +"</tr>";
                        $('#xsDetailtable').prepend(rowhtml);
                    }
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    }
</script>
</body>
</html>
