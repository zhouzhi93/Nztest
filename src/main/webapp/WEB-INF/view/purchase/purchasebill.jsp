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
    String zdrmc=(String)session.getAttribute("f_zymc");
    String lxbm=(String) session.getAttribute("f_lxbm");
    String f_qyck=(String)session.getAttribute("f_qyck");
%>
<%--<!DOCTYPE html>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台供应商端V1-进货单</title>
    <meta name="description" content="云平台供应商端V1-进货单">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="apple-touch-icon-precomposed" href="/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="/assets/css/amazeui.min.css"/>
    <link rel="stylesheet" href="/assets/css/iconfont.css"/>
    <link rel="stylesheet" href="/assets/address/amazeui.address.css"/>
    <link rel="stylesheet" href="/tree/amazeui.tree.css"/>
    <link rel="stylesheet" href="/tree/amazeui.tree.min.css"/>
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
        .am-form-group {
            margin-bottom: 1.1rem;
        }

    </style>
</head>
<body>
<div class="am-g">
    <div class="am-u-sm-12 am-u-md-12" id="xsdiv">
        <div class="header">
            <div class="am-g">
                <h1>进&nbsp;&nbsp;货&nbsp;&nbsp;单</h1>
            </div>
        </div>
        <div class="am-container am-">
            <div class="am-u-sm-7 am-u-md-7">供应商：<input class="am-radius am-form-field am-input-sm" id="csbm" readonly style="width: 140px;display:inline-block;" type="text" placeholder="选择供应商">
                <%--<i class="iconfont icon-htmal5icon26" style="position: relative;left:-30px;vertical-align: middle;"></i>--%>
            </div>
            <div class="am-u-sm-5 am-u-md-5"><span class="am-fr" style="vertical-align: middle;">日期：<%=str%></span></div>
        </div>
        <div class="am-container" style="margin-top: 10px;">
            <%--<div class="am-u-sm-6 am-u-md-6">原单据：<input class="am-radius am-form-field am-input-sm" id="JhXx" readonly style="width: 140px;display:inline-block;" type="text" placeholder="选择单据号">--%>
            <%--</div>--%>
            <div class="am-u-sm-6 am-u-md-6 am-text-left">
                <div id="ckmcDiv">

                </div>
            </div>

            <div class="am-u-sm-6 am-u-md-6 am-text-right">
                <select data-am-selected="{btnWidth: '60%', btnSize: 'sm'}" id="f_bmbm">
                </select>
            </div>
        </div>
        <div class="am-container am-scrollable-vertical" style="margin-top: 20px;">
            <table class="am-table am-table-bordered am-table-centered" >
                <thead id="sptableTitle">

                </thead>
                <tbody id="sptable">

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

            <div class="am-form" style="clear: both;display: none;">
                <div style="margin-top:10px;"class="am-form-group">
                    备注：<textarea class="" style="width: 100%;display: block;" rows="3" id="f_djbz" placeholder="备注内容"></textarea>
                </div>
            </div>
            <div>
            </div>
        </div>
        <div class="am-container">
            <div class="am-fr">
                <input style="vertical-align:middle;" id="f_sfdyxp" type="checkbox"/><span style="font-size: 13px;vertical-align:middle;">保存后立即打印小票</span>
                <button type="button" onclick="savebill()" class="am-btn am-btn-danger  am-radius am-btn-sm">保存</button>&nbsp;&nbsp;
                <button type="button" onclick="getwxSpxx(this)" class="am-btn am-btn-primary am-btn-sm am-radius">调入</button>
            </div>
        </div>
    </div>
    <!--商品档案选择-->
    <div style="padding-top: 20px;display:none;height:600px;" id="spdadiv" class="am-scrollable-vertical">
        <button type="button" onclick="showAddsp()" class="am-btn am-btn-danger am-radius am-btn-sm">新增商品</button>
        <div class="am-fr">
            您已经选择了<span id="sphj" style="color: #E72A33;">0</span>种商品<input class="am-radius am-form-field am-input-sm" id="spoption" style="width: 180px;display:initial;" type="text" placeholder="">
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
<!--选择供应商div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseCsdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">选择供应商
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div class="am-container">
                <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                    <input class="am-radius am-form-field am-input-sm" id="csoption" style="width: 160px;display:initial;" type="text" placeholder="输入供应商名称、字母">
                    <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchKh()">搜索</button>
                </div>
                <div class="am-u-sm-6 am-u-md-6 am-text-right">
                    <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadCsxx('')" style="border: 1px solid red;background: white;color: red;">重新加载</button>
                    <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" id="addcs">新增供应商</button>
                </div>
            </div>
            <div style="margin-top: 10px; height: 400px;" class="am-container am-scrollable-vertical">
                <table class="am-table am-table-bordered am-table-centered" >
                    <thead>
                    <tr>
                        <th class="am-text-middle">供应商名称</th>
                        <th class="am-text-middle">手机号码</th>
                        <th class="am-text-middle">余额</th>
                        <th class="am-text-middle">欠款</th>
                    </tr>
                    </thead>
                    <tbody id="cstable">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!--新建商品div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="newSpdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">新增商品
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd am-scrollable-vertical" style="min-height: 520px;" >
            <div style="margin-top: 10px;" class="am-container">
                <form class="am-form am-form-horizontal" id="addkhform">
                    <%--<div class="am-form-group">
                        <label for="f_spfl" class="am-u-sm-2 am-form-label" style="padding: 0px;">商品类别</label>
                        <div class="am-u-sm-10">
                            <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                <select data-am-selected="{btnWidth: '70%',maxHeight: 200}" id="f_spfl" required>
                                </select>
                                <span style="color: #5da5fd;cursor: pointer;" onclick="loadspfl()">刷新</span>
                            </div>
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>--%>
                        <div class="am-form-group ypdxs" style="display: none;">
                            <label for="f_djzh" class="am-u-sm-2 am-form-label" style="padding: 0px;">登记号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_djzh" placeholder="请扫描二维码或手工录入PD号后回车">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_spfl" class="am-u-sm-2 am-form-label" style="padding: 0px;">商品类别</label>
                            <div class="am-u-sm-9">
                                <input readonly type="hidden" class="am-form-field am-input-sm am-radius" id="f_spfl" required placeholder="">
                                <input readonly type="text" class="am-form-field am-input-sm am-radius" id="f_spflmc" placeholder="">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sptm" class="am-u-sm-2 am-form-label" style="padding: 0px;">商品条码</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_sptm" required placeholder="选填,扫码枪或手工输入商品条形码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_spmc" class="am-u-sm-2 am-form-label" style="padding: 0px;">商品名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_spmc" required placeholder="商品名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="f_zhl" class="am-u-sm-2 am-form-label" style="padding: 0px;">总含量</label>
                            <div class="am-u-sm-4">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_zhl" placeholder="如: 1.8%、2.5%等">
                            </div>
                            <div class="am-form-group nzdxs">
                                <label for="f_jx" class="am-u-sm-1 am-form-label" style="padding: 0px;">剂型</label>
                                <div class="am-u-sm-4">
                                    <input type="text" class="am-form-field am-input-sm am-radius" id="f_jx" placeholder="如水剂、乳油、可湿性粉剂等">
                                </div>
                                <div class="am-u-sm-end"></div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_bzgg" class="am-u-sm-2 am-form-label" style="padding: 0px;">包装规格</label>
                            <div class="am-u-sm-4 am-form-inline" style="text-align:left;">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_bzgg" placeholder="规格" style="display:initial;width: 50%;">
                                <span class="pull-left" style="line-height: 34px; margin: 0 5px;">/</span>
                                <select data-am-selected="{btnWidth: '30%',maxHeight: 200}" id="primaryUnit">
                                    <option value="袋" selected>袋</option>
                                    <option value="包">包</option>
                                    <option value="瓶">瓶</option>
                                    <option value="个">个</option>
                                    <option value="件">件</option>
                                    <option value="台">台</option>
                                    <option value="卷">卷</option>
                                </select>
                            </div>
                            <div class="am-form-group nzdxs">
                                <label for="f_mbzzl" class="am-u-sm-1 am-form-label" style="padding: 0px;">每包装重量</label>
                                <div class="am-u-sm-4 am-form-inline" style="text-align:left;">
                                    <input type="number" class="am-form-field am-input-sm am-radius" id="f_mbzzl" placeholder="每包装重量" style="display:initial;width: 50%;">
                                    <span class="pull-left" style="line-height: 34px; margin: 0 5px;">/</span>
                                    <select data-am-selected="{btnWidth: '30%',maxHeight: 200}" id="f_mbzzldw">
                                        <option value="ML" selected>ML</option>
                                        <option value="G">G</option>
                                    </select>
                                </div>
                                <div class="am-u-sm-end"></div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_xsj" class="am-u-sm-2 am-form-label" style="padding: 0px;">售价</label>
                            <div class="am-u-sm-4" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="f_xsj" required placeholder="售价" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">元/<span class="priceUnit">袋</span></span>
                            </div>
                            <div class="am-form-group">
                                <label for="f_jhj" class="am-u-sm-1 am-form-label" style="padding: 0px;">进价</label>
                                <div class="am-u-sm-4" style="text-align:left;">
                                    <input type="number" class="am-form-field am-input-sm am-radius" id="f_jhj" placeholder="进价" style="display:initial;width: 80%;">
                                    <span style="margin-left: 4px; line-height: 34px;">元/<span class="priceUnit">袋</span></span>
                                </div>
                                <div class="am-u-sm-end"></div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdbxs">
                            <label for="f_jxsl" class="am-u-sm-2 am-form-label" style="padding: 0px;">进项税率</label>
                            <div class="am-u-sm-9" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="f_jxsl" required placeholder="进项税率" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">%</span>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdbxs">
                            <label for="f_xxsl" class="am-u-sm-2 am-form-label" style="padding: 0px;">销项税率</label>
                            <div class="am-u-sm-9" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="f_xxsl" required placeholder="销项税率" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">%</span>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_ghs" class="am-u-sm-2 am-form-label" style="padding: 0px;">供货商</label>
                            <div class="am-u-sm-9">
                                <select multiple  data-am-selected="{btnWidth: '100%',maxHeight: 200,searchBox:1}" id="f_ghs">
                                </select>
                                <input  id="inputselect" type="text" class="am-form-field am-input-sm am-radius"
                                        style="width:90%;position: absolute;top: 3px"/>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="f_nycpdjz" class="am-u-sm-2 am-form-label" style="padding: 0px;">登记证</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_nycpdjz" placeholder="登记证" readonly>
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="f_nycpdjzfwqdz" placeholder="农药登记证服务器地址" readonly>
                            </div>
                            <!--file上传文件-->
                            <div class="am-form-group am-form-file am-u-sm-2" style="padding: 0px;margin: 0px;">
                                <div style="text-align: left;">
                                    <button type="button" class="am-btn am-btn-default am-btn-sm">
                                        <i class="am-icon-cloud-upload"></i>浏览</button>
                                </div>
                                <input id="f_nycpdjzFile" type="file">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="f_nycpbz" class="am-u-sm-2 am-form-label" style="padding: 0px;">产品包装</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_nycpbz" placeholder="产品包装" readonly>
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="f_nycpbzfwqdz" placeholder="产品包装服务器地址" readonly>
                            </div>
                            <!--file上传文件-->
                            <div class="am-form-group am-form-file am-u-sm-2" style="padding: 0px;margin: 0px;">
                                <div style="text-align: left;">
                                    <button type="button" class="am-btn am-btn-default am-btn-sm">
                                        <i class="am-icon-cloud-upload"></i>浏览</button>
                                </div>
                                <input id="f_nycpbzFile" type="file">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="f_nycpbq" class="am-u-sm-2 am-form-label" style="padding: 0px;">产品标签</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_nycpbq" placeholder="产品标签" readonly>
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="f_nycpbqfwqdz" placeholder="产品标签服务器地址" readonly>
                            </div>
                            <!--file上传文件-->
                            <div class="am-form-group am-form-file am-u-sm-2" style="padding: 0px;margin: 0px;">
                                <div style="text-align: left;">
                                    <button type="button" class="am-btn am-btn-default am-btn-sm">
                                        <i class="am-icon-cloud-upload"></i>浏览</button>
                                </div>
                                <input id="f_nycpbqFile" type="file">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="f_nycpsms" class="am-u-sm-2 am-form-label" style="padding: 0px;">说明书</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_nycpsms" placeholder="产品说明书" readonly>
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="f_nycpsmsfwqdz" placeholder="产品说明书服务器地址" readonly>
                            </div>
                            <!--file上传文件-->
                            <div class="am-form-group am-form-file am-u-sm-2" style="padding: 0px;margin: 0px;">
                                <div style="text-align: left;">
                                    <button type="button" class="am-btn am-btn-default am-btn-sm">
                                        <i class="am-icon-cloud-upload"></i>浏览</button>
                                </div>
                                <input id="f_nycpsmsFile" type="file">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="f_nycpzmwjbh" class="am-u-sm-2 am-form-label" style="padding: 0px;">许可证明</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_nycpzmwjbh" placeholder="有关许可证明文件编号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdbxs">
                            <label class="am-u-sm-2 am-form-label" style="padding: 0px;">是否称重</label>
                            <div class="am-u-sm-9 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="0" name="f_sfcz"> 否
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="f_sfcz"> 是
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label class="am-u-sm-2 am-form-label" style="padding: 0px;">禁限农药</label>
                            <div class="am-u-sm-4 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="1" name="f_nybz" checked> 否
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="0" name="f_nybz"> 是
                                </label>
                            </div>
                            <div class="am-form-group ypdxs">
                                <label class="am-u-sm-1 am-form-label" style="padding: 0px;">商品类型</label>
                                <div class="am-u-sm-4 am-text-left">
                                    <label class="am-radio-inline">
                                        <input type="radio"  value="0" checked name="f_splx"> 商品
                                    </label>
                                    <label class="am-radio-inline">
                                        <input type="radio" value="1" name="f_splx"> 包装物
                                    </label>
                                </div>
                                <div class="am-u-sm-end"></div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-5">&nbsp;</div>
                            <div class="am-u-sm-7">
                                <button type="button" id="addspbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeNewspdiv()">取消</button>
                            </div>
                        </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--分类选择div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="SPFLdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">分类选择
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-g am-scrollable-vertical" style="min-height: 400px;">
            <div class="am-container">
                <ul class="am-tree am-tree-folder-select" role="tree" id="firstTree" style="text-align: left;">
                    <li class="am-tree-branch am-hide" data-template="treebranch" role="treeitem" aria-expanded="false">
                        <div class="am-tree-branch-header">
                            <button class="am-tree-icon am-tree-icon-caret am-icon-caret-right"><span class="am-sr-only">Open</span></button>
                            <button class="am-tree-branch-name">
                                <span class="am-tree-icon am-tree-icon-folder"></span>
                                <span class="am-tree-label"></span>
                            </button>
                        </div>
                        <ul class="am-tree-branch-children" role="group"></ul>
                        <div class="am-tree-loader" role="alertMsg">Loading...</div>
                    </li>
                    <li class="am-tree-item am-hide" data-template="treeitem" role="treeitem">
                        <button class="am-tree-item-name">
                            <span class="am-tree-icon am-tree-icon-item"></span>
                            <span class="am-tree-label"></span>
                        </button>
                    </li>
                </ul>
            </div>
        </div>
        <div class="am-form-group am-text-left">
            <div class="am-u-sm-4">&nbsp;</div>
            <div class="am-u-sm-8">
                <button type="submit" id="addFlxz" class="am-btn am-btn-danger am-btn-xs">确认</button>&nbsp;&nbsp;
                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeQyxzdiv()">取消</button>
            </div>
        </div>
    </div>
