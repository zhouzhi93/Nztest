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
    <title>云平台客户端V1-损溢查询</title>
    <meta name="description" content="云平台客户端V1-损溢查询">
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
        #ksrq,#jsrq{width:88px;}
        thead{background:#EdEdEd;}
        #tabmx td{font-size:1.4rem}
    </style>
</head>
<body>
    <div class="am-g">
            <div class="am-form-inline">
                查询模式:<select data-am-selected id="cxms" style="width:90px">
                    <option value=0 selected>汇总查询</option>
                    <option value=1>明细查询</option>
                </select>日期范围：
                <input id="ksrq" type="text" class="am-radius am-form-field am-input-sm" placeholder="开始日期" data-am-datepicker readonly required />
                ~ <input id="jsrq" type="text" class="am-radius am-form-field am-input-sm" placeholder="结束日期" data-am-datepicker readonly required />
                <button onclick="loadInfo()" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger" style="margin-left: 10px;background-color: #fff !important;border: 1px solid #e52a33 !important;color: #e52a33 !important;">查询</button>
            </div>
        <div class="am-scrollable-horizontal" style="margin-top: 15px;" id="tabmx">
            <table class="am-table am-table-bordered am-table-striped am-text-nowrap am-table-centered">
                <thead><tr id="sthead"></tr></thead><tbody id="saletable"></tbody>
            </table>
        </div>
    </div>

    <!--损溢单详情-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="xsDetail">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">单据详情
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;height: 380px;" class="am-container  am-scrollable-vertical" >
                    <table class="am-table am-table-bordered am-table-centered"  >
                        <thead>
                        <tr>
                            <th class="am-text-middle">商品名称</th>
                            <th class="am-text-middle">规格</th>
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
    var names=[];
    var cxms=1;
    $(function (){
        $('#ksrq').val('<%=str.substring(0,8)%>01');
        $('#jsrq').val('<%=str%>');
        var mx=$('#tabmx');
        mx.css('overflow','hidden');
        mx.hover(function(){console.log('1');
            mx.css('overflow','auto');
        },function(){
           mx.css('overflow','hidden');
        });
        names[0]=['操作','制单日期','单据号','制单人','数量','金额','税金'];
        names[1]=['操作','制单日期','单据号','制单人','商品名称','规格型号','产地','数量','单价','金额','税金'];
        $('select').bind('change',function(){
            cxms=$(this).val();
            changecol(cxms);
        }).change();
        loadInfo();
    });
    function changecol(k) {
      var p=$('#sthead');
      $('#saletable').html('');
      var arr=names[eval(k)];
      var html='';
      for(var i=0; i<arr.length; i++) {
          html  += '<th class="am-text-middle">'+arr[i]+'</th>';
      }
      p.html(html);
    }
    function loadInfo(){
        var $saletable=$('#saletable');
        $saletable.html('');
        var ksrq=$('#ksrq').val().replace('-','').replace('-','');
        var jsrq=$('#jsrq').val().replace('-','').replace('-','');
        $.ajax({
            url: "/gainsLosses/gainsLossesquery",type: "post",async: false,
            data: {f_cxms:cxms,f_djlx:0,f_ksrq:ksrq,f_jsrq:jsrq,f_bmbm:'', timeer: new Date() },
            success: function (data) {
                var saleList = eval(data);
                var salehtml="",sale=null;
                if(saleList.length>0) {
                    for(var i=0;i<saleList.length;i++){
                        sale=saleList[i];
                        salehtml+="<tr>\n" +
                            "    <td class=\"am-text-left\"><a href=\"javascript:showDetail('"+sale[0]+"','"+sale[2]+"','"+sale[1]+"','"+sale[3]+"')\" >详情</a> </td>\n"+
                            "    <td class=\"am-text-left\">"+sale[3].substring(0,4)+"-"+sale[3].substring(4,6)+"-"+sale[3].substring(6,8)+"</td>\n" +
                            "    <td class=\"am-text-left\">"+sale[1]+"</td>\n" +
                            "    <td class=\"am-text-left\">"+sale[5]+"</td>\n";
                        if(cxms==0) {
                            salehtml+="    <td class=\"am-text-right\">"+sale[8]+"</td>\n" +
                                "    <td class=\"am-text-right\">"+sale[9]+"</td>\n" +
                                "    <td class=\"am-text-right\">"+sale[10]+"</td>" ;
                        } else {
                            salehtml+="    <td class=\"am-text-left\">"+sale[10]+"</td>\n" +
                                "    <td class=\"am-text-left\">"+sale[12]+"</td>\n" +
                                "    <td class=\"am-text-left\">"+sale[11]+"</td>\n" +
                                "    <td class=\"am-text-right\">"+sale[13]+"</td>\n" +
                                "    <td class=\"am-text-right\">"+sale[16]+"</td>\n" +
                                "    <td class=\"am-text-right\">"+sale[14]+"</td>\n" +
                                "    <td class=\"am-text-right\">"+sale[15]+"</td>" ;
                        }
                        salehtml+="</tr>\n";
                    }
                }
                $saletable.html(salehtml);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }
    //显示单据详情
    function showDetail(f_djlx,f_bmbm,f_djh,f_zdrq){
        $('#xsDetailtable').html('');
        $('#xsDetail').modal({
            closeViaDimmer: false,
            width:680,
            height:500
        });
        $.ajax({
            url: "/gainsLosses/gainsLossesquery",type: "post",async: false,
            data: {f_cxms:1,f_djlx:f_djlx,f_ksrq:f_zdrq,f_jsrq:f_zdrq,f_bmbm:f_bmbm,f_djh:f_djh, timeer: new Date() },
            success: function (data) {
                var dataJson = eval(data);
                if(dataJson.length>0) {
                    var html="",sale=null;
                    for(var i=0;i<dataJson.length;i++){
                        sale=dataJson[i];//spmc,ggxh,sydj,sysl,syje
                        html="<tr>"
                            +"<td class=\"am-text-left am-td-spmc\">"+sale[10]+"</td>"
                            +"<td class=\"am-text-left\">"+sale[12]+"</td>"
                            +"<td class=\"am-text-right\">"+sale[13]+"</td>"
                            +"<td class=\"am-text-right\">"+sale[16]+"</td>"
                            +"<td class=\"am-text-right\">"+sale[14]+"</td>"
                            +"</tr>";
                        $('#xsDetailtable').prepend(html);
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
