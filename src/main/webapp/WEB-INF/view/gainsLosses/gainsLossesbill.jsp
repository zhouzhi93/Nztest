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
    String f_qyck=(String)session.getAttribute("f_qyck");
%>
<%--<!DOCTYPE html>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-损溢单</title>
    <meta name="description" content="云平台客户端V1-损溢单">
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
        .sptable{display:block;
            height:150px;
            overflow-y:scroll;}

        #bbs{border-collapse: collapse;}
        #bbs table thead,#bbs tbody tr {
            display:table;
            width:100%;
            table-layout:fixed;
        }

        #bbs table th{border-width:1px;}
        #bbs table thead{background:#EdEdEd;}
        #bbs table td {text-overflow:ellipsis; white-space:nowrap; overflow:hidden;}

    </style>
</head>
<body>
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-12" id="xsdiv" style="padding:0;margin:0;">
            <div class="header am-g"><h1>损&nbsp;&nbsp;益&nbsp;&nbsp;单</h1></div>
            <div class="am-container">
                <div class="am-u-sm-5 am-u-md-5">部门：<select data-am-selected="{btnSize: 'sm'}" id="bmbm"></select></div>
                <div class="am-u-sm-5 am-u-md-5">
                    <div id="ckmcDiv">

                    </div>
                </div>
                <div class="am-u-sm-2 am-u-md-2"><span class="am-fr" style="vertical-align: middle;">日期：<%=str%></span></div>
            </div>
            <div class="am-container" style="margin-top: 10px;height:320px;overflow:scroll;overflow-x:hidden;" id="bbs">
                <table class="am-table am-table-bordered am-table-centered">
                    <thead id="sptableTitle">

                    </thead>
                    <tbody id="sptable">

                    </tbody>
                </table>
            </div>
            <div class="am-container">
                <div class="am-u-sm-6 am-u-md-6"><div class="am-cf">共<span onclick="resum_hjje()" id="hjpz" style="color: #E72A33;">0</span>种商品</div></div>
                <div class="am-u-sm-6 am-u-md-6"><div class="am-fr">合计：<span id="hjje" style="color: #E72A33;">0.00</span> 元</div></div>
            </div>
                <div class="am-container" style="text-align:right;margin-top:20px;padding-right:20px;">
                    <input style="vertical-align:middle;" id="f_sfdyxp" type="checkbox"/><span style="font-size: 13px;vertical-align:middle;">保存后立即打印小票</span>
                    <button type="submit" id="subbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>
                </div>
        </div>
        <!--商品档案选择-->
        <div style="padding-top: 20px;display:none;height: 600px;" id="spdadiv" class="am-scrollable-vertical">
            <div class="am-fr">
                您已经选择了<span id="sphj" style="color: #E72A33;">0</span>种商品<input class="am-radius am-form-field am-input-sm" id="spoption" style="width: 240px;display:initial;" type="text" placeholder="">
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
            <div id="title_div">损益单</div>
            <div id="infol_div">
                <table width='100%' id="infol_tb">
                    <tr><th>日&#12288;&#12288;期:</th><td><%=str%></td><th>单&nbsp;据&nbsp;号:</th><td><text id="prt_djh"></text></td>
                    </tr>
                    <%--<tr><th>进货部门:</th><td><text id="prt_djh"></text></td>--%>
                    <%--<th>入库仓库:</th><td> 0101仓库</td></tr>--%>
                    <tr><th>部门名称:</th><td><text id="prt_gys"></text></td>
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
        var djlx='0';
        var djh='';
        var ckxxJson = null;
        var qyck = <%=f_qyck%>;

        window.onload = function(){
            var tableCont = document.querySelector('#bbs')
            function scrollHandle (e){
                console.log(this)
                var scrollTop = this.scrollTop;
                this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
            }
            tableCont.addEventListener('scroll',scrollHandle)
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
        function addOption() {
            var depts='${bmdalist}'.split(";");
            var s=depts.length;
            var obj=$('#bmbm');
            obj.bind('change',function(){
                searchSpda();
            });
            var j=0,k=0;
            for(var i=0;i<s;i++) {
                j=depts[i].indexOf(",");
                if(j<1)continue;
                obj[0].options[k++]=new Option(depts[i].substr(j+1),depts[i].substr(0,j));
            }
            //if(k==1) obj.parent().hide();
            //searchSpda();
        }

        $(function(){
            loadCkcs();
            addOption();
            $('#subbtn').click(function(){
                savebill();
            });

            var spdalist ='${spdalist}';
            if(spdalist.length==0){
                console.log('暂无商品信息');
            }else {
                var $spul=$('#spdadiv ul');//商品档案展示ul
                spdalist=JSON.parse(spdalist);
                var spdahtml="";
                for(var i=0;i<spdalist.length;i++){
                    var spda=spdalist[i];
                    spdahtml+="<li>\n" +
                        "                        <div class=\"am-gallery-item\">\n" +
                        "                                <img src=\""+spda.F_SPTP+"\"  alt=\""+spda.F_SPMC+"\" style='height: 150px;'/>\n" +
                        "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                        "                            <div class=\"am-gallery-desc\">成本价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                        "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                        "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"kcsl\":"+spda.F_KCSL+",\"sl\":"+spda.F_SL+",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\"}</span>\n" +
                        "                        </div>\n" +
                        "                    </li>"
                }
                $spul.append(spdahtml);
            }
            var show= localStorage.getItem("showSpdiv");//用户最后一次选择展示还是不展示商品选择
            spdadivshow();
            $('.am-gallery-item').click(function () {
                spimgclick(this);
            });
            //显示选择客户
            $('#khxx').click(function () {
                $('#chooseKhdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:500
                });
                $('#chooseKhdiv').modal('open');
            });

            $("#f_ckbm").change(function (){
                if ($('#sptable').find('tr').find('td').length <= 1){
                    //如果商品数量小于1，弹窗
                    alertMsg("请先选择商品！");
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
        });

        //商品档案选择界面 选择商品事件
        function spimgclick(evnet){
            var spjson=$(evnet).children("span:last-child").text();
            spjson=JSON.parse(spjson);
            var flag=checksp(spjson.spbm);
            var spcount=0;
            if(!flag){//如果不包含此商品
                if (qyck == 0){
                    var rowhtml="<tr sptm='"+spjson.spbm+"' kcsl='"+spjson.kcsl+"' sl='"+spjson.sl+"'>"
                        +"<td class=\"am-text-middle am-td-spmc\" title='"+spjson.spmc+"' style='width: 24%'>"+spjson.spmc+"</td>"
                        +"<td class=\"am-text-middle\">"+spjson.ggxh+"</td>"
                        +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" value=\"1\" onblur=\"resum_row(this)\" style='width:50px;text-align:right;border:none;' />"+spjson.jldw+"</td>"
                        +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\">"+spjson.spdj.toFixed(2)+"</td>"
                        +"<td class=\"am-text-middle\">"+spjson.spdj.toFixed(2)+"</td>"
                        +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                        +"</tr>";
                    $('#sptable').prepend(rowhtml);
                }else if (qyck == 1){
                    var rowhtml="<tr sptm='"+spjson.spbm+"' kcsl='"+spjson.kcsl+"' sl='"+spjson.sl+"'>"
                        +"<td class=\"am-text-middle am-td-spmc\" title='"+spjson.spmc+"' style='width: 24%'>"+spjson.spmc+"</td>"
                        +"<td class=\"am-text-middle\">"+spjson.ggxh+"</td>"
                        +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" value=\"1\" onblur=\"resum_row(this)\" style='width:50px;text-align:right;border:none;' />"+spjson.jldw+"</td>"
                        +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\">"+spjson.spdj.toFixed(2)+"</td>"
                        +"<td class=\"am-text-middle\">"+spjson.spdj.toFixed(2)+"</td>"
                        +"<td class=\"am-text-middle\" style='padding: 0;width: 17%;'>"
                        +"  <select class='ddckbm' data-am-selected=\"{btnWidth: '100%',btnSize: 'sm',maxHeight:'100px',}\" style='width: 100%;height:43px;border: 0px;text-align: center;'>"
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
                }

                if($("#tishitr")!=undefined) {//删除请选择 提示行
                    $("#tishitr").remove();
                };
                spcount=$("#sptable").find('tr').length;
                $(this).addClass("am-gallery-item-boder");

                $('#hjpz').text(spcount);
                $('#sphj').text(spcount);
                $('#hjje').text(resum_hjje());

                //if(spcount==1)setWidth(1);
            }else if($("#sptable").find('tr').length==0){
                    var tshtml="<tr id=\"tishitr\">\n" +
                        "                        <td class=\"am-text-middle\" colspan=\"6\">选择需要的商品</td>\n" +
                        "                    </tr>";
                    $('#sptable').prepend(tshtml);
                    $('#hjpz').text(rowcount);
                    $('#hjje').text("0.00");
            } else {
                var rowcount=$("#sptable").find('tr').length;
                $(this).removeClass("am-gallery-item-boder");
                $('#hjje').text(resum_hjje());
                $('#hjpz').text(rowcount);
                $('#sphj').text(rowcount);
            }
        };

        function searchSpda(){
            var spxx=$('#spoption').val();
            $.ajax({
                url: "/gainsLosses/GetSpda",type: "post",async: false,
                data: {spxx:spxx,f_bmbm:$('#bmbm').val(), timeer: new Date() },
                success: function (data) {
                    var spdalist = JSON.parse(data);
                    if(spdalist.length>0) {
                        var $spul=$('#spdadiv ul');//商品档案展示ul
                        var spdahtml="";
                        for(var i=0;i<spdalist.length;i++){
                            var spda=spdalist[i];

                                spdahtml+="<li>\n" +
                                    "                        <div class=\"am-gallery-item\">\n" +
                                    "                                <img src=\""+spda.F_SPTP+"\"  alt=\""+spda.F_SPMC+"\" style='height: 150px;'/>\n" +
                                    "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                                    "                            <div class=\"am-gallery-desc\">成本价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                                    "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                                    "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"kcsl\":"+spda.F_KCSL+",\"sl\":"+spda.F_SL+",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\"}</span>\n" +
                                    "                        </div>\n" +
                                    "                    </li>"

                        }
                        $spul.html(spdahtml);//.am-gallery-item
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
            $('#hjje').text(resum_hjje());
            $('#hjpz').text(spcount);
            $('#sphj').text(spcount);
        }
        //鼠标进入td 激活input
        function GetFocus(event){
            //$(event).children("input:first-child").focus();
        }
        function savebill(){
            var table=$('#sptable');
            var trs=table.find('tr');
            var s=trs.length;
            var xssl=0,kc=0,je=0,sj=0,sl=0,dj=0;
            var ckbm = '';
            var str='',row=null,tr=null;
            var zdrq = str.replace("-","");
            //0f_ckbm,1f_sptm,2f_ypzjh,3f_jldwlx,4f_sysl,5f_sydj,6f_syje,7f_sysj,8f_sl,9f_lsdj,10f_lsje,11f_syyybm,12f_js,13f_splx,14f_zhjj,15f_sgpch
            var ok=true;
            var prtspHmtl="";

            var f_ckbm = "";
            if (qyck == 1){
                var cksl = trs.find("select");
                for (var i = 0;i < cksl.length; i++){
                    f_ckbm = cksl.eq(i).val();
                    if (f_ckbm == null || f_ckbm == "" || f_ckbm == undefined){
                        alertMsg('请选择仓库');
                        return;
                    }
                }
            }

            for(var i=0; i<s; i++) {
                tr=trs.eq(i);
                xssl=tr.find('td:eq(2)').children("input:first-child").val();
                ckbm=tr.find('td:eq(5)').children("select:first-child").val();
                kc=tr.attr('kcsl');
                if(eval(xssl)<0&&eval(kc)+eval(xssl)<0) {
                    alertMsg(tr.find('td:eq(0)').html()+"损耗数量不能大于库存数量("+kc+")！");
                    //tr.find('td:eq(2)').children("input:first-child").select().focus();
                    ok= false;
                    break;
                }
                je=tr.find('td:eq(4)').text();
                sl = eval(tr.attr('sl'));
                if(sl==0)sj=0;
                else sj=(je*sl/(100+sl)).toFixed(2);
                dj=tr.find('td:eq(3)').text();
                //sptm='"+spjson.spbm+"' kcsl='"+spjson.kcsl+"' sl='"+spjson.sl+"'
                row=ckbm+','+tr.attr('sptm')+',,0,';//ckbm,sptm,ypzjh,jldwlx
                row+=xssl+','+dj+','+je+','+sj+','+sl+',';//sysl,sydj,syje,sysj,sl,
                row+=dj+','+je+',,'+xssl+',0,'+dj;//lsdj,lsje,syybm,js,splx,zhjj
                if(str!='')str+=';';
                str+=row;
                var spmc=tr.find('td:eq(0)').text();
                var ggxh=tr.find('td:eq(1)').text();
                prtspHmtl+="<tr>\n" +
                    "                        <td><div noWrap style=\"text-align:left;width:260px;text-overflow:ellipsis;overflow:hidden;\">"+spmc+"</div></td>\n" +
                    "                        <td class=\"td_number\">"+ggxh+"</td>\n" +
                    "                        <td class=\"td_number\">"+xssl+"</td>\n" +
                    "                        <td class=\"td_number\">"+dj+"</td>\n" +
                    "                        <td class=\"td_number\">"+je+"</td>\n" +
                    "                    </tr>"
            }
            if(!ok)return false;
            $.ajax({//f_djlx,f_djh,f_zdrq,sub,spxx
                url: "/gainsLosses/gainsSave", type: "post",async: false,
                data: {f_bmbm:$('#bmbm').val(),f_djlx : djlx,f_djh: '',f_zdrq:zdrq, spxx: str, sub : 1, timeer: new Date()},
                success: function (data) {
                    var i=data.indexOf("单据号:");
                    if(i!=-1) {
                        djh=data.substring(i+4);
                        data=data.substring(0,i);
                    }
                    alertMsg(data);
                    if(data.indexOf('成功')!=-1) {
                        $('#prt_djh').text(djh);
                        $('#prt_sp').html(prtspHmtl);
                        $('#prt_gys').text($('#bmbm').val());
                        $('#prt_hjje').text($('#hjje').text());
                        var sfdyxp=$('#f_sfdyxp').attr('checked');
                        if(sfdyxp=="checked"){
                            $('#okbtn').click(function () {
                                $('#alertdlg').modal('close');
                                $('.am-dimmer.am-active').hide();
                                $(this).unbind("click");
                                printBill();
                            })
                        }
                        //location.reload();
                        clearpage();
                    }else{

                    }

                }
            });
        };

        //清除界面值
        function clearpage(){
            var tshtml="<tr id=\"tishitr\">\n" +
                "                        <td class=\"am-text-middle\" colspan=\"6\">选择需要损益的商品</td>\n" +
                "                    </tr>";
            $('#sptable').html(tshtml);
            $('#hjpz').text('0');
            $('#hjje').text("0.00");
            $('#jsje').text("0.00");
            $('#hjje').text('0.00');
            $('#hjpz').text('0');
            $('#f_djbz').val('');
            $('#sphj').text('0');
            $('#ssje').val("0.00");
            $('#zlje').text("0.00");

        };
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
                alertMsg(tr.find('td:eq(0)').html()+"损耗数量不能大于库存数量！");
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
        //显示/影藏商品选择界面
        function spdadivshow() {
            var k=2;
            if($("#spdadiv").is(":hidden")){
                $("#xsdiv").removeClass("am-u-sm-12 am-u-md-12").addClass("am-u-sm-6 am-u-md-6");
                $("#spdadiv").addClass("am-u-sm-6 am-u-md-6");
                $("#spdadiv").show();
                $("#morespda").removeClass("am-icon-chevron-left").addClass("am-icon-chevron-right");
                localStorage.setItem("showSpdiv", "true");
            }else{k=3;
                $("#spdadiv").hide();
                $("#xsdiv").removeClass("am-u-sm-6 am-u-md-6").addClass("am-u-sm-12 am-u-md-12");
                $("#morespda").removeClass("am-icon-chevron-right").addClass("am-icon-chevron-left");
                localStorage.setItem("showSpdiv", "false");
            }
            //setwidth(k);
        }
        /*function setwidth(k){
            var ftr=$('#bbs').find('thead th');
            var btrs=$('#bbs').find('tbody tr');
            if(k==1){
                if(btrs.length==0)return;
                var btr=trs.eq(0).find('td');
                var s=ftr.length;
                var w=0,ws=0;
                for(var i=0; i<s; i++) {
                    w=btr.eq(i).css('width');
                    ws+=eval(w.replace('px','').replace('pt',''));
                    btrs.find('td:eq(i)').css('width',w).width(w);
                    //ftr.eq(i).css('width',w);
                }
                //$('#bbs').find('table').width(ws).css('width',ws);
            } else {
                var sub=80;
                var ws=document.body.clientWidth-80;
                if(k==2)ws=(ws-ws%2)/2;
                $('#bbs').find('table').width(ws).css('width',ws);
            }

        }*/
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
            var sptableTitleHtml = "";
            var sptableHtml = "";
            if (qyck == 1){
                ckHtml += "     <label for=\"f_ckbm\" style=\"font-size: 16px;\">仓库名称：</label> \n" +
                    "           <select id=\"f_ckbm\" data-am-selected=\"{btnWidth: '40%',btnSize: 'sm'}\" style='width: 40%;border: 1px solid #ddd;padding: 7px;font-size: 1.4rem;color: #444;'>" +
                    "           </select>";
                $("#ckmcDiv").html(ckHtml);
                loadCkxx();

                sptableTitleHtml += "   <tr>"+
                    "                       <th class=\"am-text-middle\" style='width: 24%;'>商品名称</th>"+
                    "                       <th class=\"am-text-middle\">规格</th>"+
                    "                       <th class=\"am-text-middle\">数量</th>"+
                    "                       <th class=\"am-text-middle\">单价</th>"+
                    "                       <th class=\"am-text-middle\">金额</th>"+
                    "                       <th class=\"am-text-middle\" style='width: 17%;'>仓库</th>"+
                    "                       <th class=\"am-text-middle\">操作</th>"+
                    "                   </tr>";

                sptableHtml += "<tr id=\"tishitr\">"+
                    "               <td class=\"am-text-middle\" colspan=\"7\">选择需要的商品</td>"+
                    "           </tr>";
                $("#sptableTitle").html(sptableTitleHtml);
                $("#sptable").html(sptableHtml);
            }else {
                sptableTitleHtml += "   <tr>"+
                    "                       <th class=\"am-text-middle\" style='width: 24%;'>商品名称</th>"+
                    "                       <th class=\"am-text-middle\">规格</th>"+
                    "                       <th class=\"am-text-middle\">数量</th>"+
                    "                       <th class=\"am-text-middle\">单价</th>"+
                    "                       <th class=\"am-text-middle\">金额</th>"+
                    "                       <th class=\"am-text-middle\">操作</th>"+
                    "                   </tr>";

                sptableHtml += "<tr id=\"tishitr\">"+
                    "               <td class=\"am-text-middle\" colspan=\"6\">选择需要的商品</td>"+
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
