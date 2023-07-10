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
    <style>
        .header
        {
            text-align: center;
        }

        .header h21
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
        html,body{
            width:100%;
            height:100%
        }
    </style>
</head>
<body style="background:url(/images/bgimg.png) no-repeat;background-size: 100% 100%;">
<%--<img style="opacity: 0;float: left;" src="/images/bgimg.png">--%>
<%--<img class="niu" src="/images/logo.png">--%>
<div class="am-radius" style="width: 400px;position: absolute;right: 200px;top:150px;background-color: white;padding: 10px 10px 10px 10px;">
    <header class="header"><h2>欢迎注册，常熟市农药管理平台!</h2></header>
    <form class="am-form am-form-horizontal" id="loginform">
        <div class="am-form-group">
            <label for="f_sjhm" class="am-u-sm-3 am-form-label">账户</label>
            <div class="am-u-sm-9">
                <input type="text" class="am-form-field am-input-sm am-radius" id="f_sjhm" required placeholder="请输入手机号码或工号">
            </div>
        </div>
        <div class="am-form-group">
            <label for="f_zykl" class="am-u-sm-3 am-form-label">密码</label>
            <div class="am-u-sm-9">
                <input type="password" class="am-form-field am-input-sm am-radius" id="f_zykl" required placeholder="请输入登录密码">
            </div>
        </div>
        <div class="am-form-group am-text-left">
            <div class="am-u-sm-3">&nbsp;</div>
            <div class="am-u-sm-9">
                <button type="submit" id="submitBtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '登录中', resetText: 'loading'}" class="am-btn am-btn-danger am-btn-sm am-radius am-btn-block">登录</button>&nbsp;&nbsp;
                <div style="margin-top: -15px;">
                <div class="am-fl">
                    <a href="#" style="color: #e52a33;font-size: 1.2rem;color: #cf121c;cursor: pointer;text-decoration: none;" id="forgetPwd">忘记密码？</a>
                </div>
                <div class="am-fr">
                    <a href="/regist" style="color: #e52a33;font-size: 1.2rem;color: #cf121c;cursor: pointer;text-decoration: none;">没有账户？免费注册</a>
                </div>
                </div>
                <div style="margin-top: 50px;color: #e52a33;font-size: 1.2rem;color: #cf121c;text-align:center;text-decoration: none;">
                    为了您的账号安全，请不要在公共设施上登录！
                </div>
                <div style="margin-top: 10px;text-align:left;text-decoration: none;">
                    <a href="http://nz.njyfkj.cn:30001/csnz/login.jsp" style="font-size: 1.6rem;color: #0035ff;" target="_blank">农药补贴供应与绿色防控服务平台</a>
                </div>
                <div style="margin-top: 10px;text-align:left;text-decoration: none;">
                    <a href="/registration/PesticideUseRegistration" style="font-size: 1.6rem;color: #0035ff;" target="_blank">农药使用登记</a>
                </div>
            </div>
        </div>
        <div class="am-form-group am-text-left">
            <div class="am-u-sm-3">&nbsp;</div>
            <div class="am-u-sm-9">

            </div>
        </div>
    </form>

    <!--选择客户div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="choosePwddiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">重置登录密码
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <form class="am-form am-form-horizontal" id="forgetPwdform" style="margin-top: 20px;">
                <div class="am-u-sm-11">
                    <div class="am-form-group">
                        <label for="pwdf_sjhm" class="am-u-sm-2 am-form-label">手机号</label>
                        <div class="am-u-sm-10">
                            <input type="number" class="am-form-field am-input-sm am-radius" id="pwdf_sjhm" required placeholder="手机号">
                        </div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_yzm" class="am-u-sm-2 am-form-label">验证码</label>
                        <div class="am-u-sm-10">
                            <div class="am-input-group am-input-group-sm">
                                <input type="number" autocomplete="off" class="m-form-field am-input-sm am-radius" id="f_yzm" required placeholder="输入验证码"/>
                                <span class="am-input-group-btn">
                                        <button class="am-btn am-btn-default am-btn-xs am-radius" onclick="sendMsg(this)" type="button">获取验证码</button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="am-form-group">
                        <label for="pwdf_zykl" class="am-u-sm-2 am-form-label">设置密码</label>
                        <div class="am-u-sm-10 ">
                            <input type="text" autocomplete="off" class="am-form-field am-input-sm am-radius" id="pwdf_zykl" required placeholder="">
                        </div>
                    </div>
                    <div class="am-form-group">
                        <label for="pwdf_qrkl" class="am-u-sm-2 am-form-label">确认密码</label>
                        <div class="am-u-sm-10">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="pwdf_qrkl" required placeholder="请再次输入密码">
                        </div>
                    </div>
                    <div class="am-form-group am-text-left">
                        <div class="am-u-sm-5">&nbsp;</div>
                        <div class="am-u-sm-6">
                            <button type="submit" id="submitPwd" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '重置中', resetText: 'loading'}" class="am-btn am-btn-danger am-btn-xs am-radius">确认</button>&nbsp;&nbsp;
                            <button type="button" class="am-btn am-btn-default am-btn-xs am-radius" onclick="closeNewPwddiv()">取消</button>
                        </div>
                        <div class="am-u-sm-1">&nbsp;</div>
                    </div>
                </div>
                <div class="am-u-sm-1"></div>
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
            <span class="am-modal-btn" id="okbtn">确定</span>
        </div>
    </div>
