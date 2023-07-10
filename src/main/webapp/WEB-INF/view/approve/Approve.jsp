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
    <title>云平台客户端V1-商户审核</title>
    <meta name="description" content="云平台客户端V1-商户审核">
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
        #spmxtable input{
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
        thead{background:#EdEdEd;}
        #tabmx td{font-size:1.4rem}
    </style>
</head>
<body>
    <div class="am-g">
            <div class="am-form-inline">
                查询模式:<select data-am-selected id="shzt" style="width:90px">
                    <option value='0' selected>待审核</option>
                    <option value='1'>审核通过</option>
                    <option value='2'>审核未通过</option>
                    <option value='3'>停用</option>
                </select>
                <button onclick="getSpmx($('#shzt').val())" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger" style="margin-left: 10px;background-color: #fff !important;border: 1px solid #e52a33 !important;color: #e52a33 !important;">查询</button>
            </div>
        <div class="am-scrollable-horizontal" style="margin-top: 15px;" id="tabmx">
            <table class="am-table am-table-bordered am-table-striped am-text-nowrap am-table-centered">
                <thead>
                    <tr>
                        <th class="am-text-middle">操作</th>
                        <th class="am-text-middle">商户编码</th>
                        <th class="am-text-middle">商户名称</th>
                        <th class="am-text-middle">地址</th>
                        <th class="am-text-middle">电话</th>
                        <th class="am-text-middle">EMAIL</th>
                    </tr>
                </thead>
                <tbody id="spmxtable"></tbody>
            </table>
        </div>
    </div>

    <!--审批详情-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="spxqDetail">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">商户详情
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd am-scrollable-vertical" style="min-height: 450px;">
                <form class="am-form am-form-horizontal" id="loginform" style="margin-top: 20px;">
                    <div class="am-u-sm-11">
                        <div class="am-form-group" id="div1">
                            <label for="f_shmc" class="am-u-sm-2 am-form-label">商户名称：</label>
                            <div class="am-u-sm-4 gd1" style="border-bottom: 1px solid #DDDDDD;">
                                <input type="hidden" id="f_shbm"/>
                                <label id="f_shmc" class="am-form-label"></label>
                            </div>
                            <label  class="am-u-sm-2 am-form-label">商户类型：</label>
                            <div class="am-u-sm-4 gd2" style="border-bottom: 1px solid #DDDDDD;">
                                <input type="hidden" id="f_shlx"/>
                                <label id="f_shlxmc" class="am-form-label"></label>
                            </div>
                        </div>
                        <div class="am-form-group" id="div2">
                            <label for="f_sjhm" class="am-u-sm-2 am-form-label">手机号：</label>
                            <div class="am-u-sm-4 gd2" style="border-bottom: 1px solid #DDDDDD;">
                                <label id="f_sjhm" class="am-form-label"></label>
                            </div>
                            <label for="f_yzbm" class="am-u-sm-2 am-form-label">邮政编码：</label>
                            <div class="am-u-sm-4 gd2" style="border-bottom: 1px solid #DDDDDD;">
                                <label id="f_yzbm" class="am-form-label"></label>
                            </div>
                        </div>
                        <div class="am-form-group" id="div3">
                            <label for="f_xxdz" class="am-u-sm-2 am-form-label">街道地址：</label>
                            <div class="am-u-sm-4 gd3" style="border-bottom: 1px solid #DDDDDD;">
                                <label id="f_xxdz" class="am-form-label"></label>
                            </div>
                            <label for="f_lxdh" class="am-u-sm-2 am-form-label">联系电话：</label>
                            <div class="am-u-sm-4 gd3" style="border-bottom: 1px solid #DDDDDD;">
                                <label id="f_lxdh" class="am-form-label"></label>
                            </div>
                        </div>
                        <div class="am-form-group" id="div4">
                            <label for="f_jyxkzh" class="am-u-sm-2 am-form-label">农药经营许可证号：</label>
                            <div class="am-u-sm-4 gd4" style="border-bottom: 1px solid #DDDDDD;">
                                <label id="f_jyxkzh" class="am-form-label"></label>
                            </div>
                            <label for="f_email" class="am-u-sm-2 am-form-label">EMAIL：</label>
                            <div class="am-u-sm-4 gd4" style="border-bottom: 1px solid #DDDDDD;">
                                <label id="f_email" class="am-form-label"></label>
                            </div>
                        </div>
                        <div class="am-form-group" id="div5">
                            <label for="f_khh" class="am-u-sm-2 am-form-label">开户行：</label>
                            <div class="am-u-sm-4 gd5" style="border-bottom: 1px solid #DDDDDD;">
                                <label id="f_khh" class="am-form-label"></label>
                            </div>
                            <label for="f_khzh" class="am-u-sm-2 am-form-label">开户帐号：</label>
                            <div class="am-u-sm-4 gd5" style="border-bottom: 1px solid #DDDDDD;">
                                <label id="f_khzh" class="am-form-label"></label>
                            </div>
                        </div>
                        <div class="am-form-group" id="div6">
                            <label for="f_sh" class="am-u-sm-2 am-form-label">税号：</label>
                            <div class="am-u-sm-4 gd6" style="border-bottom: 1px solid #DDDDDD;">
                                <label id="f_sh" class="am-form-label"></label>
                            </div>
                            <label for="f_fr" class="am-u-sm-2 am-form-label">法人：</label>
                            <div class="am-u-sm-4 gd6" style="border-bottom: 1px solid #DDDDDD;">
                                <label id="f_fr" class="am-form-label"></label>
                            </div>
                        </div>
                        <div class="am-form-group" id="div7">
                            <label for="f_zczb" class="am-u-sm-2 am-form-label">注册资本：</label>
                            <div class="am-u-sm-4 gd7" style="border-bottom: 1px solid #DDDDDD;">
                                <label id="f_zczb" class="am-form-label">测试</label>
                            </div>
                            <label  class="am-u-sm-2 am-form-label">是否连锁：</label>
                            <div class="am-u-sm-4 gd7" style="border-bottom: 1px solid #DDDDDD;">
                                <label id="f_sfls" class="am-form-label">测试</label>
                            </div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_yy" class="am-u-sm-2 am-form-label">失败原因</label>
                            <div class="am-u-sm-10">
                                <textarea rows="5" class="am-form-field am-radius" id="f_yy" placeholder="失败原因"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="am-u-sm-1"></div>
                    <div class="am-form-group am-text-left">
                        <div class="am-u-sm-5"></div>
                        <div class="am-u-sm-7">
                            <button type="button" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '通过...', resetText: '通过'}" class="am-btn am-btn-danger am-btn-xs sfxs" onclick="Spsftg(1)">通过</button>&nbsp;&nbsp;
                            <button type="button" class="am-btn am-btn-default am-btn-xs  sfxs" onclick="Spsftg(2)">不通过</button>
                        </div>
                    </div>
                </form>
            </div>

        </div>
    </div>
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
    var spmxJson = null;
    var shzt=0;
    $(function (){
        var mx=$('#tabmx');
        mx.css('overflow','hidden');
        mx.hover(function(){console.log('1');
            mx.css('overflow','auto');
        },function(){
           mx.css('overflow','hidden');
        });
        //loadInfo();
        getSpmx(0);

    });

    function getSpmx(shzt){
        var fshzt = $("#shzt").val();
        $.ajax({
            url: "/approve/getShmx",
            type: "post",
            async: false,
            data: {shzt:shzt},
            success: function (data) {
                var splist = JSON.parse(data);
                spmxJson = splist;
                $('#spmxtable').html("");
                if(splist.length>0) {
                    for(var i=0;i<splist.length;i++){
                        var spjson = splist[i];
                        var rowhtml="<tr>"
                            +"<td class=\"am-text-middle am-td-spmc\">" +
                            "<a href=\"#\" class=\"redlink\" onclick=\"showDetail("+i+")\">详情</a>&nbsp;&nbsp;&nbsp;";
                        if(fshzt == 3){
                            rowhtml+="<a href=\"#\" class=\"redlink\" onclick=\"startDeatil("+i+")\">启用</a>";
                        }else{
                            rowhtml+="<a href=\"#\" class=\"redlink\" onclick=\"stopDeatil("+i+")\">停用</a>";
                        }
                        rowhtml+="</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_SHBM+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_SHMC+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_DZ+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_DH+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_EMAIL+"</td>"
                            +"</tr>";
                        $('#spmxtable').prepend(rowhtml);
                    }
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }
    //显示单据详情
    function showDetail(index){
        var json = spmxJson[index];
        $('#xsDetailtable').html('');
        $('#spxqDetail').modal({
            closeViaDimmer: false,
            width:1100,
            height:500
        });

        var gd1 = $('#div1').height();
        $(".gd1").css("height",gd1);

        var gd2 = $('#div2').height();
        $(".gd2").css("height",gd2);

        var gd3 = $('#div3').height();
        $(".gd3").css("height",gd3);

        var gd4 = $('#div4').height();
        $(".gd4").css("height",gd4);

        var gd5 = $('#div5').height();
        $(".gd5").css("height",gd5);

        var gd6 = $('#div6').height();
        $(".gd6").css("height",gd6);

        var gd7 = $('#div7').height();
        $(".gd7").css("height",gd7);

        if(json.F_SHZT != '0'){
            $('.sfxs').hide();
        }else{
            $('.sfxs').show();
        }

        $('#f_shbm').val(json.F_SHBM);
        $('#f_shmc').text(json.F_SHMC);
        $('#f_shlx').val(json.F_LXBM);
        $('#f_shlxmc').text(json.F_LXBMMC);
        $('#f_sjhm').text(json.F_SJH);
        $('#f_xxdz').text(json.F_DZ);
        $('#f_yzbm').text(json.F_YB);
        $('#f_lxdh').text(json.F_DH);
        if(json.F_JYXKZH == null || json.F_JYXKZH == undefined){
            $('#f_jyxkzh').text(" ");
        }else{
            $('#f_jyxkzh').text(" "+json.F_JYXKZH);
        }
        $('#f_email').text(json.F_EMAIL);
        $('#f_khh').text(json.F_KHH);
        $('#f_khzh').text(json.F_ZH);
        $('#f_sh').text(json.F_SH);
        $('#f_fr').text(json.F_FR);
        $('#f_zczb').text(json.F_ZCZB);
        $('#f_sfls').text(json.F_SFLS);
        $('#f_yy').val(json.F_YY);
    }

    function stopDeatil(index){
        var json = spmxJson[index];
        $.ajax({
            url: "/approve/updateShzt",
            type: "post",
            async: false,
            data: {shzt:3,shbm:json.F_SHBM},
            success: function (data) {

                if(data == "ok"){
                    alertMsg("停用成功！");
                    getSpmx($('#shzt').val());
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }

    function startDeatil(index){
        var json = spmxJson[index];
        $.ajax({
            url: "/approve/updateShzt",
            type: "post",
            async: false,
            data: {shzt:1,shbm:json.F_SHBM},
            success: function (data) {

                if(data == "ok"){
                    alertMsg("停用成功！");
                    getSpmx($('#shzt').val());
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }

    function Spsftg(shzt){
        var shbm =$('#f_shbm').val();
        var shmc = $('#f_shmc').text();
        var shlx = $('#f_shlx').val();
        var yy = $('#f_yy').val();
        var sjhm = $('#f_sjhm').text();
        if(shzt == 2){
            if(yy == ''){
                alertMsg('请填写失败原因！！');
                return null;
            }
        }
        $.ajax({
            url: "/approve/SpSh",
            type: "post",
            async: false,
            data: {shzt:shzt,shbm:shbm,shmc:shmc,lxbm:shlx,yy:yy,f_sjhm:sjhm},
            success: function (data) {

                if(data == "ok"){
                    alertMsg("提交成功！");
                    $('#spxqDetail').modal('close');
                    getSpmx(0);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }

    function alertMsg(msg){
        $('#alertcontent ',parent.document).text(msg);
        $('#alertdlg',parent.document).modal('open');
    }
</script>
</body>
</html>
