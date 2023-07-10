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
    String f_brcdmrck=(String)session.getAttribute("f_brcdmrck");
    String f_bcdmrbrdw=(String)session.getAttribute("f_bcdmrbrdw");
%>
<%--<!DOCTYPE html>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-包装物拨出单</title>
    <meta name="description" content="云平台客户端V1-包装物拨出单">
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
        .header{text-align: center;}
        .header h1{font-size: 200%;color: #333;margin-top: 10px;}
        .am-text-middle input{border: 0px;width:70px;outline:none;cursor: pointer;text-align:center;}
        .am-gallery-item-boder{border:1px solid red;padding: 1px;}
        .am-td-spmc{max-width: 150px;font-size: 1.4rem;}
        #sptable input{padding-bottom: 5px;text-align:right;padding-right:3px;}
        .am-container{padding-left: 0;padding-right: 0;}
        label{font-weight: 500;font-size:1.4rem;}
        .am-popup{z-index: 1200;}
        .sptable{display:block;height:150px; overflow-y:scroll;}

        #bbs{border-collapse: collapse;}
        #bbs table thead,#bbs tbody tr {
            display:table;width:100%;table-layout:fixed;
        }
        #bbs table th{border-width:1px;}
        #bbs table thead{background:#EdEdEd;}
        #bbs table td {text-overflow:ellipsis; white-space:nowrap; overflow:hidden;}
    </style>
</head>
<body>
<div class="am-g">
    <div class="am-u-sm-12 am-u-md-12" id="xsdiv">
        <div class="header">
            <div class="am-g">
                <h1>包装物拨入单</h1>
            </div>
        </div>
        <div class="am-container am-">
            <div class="am-u-sm-7 am-u-md-7">拨出仓库编码：<select data-am-selected id="bcckbm"></select></div>
            <div class="am-u-sm-7 am-u-md-7">拨入单位编码：<select data-am-selected id="brdwbm"></select></div>
            <div class="am-u-sm-5 am-u-md-5"><span class="am-fr" style="vertical-align: middle;">日期：<%=str%></span></div>
        </div>
        <div class="am-container" style="margin-top: 20px;height:320px;overflow:scroll;overflow-x:hidden;" id="bbs">
            <table class="am-table am-table-bordered am-table-centered">
                <thead><tr>
                    <th class="am-text-middle" style="width:28%">包装物名称</th>
                    <th class="am-text-middle" style="width:16%">规格</th>
                    <th class="am-text-middle" style="width:17%">数量</th>
                    <th class="am-text-middle" style="width:14%">单价</th>
                    <th class="am-text-middle" style="width:14%">金额</th>
                    <th class="am-text-middle" style="width:11%">操作</th>
                </tr>
                </thead>
                <tbody id="sptable"></tbody>
                <tfoot><tr id="tishitr"><td class="am-text-middle" colspan="6">选择需要的商品</td></tr></tfoot>
            </table>
        </div>
        <div class="am-container">
            <div class="am-u-sm-6 am-u-md-6"><div class="am-cf">
                共<span onclick="resum_hjje()" id="hjpz" style="color: #E72A33;">0</span>种
            </div></div>
            <div class="am-u-sm-6 am-u-md-6"><div class="am-fr">
                合计：<span id="hjje" style="color: #E72A33;">0.00</span> 元
            </div></div>
        </div>
        <div class="am-container" style="display: none;">

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
                <button type="button" onclick="savebill()" class="am-btn am-btn-danger  am-radius am-btn-sm">保存</button></div>
        </div>
    </div>
    <!--包装物档案选择-->
    <div style="padding-top: 20px;display:none;height: 600px;" id="spdadiv" class="am-scrollable-vertical">
        <div class="am-fr">
            您已经选择了<span id="sphj" style="color: #E72A33;">0</span>种包装物<input class="am-radius am-form-field am-input-sm" id="spoption" style="width: 240px;display:initial;" type="text" placeholder="">
            <button type="button" onclick="searchSpda()" class="am-btn am-btn-default am-radius am-btn-sm">搜索</button>
        </div>
        <div class="am-g" style="margin-top: 20px;">
            <ul data-am-widget="gallery" class="am-gallery am-avg-sm-3 am-avg-md-3 am-avg-lg-4 am-gallery-default" data-am-gallery="{ pureview: false }">
            </ul>
        </div>
    </div>
</div>
<!-- 按钮触发器， 需要指定 target -->
<i class="am-icon-chevron-left" style="position: fixed;right: 0px;top: 50%;" id="morespda" onclick="spdadivshow()"></i>

