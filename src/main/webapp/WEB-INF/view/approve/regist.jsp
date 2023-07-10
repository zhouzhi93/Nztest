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
    <header class="header"><h1>欢迎注册，盈放云管家!</h1></header>

    <form class="am-form am-form-horizontal" id="loginform" style="margin-top: 20px;">
        <div class="am-u-sm-2">&nbsp;</div>
        <div class="am-u-sm-8">
            <div class="am-form-group">
                <label for="f_khmc" class="am-u-sm-2 am-form-label">商户名称</label>
                <div class="am-u-sm-4">
                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_khmc" required placeholder="客户名称">
                </div>
                <label  class="am-u-sm-2 am-form-label">商户类型</label>
                <div class="am-u-sm-4">
                    <label class="am-radio-inline">
                        <input type="radio" value="1" checked name="f_shlx"> 农资店
                    </label>
                    <label class="am-radio-inline">
                        <input type="radio" value="2" name="f_shlx"> 零售超市
                    </label>
                    <%--<label class="am-radio-inline">--%>
                        <%--<input type="radio" value="0" name="f_shlx"> 专卖店--%>
                    <%--</label>--%>
                    <label class="am-radio-inline">
                        <input type="radio" value="3" name="f_shlx"> 水果店
                    </label>
                </div>
            </div>
            <div class="am-form-group">
                <label for="f_sjhm" class="am-u-sm-2 am-form-label">手机号</label>
                <div class="am-u-sm-4">
                    <input type="number" class="am-form-field am-input-sm am-radius" id="f_sjhm" required placeholder="手机号">
                </div>
                <label for="f_qydz" class="am-u-sm-2 am-form-label">所在地区</label>
                <div class="am-u-sm-4" data-am-address="{prov:'江苏省',scrollToCenter:true}">
                    <input type="text" id="f_qydz" class="am-form-field am-input-sm am-radius" readonly required  placeholder="请选择地址">
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
                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_zykl" required placeholder="请设置6~16位字符">
                </div>
                <label for="f_yzbm" class="am-u-sm-2 am-form-label">邮政编码</label>
                <div class="am-u-sm-4">
                    <input type="number" class="am-form-field am-input-sm am-radius" id="f_yzbm" placeholder="邮政编码">
                </div>
            </div>
            <div class="am-form-group">
                <label for="f_qrkl" class="am-u-sm-2 am-form-label">确认密码</label>
                <div class="am-u-sm-4">
                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_qrkl" required placeholder="请再次输入密码">
                </div>

                <label for="f_lxdh" class="am-u-sm-2 am-form-label">联系电话</label>
                <div class="am-u-sm-4">
                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_lxdh" placeholder="联系电话">
                </div>
            </div>
            <div class="am-form-group">
                <label for="f_cz" class="am-u-sm-2 am-form-label">传真</label>
                <div class="am-u-sm-4">
                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_cz" placeholder="传真">
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
                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_zczb" placeholder="注册资本">
                </div>
                <label  class="am-u-sm-2 am-form-label">是否连锁</label>
                <div class="am-u-sm-4">
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
                    <button type="submit" id="submitBtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '注册中', resetText: 'loading'}" class="am-btn am-btn-danger am-btn-xs am-radius">注册</button>&nbsp;&nbsp;
                    <button type="button" class="am-btn am-btn-default am-btn-xs am-radius" onclick="closeNewKhdiv()">取消</button>
                </div>
                <div class="am-u-sm-6">&nbsp;</div>
            </div>
        </div>
        <div class="am-u-sm-2"></div>
    </form>
</div>
</body>
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script src="/assets/address/address.min.js"></script>
<script src="/assets/address/iscroll.min.js"></script>
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
                        var f_khmc = $("#f_khmc").val();
                        var f_zykl = $("#f_zykl").val();
                        var f_yzm = $("#f_yzm").val();
                        var f_qrkl = $("#f_qrkl").val();
                        var f_shlx=$("input[name='f_sfls']:checked").val();
                        var f_sfls=$("input[name='f_sfls']:checked").val();
                        var f_qydz=$('#f_qydz').val();
                        var f_xxdz=$('#f_xxdz').val();
                        var f_yzbm=$('#f_yzbm').val();
                        var f_lxdh=$('#f_lxdh').val();
                        var f_cz=$('#f_cz').val();
                        var f_emall=$('#f_emall').val();
                        var f_khh=$('#f_khh').val();
                        var f_khzh=$('#f_khzh').val();
                        var f_sh=$('#f_sh').val();
                        var f_fr=$('#f_fr').val();
                        var f_zczb=$('#f_zczb').val();
                        setTimeout(function () {
                            $.ajax({
                                url: "/registUser",
                                type: "post",
                                async: false,
                                data: { f_sjhm: f_sjhm,f_khmc: f_khmc,f_yzm:f_yzm,f_qrkl:f_qrkl, f_zykl: f_zykl,f_shlx:f_shlx,f_sfls:f_sfls,f_qydz:f_qydz,
                                    f_xxdz:f_xxdz,f_yzbm:f_yzbm,f_lxdh:f_lxdh,f_cz:f_cz,f_emall:f_emall,f_khh:f_khh,f_khzh:f_khzh,f_sh:f_sh,f_fr:f_fr,f_zczb:f_zczb, timeer: new Date() },
                                success: function (data, textStatus) {
                                    if (data == "ok") {
                                        window.location = "/login";
                                    }
                                    else {
                                        alert(data);
                                    }
                                    $subbtn.button('reset');
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    alert(errorThrown + "||" + textStatus);
                                    $subbtn.button('reset');
                                }
                            });
                        }, 10);
                    }
                    catch (e) {
                        alert(e.name);
                    }
                } else {
                    // 验证失败的逻辑
                }
                //阻止原生form提交
                return false;
            }
        });
    });
    function sendMsg(event){
        var f_sjhm = $("#f_sjhm").val();
        if(f_sjhm.length<=0){
            alert("请输入手机号码!");
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
                    alert(data);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }
</script>
</html>
