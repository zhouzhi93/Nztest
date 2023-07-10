<%--
  Created by IntelliJ IDEA.
  User: tao
  Date: 2018-07-10
  Time: 16:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%--<!DOCTYPE html> &lt;%&ndash;<html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"&ndash;%&gt;--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1</title>
    <meta name="description" content="云平台客户端V1">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="apple-touch-icon-precomposed" href="/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="/assets/css/amazeui.min.css"/>
    <style>
        .header
        {
            text-align: center;
        }

        .header h1
        {
            font-size: 250%;
            color: #333;
            margin-top: 30px;
        }

        .header p
        {
            font-size: 14px;
        }
        .niu{
            position: absolute;
            left: 50%;
            top: 50%;
            margin-top: -240px;
            margin-left: -530px;
            float: left;
            width: auto;
            height: 480px;
        }
        img{
            vertical-align: middle;
        }
        label{
            font-weight: 500;
            font-size:1.4rem;
        }
    </style>
</head>
<%--<body style="  background-image: url(http://dian.kingnew.me/form/login/images/landBG_02.jpg);">--%>
<body>
<%--<img style="opacity: 0;float: left;" src="http://dian.kingnew.me/form/login/images/landBG_02.jpg">--%>
<%--<img class="niu" src="http://dian.kingnew.me/form/login/images/niu_06.png">--%>
<%--<div class="am-radius" style="width: 600px;position: absolute;right: 200px;top:50px;background-color: white;padding: 10px 10px 10px 10px;">--%>
    <div class="am-g">
    <header class="header"><h1>农药使用登记</h1></header>
