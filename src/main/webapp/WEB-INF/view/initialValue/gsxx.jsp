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
    <link rel="stylesheet" href="/assets/css/admin.css"/>
    <link rel="stylesheet" href="/assets/address/amazeui.address.css"/>
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
        img{
            vertical-align: middle;
        }
        label{
            font-weight: 500;
            font-size:1.4rem;
        }
    </style>
</head>
<body>
<div class="am-g">
    <form class="am-form am-form-horizontal" id="gsxxform" style="margin-top: 20px;">
        <div class="am-u-sm-12">
            <div class="am-form-group">
                <label for="f_khmc" class="am-u-sm-2 am-form-label">商户名称</label>
                <div class="am-u-sm-4">
                    <input type="text" class="am-form-field am-input-sm am-radius " id="f_khmc" readonly required placeholder="客户名称">
                </div>
                <label  class="am-u-sm-2 am-form-label">商户类型</label>
                <div class="am-u-sm-4">
                    <select data-am-selected disabled id="f_shlx">
                    </select>
                </div>
            </div>
            <div class="am-form-group">
                <label for="f_sjhm" class="am-u-sm-2 am-form-label">手机号</label>
                <div class="am-u-sm-4">
                    <input type="number" class="am-form-field am-input-sm am-radius" id="f_sjhm" required placeholder="手机号">
                </div>
                <label for="f_qydz" class="am-u-sm-2 am-form-label">所在地区</label>
                <div class="am-u-sm-4" id="address">
                    <input type="text" id="f_qydz" class="am-form-field am-input-sm am-radius" readonly required  placeholder="请选择地址">
                    <input type="hidden"id="f_qyzd_hidd">
                </div>

            </div>
            <div class="am-form-group">
                <label for="f_yzm" class="am-u-sm-2 am-form-label">验证码</label>
                <div class="am-u-sm-4">
                    <div class="am-input-group am-input-group-sm">
                        <input type="text" class="m-form-field am-input-sm am-radius" id="f_yzm" required placeholder="输入验证码"/>
                        <span class="am-input-group-btn">
                        <button class="am-btn am-btn-default am-btn-xs am-radius" onclick="sendMsg(this)" type="button">获取验证码</button>
                        </span>
                    </div>
                </div>
                <label for="f_xxdz" class="am-u-sm-2 am-form-label">街道地址</label>
                <div class="am-u-sm-4">
                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_xxdz" placeholder="详细地址">
                </div>
            </div>
            <div class="am-form-group">
                <label for="f_sjhm" class="am-u-sm-2 am-form-label">设置密码</label>
                <div class="am-u-sm-4 ">
                    <input type="password" class="am-form-field am-input-sm am-radius" id="f_zykl" required placeholder="">
                </div>
                <label for="f_yzbm" class="am-u-sm-2 am-form-label">邮政编码</label>
                <div class="am-u-sm-4">
                    <input type="number" class="am-form-field am-input-sm am-radius" id="f_yzbm" placeholder="邮政编码">
                </div>
            </div>
            <div class="am-form-group">
                <label for="f_qrkl" class="am-u-sm-2 am-form-label">确认密码</label>
                <div class="am-u-sm-4">
                    <input type="password" class="am-form-field am-input-sm am-radius" id="f_qrkl" required placeholder="请再次输入密码">
                </div>
                <label for="f_lxdh" class="am-u-sm-2 am-form-label">联系电话</label>
                <div class="am-u-sm-4">
                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_lxdh" placeholder="联系电话">
                </div>
            </div>
            <div class="am-form-group">
                <label for="f_jyxkzh" class="am-u-sm-2 am-form-label">农药经营许可证号</label>
                <div class="am-u-sm-4">
                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_jyxkzh" placeholder="农药经营许可证号">
                </div>
                <label for="f_emall" class="am-u-sm-2 am-form-label">EMAIL</label>
                <div class="am-u-sm-4">
                    <input type="email" class="am-form-field am-input-sm am-radius" id="f_emall" placeholder="EMAIL">
                </div>
            </div>
            <div class="am-form-group">
                <label for="f_khh" class="am-u-sm-2 am-form-label">开户行</label>
                <div class="am-u-sm-4">
                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_khh" placeholder="开户行">
                </div>
                <label for="f_khzh" class="am-u-sm-2 am-form-label">开户帐号</label>
                <div class="am-u-sm-4">
                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_khzh" placeholder="开户帐号">
                </div>
            </div>
            <div class="am-form-group">
                <label for="f_sh" class="am-u-sm-2 am-form-label">税号</label>
                <div class="am-u-sm-4">
                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_sh" placeholder="税号">
                </div>
                <label for="f_fr" class="am-u-sm-2 am-form-label">法人</label>
                <div class="am-u-sm-4">
                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_fr" placeholder="法人">
                </div>
            </div>
            <div class="am-form-group">
                <label for="f_zczb" class="am-u-sm-2 am-form-label">注册资本</label>
                <div class="am-u-sm-4">
                    <input type="number" class="am-form-field am-input-sm am-radius" id="f_zczb" placeholder="注册资本">
                </div>
                <label class="am-u-sm-2 am-form-label">是否连锁</label>
                <div class="am-u-sm-4" id="sflsDiv">
                    <label class="am-radio-inline">
                        <input type="radio" value="1" checked name="f_sfls"> 不连锁
                    </label>
                    <label class="am-radio-inline">
                        <input type="radio" value="2" name="f_sfls"> 连锁
                    </label>
                </div>
            </div>
            <div class="am-form-group am-text-left">
                <div class="am-u-sm-2">&nbsp;</div>
                <div class="am-u-sm-4">
                    <button type="button" onclick="saveGsxx()" class="am-btn am-btn-danger am-btn-xs am-radius">保存</button>&nbsp;&nbsp;
                </div>
                <div class="am-u-sm-6">&nbsp;</div>
            </div>
        </div>
    </form>
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
<script src="/assets/address/address.min.js"></script>
<script src="/assets/address/iscroll.min.js"></script>
<script type="text/javascript">
    $(function () {
        loadXzdq();
        loadGsxx();
    });

    //回显公司信息
    function loadGsxx() {
        $.ajax({
            url: "/initialvalues/loadGsxx",
            type: "post",
            async: false,
            data: { timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var gsxx=dataJson[0];
                    $("#f_khmc").val(gsxx.F_SHMC);
                    $("#f_shlx").html("<option value='"+gsxx.F_LXBM+"' selected>"+gsxx.F_LXMC+"</option>");
                    $("#f_sjhm").val(gsxx.F_SJH);
                    $('#f_qydz').val(gsxx.F_DZ);
                    $('#f_xxdz').val(gsxx.F_XXDZ);
                    $("#f_zykl").val(gsxx.F_MM);
                    $('#f_yzbm').val(gsxx.F_YB);
                    $("#f_qrkl").val(gsxx.F_MM);
                    $('#f_lxdh').val(gsxx.F_DH);
                    $('#f_jyxkzh').val(gsxx.F_JYXKZH);
                    $('#f_emall').val(gsxx.F_EMAIL);
                    $('#f_khh').val(gsxx.F_KHH);
                    $('#f_khzh').val(gsxx.F_ZH);
                    $('#f_sh').val(gsxx.F_SH);
                    $('#f_fr').val(gsxx.F_FR);
                    $('#f_zczb').val(gsxx.F_ZCZB);

                    var sflsLen = $("#sflsDiv").find("label").length;
                    for (var i = 0; i < sflsLen; i++){
                        var sflsval = $("#sflsDiv").find("label").eq(i).find("input").eq(0).val();
                        if (sflsval == gsxx.F_SFLS){
                            $("#sflsDiv").find("label").eq(i).find("input").eq(0).attr("checked",true);
                        }
                    }
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alertMsg(errorThrown + "||" + textStatus);
            }
        });
    }

    //修改公司信息
    function saveGsxx() {
        var sjhm = $("#f_sjhm").val();
        var f_qydz = $('#f_qydz').val();
        var f_yzm = $('#f_yzm').val();
        var f_xxdz = $('#f_xxdz').val();
        var f_zykl = $("#f_zykl").val();
        var f_yzbm = $('#f_yzbm').val();
        var f_qrkl = $("#f_qrkl").val();
        var f_lxdh = $('#f_lxdh').val();
        var f_jyxkzh = $('#f_jyxkzh').val();
        var f_emall = $('#f_emall').val();
        var f_khh = $('#f_khh').val();
        var f_khzh = $('#f_khzh').val();
        var f_sh = $('#f_sh').val();
        var f_fr = $('#f_fr').val();
        var f_zczb = $('#f_zczb').val();
        var f_sfls = $("input[name='f_sfls']:checked").val();

        if (f_yzm == null || f_yzm == ""){
            alertMsg("请输入验证码！");
            return;
        }

        $.ajax({
            url: "/initialvalues/saveGsxx",
            type: "post",
            async: false,
            data: { sjhm:sjhm,f_qydz:f_qydz,f_yzm:f_yzm,f_xxdz:f_xxdz,f_zykl:f_zykl,f_yzbm:f_yzbm,
                f_qrkl:f_qrkl,f_lxdh:f_lxdh,f_jyxkzh:f_jyxkzh,f_emall:f_emall,f_khh:f_khh,f_khzh:f_khzh,
                f_sh:f_sh,f_fr:f_fr,f_zczb:f_zczb,f_sfls:f_sfls,timeer: new Date() },
            success: function (data) {
                if (data == "ok"){
                    alertMsg("保存成功！");
                }else if (data == "411"){
                    alertMsg("验证码不正确!");
                }else if (data == "412"){
                    alertMsg("两次输入的密码不一致!");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alertMsg(errorThrown + "||" + textStatus);
            }
        });
    }

    //弹出所在地区选择框
    function loadXzdq() {
        $("#address").address({
            prov: "江苏省",
//            city: "南京",
//            district: "阳山县",
            scrollToCenter: true,
            footer: false,
            selectEnd: function(json,address) {
                var f_qydz_hide="";
                for(var key in json) {
                    if(f_qydz_hide==""){
                        f_qydz_hide+=json[key];
                    }else{
                        f_qydz_hide+="|"+json[key];
                    }
                }
                $('#f_qyzd_hidd').val(f_qydz_hide);
            }
        });
    }

    function sendMsg(event){
        var f_sjhm = $("#f_sjhm").val();
        if(f_sjhm.length<=0){
            alertMsg("请输入手机号码!");
            return;
        }
        var t = 60;
        var _res= setInterval(function () {
            if (t > 0) {
                t--;
                event.innerText ="("+t+")重新获取"
                event.disabled = true;
            } else {
                window.clearInterval(_res);
                event.innerText = "再次获取";
                event.disabled = false;
            }
        }, 1000);
        $.ajax({
            url: "/SendMsg",
            type: "post",
            async: false,
            data: { f_sjhm: f_sjhm, timeer: new Date() },
            success: function (data, textStatus) {
                if (data == "ok") {

                }
                else {
                    alertMsg(data);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alertMsg(errorThrown + "||" + textStatus);
            }
        });
    }

    function alertMsg(msg){
        $('#alertcontent').text(msg);
        $('#alertdlg').modal('open');
        $('#alertdlg').css("z-index","1120");
        $('#okbtn').click(function (){
            location.reload(true);
            $('#alertdlg').modal('close');
        });
    }
</script>
</body>
</html>