</div>
<!--新建供应商div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="newCSdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">新增供应商
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd">
            <div style="margin-top: 10px;" class="am-container">
                <form class="am-form am-form-horizontal" id="addcsform">
                    <div class="am-form-group">
                        <label for="f_csmc" class="am-u-sm-3 am-form-label">供应商名称</label>
                        <div class="am-u-sm-8">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_csmc" required placeholder="供应商名称">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>

                    <div class="am-form-group">
                        <label for="f_sjhm" class="am-u-sm-3 am-form-label">联系电话</label>
                        <div class="am-u-sm-8">
                            <input type="number" class="am-form-field am-input-sm am-radius" id="f_sjhm" required placeholder="手机号">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_sfzh"  class="am-u-sm-3 am-form-label">证件号码</label>
                        <div class="am-u-sm-8">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_sfzh" placeholder="身份证号">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_bz" class="am-u-sm-3 am-form-label">备注</label>
                        <div class="am-u-sm-8">
                            <textarea  class="am-form-field am-input-sm am-radius" id="f_bz" placeholder="备注"></textarea>
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label class="am-u-sm-3 am-form-label">状态</label>
                        <div class="am-u-sm-8 am-text-left">
                            <label class="am-radio-inline">
                                <input type="radio"  value="0" name="f_zt"> 启用
                            </label>
                            <label class="am-radio-inline">
                                <input type="radio" value="1" name="f_zt"> 停用
                            </label>
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group am-text-left">
                        <div class="am-u-sm-3">&nbsp;</div>
                        <div class="am-u-sm-9">
                            <button type="submit" id="addcsbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                            <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closenewCSdiv()">取消</button>
                        </div>
                    </div>
                </form>
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
        <div id="title_div">入库验收单</div>
        <div id="infol_div">
            <table width='100%' id="infol_tb">
                <tr><th>日&#12288;&#12288;期:</th><td><%=str%></td><th>单&nbsp;据&nbsp;号:</th><td><text id="prt_djh"></text></td>
                </tr>
                <%--<tr><th>进货部门:</th><td><text id="prt_djh"></text></td>--%>
                    <%--<th>入库仓库:</th><td> 0101仓库</td></tr>--%>
                <tr><th>供应商:</th><td><text id="prt_gys"></text></td>
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
<script src="/tree/amazeui.tree.js"></script>
<script src="/tree/amazeui.tree.min.js"></script>
<script src="/assets/js/LodopFuncs.js"></script>
<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
    <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