<div class="am-modal am-modal-alert" tabindex="-1" id="alertdlg">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">提示</div>
        <div class="am-modal-bd" id="alertcontent"></div>
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
    var brdwbmJson = null;

    $(function(){
        addOption();
        var spdalist ='${spdalist}';
        var show= localStorage.getItem("showSpdivGj");//用户最后一次选择展示还是不展示包装物选择
        if(show=="true"){
            $("#xsdiv").removeClass("am-u-sm-12 am-u-md-12").addClass("am-u-sm-6 am-u-md-6");
            $("#spdadiv").addClass("am-u-sm-6 am-u-md-6");
            $("#spdadiv").show();
            $("#morespda").removeClass("am-icon-chevron-left").addClass("am-icon-chevron-right");
        }
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

        //关闭还原遮罩蒙板z-index
        $('#newCSdiv').on('closed.modal.amui', function() {
            $('.am-dimmer').css("z-index","1100");
        });

    });

    //加载拨出仓库编码和拨入单位编码
    function addOption() {
        //拨出仓库(900001)
        var bcckbm = "<%=f_brcdmrck %>";
        $.ajax({
            url: "/packing/getBcckmc",
            type: "post",
            async: false,
            data: {bcckbm:bcckbm, timeer: new Date() },
            success: function (data) {
                var bcckmc = data;
                var bcckHtml = "<option value='"+bcckbm+"'>"+bcckmc+"</option>";
                $("#bcckbm").html(bcckHtml);
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


        //拨入单位(901001)
        var bcdwbm = "<%=f_bcdmrbrdw %>";
        $.ajax({
            url: "/packing/getBrdw",
            type: "post",
            async: false,
            data: { bcdwbm:bcdwbm,timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                brdwbmJson = dataJson;
                var brdwHtml = "";
                for (var i = 0; i < dataJson.length; i++){
                    var brdwxx = dataJson[i];
                    brdwHtml += "<option value='"+brdwxx.F_BMBM+"'>"+brdwxx.F_BMMC+"</option>";
                }
                $("#brdwbm").html(brdwHtml);
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

        searchSpda();
    }


    //保存单据
    function savebill(){
        var bcckbm=$('#bcckbm').val();
        var brdwbm=$('#brdwbm').val();
        if(bcckbm===undefined|| bcckbm.length<0){
            alertMsg('请选择拨出仓库！');
            return;
        }
        if(brdwbm===undefined|| brdwbm.length<0){
            alertMsg('请选择拨入单位！');
            return;
        }
        var spcount=$('#hjpz').text();
        if(spcount<=0){
            alertMsg('请选择包装物后再提交');
            return;
        }
        var $table=$('#sptable');
        var spxx= "";
        var kong=false;//包装物单价为空!;
        $table.find('tr').each(function () {
            var sptm=$(this).attr('sptm');
            var spdj=$(this).find('td:eq(3)').text();
            if(spdj.length<=0){
                kong=true;
            }
            var gjsl=  $(this).find('td:eq(2)').children("input:first-child").val();
            if(gjsl == "" || gjsl <= 0){
                alertMsg('包装物数量不能为空或小于0！');
                return;
            }
            var sp="{\"sptm\":\""+sptm+"\",\"gjdj\":\""+spdj+"\",\"gjsl\":\""+gjsl+"\"}";
            if(spxx==""){
                spxx="["+sp;
            }else{
                spxx= spxx+","+sp;
            }
        })
        if(kong){
            alertMsg("包装物单价不能为空!");
            return;
        }
        var spxx =spxx+"]";
        setTimeout(function(){
            $.ajax({
                url: "/packing/bzwbcdBill",
                type: "post",
                async: false,
                data: {bcckbm:bcckbm,brdwbm:brdwbm,spxx:spxx,timeer: new Date() },
                success: function (data) {
                    if(data=="ok"){
                        alertMsg("保存成功！");
                        clearpage();
                    }else if (data == "410"){
                        alertMsg("库存不足！");
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
        $('#f_djbz').val('');
    }
    //判断table是否已经含有此商品
    function checksp1(spbm){
        var result=false;
        $("#sptable").find('tr').each(function () {
            if($(this).attr("sptm")==spbm)  {
                var  inp = $(this).find('td:eq(2)').children("input:first-child");
                var sl=eval(inp.val())+1;
                inp.val(sl);resum_row(inp);
                result=true;
                return false; //结束循环
            }
        })
        return result;
    }
    //包装物档案选择界面 选择包装物事件
    function spimgclick(evnet){
        var spjson=$(evnet).children("span:last-child").text();
        spjson=JSON.parse(spjson);
        var flag=checksp1(spjson.spbm);
        //var flag=false;//要求第二次点选不删除已选择包装物
        var spcount=0;
        if(!flag){//如果不包含此包装物
            var rowhtml="<tr sptm='"+spjson.spbm+"' kcsl='"+spjson.kcsl+"' sl='"+spjson.sl+"'>"
                +"<td class=\"am-text-left am-td-spmc\" style='width:28%;' title='"+spjson.spmc+"'>"+spjson.spmc+"</td>"
                +"<td class=\"am-text-left\" style='width:16%;'>"+spjson.ggxh+"</td>"
                +"<td class=\"am-text-left\" onmouseover=\"GetFocus(this)\" style='width:17%;'><input type=\"number\" value=\"1\" onblur=\"resum_row(this)\" style='width:50px;text-align:right;border:none;' />"+spjson.jldw+"</td>"
                +"<td class=\"am-text-right\" onmouseover=\"GetFocus(this)\" style='width:14%;'>"+spjson.spdj.toFixed(2)+"</td>"
                +"<td class=\"am-text-right\" style='width:14%;'>"+spjson.spdj.toFixed(2)+"</td>"
                +"<td class=\"am-text-middle\" style='width:11%;'><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
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
                    "   <td class=\"am-text-middle\" colspan=\"6\">选择包装物</td>\n" +
                    "   </tr>";
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
    function searchSpda(){
        var spxx=$('#spoption').val();
        $.ajax({
            url: "/packing/packingGoods",
            type: "post",
            async: false,
            data: {spxx:spxx,f_brdwbm:$('#bcckbm').val(), timeer: new Date() },
            success: function (data) {
                var spdalist = JSON.parse(data);
                var $spul=$('#spdadiv ul');//商品档案展示ul
                if(spdalist.length>0) {
                    var spdahtml="";
                    for(var i=0;i<spdalist.length;i++){
                        var spda=spdalist[i];
                        spdahtml+="<li>\n" +
                            "      <div class=\"am-gallery-item\">\n" +
                            "      <img src=\""+spda.F_SPTP+"\"  alt=\""+spda.F_SPMC+"\" style='height: 150px;'/>\n" +
                            "      <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                            "      <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                            "      <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                            "      <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"kcsl\":"+spda.F_KCSL+",\"sl\":"+spda.F_SL+",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\"}</span>\n" +
                            "      </div>\n" +
                            "</li>"

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
    //重新计算界面包装物选择品种
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
        var tr=$table.find('tr:eq(' + (rowNum) + ')');
        var spdj=tr.find('td:eq(3)').text();
        var inp=tr.find('td:eq(2)').children("input:first-child");
        var xssl=inp.val();
        var kc=tr.attr('kcsl');

        if(eval(xssl)<0&&eval(kc)+eval(xssl)<0) {
            alert(tr.find('td:eq(0)').html()+"损耗数量不能大于库存数量！");
            return false;
        }
        var result=eval(spdj)*eval(xssl);
        tr.find('td:eq(4)').text(result.toFixed(2));
        $('#hjje').text(resum_hjje());
    }
    //计算总合计金额
    function resum_hjje() {
        var $table=$('#sptable');
        var hjje=0;
        $table.find('tr').each(function () {
            var spdj=  $(this).find('td:eq(3)').text();
            var xssl=$(this).find('td:eq(2)').children("input:first-child").val();
            var rowhj=0;
            if(spdj===undefined){
                rowhj=0;
            }else{
                rowhj=eval(spdj)*eval(xssl);
            }
            hjje+=rowhj;
        });
        return hjje.toFixed(2);
    }
    //显示/影藏包装物选择界面
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
    //判断table是否已经含有此包装物
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
        $('#brdwbm').val('');
        var brdwHtml = "";
        for (var i = 0; i < brdwbmJson.length; i++){
            var brdwxx = brdwbmJson[i];
            brdwHtml += "<option value='"+brdwxx.F_BMBM+"'>"+brdwxx.F_BMMC+"</option>";
        }
        $("#brdwbm").html(brdwHtml);
        var tshtml="<tr id=\"tishitr\">\n" +
            "                        <td class=\"am-text-middle\" colspan=\"6\">选择包装物</td>\n" +
            "                    </tr>";
        $('#sptable').html(tshtml);
        $('#hjpz').text('0');
        $('#hjje').text("0.00");
        $('#jsje').text("0.00");
        $('#f_djbz').val('');
        $('#sphj').text('0');
        $('#ssje').val("0.00");
        $('#zlje').text("0.00");

    };
    //判断spdadiv是否已经含有此包装物
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