</div>
</body>
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script type="text/javascript">
    var _topWin = window;
    while (_topWin != _topWin.parent.window) {
        _topWin = _topWin.parent.window;
    }
    if (window != _topWin) _topWin.document.location.href = '/index/login';
    $(function () {
        var $form = $('#loginform');
        $form.validator({
            H5validation: false,
            submit: function () {
                var formValidity = this.isFormValid();
                if (formValidity) {
                    try {
                        var $subbtn = $("#submitBtn");
                        $subbtn.button('loading');
                        var f_sjhm = $("#f_sjhm").val();
                        var f_zykl = $("#f_zykl").val();
                        setTimeout(function () {
                            $.ajax({
                                url: "/checkLogin",
                                type: "post",
                                async: false,
                                data: { f_sjhm: f_sjhm, f_zykl: f_zykl, timeer: new Date() },
                                success: function (data, textStatus) {
                                    if (data == "ok") {
                                        window.location = "/index";
                                    } else if(data == "gotoSalesBill"){
                                        window.location = "/sales/salesbill";
                                    }else {
                                        alertMsg(data);
                                        if(data=="申请审核失败!"){
                                            $('#okbtn').click(function () {
                                                window.location = "/edit?type=up";
                                            });

                                        }
                                        //window.location = "/edit?type="+"up";
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

        var $form2 = $('#forgetPwdform');
        $form2.validator({
            H5validation: false,
            submit: function () {
                var formValidity = this.isFormValid();
                if (formValidity) {
                    try {
                        var $subbtn = $("#submitPwd");
                        $subbtn.button('loading');
                        var f_sjhm = $("#pwdf_sjhm").val();
                        var f_zykl = $("#pwdf_zykl").val();
                        var f_yzm = $("#f_yzm").val();
                        var f_qrkl = $("#pwdf_qrkl").val();
                        setTimeout(function () {
                            $.ajax({
                                url: "/forgetPwd",
                                type: "post",
                                async: false,
                                data: { f_sjhm: f_sjhm,f_yzm:f_yzm,f_qrkl:f_qrkl,f_zykl: f_zykl,timeer: new Date() },
                                success: function (data, textStatus) {
                                    if (data == "ok") {
                                        alertMsg("您已重置密码成功，请重新登陆！");
                                        window.location = "/login";
                                    }
                                    else {
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

        $('#forgetPwd').click(function () {
            $('#choosePwddiv').modal({
                closeViaDimmer: false,
                width:610,
                height:400
            });
            $('#choosePwddiv').modal('open');
        });
    });
    function sendMsg(event){
        var f_sjhm = $("#pwdf_sjhm").val();
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
    function closeNewPwddiv() {
        $('#choosePwddiv').modal('close');
    }
    function alertMsg(msg){
        $('#alertcontent').text(msg);
        $('#alertdlg').modal('open');
        $('#alertdlg').css("z-index","1120");
    }
</script>
</html>
