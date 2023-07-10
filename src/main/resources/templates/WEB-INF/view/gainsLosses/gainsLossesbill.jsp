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
            <div class="am-container am-">
                <div class="am-u-sm-6 am-u-md-6"><span class="am-fr">制单日期：<%=str%></span></div>
            <div class="am-container" style="margin-top: 20px;height:320px;overflow:scroll;overflow-x:hidden;" id="bbs">
                <table class="am-table am-table-bordered am-table-centered">
                    <thead><tr>
                        <th class="am-text-middle" style="width:28%">商品名称</th><th class="am-text-middle" style="width:16%">规格</th>
                        <th class="am-text-middle" style="width:16%">数量</th><th class="am-text-middle" style="width:14%">单价</th>
                        <th class="am-text-middle" style="width:14%">金额</th><th class="am-text-middle" style="width:12%">操作</th>
                    </tr>
                    </thead>
                    <tbody id="sptable"></tbody>
                    <tfoot><tr id="tishitr"><td class="am-text-middle" colspan="6">选择需要的商品</td></tr></tfoot>
                </table>
            </div>
            <div class="am-container">
                <div class="am-u-sm-6 am-u-md-6"><div class="am-cf">共<span onclick="resum_hjje()" id="hjpz" style="color: #E72A33;">0</span>种商品</div></div>
                <div class="am-u-sm-6 am-u-md-6"><div class="am-fr">合计：<span id="hjje" style="color: #E72A33;">0.00</span> 元</div></div>
            </div>
                <div class="am-container" style="text-align:right;margin-top:20px;padding-right:20px;">
                    <button type="submit" id="subbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>
                </div>
            </div>
        </div>
        <!--商品档案选择-->
        <div style="padding-top: 20px;display:none;" id="spdadiv">
            <div class="am-fr">
                您已经选择了<span id="sphj" style="color: #E72A33;">0</span>种商品<input class="am-radius am-form-field am-input-sm" id="spoption" style="width: 240px;display:initial;" type="text" placeholder="">
                <button type="button" onclick="searchSpda()" class="am-btn am-btn-default am-radius am-btn-sm">搜索</button>
            </div>
            <div class="am-g" style="margin-top: 20px;">
                <ul data-am-widget="gallery" class="am-gallery am-avg-sm-3 am-avg-md-3 am-avg-lg-4 am-gallery-default" data-am-gallery="{ pureview: false }">
                    <%--<li>--%>
                        <%--<div class="am-gallery-item">--%>
                                <%--<img src="/images/default.png"  alt="远方 有一个地方 那里种有我们的梦想"/>--%>
                                <%--<div class="am-gallery-desc">规格：10KG/袋</div>--%>
                            <%--<div class="am-gallery-desc">售价：<span style="color:red;font-size: 1.5rem;">11.00元</span></div>--%>
                            <%--<div class="am-text-sm">我还是很喜欢你，像风走了八千里</div>--%>
                            <%--<span style="display: none">{"spbm":"010101","spmc": "我还是很喜欢你，像风走了八千里，不问归期","spdj": 11.00,"ggxh": "袋","jldw": "元/kg"}</span>--%>
                        <%--</div>--%>
                    <%--</li>--%>
                </ul>
            </div>
        </div>
    </div>
    <!-- 按钮触发器， 需要指定 target -->
    <i class="am-icon-chevron-left" style="position: fixed;right: 0px;top: 50%;" id="morespda" onclick="spdadivshow()"></i>

    <script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
    <script src="/assets/js/amazeui.min.js"></script>
    <script src="/assets/js/app.js"></script>
    <script src="/assets/address/address.min.js"></script>
    <script src="/assets/address/iscroll.min.js"></script>
    <script type="text/javascript">
        var djlx='0';
        var djh='';

        window.onload = function(){
            var tableCont = document.querySelector('#bbs')
            function scrollHandle (e){
                console.log(this)
                var scrollTop = this.scrollTop;
                this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
            }
            tableCont.addEventListener('scroll',scrollHandle)
        }

        $(function(){
            $('#subbtn').click(function(){savebill();});
            var spdalist ='${spdalist}';
            if(spdalist.length==0){
                console.log('暂无商品信息');
            }else {
                var $spul=$('#spdadiv ul');//商品档案展示ul
                spdalist=JSON.parse(spdalist);
                var spdahtml="";
                for(var i=0;i<spdalist.length;i++){
                    var spda=spdalist[i];
                    /*if(spdahtml==""){
                        spdahtml="<li>\n" +
                            "                        <div class=\"am-gallery-item\">\n" +
                            "                                <img src=\"/images/default.png\"  alt=\""+spda.F_SPMC+"\"/>\n" +
                            "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                            "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                            "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                            "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\"}</span>\n" +
                            "                        </div>\n" +
                            "                    </li>"
                    }else{*/
                        spdahtml+="<li>\n" +
                            "                        <div class=\"am-gallery-item\">\n" +
                            "                                <img src=\"/images/default.png\"  alt=\""+spda.F_SPMC+"\"/>\n" +
                            "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                            "                            <div class=\"am-gallery-desc\">成本价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                            "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                            "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"kcsl\":"+spda.F_KCSL+",\"sl\":"+spda.F_SL+",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\"}</span>\n" +
                            "                        </div>\n" +
                            "                    </li>"
                    //}
                }
                $spul.append(spdahtml);
            }
            var show= localStorage.getItem("showSpdiv");//用户最后一次选择展示还是不展示商品选择
            /*if(show=="true"){
                $("#xsdiv").removeClass("am-u-sm-12 am-u-md-12").addClass("am-u-sm-6 am-u-md-6");
                $("#spdadiv").addClass("am-u-sm-6 am-u-md-6");
                $("#spdadiv").show();
                $("#morespda").removeClass("am-icon-chevron-left").addClass("am-icon-chevron-right");
            }*/
            spdadivshow();
            $('.am-gallery-item').click(function () {
                spimgclick(this);
            });
        });
        //商品档案选择界面 选择商品事件
        function spimgclick(evnet){
            var spjson=$(evnet).children("span:last-child").text();
            spjson=JSON.parse(spjson);
            var flag=checksp(spjson.spbm);
            var spcount=0;
            if(!flag){//如果不包含此商品
                var rowhtml="<tr sptm='"+spjson.spbm+"' kcsl='"+spjson.kcsl+"' sl='"+spjson.sl+"'>"
                    +"<td class=\"am-text-left am-td-spmc\" style='width:28%;' title='"+spjson.spmc+"'>"+spjson.spmc+"</td>"
                    +"<td class=\"am-text-left\" style='width:16%;'>"+spjson.ggxh+"</td>"
                    +"<td class=\"am-text-left\" onmouseover=\"GetFocus(this)\" style='width:16%;'><input type=\"number\" value=\"1\" onblur=\"resum_row(this)\" style='width:40px;text-align:right;border:none;' />"+spjson.jldw+"</td>"
                    +"<td class=\"am-text-right\" onmouseover=\"GetFocus(this)\" style='width:14%;'>"+spjson.spdj.toFixed(2)+"</td>"
                    +"<td class=\"am-text-right\" style='width:14%;'>"+spjson.spdj.toFixed(2)+"</td>"
                    +"<td class=\"am-text-middle\" style='width:12%;'><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                    +"</tr>";
                $('#sptable').prepend(rowhtml);
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
                url: "/gainsLosses/GetSpda",
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

                                spdahtml+="<li>\n" +
                                    "                        <div class=\"am-gallery-item\">\n" +
                                    "                                <img src=\"/images/default.png\"  alt=\""+spda.F_SPMC+"\"/>\n" +
                                    "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                                    "                            <div class=\"am-gallery-desc\">成本价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                                    "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                                    "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"kcsl\":"+spda.F_KCSL+",\"sl\":"+spda.F_SL+",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\"}</span>\n" +
                                    "                        </div>\n" +
                                    "                    </li>"

                        }
                        $spul.html(spdahtml);
                        $('#spdadiv .am-gallery-item').click(function () {
                            spimgclick(this);
                        });
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
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
            var str='',row=null,tr=null;
            var zdrq = str.replace("-","");
            //0f_ckbm,1f_sptm,2f_ypzjh,3f_jldwlx,4f_sysl,5f_sydj,6f_syje,7f_sysj,8f_sl,9f_lsdj,10f_lsje,11f_syyybm,12f_js,13f_splx,14f_zhjj,15f_sgpch
            for(var i=0; i<s; i++) {
                tr=trs.eq(i);
                xssl=tr.find('td:eq(2)').children("input:first-child").val();
                kc=tr.attr('kcsl');
                if(eval(xssl)<0&&eval(kc)+eval(xssl)<0) {
                    alert(tr.find('td:eq(0)').text+"损耗数量不能大于库存数量("+kc+")！");
                    tr.find('td:eq(2)').children("input:first-child").select().focus();
                    return false;
                }
                je=tr.find('td:eq(4)').text();
                sl = eval(tr.attr('sl'));
                if(sl==0)sj=0;
                else sj=(je*sl/(100+sl)).toFixed(2);
                dj=tr.find('td:eq(3)').text();
                //sptm='"+spjson.spbm+"' kcsl='"+spjson.kcsl+"' sl='"+spjson.sl+"'
                row=','+tr.attr('sptm')+',,0,';//ckbm,sptm,ypzjh,jldwlx
                row+=xssl+','+dj+','+je+','+sj+','+sl+',';//sysl,sydj,syje,sysj,sl,
                row+=dj+','+je+',,'+xssl+',0,'+dj;//lsdj,lsje,syybm,js,splx,zhjj
                if(str!='')str+=';';
                str+=row;
            }
            $.ajax({//f_djlx,f_djh,f_zdrq,sub,spxx
                url: "/gainsLosses/gainsSave", type: "post",async: false,
                data: {f_djlx : djlx,f_djh: djh,f_zdrq:zdrq, spxx: str, sub : 1, timeer: new Date()},
                success: function (data) {
                    var i=data.indexOf("单据号:");
                    if(i!=-1) {
                        djh=data.substring(i+4);
                        data=data.substring(0,i);
                    }
                    alert(data);
                    if(data.indexOf('成功')!=-1) {
                        /*var tshtml="<tr id='ishitr'>\n" +
                            "                        <td class='am-text-middle' colspan=6>选择需要的商品</td>\n" +
                            "                    </tr>";
                        $('#sptable').html('');
                        $('#tishitr').html(tshtml);
                        $('#hjpz').text('0');
                        $('#hjje').text("0.00");*/
                        location.reload();
                    }
                }
            });
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
                alert("损耗数量不能大于库存数量！");
                //inp.focus();
                //inp.select();
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
    </script>
</body>
</html>