<hr/>
        <div class="am-u-sm-2">&nbsp;</div>
        <div class="am-u-sm-8">
                <div class="am-form-horizontal">
                    <div class="am-form-group">
                        <label for="f_sfzh" class="am-u-sm-2 am-form-label am-text-right">身份证号：</label>
                        <div class="am-u-sm-4 am-text-left">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_sfzh" required placeholder="输入身份证号码回车查询信息">
                        </div>
                        <label for="f_dh" class="am-u-sm-2 am-form-label am-text-right">电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话：</label>
                        <div class="am-u-sm-4 am-text-left">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_dh" required placeholder="">
                        </div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_khmc" class="am-u-sm-2 am-form-label am-text-right">客&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;户：</label>
                        <div class="am-u-sm-4 am-text-left">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_khmc" readonly placeholder="">
                            <input type="hidden" id="f_khbm"/><!--客户编码-->
                            <input type="hidden" id="f_shbm"/><!--商户编码-->
                        </div>
                        <label  class="am-u-sm-2 am-form-label">农药标志：</label>
                        <div class="am-u-sm-4">
                            <label class="am-radio-inline">
                                <input type="radio" value="0" checked name="f_nybz"> 禁限农药
                            </label>
                            <label class="am-radio-inline">
                                <input type="radio" value="1" name="f_nybz"> 非禁限农药
                            </label>
                        </div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_djh" class="am-u-sm-2 am-form-label am-text-right">调&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;单：</label>
                        <div class="am-u-sm-4 am-text-left">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_djh" readonly placeholder="点击选择调入农药记录">
                        </div>
                        <div class="am-u-sm-end">
                        </div>
                    </div>
                </div>
                <div class="am-container am-scrollable-vertical am-scrollable-horizontal" style="margin-top: 20px;min-height: 300px;">
                    <table class="am-table am-table-bordered am-table-centered am-text-nowrap" >
                        <thead>
                        <tr>
                            <th class="am-text-middle">农药名称</th>
                            <th class="am-text-middle">登记证号</th>
                            <th class="am-text-middle">规格</th>
                            <th class="am-text-middle">购买网点</th>
                            <th class="am-text-middle">销售单号</th>
                            <th class="am-text-middle">购买时间</th>
                            <th class="am-text-middle">购买数量</th>
                            <th class="am-text-middle">供货商</th>
                            <th class="am-text-middle">用药时间</th>
                            <th class="am-text-middle">农作物</th>
                            <th class="am-text-middle">防治对象</th>
                            <th class="am-text-middle">配比浓度</th>
                            <th class="am-text-middle">使用量</th>
                            <th class="am-text-middle">生产周期使用次数</th>
                            <th class="am-text-middle">末次使用时间</th>
                            <th class="am-text-middle">用药间隔期</th>
                            <th class="am-text-middle">备注</th>
                        </tr>
                        </thead>
                        <tbody id="sptable">
                        <%--<td class="am-text-middle">农药名称</td>--%>
                        <%--<td class="am-text-middle">登记证号</td>--%>
                        <%--<td class="am-text-middle">规格</td>--%>
                        <%--<td class="am-text-middle">购买网点</td>--%>
                        <%--<td class="am-text-middle">销售单号</td>--%>
                        <%--<td class="am-text-middle">购买时间</td>--%>
                        <%--<td class="am-text-middle">购买数量</td>--%>
                        <%--<td class="am-text-middle">供货商</td>--%>
                        <%--<td class="am-text-middle">--%>
                            <%--<input type="datetime-local" name="user_date" />--%>
                        <%--</td>--%>
                        <%--<td class="am-text-middle"><input type="text" max="0" value=''/></td>--%>
                        <%--<td class="am-text-middle"><input type="text" max="0" value=''/></td>--%>
                        <%--<td class="am-text-middle"><input type="text" max="0" value=''/></td>--%>
                        <%--<td class="am-text-middle"><input type="text" max="0" value=''/></td>--%>
                        <%--<td class="am-text-middle"><input type="text" max="0" value=''/></td>--%>
                        <%--<td class="am-text-middle"><input type="text" max="0" value=''/></td>--%>
                        <%--<td class="am-text-middle"><input type="text" max="0" value=''/></td>--%>
                        <%--<td class="am-text-middle"><input type="text" max="0" value=''/></td>--%>
                        <%--</tbody>--%>
                    </table>
                </div>

                <div class="am-fr" style="margin-top: 20px;">
                    <%--<input style="vertical-align:middle;" id="f_sfdyxp" type="checkbox"/><span style="font-size: 13px;vertical-align:middle;">保存后立即打印小票</span>--%>
                    <button type="button" onclick="savebill()" class="am-btn am-btn-danger  am-radius am-btn-sm">提交保存</button>
                </div>

        </div>
        <div class="am-u-sm-2"></div>
    </form>