</object>
<script type="text/javascript">
    var ckxxJson = null;
    var qyck = <%=f_qyck%>;

    $(function(){
        loadCkcs();

        var spdalist ='${spdalist}';
        if(spdalist.length==0){
            console.log('暂无商品信息');
        }else {
            var $spul=$('#spdadiv ul');//商品档案展示ul
            spdalist=JSON.parse(spdalist);
            console.log(spdalist);
            var spdahtml="";
            for(var i=0;i<spdalist.length;i++){
                var spda=spdalist[i];

                if(spdahtml==""){
                    spdahtml="<li>\n" +
                        "                        <div class=\"am-gallery-item\">\n" +
                        "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\" style='height: 150px;'/>\n" +
                        "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                        "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                        "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                        "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\",\"zhjj\": \""+spda.F_ZHJJ+"\",\"csbm\": \""+spda.F_GYSBM+"\",\"csmc\": \""+spda.F_GYSMC+"\"}</span>\n" +
                        "                        </div>\n" +
                        "                    </li>"
                }else{
                    spdahtml+="<li>\n" +
                        "                        <div class=\"am-gallery-item\">\n" +
                        "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\" style='height: 150px;'/>\n" +
                        "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                        "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                        "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                        "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\",\"zhjj\": \""+spda.F_ZHJJ+"\",\"csbm\": \""+spda.F_GYSBM+"\",\"csmc\": \""+spda.F_GYSMC+"\"}</span>\n" +
                        "                        </div>\n" +
                        "                    </li>"
                }
            }
            $spul.append(spdahtml);
        }
        var sxbmList='${sxbmList}';
        if(sxbmList.length==0){
            console.log("暂无分管部门信息");
        }else{
            var bmList=JSON.parse(sxbmList);
            var bmHtmle="";
            for(var i=0;i<bmList.length;i++){
                bmHtmle+="<option value=\""+bmList[i].F_BMBM+"\">"+bmList[i].F_BMMC+"</option>";
            }
            $("#f_bmbm").html(bmHtmle);
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
        loadspfl();
        loadGhs();
        //显示选择权限
        $('#f_spflmc').click(function () {
            $('#SPFLdiv').modal({
                closeViaDimmer: false,
                width:680,
                height:550
            });
            $('#SPFLdiv').modal('open');
            $('#SPFLdiv').css("z-index","1219");
        });
        $('#firstTree').on('selected.tree.amui', function (event, data) {
            var flbm = data.target.id;
            var flmc = data.target.title;
            spflbm = flbm;
            spflmc = flmc;
        });
        //增加商品提交
        $("#addspbtn").click(function (){
            var sptm = $("#f_sptm").val();
            var djh = $("#f_djzh").val();
            var spmc = $("#f_spmc").val();
            var spfl = $("#f_spfl").val();

            if(spfl == ''){
                alertMsg('商品分类不能为空！');
                return;
            }
            if(sptm == ''){
                alertMsg('商品条码不能为空！');
                return;
            }
            if(spmc == ''){
                alertMsg('商品名称不能为空！');
                return;
            }
            var ggxh = $("#f_bzgg").val()
            var jldw = $("#primaryUnit").val();
            var xsj = $("#f_xsj").val();
            var jhj = $("#f_jhj").val();
            var jxsl = $("#f_jxsl").val();
            var xxsl = $("#f_xxsl").val();
            //var scqy = $("#f_scqy").val();
            var scqy = "";
            var scxkz = $("#f_scxkz").val();
            var ghs = $("#inputselect").val();
            var splx = $("input[name='f_splx']:checked").val();
            var nybz = $("input[name='f_nybz']:checked").val();
            var nycpdjz = "";
            var nycpbz = "";
            var nycpbq = "";
            var nycpsms = "";
            var zhl = "";
            var jx = "";
            var mbzzl = "";
            var mbzzldw = "";
            var nycpzmwjbh = $("#f_nycpzmwjbh").val();

            if(splx != '1'){
                if(ggxh == ''){
                    alertMsg('包装规格不能为空！');
                    return;
                }
                if(jhj == ''){
                    alertMsg('进价不能为空！');
                    return;
                }
                if(ghs == '' || ghs == null || ghs == '[]'){
                    alertMsg('供货商不能为空！');
                    return;
                }
            }
            if(xsj == ''){
                alertMsg('售价不能为空！');
                return;
            }

            if("<%=lxbm%>" != '1'  && "<%=lxbm%>" != '0'){
                if(jxsl == ''){
                    alertMsg('进项税率不能为空！');
                    return;
                }
                if(xxsl == ''){
                    alertMsg('销项税率不能为空！');
                    return;
                }
            }
            if("<%=lxbm%>" == '1'){
                zhl = $("#f_zhl").val();
                jx = $("#f_jx").val();
                mbzzl = $("#f_mbzzl").val();
                mbzzldw = $("#f_mbzzldw").val();
            }

            if("<%=lxbm%>" == '0'){
                var result = uploadFiles($("#f_nycpdjzFile"));
                nycpdjz = result;
                nycpbz = uploadFiles($("#f_nycpbzFile"));
                nycpbq = uploadFiles($("#f_nycpbqFile"));
                nycpsms = uploadFiles($("#f_nycpsmsFile"));
            }
            /*if(scxkz == ''){
                alertMsg('生产企业不能为空！');
                return;
            }*/

            var $subbtn = $("#addspbtn");
            $subbtn.button('loading');
            if(ghs == null){
                ghs = "";
            }
            $.ajax({
                url: "/commodity/saveSpda",
                type: "post",
                async: false,
                data: { sptm: sptm, djh: djh,spmc:spmc, spfl: spfl, ggxh: ggxh,jldw:jldw,
                    xsj: xsj,jhj:jhj,jxsl:jxsl,xxsl:xxsl,scxkz:scxkz,ghs:ghs.toString(),scqy:scqy,splx:splx,nybz:nybz,
                    nycpdjz:nycpdjz,nycpbz:nycpbz,nycpbq:nycpbq,nycpsms:nycpsms,nycpzmwjbh:nycpzmwjbh,
                    zhl:zhl,jx:jx,mbzzl:mbzzl,mbzzldw:mbzzldw,timeer: new Date() },
                success: function (data, textStatus) {
                    if(data == "ok"){
                        alertMsg("保存成功！");
                    }
                    $subbtn.button('reset');
                    $('#newSpdiv').modal('close');
                    loadSpxx("");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alertMsg(errorThrown + "||" + textStatus);
                    $subbtn.button('reset');
                }
            });

        });

        $('#f_djzh').keypress(function (e) {
            if (e.keyCode == 13) {
                var djzh = $("#f_djzh").val();
                $.ajax({
                    url: "/goodsAnalysis/goodsInfo",
                    type: "post",
                    async: false,
                    data: {url:djzh, timeer: new Date() },
                    success: function (data) {
                        if(data != '' && data != null && data != 'err'){
                            var json = JSON.parse(data);
                            if(json.length > 0){
                                $("#f_spmc").val(json[0].YPMC);
                                $("#f_zhl").val(json[0].YPZJL);
                                $("#f_jx").val(json[0].YPJX);
                                $("#f_spfl").val(json[0].F_SPLBBM);
                                $("#f_spflmc").val(json[0].YPLB);
                                $("#inputselect").val(json[0].DJHSCCJ);
                                $("#f_djzh").val(json[0].YPDJH);
                                setsptm(json[0].F_SPLBBM);
                            }
                        }else{
                            if(data == 'err'){
                                alertMsg("该商品已添加！");
                            }else if(data == '' || data == '[]'){
                                alertMsg("无国家标准农药信息！");
                            }
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alertMsg(errorThrown + "||" + textStatus);
                        $("#savaBtn").button('reset');
                    }
                });
            }
        });
        $('#addFlxz').click(function () {
            $('#SPFLdiv').modal('close');

            $("#f_spfl").val(spflbm);
            $("#f_spflmc").val(spflmc);
            $("#xgf_spfl").val(spflbm);
            $("#xgf_spflmc").val(spflmc);
            setsptm(spflbm);
        });
        if("<%=lxbm%>" == '1'){
            $('.ypdxs').show();
            $('.ypdbxs').hide();
        }
        if("<%=lxbm%>" == '0'){
            $('.nycsxs').show();
        }else{
            $('.nycsxs').hide();
        }
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

        $('#f_ghs').change(function () {
            var ghs = $('#f_ghs').val();
            if(ghs != null){
                $('#inputselect').val(ghs);
            }else{
                $('#inputselect').val('');
            }
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


    function closeNewspdiv(){
        $('#newSpdiv').modal('close');
    }


    function setsptm(splbbm){
        $.ajax({
            url: "/commodity/getMaxSptm",
            type: "post",
            async: false,
            data: {splbbm:splbbm},
            success: function (data) {
                if(data != ''){
                    $('#f_sptm').val(data);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alertMsg(errorThrown + "||" + textStatus);
            }
        });
    }
    //加载客户
    function loadspfl(){
        $.ajax({
            url: "/commodity/getSplbda",
            type: "post",
            async: false,
            data: {splbbm:'',timeer: new Date() },
            success: function (data) {
                splbJson = data;
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alertMsg(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });


        $('#firstTree').tree({
            dataSource: function(options, callback) {
                // 模拟异步加载
                setTimeout(function() {
                    var json = JSON.parse(splbJson);
                    callback({data: options.products || json});
                }, 400);
            },
            multiSelect: false,
            cacheItems: false,
            folderSelect: true
        });
    }
    //加载供应商
    function loadGhs(){
        $.ajax({
            url: "/initialvalues/GetKhda",
            type: "post",
            async: false,
            data: {khxx:"",cslx:0, timeer: new Date() },
            success: function (data) {
                var $selected = $('#f_ghs');
                var $selected2 = $('#xgf_ghs');
                $selected.html("");
                $selected.append('<option value=""></option>');
                $selected2.html("");
                $selected2.append('<option value=""></option>');
                var res = JSON.parse(data);
                var dataJson = JSON.parse(res.list);
                if(dataJson.length>0) {
                    for(var i=0;i<dataJson.length;i++){
                        var scqymx=dataJson[i];
                        $selected.append('<option value="'+scqymx.F_CSMC+'">'+scqymx.F_CSMC+'</option>');
                        $selected2.append('<option value="'+scqymx.F_CSMC+'">'+scqymx.F_CSMC+'</option>');
                    }
                    $selected.trigger('changed.selected.amui');
                    $selected2.trigger('changed.selected.amui');
                }else{
                    $('#f_ghs').html("");
                    $('#xgf_ghs').html("");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alertMsg(errorThrown + "||" + textStatus);
            }
        });
    };
    function closeQyxzdiv(){
        $('#SPFLdiv').modal('close');
    }
    //显示新增商品
    function showAddsp(){
        $("#f_spfl").val("");
        $("#f_spflmc").val("");
        $("#f_djzh").val("");
        $("#f_sptm").val("");
        $("#f_spmc").val("");
        $("#f_bzgg").val("");
        $("#primaryUnit").val("");
        $("#f_xsj").val("");
        $("#f_jhj").val("");
        $("#f_jxsl").val("");
        $("#f_xxsl").val("");
        $("#f_scqy").val("");
        $("#f_scxkz").val("");
        $("#f_ghs").val("");

        $('#f_scqy').trigger('changed.selected.amui');
        $('#f_ghs').trigger('changed.selected.amui');

        $('#newSpdiv').modal({
            closeViaDimmer: false,
            width:880,
            height:570
        });
        $('#newSpdiv').modal('open');
        $('.am-dimmer').css("z-index","1111");
        $('#newSpdiv').css("z-index","1119");
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
    //判断输入必须是是正数
    function IsNum(num){
        var reNum=/^\d*$/;
        if(reNum.test(num)) { return true; } else { if(num < 0) { alert("价格不能为负数！"); } else { alert("价格必须为数字！"); } return false; }}
    //获取微信扫描商品
    function getwxSpxx(event){
        $.ajax({
            url: "/sales/GetWxsp",
            type: "post",
            async: false,
            data: {f_djlx:1, timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                if(dataJson.length>0) {
                    var html="";
                    for(var i=0;i<dataJson.length;i++){
                        var spjson=dataJson[i];
                        var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                            +"<td class=\"am-text-middle am-td-spmc\">"+spjson.F_SPMC+"</td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                            +"<td class=\"am-text-middle\"><input type=\"text\"/></td>"
                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.F_JLDW+"</td>"
                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\""+spjson.F_XSDJ+"\" onblur=\"resum_row(this)\" /></td>"
                            +"<td class=\"am-text-middle\">"+spjson.F_XSDJ+"</td>"
                            +"<td class=\"am-hide\">"+spjson.F_PCH+"</td>"
                            +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                            +"</tr>";
                        $('#sptable').prepend(rowhtml);
                        if($("#tishitr")!=undefined) {//删除请选择 提示行
                            $("#tishitr").remove();
                        };
                    }
                    recountSppz();
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
    //保存单据
    function savebill(){
        var csbm=$('#csbm').attr('csbm');
        var gysmc=$('#csbm').val();
        var f_ckbm = $('#f_ckbm').val();
        if(csbm===undefined|| csbm.length<0){
            alertMsg('请先选择供应商');
            return;
        }

        var f_ckbm = "";
        if (qyck == 1){
            var cksl = $("#sptable").find("tr").find("select");
            for (var i = 0;i < cksl.length; i++){
                f_ckbm = cksl.eq(i).val();
                if (f_ckbm == null || f_ckbm == "" || f_ckbm == undefined){
                    alertMsg('请选择仓库');
                    return;
                }
            }
        }

        var spcount=$('#hjpz').text();
        if(spcount<=0){
            alertMsg('请选择商品后再提交');
            return;
        }
        var $table=$('#sptable');
        var spxx= "";
        var prtspHmtl="";
        var kong=false;//进货单价为空!;
        var sgkong=false;//手工批次号为空!
        $table.find('tr').each(function () {
            var sptm=$(this).attr('sptm');
            var spdj=$(this).find('td:eq(4)').children("input:first-child").val();
            var spmc=$(this).find('td:eq(0)').text();
            var ggxh=$(this).find('td:eq(1)').text();
            var sgpch=$(this).find('td:eq(2)').children("input:first-child").val();
            var sphjje=$(this).find('td:eq(5)').text();
            var ckbm=$(this).find('td:eq(6)').children("select:first-child").val();
            if(sgpch.length<=0) {
                sgkong=true;
            }
            if(spdj.length<=0){
                kong=true;
            }
            var gjsl=  $(this).find('td:eq(3)').children("input:first-child").val();
            var sp="{\"sptm\":\""+sptm+"\",\"gjdj\":\""+spdj+"\",\"gjsl\":\""+gjsl+"\","+"\"sgpch\":\""+sgpch+"\",\"ckbm\":\""+ckbm+"\"}";
            if(spxx==""){
                spxx="["+sp;
            }else{
                spxx= spxx+","+sp;
            }
            prtspHmtl+="<tr>\n" +
                "                        <td><div noWrap style=\"text-align:left;width:260px;text-overflow:ellipsis;overflow:hidden;\">"+spmc+"</div></td>\n" +
                "                        <td class=\"td_number\">"+ggxh+"</td>\n" +
                "                        <td class=\"td_number\">"+gjsl+"</td>\n" +
                "                        <td class=\"td_number\">"+spdj+"</td>\n" +
                "                        <td class=\"td_number\">"+sphjje+"</td>\n" +
                "                    </tr>"
        })
        if(kong){
            alertMsg("进货单价不能为空!");
            return;
        }
        if(sgkong){
            alertMsg("批号不能为空!");
            return;
        }
        spxx =spxx+"]";
        var yhje=$('#yhje').val();
        var jsje=$('#jsje').text();
        var f_bmbm=$('#f_bmbm').val();
        var f_djbz=$('#f_djbz').val();
        setTimeout(function(){
            $.ajax({
                url: "/purchase/SavaBill",
                type: "post",
                async: false,
                data: {csbm:csbm,f_bmbm:f_bmbm,yhje:yhje,jsje:jsje,spxx:spxx,f_djbz:f_djbz,timeer: new Date() },
                success: function (data) {
                    var rows=data.split("|");
                    if(rows[0]=="ok"){
                        alertMsg('保存成功！')
                        $('#prt_djh').text(rows[1]);
                        $('#prt_sp').html(prtspHmtl);
                        $('#prt_gys').text(gysmc);
                        $('#prt_hjje').text(jsje);
                        var sfdyxp=$('#f_sfdyxp').attr('checked');
                        if(sfdyxp=="checked"){
                            $('#okbtn').click(function () {
                                $('#alertdlg').modal('close');
                                $('.am-dimmer.am-active').hide();
                                $(this).unbind("click");
                                printBill();
                            })
                        }
                        clearpage();
                    }else{
                        alertMsg(data);
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

    //商品档案选择界面 选择商品事件
    function spimgclick(evnet){
        var spjson=$(evnet).children("span:last-child").text();
        spjson=JSON.parse(spjson);
        var flag=checksp(spjson.spbm);
        $('#csbm').val(spjson.csmc);
        $('#csbm').attr('csbm',spjson.csbm);
        //var flag=false;//要求第二次点选不删除已选择商品
        var spcount=0;
        if(!flag){//如果不包含此商品
            if (qyck == 0){
                var rowhtml="<tr sptm='"+spjson.spbm+"'>"
                    +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.spmc+"</td>"
                    +"<td class=\"am-text-middle\">"+spjson.ggxh+"</td>"
                    +"<td class=\"am-text-middle\"><input type=\"text\"/></td>"
                    +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.jldw+"</td>"
                    +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value="+spjson.zhjj+" placeholder='单价' onblur=\"resum_row(this)\" /></td>"
                    +"<td class=\"am-text-middle\">"+spjson.zhjj+"</td>"
                    +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                    +"</tr>";
                $('#sptable').prepend(rowhtml);
            }else if (qyck == 1){
                var rowhtml="<tr sptm='"+spjson.spbm+"'>"
                    +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.spmc+"</td>"
                    +"<td class=\"am-text-middle\">"+spjson.ggxh+"</td>"
                    +"<td class=\"am-text-middle\"><input type=\"text\"/></td>"
                    +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.jldw+"</td>"
                    +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value="+spjson.zhjj+" placeholder='单价' onblur=\"resum_row(this)\" /></td>"
                    +"<td class=\"am-text-middle\">"+spjson.zhjj+"</td>"
                    +"<td class=\"am-text-middle\" style='padding: 0;'>"
                    +"  <select class=\"ddckbm\" data-am-selected=\"{btnWidth: '100%',btnSize: 'sm',maxHeight:'100px',}\" style='width: 100%;height:66.927px;border: 0px;text-align: center;'>"
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
            var hjje=resum_hjje();
            $('#hjje').text(hjje);
            $('#jsje').text(hjje);
            $('#ssje').val(hjje);
            $('#hjpz').text(spcount);
            $('#sphj').text(spcount);
        }else {
            var rowcount=$("#sptable").find('tr').length;
            if(rowcount==0){
                if (qyck == 1){
                    var tshtml="<tr id=\"tishitr\">\n" +
                        "                        <td class=\"am-text-middle\" colspan=\"7\">选择需要购进的商品</td>\n" +
                        "                    </tr>";
                    $('#sptable').html(tshtml);
                }else{
                    var tshtml="<tr id=\"tishitr\">\n" +
                        "                        <td class=\"am-text-middle\" colspan=\"6\">选择需要购进的商品</td>\n" +
                        "                    </tr>";
                    $('#sptable').html(tshtml);
                }
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
            url: "/purchase/GetSpda",
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
                                "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\" style='height: 150px;'/>\n" +
                                "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                                "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                                "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                                "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\",\"zhjj\": \""+spda.F_ZHJJ+"\",\"gysbm\": \""+spda.F_ZHJJ+"\",\"csbm\": \""+spda.F_GYSBM+"\",\"csmc\": \""+spda.F_GYSMC+"\"}</span>\n" +
                                "                        </div>\n" +
                                "                    </li>"
                        }else{
                            spdahtml+="<li>\n" +
                                "                        <div class=\"am-gallery-item\">\n" +
                                "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\" style='height: 150px;'/>\n" +
                                "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                                "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                                "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                                "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\",\"zhjj\": \""+spda.F_ZHJJ+"\",\"gysbm\": \""+spda.F_ZHJJ+"\",\"csbm\": \""+spda.F_GYSBM+"\",\"csmc\": \""+spda.F_GYSMC+"\"}</span>\n" +
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
        var xssl=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(3)').children("input:first-child").val();
        var spdj=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(4)').children("input:first-child").val();
        var result=eval(spdj)*eval(xssl);
        $table.find('tr:eq(' + (rowNum) + ')').find('td:eq(5)').text(result.toFixed(2));
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
            var xssl=  $(this).find('td:eq(3)').children("input:first-child").val();
            var spdj=$(this).find('td:eq(4)').children("input:first-child").val();
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
        if (qyck == 1){
            var tshtml="<tr id=\"tishitr\">\n" +
                "                        <td class=\"am-text-middle\" colspan=\"7\">选择需要购进的商品</td>\n" +
                "                    </tr>";
            $('#sptable').html(tshtml);
        }else{
            var tshtml="<tr id=\"tishitr\">\n" +
                "                        <td class=\"am-text-middle\" colspan=\"6\">选择需要购进的商品</td>\n" +
                "                    </tr>";
            $('#sptable').html(tshtml);
        }
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

    //加载仓库参数
    function loadCkcs() {
        var ckHtml = "";
        var sptableTitleHtml = "";
        var sptableHtml = "";
        if (qyck == 1){
            ckHtml += "     <label for=\"f_ckbm\" style=\"font-size: 16px;\">仓库名称：</label> \n" +
                "           <select id=\"f_ckbm\" data-am-selected=\"{btnWidth: '100%',btnSize: 'sm'}\" style='width: 40%;border: 1px solid #ddd;padding: 7px;'>" +
                "           </select>";
            $("#ckmcDiv").html(ckHtml);
            loadCkxx();

            sptableTitleHtml += "   <tr>"+
                "                       <th class=\"am-text-middle\">商品名称</th>"+
                "                       <th class=\"am-text-middle\">规格</th>"+
                "                       <th class=\"am-text-middle\">批号</th>"+
                "                       <th class=\"am-text-middle\">数量</th>"+
                "                       <th class=\"am-text-middle\">单价</th>"+
                "                       <th class=\"am-text-middle\">金额</th>"+
                "                       <th class=\"am-text-middle\">仓库</th>"+
                "                       <th class=\"am-text-middle\">操作</th>"+
                "                   </tr>";

            sptableHtml += "<tr id=\"tishitr\">"+
                "               <td class=\"am-text-middle\" colspan=\"8\">选择需要购进的商品</td>"+
                "           </tr>";
            $("#sptableTitle").html(sptableTitleHtml);
            $("#sptable").html(sptableHtml);
        }else {
            sptableTitleHtml += "   <tr>"+
                "                       <th class=\"am-text-middle\">商品名称</th>"+
                "                       <th class=\"am-text-middle\">规格</th>"+
                "                       <th class=\"am-text-middle\">批号</th>"+
                "                       <th class=\"am-text-middle\">数量</th>"+
                "                       <th class=\"am-text-middle\">单价</th>"+
                "                       <th class=\"am-text-middle\">金额</th>"+
                "                       <th class=\"am-text-middle\">操作</th>"+
                "                   </tr>";

            sptableHtml += "<tr id=\"tishitr\">"+
                "               <td class=\"am-text-middle\" colspan=\"7\">选择需要购进的商品</td>"+
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
                    ckbmHtml += "<option value=''>选择仓库</option>";
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
