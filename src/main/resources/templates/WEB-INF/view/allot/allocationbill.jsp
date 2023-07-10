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
    <title>云平台供应商端V1-调拨单</title>
    <meta name="description" content="云平台供应商端V1-调拨单">
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
                <h1>调&nbsp;&nbsp;拨&nbsp;&nbsp;单</h1>
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
                    <td class="am-text-middle" colspan="6">选择需要调拨的商品</td>
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
            <%--<div class="am-fr am-text-right" style="margin-top: 10px;margin-right: 10px;">--%>
                <%--优惠金额：<input id="yhje" class="am-radius am-form-field am-input-sm" min="0" style="width: 120px;display:initial;" type="number" placeholder="">元--%>
                <%--<br>--%>
                <%--结算总额：<span id="jsje" style="color: #E72A33;">0.00</span> 元--%>
            <%--</div>--%>
        </div>
        <div class="am-container">

            <div class="am-form" style="clear: both;">
                <div style="margin-top:10px;"class="am-form-group">
                    备注：<textarea class="" style="width: 100%;display: block;" rows="3" id="f_djbz" placeholder="备注内容"></textarea>
                </div>
            </div>
            <div>
            </div>
        </div>
        <div class="am-container">
            <div class="am-fr">
                <input style="vertical-align:middle;"  type="checkbox"/><span style="font-size: 13px;vertical-align:middle;">保存后立即打印小票</span>
                <button type="button" onclick="savebill()" class="am-btn am-btn-danger  am-radius am-btn-sm">保存</button></div>
        </div>
    </div>
    <!--商品档案选择-->
    <div style="padding-top: 20px;display:none;" id="spdadiv">
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
<div class="am-modal am-modal-alert" tabindex="-1" id="alertdlg">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">提示</div>
        <div class="am-modal-bd" id="alertcontent">

        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn">确定</span>
        </div>
    </div>
</div>
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script src="/assets/js/app.js"></script>
<script src="/assets/address/address.min.js"></script>
<script src="/assets/address/iscroll.min.js"></script>
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
                                    alertMsg(errorThrown + "||" + textStatus);
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
    //保存单据
    function savebill(){
        var csbm=$('#csbm').attr('csbm');
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
        var kong=false;//调拨单价为空!;
        $table.find('tr').each(function () {
            var sptm=$(this).attr('sptm');
            console.log(sptm);
            var spdj=$(this).find('td:eq(3)').children("input:first-child").val();
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
        })
        if(kong){
            alertMsg("调拨单价不能为空!");
            return;
        }
        var spxx =spxx+"]";
        var yhje=$('#yhje').val();
        var jsje=$('#jsje').text();
        console.log('yhje:'+yhje);
        console.log('jsje:'+jsje);
        console.log('spxx:'+spxx);
        setTimeout(function(){
            $.ajax({
                url: "/purchase/SavaBill",
                type: "post",
                async: false,
                data: {csbm:csbm,yhje:yhje,jsje:jsje,spxx:spxx,timeer: new Date() },
                success: function (data) {
                    if(data=="ok"){
                        alertMsg("保存成功！");
                        clearpage();
                    }else{
                        alertMsg(data);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alertMsg(errorThrown + "||" + textStatus);
                    //$("#savaBtn").button('reset');
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
        $('#f_djbz').val('');
    }
    //商品档案选择界面 选择商品事件
    function spimgclick(evnet){
        var spjson=$(evnet).children("span:last-child").text();
        spjson=JSON.parse(spjson);
        //var flag=checksp(spjson.spbm);
        var flag=false;//要求第二次点选不删除已选择商品
        var spcount=0;
        if(!flag){//如果不包含此商品
            var rowhtml="<tr sptm='"+spjson.spbm+"'>"
                +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.spmc+"</td>"
                +"<td class=\"am-text-middle\">"+spjson.ggxh+"</td>"
                +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.jldw+"</td>"
                +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" placeholder='单价' onblur=\"resum_row(this)\" /></td>"
                +"<td class=\"am-text-middle\"></td>"
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
                    "                        <td class=\"am-text-middle\" colspan=\"6\">选择需要进货的商品</td>\n" +
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
        var csbm=$('#csoption').val();
        loadCsxx(csbm);
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
                alertMsg(errorThrown + "||" + textStatus);
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
                alertMsg(errorThrown + "||" + textStatus);
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
        $table.find('tr:eq(' + (rowNum) + ')').find('td:eq(4)').text(result);
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
            if($(this).attr("sptm")==spbm)
            {
                $(this).remove();
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
        $('#f_djbz').val('');
        $('#hjpz').text('0');
        $('#sphj').text('0');
        $('#ssje').val("0.00");
        $('#zlje').text("0.00");

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
    function alertMsg(msg){
        $('#alertcontent').text(msg);
        $('#alertdlg').modal('open');
        $('#alertdlg').css("z-index","1120");
    }
</script>
</body>
</html>