</div>
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseXsdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">选择销售单
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div class="am-container">
                <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                    <input class="am-radius am-form-field am-input-sm" id="xskhOption" style="width: 160px;display:initial;" type="text" placeholder="输入商品名称">
                    <button type='button' class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchSale()">搜索</button>
                </div>
                <div class="am-u-sm-6 am-u-md-6 am-text-right">
                    <button type="button" class="am-btn am-btn-xs am-radius" onclick="reloadsale()" style="border: 1px solid red;background: white;color: red;">重新加载</button>
                </div>
            </div>
            <div style="margin-top: 10px;height: 380px;" class="am-container  am-scrollable-vertical">
                <table class="am-table am-table-bordered am-table-centered"  >
                    <thead>
                    <tr>
                        <th class="am-text-middle">销售时间</th>
                        <th class="am-text-middle">购买网点</th>
                        <th class="am-text-middle">农药名称</th>
                        <th class="am-text-middle">数量</th>
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
</body>
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script type="text/javascript">
    $(function () {
        $('#f_sfzh').keydown(function (e) {
            if(e.keyCode=="13"){
                var f_sfzh=$('#f_sfzh').val();
                GetKhda(f_sfzh,'');
            }
        });
        $('#f_dh').keydown(function (e) {
            if(e.keyCode=="13"){
                var f_dh=$('#f_dh').val();
                GetKhda('',f_dh);
            }
        });
        $('input[type=radio][name=f_nybz]').change(function () {
            $('#salestable').html('');
        });
        //显示原销售单
        $('#f_djh').click(function(){
            var f_khbm=$('#f_khbm').val();
            var f_shbm=$('#f_shbm').val();
            if(f_khbm==undefined||f_khbm.length<=0){
                alertMsg('请先获取客户信息');
                return;
            }
            $('#chooseXsdiv').modal({
                closeViaDimmer: false,
                width:680,
                height:500
            });
            loadSalexx(f_khbm,f_shbm,"");
            $('#chooseXsdiv').modal('open');
        });
    });
    function GetKhda(f_sfzh,f_dh){
        $.ajax({
            url: "/registration/GetKhda",
            type: "post",
            async: false,
            data: { f_sfzh: f_sfzh,f_dh:f_dh, timeer: new Date() },
            success: function (data, textStatus) {
                data=JSON.parse(data);
                if(data.length>0){
                    $('#f_khmc').val(data[0].F_CSMC);
                    $('#f_khbm').val(data[0].F_CSBM);
                    $('#f_sfzh').val(data[0].F_SFZH);
                    $('#f_dh').val(data[0].F_DH);
                    $('#f_shbm').val(data[0].F_SHBM);
                }else{
                    alertMsg("没有查询到结果！");
                    $('#f_khmc').val('');
                    $('#f_khbm').val('');
                    $('#f_sfzh').val('');
                    $('#f_dh').val('');
                    $('#f_shbm').val('');
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alertMsg(errorThrown + "||" + textStatus);
            }
        });
    }
    function loadbysp(){
        var f_khbm=$('#f_khbm').val();
        var f_shbm=$('#f_shbm').val();
        var f_spmc=
        loadSalexx(f_khbm,f_shbm,"");
    }
    function reloadsale(){
        var f_khbm=$('#f_khbm').val();
        var f_shbm=$('#f_shbm').val();
        loadSalexx(f_khbm,f_shbm,"");
    }
    function loadbysp(){
        var f_khbm=$('#f_khbm').val();
        var f_shbm=$('#f_shbm').val();
        var f_spmc=$('#xskhOption').val();
        loadSalexx(f_khbm,f_shbm,f_spmc);
    }
    //查询销售信息
    function loadSalexx(f_khbm,f_shbm,f_cxtj){
        var f_nybz=$("input[name='f_nybz']:checked").val();
        $.ajax({
            url: "/registration/saleZbxx",
            type: "post",
            async: false,
            data: {f_khbm:f_khbm,f_shbm:f_shbm,f_cxtj:f_cxtj,f_nybz:f_nybz, timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var html="";
                    for(var i=0;i<dataJson.length;i++){
                        var row=dataJson[i];
                        html+="<tr>\n" +
                            "                            <td class=\"am-text-middle\">"+row.F_RZRQ+row.F_XSSJ+"</td>\n" +
                            "                            <td class=\"am-text-middle\">"+row.F_BMMC+"</td>\n" +
                            "                            <td class=\"am-text-middle\">"+row.F_SPMC+"</td>\n" +
                            "                            <td class=\"am-text-middle\">"+row.F_XSSL+"</td>\n" +
                            "                            <td class=\"am-hide\">"+JSON.stringify(row)+"</td>\n" +
                            "                        </tr>"
                    }
                    $('#salestable').html(html);
                    $('#salestable tr').click(function () {
                        var rowNum=$(this).index();
                        var $table=$(this).parent();
                        var khmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(1)').text();
                        var spJson=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(4)').text();
                        spJson=JSON.parse(spJson);
                        //$('#saleXx').val(djh);
                        //$('#saleXx').attr('djh',djh);
                        //$('#sptable').html("");
                        var rowhtml="<tr sptm='"+spJson.F_SPTM+"'>"+
                            "<td class=\"am-text-middle\">"+spJson.F_SPMC+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+spJson.F_YPZJH+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+spJson.F_GGXH+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+spJson.F_BMMC+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+spJson.F_DJH+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+spJson.F_RZRQ+spJson.F_XSSJ+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+spJson.F_XSSL+"</td>\n" +
                            "                        <td class=\"am-text-middle\">"+spJson.F_GYSMC+"</td>\n" +
                            "                        <td class=\"am-text-middle\">\n" +
                            "                            <input type=\"datetime-local\" name=\"user_date\" />\n" +
                            "                        </td>\n" +
                            "                        <td class=\"am-text-middle\"><input type=\"text\"  value=''/></td>\n" +
                            "                        <td class=\"am-text-middle\"><input type=\"text\"  value=''/></td>\n" +
                            "                        <td class=\"am-text-middle\"><input type=\"text\"  value=''/></td>\n" +
                            "                        <td class=\"am-text-middle\"><input type=\"text\"  value=''/></td>\n" +
                            "                        <td class=\"am-text-middle\"><input type=\"text\"  value=''/></td>\n" +
                            "                        <td class=\"am-text-middle\">\n" +
                            "                            <input type=\"datetime-local\" name=\"user_date\" />\n" +
                            "                        </td>\n" +
                            "                        <td class=\"am-text-middle\"><input type=\"text\"  value=''/></td>\n" +
                            "                        <td class=\"am-text-middle\"><input type=\"text\"  value=''/></td>\n"+
                            "                        <td class=\"am-hide\">"+f_nybz+"</td>\n" +
                            "                        <td class=\"am-hide\">"+spJson.F_JLDW+"</td>\n" +
                            "</tr>";
                        $('#sptable').prepend(rowhtml);
                        $('#chooseXsdiv').modal('close');
                    });
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alertMsg(errorThrown.toString());
            }
        });
    };
    function savebill(){
        var $table=$('#sptable');
        var splist= new Array();
        $table.find('tr').each(function () {
            var sp= new Object();
            sp.f_nybz=$(this).find('td:eq(17)').text();;
            sp.f_khmc=$('#f_khmc').val();
            sp.f_sfzh=$('#f_sfzh').val();
            sp.f_lxdh=$('#f_dh').val();
            sp.f_nymc=$(this).find('td:eq(0)').text();;
            sp.f_nyzjh=$(this).find('td:eq(1)').text();
            sp.f_ggxh=$(this).find('td:eq(2)').text();
            sp.f_bmmc=$(this).find('td:eq(3)').text();
            sp.f_gjsj=$(this).find('td:eq(5)').text();
            sp.f_djh=$(this).find('td:eq(4)').text();
            sp.f_jldw=$(this).find('td:eq(18)').text();
            sp.f_nysl=$(this).find('td:eq(6)').text();
            sp.f_csmc=$(this).find('td:eq(7)').text();
            sp.f_yysj=$(this).find('td:eq(8)').children("input:first-child").val();
            sp.f_nzw=$(this).find('td:eq(9)').children("input:first-child").val();
            sp.f_fzdx=$(this).find('td:eq(10)').children("input:first-child").val();
            sp.f_pbnd=$(this).find('td:eq(11)').children("input:first-child").val();
            sp.f_sysl=$(this).find('td:eq(12)').children("input:first-child").val();
            sp.f_sycs=$(this).find('td:eq(13)').children("input:first-child").val();
            sp.f_zhsj=$(this).find('td:eq(14)').children("input:first-child").val();
            sp.f_yyjgsj=$(this).find('td:eq(15)').children("input:first-child").val();
            sp.f_bz=$(this).find('td:eq(16)').children("input:first-child").val();
            splist.push(sp);
        })
        console.dir(splist);
        $.ajax({
            url: "/registration/SavaNydj",
            type: "post",
            async: false,
            data: {splist:JSON.stringify(splist), timeer: new Date() },
            success: function (data) {
                if(data=="ok"){
                    alertMsg("提交保存成功!");
                }else{
                    alertMsg(data);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alertMsg(errorThrown.toString());
            }
        });
    }
    function alertMsg(msg){
        $('#alertcontent').text(msg);
        $('#alertdlg').modal('open');
        $('#alertdlg').css("z-index","1120");
    }
</script>
</html>
