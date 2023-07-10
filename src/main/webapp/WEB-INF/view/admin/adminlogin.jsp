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
    <title>盈放云平台管理平台</title>
    <meta name="description" content="盈放云平台管理平台">
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
<body style="background:url(/images/shbgimg.png) no-repeat;background-size: 100% 100%;">
<%--<img style="opacity: 0;float: left;" src="/images/bgimg.png">--%>
<%--<img class="niu" src="/images/logo.png">--%>
<div class="am-radius" style="width: 400px;position: absolute;right: 200px;top:150px;background-color: white;padding: 10px 10px 10px 10px;">
    <header class="header"><h2>欢迎登录，盈放管理平台!</h2></header>
    <form class="am-form am-form-horizontal" id="loginform">
        <div class="am-form-group">
            <label for="f_zybm" class="am-u-sm-3 am-form-label">账户</label>
            <div class="am-u-sm-9">
                <input type="text" class="am-form-field am-input-sm am-radius" id="f_zybm" required placeholder="请输入手机号码或工号">
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
                <%--<div style="margin-top: -15px;">
                <div class="am-fl">
                    <a href="#" style="color: #e52a33;font-size: 1.2rem;color: #cf121c;cursor: pointer;text-decoration: none;">忘记密码？</a>
                </div>
                <div class="am-fr">
                    <a href="/regist" style="color: #e52a33;font-size: 1.2rem;color: #cf121c;cursor: pointer;text-decoration: none;">没有账户？免费注册</a>
                </div>
                </div>--%>
                <div style="margin-top: 100px;color: #e52a33;font-size: 1.2rem;color: #cf121c;text-align:center;text-decoration: none;">
                    为了您的账号安全，请不要在公共设施上登录！
                </div>
            </div>
        </div>
        <div class="am-form-group am-text-left">
            <div class="am-u-sm-3">&nbsp;</div>
            <div class="am-u-sm-9">

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
</body>
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script type="text/javascript">
    var _topWin = window;
    while (_topWin != _topWin.parent.window) {
        _topWin = _topWin.parent.window;
    }
    //if (window != _topWin) _topWin.document.location.href = '/index/login';
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
                        var f_zybm = $("#f_zybm").val();
                        var f_zykl = $("#f_zykl").val();
                        setTimeout(function () {
                            $.ajax({
                                url: "/manage/checkLogin",
                                type: "post",
                                async: false,
                                data: { f_zybm: f_zybm, f_zykl: f_zykl, timeer: new Date() },
                                success: function (data, textStatus) {
                                    if (data == "ok") {
                                        window.location = "/manage/gotoAdminIndex";
                                    }
                                    else {
                                        alertMsg(data);
                                        if(data=="申请尚未审核!"||data=="申请审核失败!"){
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
    });
    function alertMsg(msg){
        $('#alertcontent').text(msg);
        $('#alertdlg').modal('open');
        $('#alertdlg').css("z-index","1120");
    }
</script>
</html>
