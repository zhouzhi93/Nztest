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
    String lxbm=(String)session.getAttribute("f_lxbm");
    String zdrmc=(String)session.getAttribute("f_zymc");
    String f_qyck=(String)session.getAttribute("f_qyck");
    String f_jdxsdts=(String)session.getAttribute("f_jdxsdts");
    String f_qygmxe=(String)session.getAttribute("f_qygmxe");
%>
<%--<!DOCTYPE html>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-销售单</title>
    <meta name="description" content="云平台客户端V1-销售单">
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
    <%--<script src="https://cdn.webrtc-experiment.com/MediaStreamRecorder.js"></script>
    <script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>--%>
    <script src="../../recorder/MediaStreamRecorder.js"></script>
    <script src="../../recorder/adapter-latest.js"></script>
    <script src="../../recorder/recorder-core.js"></script> <!--已包含recorder-core和mp3格式支持-->
    <script src="../../recorder/mp3.js"></script> <!--已包含recorder-core和mp3格式支持-->
    <script src="../../recorder/mp3-engine.js"></script> <!--已包含recorder-core和mp3格式支持-->
    <script src="../../recorder/ztest-codemirror.min.5.48.4.js"></script>
    <script src="../../recorder/ztest-jquery.min-1.9.1.js"></script>
    <script src="../../recorder/ztest-rsa.js"></script>
    <script src="../../recorder/waveview.js"></script>
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
                    <h1>销&nbsp;&nbsp;售&nbsp;&nbsp;单</h1>
                </div>
            </div>

<%--            <div class="mainBox mainCtrl" style="display:none">
                <div style="padding-bottom:12px">
                    <div style="height:100px;width:300px;border:1px solid #ccc;box-sizing: border-box;display:inline-block;vertical-align:bottom" class="ctrlProcessWave"></div>
                    <div style="height:40px;width:300px;display:inline-block;background:#999;position:relative;vertical-align:bottom">
                        <div class="ctrlProcessX" style="height:40px;background:#0B1;position:absolute;"></div>
                        <div class="ctrlProcessT" style="padding-left:50px; line-height:40px; position: relative;"></div>
                    </div>
                </div>

                &lt;%&ndash;<div class="ctrlBtns"></div>&ndash;%&gt;
            </div>--%>
            <div class="am-container"  style="margin-top: 10px;">
                <div class="am-u-sm-4 am-u-md-4 qtxs">
                    <div class="am-btn-group">
                        <button type="button" id="xd" onclick="newXsd()" class="am-btn am-btn-default am-radius am-btn-sm">新单</button>
                        <button type="button" id="sz" onclick="firstXsd()" class="am-btn am-btn-primary am-radius am-btn-sm">首张</button>
                        <button type="button" id="qz" onclick="loadLsxsd()" class="am-btn am-btn-primary am-radius am-btn-sm">前张</button>
                        <button type="button" id="hz" onclick="afterXsd()" class="am-btn am-btn-primary am-radius am-btn-sm">后张</button>
                        <button type="button" id="wz" onclick="finallyXsd()" class="am-btn am-btn-primary am-radius am-btn-sm">尾张</button>
                    </div>
                </div>
                <div class="am-u-sm-8 am-u-md-8">
                    <div class="am-btn-group">
                        <button type="button" onclick="btdownload('../../WebReader/WebReader.rar')" class="am-btn am-btn-danger  am-radius am-btn-sm">
                            下载驱动
                        </button>
                        <button type="button" onclick="readcard(0)" class="am-btn am-btn-danger  am-radius am-btn-sm">刷卡</button>
                        <button id="start-recording" class="am-btn am-btn-primary am-btn-sm am-radius">刷脸</button>
                        <button type="button" onclick="recStart()" class="am-btn am-btn-primary  am-radius am-btn-sm">录音</button>
                        <button type="button" id="rediostop" onclick="recStop(false)" class="am-btn am-btn-primary  am-radius am-btn-sm">停止</button>
                        <button type="button" onclick="querykhxx()" class="am-btn am-btn-primary am-btn-sm am-radius">客户信息</button>
                        <button type="button" onclick="queryJxs()" class="am-btn am-btn-primary am-btn-sm am-radius csxs">季销售</button>
                        <button type="button" onclick="queryNxs()" class="am-btn am-btn-primary am-btn-sm am-radius tjxs">年销售</button>
                        <button type="button" onclick="queryYpsycx()" class="am-btn am-btn-primary am-btn-sm am-radius tjxs">药品使用查询</button>
                        <button type="button" onclick="exist()" class="am-btn am-btn-danger am-btn-sm am-radius">退出</button>
                    </div>
                </div>
            </div>
            <div class="am-container" style="margin-top: 10px;font-weight: 500;font-size: 1.4rem;">
                <div class="am-u-sm-3 am-u-md-3">客户：
                    <input class="am-radius am-form-field am-input-sm" id="khxx" readonly style="width: 140px;display:inline-block;cursor: pointer;" type="text" placeholder="选择客户">
                </div>

                <div class="am-u-sm-3 am-u-md-3">
                    <div id="ckmcDiv">

                    </div>
                </div>

                <div class="am-u-sm-3 am-u-md-3 ctjxs">
                    电话：<span id="dh"></span>
                </div>

                <div class="am-u-sm-3 am-u-md-3">
                    <span class="am-fr" style="vertical-align: middle;">日期：<%=str%></span>
                </div>
            </div>

            <div class="am-container qtxs" style="margin-top: 10px;font-weight: 500;font-size: 1.4rem;">
                <div class="am-u-sm-4 am-u-md-4 ctjxs">
                    身份证号：<span id="sfzh"></span>
                </div>

                <div class="am-u-sm-4 am-u-md-4 ctjxs">
                    集中配送：<span id="jzps"></span>
                </div>

                <div class="am-u-sm-4 am-u-md-4 ctjxs">
                    经营面积：<span id="jymj"></span>亩
                </div>
            </div>

            <div class="am-container qtxs" style="margin-top: 10px;font-weight: 500;font-size: 1.4rem;">
                <div class="am-u-sm-4 am-u-md-4 ctjxs">
                    允许购买金额：<span id="yxgmje"></span>元
                </div>
                <div class="am-u-sm-4 am-u-md-4 csxs">
                    本季累计购买金额：<span id="bjljgmje"></span>元
                </div>

                <div class="am-u-sm-4 am-u-md-4 tjxs">
                    本年累计购买金额：<span id="bnljgmje"></span>元
                </div>

                <div class="am-u-sm-4 am-u-md-4 ctjxs">
                    制单日期：<span id="zdrq"><%=str %></span>
                </div>
            </div>

            <div class="am-container" style="margin-top: 10px;font-weight: 500;font-size: 1.4rem;">
                <div class="am-u-sm-7 am-u-md-7">
                    <label id="smmc">商品条码：</label>
                    <input class="am-radius am-form-field am-input-sm" id="sptmScan"  style="width: 260px;display:inline-block;border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;  " type="text" placeholder="">
                </div>
                <div class="am-u-sm-5 am-u-md-5 am-text-right">
                    <label>部门名称：</label>
                    <select data-am-selected="{btnWidth: '70%', btnSize: 'sm'}" id="f_bmbm">
                    </select>
                </div>
            </div>
            <div class="am-container am-scrollable-vertical" style="margin-top: 10px;">
                <table class="am-table am-table-bordered am-table-centered" >
                    <thead id="sptableTitle">

                    </thead>
                    <tbody id="sptable">

                    </tbody>
                </table>
            </div>
            <div class="am-container">
                <div class="am-u-sm-12 am-u-md-12" id="jdtsdiv" style="color: red;">

                </div>
            </div>
            <div class="am-container">
                <div class="am-u-sm-6 am-u-md-6"><div class="am-cf">
                    共<span onclick="resum_hjje()" id="hjpz" style="color: #E72A33;">0</span>种商品
                </div></div>
                <div class="am-u-sm-6 am-u-md-6"><div class="am-fr">
                    合计：<span id="hjje" style="color: #E72A33;">0.00</span> 元
                </div></div>
                <div class="am-fr am-text-right am-hide" style="margin-top: 10px;margin-right: 10px;">
                    优惠金额：<input id="yhje" class="am-radius am-form-field am-input-sm" min="0" style="width: 120px;display:initial;" type="number" placeholder="">元
                    <br>
                    结算总额：<span id="jsje" style="color: #E72A33;">0.00</span> 元
                </div>
            </div>

            <hr/>
            <div class="am-container" id="xzfkfsDiv">
                <div class="am-u-sm-4 am-u-md-4">
                    付款：<select id="zfbz" data-am-selected="{btnWidth: '60%', btnSize: 'sm'}">
                    <option value="1"selected>现金</option>
                    <option value="7" >支付宝</option>
                    <option value="8">微信</option>
                    <option value="9">赊账</option>
                </select>
                </div>
                    <div class="am-u-sm-4 am-u-md-4 am-inline" style="padding-left: 0px;padding-right: 0px;">
                        实收：<input class="am-radius am-form-field am-input-sm" min="0" id="ssje" style="width: 70px;display:inline-block;"  type="number"  value="0.00">元
                    </div>
                    <div class="am-u-sm-4 am-u-md-4 am-text-right" style="padding-left: 0px;padding-right: 0px;">
                        找零 ：<span id="zlje" style="color: #E72A33;">0.00</span> 元
                    </div>
                <%--</div>--%>
                <div class="am-form" style="clear: both;display: none">
                        <div style="margin-top:10px;"class="am-form-group">
                            备注：<textarea class="" style="width: 100%;display: block;" rows="3" id="doc-ta-1" placeholder="备注内容"></textarea>
                        </div>
                </div>

            </div>
            <div class="am-container" id="kpDiv">
                <div class="am-fr">
                    <input style="vertical-align:middle;" id="f_sfdyxp" type="checkbox"/><span style="font-size: 13px;vertical-align:middle;">打印小票</span>
                    <button type="button" onclick="savebill()" class="am-btn am-btn-danger  am-radius am-btn-sm">开票</button>&nbsp;&nbsp;
                    <button type="button" onclick="getwxSpxx(this)" class="am-btn am-btn-primary am-btn-sm am-radius">调入</button>
                </div>
            </div>
        </div>
        <!--商品档案选择-->
        <div style="padding-top: 20px;display:none;height: 600px;" id="spdadiv" class="am-scrollable-vertical">
            <%--<button type="button" onclick="showAddsp()" class="am-btn am-btn-default am-radius am-btn-sm">新增商品</button>--%>
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
    <!--选择客户div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseKhdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">选择客户
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div class="am-container">
                    <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                        <input class="am-radius am-form-field am-input-sm" id="khoption" style="width: 160px;display:initial;" type="text" placeholder="输入客户名称、字母">
                        <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchKh()">搜索</button>
                    </div>
                    <div class="am-u-sm-6 am-u-md-6 am-text-right">
                        <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadKhxx('')" style="border: 1px solid red;background: white;color: red;">重新加载</button>
                        <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" id="addkh">新增客户</button>
                    </div>
                </div>
                <div style="margin-top: 10px; height: 400px;" class="am-container am-scrollable-vertical">
                    <table class="am-table am-table-bordered am-table-centered" >
                        <thead id = "khth">
                        <tr>
                            <th class="am-text-middle">客户名称</th>
                            <th class="am-text-middle">联系电话</th>
                            <%--<th class="am-text-middle">余额</th>
                            <th class="am-text-middle">欠款</th>--%>
                        </tr>
                        </thead>
                        <tbody id="khtable">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseCameradiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">摄像头
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <section class="experiment" style="padding: 5px;">
                <%--<button id="stop-recording" class="am-btn am-btn-danger  am-radius am-btn-sm" disabled>停止</button>--%>
                <button id='picture' class="am-btn am-btn-primary am-btn-sm am-radius">截图</button>
                <button id='read' class="am-btn am-btn-primary am-btn-sm am-radius">人脸识别</button>
                <button id='readsfz' class="am-btn am-btn-primary am-btn-sm am-radius">身份证识别</button>
            </section>
            <section class="experiment">
                <div id="videos-container" style="float: left"></div>
                <canvas id="canvas" width="320" height="240" style="float: right"></canvas>
            </section>
        </div>
    </div>

    <!--选择商品-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chooseSpdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">请选择商品
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;height: 360px;" class="am-container  am-scrollable-vertical">
                    <table class="am-table am-table-bordered am-table-centered"  >
                        <thead>
                            <tr>
                                <th class="am-text-middle">商品条码</th>
                                <th class="am-text-middle">商品名称</th>
                                <th class="am-text-middle">规格型号</th>
                                <th class="am-text-middle">销售单价</th>
                            </tr>
                        </thead>
                        <tbody id="chooseSptable">
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
            <div class="am-modal-bd am-scrollable-vertical" style="min-height: 430px;" >
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="addspform">
                        <div class="am-form-group">
                            <label for="f_spfl" class="am-u-sm-2 am-form-label" style="padding: 0px;">商品类别</label>
                            <div class="am-u-sm-9">
                                <input readonly type="hidden" class="am-form-field am-input-sm am-radius" id="f_spfl" required placeholder="">
                                <input readonly type="text" class="am-form-field am-input-sm am-radius" id="f_spflmc" placeholder="">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdxs" style="display: none;">
                            <label for="f_djzh" class="am-u-sm-2 am-form-label" style="padding: 0px;">登记号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_djzh" placeholder="二维码扫描">
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
                        <div class="am-form-group">
                            <label for="f_bzgg" class="am-u-sm-2 am-form-label" style="padding: 0px;">包装规格</label>
                            <div class="am-u-sm-9 am-form-inline" style="text-align:left;">
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
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_xsj" class="am-u-sm-2 am-form-label" style="padding: 0px;">售价</label>
                            <div class="am-u-sm-9" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="f_xsj" required placeholder="售价" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">元/<span class="priceUnit">袋</span></span>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_jhj" class="am-u-sm-2 am-form-label" style="padding: 0px;">进价</label>
                            <div class="am-u-sm-9" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="f_jhj" placeholder="进价" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">元/<span class="priceUnit">袋</span></span>
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
                        <%--<div class="am-form-group ypdxs">--%>
                            <%--<label class="am-u-sm-2 am-form-label" style="padding: 0px;">商品类型</label>--%>
                            <%--<div class="am-u-sm-9 am-text-left">--%>
                                <%--<label class="am-radio-inline">--%>
                                    <%--<input type="radio"  value="0" checked name="f_splx"> 商品--%>
                                <%--</label>--%>
                                <%--<label class="am-radio-inline">--%>
                                    <%--<input type="radio" value="1" name="f_splx"> 包装物--%>
                                <%--</label>--%>
                            <%--</div>--%>
                            <%--<div class="am-u-sm-end"></div>--%>
                        <%--</div>--%>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
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
    <!--新建客户div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="newKhdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">新增客户
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="addkhform">
                        <div class="am-form-group">
                            <label for="f_khmc" class="am-u-sm-3 am-form-label">客户名称</label>
                            <div class="am-u-sm-8">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_khmc" required placeholder="客户名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sjhm" class="am-u-sm-3 am-form-label">联系电话</label>
                            <div class="am-u-sm-8">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="f_sjhm" required placeholder="联系电话">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sfzh"  class="am-u-sm-3 am-form-label">证件号码</label>
                            <div class="am-u-sm-8">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_sfzh" placeholder="证件号码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <%--<div class="am-form-group" id="address5" data-am-address="{prov:'上海',scrollToCenter:true}">--%>
                            <%--<label for="f_qydz" class="am-u-sm-2 am-form-label">所在地区</label>--%>
                            <%--<div class="am-u-sm-9">--%>
                                <%--<input type="text" id="f_qydz" class="am-form-field am-input-sm am-radius" readonly required  placeholder="请选择地址">--%>
                            <%--</div>--%>
                            <%--<div class="am-u-sm-end"></div>--%>
                        <%--</div>--%>
                        <%--<div class="am-form-group">--%>
                            <%--<label for="f_xxdz" class="am-u-sm-2 am-form-label">详细地址</label>--%>
                            <%--<div class="am-u-sm-9">--%>
                                <%--<input type="text" class="am-form-field am-input-sm am-radius" required id="f_xxdz" placeholder="详细地址">--%>
                            <%--</div>--%>
                            <%--<div class="am-u-sm-end"></div>--%>
                        <%--</div>--%>
                        <div class="am-form-group">
                            <label for="f_djbz" class="am-u-sm-3 am-form-label">备注</label>
                            <div class="am-u-sm-8">
                                <textarea  class="am-form-field am-input-sm am-radius" id="f_djbz" placeholder="备注"></textarea>
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
                                <button type="submit" id="addkhbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeNewKhdiv()">取消</button>
                                <input type="reset" name="reset" style="display: none;" />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--购买人详情div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="queryKhdiv">
        <div class="am-modal-dialog">
            <div>
                <div class="am-modal-hd">购买人信息
                    <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
                </div>
                <div class="am-u-sm-4">
                    <span id="q_gmrxm"></span>
                </div>
                <div class="am-u-sm-4">
                    <span id="q_gmrsfzh"></span>
                </div>
                <hr data-am-widget="divider" style="" class="am-divider am-divider-default" />
            </div>
            <div id="queryztxx">
                <div class="am-modal-hd" style="padding-top: 0px;">主体信息</div>
                <hr data-am-widget="divider" style="" class="am-divider am-divider-default" />
            </div>
        </div>
    </div>


    <!--查询客户信息div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="updateKhdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">客户信息
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="updatekhform">
                        <div class="am-form-group">
                            <label for="xgf_khmc" class="am-u-sm-2 am-form-label">客户名称</label>
                            <div class="am-u-sm-9">
                                <input type="hidden" id="xgf_khbm" />
                                <input type="text" readonly class="am-form-field am-input-sm am-radius" id="xgf_khmc" required placeholder="客户名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>

                        <div class="am-form-group">
                            <label for="xgf_sjhm" class="am-u-sm-2 am-form-label">联系电话</label>
                            <div class="am-u-sm-9">
                                <input type="tel" readonly class="am-form-field am-input-sm am-radius" id="xgf_sjhm" placeholder="联系电话">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_sfzh"  class="am-u-sm-2 am-form-label">身份证号</label>
                            <div class="am-u-sm-9">
                                <input type="text" readonly class="am-form-field am-input-sm am-radius" id="xgf_sfzh" placeholder="身份证号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_Dz"  class="am-u-sm-2 am-form-label">地址</label>
                            <div class="am-u-sm-9">
                                <input type="text" readonly class="am-form-field am-input-sm am-radius" id="xgf_Dz" placeholder="地址">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_Khh"  class="am-u-sm-2 am-form-label">开户行</label>
                            <div class="am-u-sm-9">
                                <input type="text" readonly class="am-form-field am-input-sm am-radius" id="xgf_Khh" placeholder="开户行">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_Yhkh"  class="am-u-sm-2 am-form-label">银行账号</label>
                            <div class="am-u-sm-9">
                                <input type="text" readonly class="am-form-field am-input-sm am-radius" id="xgf_Yhkh" placeholder="银行账号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_Tyxym"  class="am-u-sm-2 am-form-label">统一信用码</label>
                            <div class="am-u-sm-9">
                                <input type="text" readonly class="am-form-field am-input-sm am-radius" id="xgf_Tyxym" placeholder="统一信用码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>

                        <%--是否集中配送和客户类型div放在这里--%>
                        <div id="xgmorelxDiv">

                        </div>
                        <div class="am-form-group">
                            <label for="xgf_bz" class="am-u-sm-2 am-form-label">备注</label>
                            <div class="am-u-sm-9">
                                <textarea class="am-form-field am-input-sm am-radius" id="xgf_bz" disabled placeholder="备注"></textarea>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>

                        <%--统计明细Div在这--%>
                        <div id="xgtjmxTable" class="am-g">

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%--季销售或年销售div--%>
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1"  id="saleDiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">销售单查询
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <div class="am-form-inline">
                        销售日期:
                        <input type="text" id="f_ksrq" class="am-form-field am-input-sm am-radius" style="width: 150px;" data-am-datepicker readonly placeholder="开始日期">至
                        <input type="text" id="f_jsrq" class="am-form-field am-input-sm am-radius" style="width: 150px;" data-am-datepicker readonly placeholder="结束日期">&nbsp;&nbsp;&nbsp;&nbsp;
                        查询方式:
                        <label class="am-radio-inline">
                            <input type="radio" value="0" checked="checked" name="f_cxfs"> 单据汇总
                        </label>
                        <label class="am-radio-inline">
                            <input type="radio" value="1"  name="f_cxfs"> 明细查询
                        </label>
                    </div>

                    <div class="am-form-inline" style="margin-top: 10px;">
                        <input type="text" id="searchSpxx" class="am-form-field am-input-sm am-radius" style="width: 230px;" placeholder="在当前条件下搜索商品名">&nbsp;
                        <button onclick="querySaleBill()" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger">查询</button>
                        <%--<button onclick="getexcel()" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger">导出excel</button>--%>
                        <%--<button onclick="loadInfo('')" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger" style="margin-left: 10px;background-color: #fff !important;border: 1px solid #e52a33 !important;color: #e52a33 !important;">重新加载</button>--%>
                    </div>

                    <div class="am-scrollable-horizontal am-scrollable-vertical" style="margin-top: 15px;height:800px;">
                        <table class="am-table am-table-bordered am-table-striped am-text-nowrap am-table-centered" id="hztable">
                            <thead>
                            <tr>
                                <th class="am-text-middle">操作</th>
                                <th class="am-text-middle">制单时间</th>
                                <th class="am-text-middle">客户名称</th>
                                <th class="am-text-middle">合计金额</th>
                                <th class="am-text-middle">结算总金额</th>
                                <th class="am-text-middle">付款金额</th>
                            </tr>
                            </thead>
                            <tbody id="saletable">
                            </tbody>
                        </table>
                        <table class="am-table am-table-bordered am-table-striped am-text-nowrap am-table-centered" id="mxtable" style="display: none;">
                            <thead>
                            <tr>
                                <th class="am-text-middle">单据号</th>
                                <th class="am-text-middle">制单日期</th>
                                <th class="am-text-middle">商品条码</th>
                                <th class="am-text-middle">商品名称</th>
                                <th class="am-text-middle">商品属性</th>
                                <th class="am-text-middle">规格</th>
                                <th class="am-text-middle">批号</th>
                                <th class="am-text-middle">单位</th>
                                <th class="am-text-middle">单价</th>
                                <th class="am-text-middle">销售数量</th>
                                <th class="am-text-middle">销售金额</th>
                            </tr>
                            </thead>
                            <tbody id="saleMxtable">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!--销售单详情-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="xsDetail">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">销售单据详情
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;height: 380px;" class="am-container  am-scrollable-vertical">
                    <table class="am-table am-table-bordered am-table-centered"  >
                        <thead>
                        <tr>
                            <th class="am-text-middle">商品名称</th>
                            <th class="am-text-middle">规格型号</th>
                            <th class="am-text-middle">销售单价</th>
                            <th class="am-text-middle">销售数量</th>
                            <th class="am-text-middle">实收金额</th>
                            <th class="am-text-middle">录音文件</th>
                        </tr>
                        </thead>
                        <tbody id="xsDetailtable">
                        </tbody>
                    </table>
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

    <div style="display: none;" id="printDiv">
        <style>
            .td_rht	{text-align:right;}
            #td_t1{font-size:14px;font-weight:bold;text-align:center;}
            #printMain div,#printMain td,#printMain th,#printMain span.font{font-size:12px;text-align:left;margin:0;padding:0;}
            #printMain table{border-collapse:collapse;jerry:expression(cellSpacing="0");border:0;margin:0px;padding:0px;width:100%;}
            #printMain td{padding-left:2px;}
            #page_div	{width:180px;border-width:0px;margin:0px auto;}
            #td_t1{font-size:14px;font-weight:bold;text-align:center;}
            #printMain th{font-size:12px}
            #printMain td{font-size:12px}
            #td_t2{font-size:14px;font-family:楷体;text-align:center;font-weight:bold;}
            #infol_div{width:100%;border:0px solid red;margin-top:15px;}
            #datatb{width:100%; margin:0;padding:0;border-collapse:collapse;border:2px solid gray;border-width:2px 0;table-layout:fixed;}
            #printMain tr{height:20px;}

            #datatb td,#datatb th{border:0px solid gray;text-align:right;font-size:12.5px;}
            #datatb th{text-align:center;}
            #printMain div span{line-height:18px;}
            #hjl td{border-width:1px 0;border-style:dotted;border-color:gray;height:20px;}
        </style>
        <div id="page_div" style="font-size:12px;text-align:left;margin:0;padding:0;">	<%
            int ps=1;
            int cp=1;
        %>
        </div>
        <div id="printMain">
            <div id="td_t1">销售单</div>
            <div>
                <table style="float:left;display:inline" class="tablePrt">
                    <tr><td style='text-align:left'>网点:<text id="prt_wd"></text></td></tr>
                    <tr><td style='text-align:left'>日期:<%=str%></td></tr>
                    <tr><td style='text-align:left'>单据号:<text id="prt_djh"></text></td></tr>
                    <tr><td style='text-align:left'>顾客:<text id="prt_kh"></text></td></tr>
                    <tr><td style='text-align:left'>收银员:<%=zdrmc%></td></tr>
                </table>
                <table id='datatb' style="display:inline;width:100%;">
                    <tr><th style='width:26%'>名称</th>
                        <th style='width:24%'>数量</th>
                        <th style='width:24%'>单价</th>
                        <th style='width:26%'>金额</th></tr>
                    <tbody id="prt_sp">

                    </tbody>

                    <tr id='hjl'><td colspan=4><span style='font-weight:bold;'>小计:</span>
                        <text id="prt_xjje"></text>&nbsp;
                        <span style='font-weight:bold;'>应收:</span><text id="prt_ysje"></text></td></tr>
                    <tr><th colspan=4>交易时刻:<text id="prt_jysk"></text></th></tr>
                    <tr><td colspan=4 style='text-align:left'><span style='font-weight:bold;'>实收:</span><text id="prt_ssje"></text></td></tr>
                    <tr><td colspan=4 style='text-align:left'><span style='font-weight:bold;'>应收:</span><text id="prt_xj"></text></td></tr>
                    <tr><td colspan=4 style='text-align:left'><span style='font-weight:bold;'>找零:</span><text id="prt_zl"></text></td></tr>
                    <tr><td colspan=4 style='text-align:left'><span style='font-weight:bold;'>大写:</span><text id="prt_dxje"></text></td></tr>
                    <tr><td colspan=4 ><text id="prt_jdts" style="text-align: left;"></text></td></tr>
                    <tr><th colspan=4 >请妥善保管此票据</th></tr>
                </table>
            </div>
            <div>
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
        var redioid = null;
        var rediobolb = null;
        var khxxobj = null;
        var ckxxJson = null;
        var clickCsbm = null;
        var slJson = null;
        var qyck = <%=f_qyck%>;
        var sfsyjdFlag=false;

        $(function(){
            loadCkcs();

            var spdalist ='${spdalist}';
            if(spdalist.length==0){

            }else {
                var $spul=$('#spdadiv ul');//商品档案展示ul
                spdalist=JSON.parse(spdalist);
                var spdahtml="";
                for(var i=0;i<spdalist.length;i++){
                    var spda= spdalist[i];
                    if(spdahtml==""){
                        spdahtml="<li>\n" +
                            "                        <div class=\"am-gallery-item\">\n" +
                            "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\" style='height: 150px;'/>\n" +
                            "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                            "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                            "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                            "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\"}</span>\n" +
                            "                        </div>\n" +
                            "                    </li>"
                    }else{
                        spdahtml+="<li>\n" +
                            "                        <div class=\"am-gallery-item\">\n" +
                            "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\"  style='height: 150px;'/>\n" +
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
            var lxbm= '<%=lxbm%>';
            if(lxbm=="1"){
                $('#smmc').text("农药登记号：");
                $('#sptmScan').attr('placeholder',"扫描二维码/输入登记号");
            };
            var show= localStorage.getItem("showSpdiv");//用户最后一次选择展示还是不展示商品选择
            if(show=="true"){
                $("#xsdiv").removeClass("am-u-sm-12 am-u-md-12").addClass("am-u-sm-6 am-u-md-6");
                $("#spdadiv").addClass("am-u-sm-6 am-u-md-6");
                $("#spdadiv").show();
                $("#morespda").removeClass("am-icon-chevron-left").addClass("am-icon-chevron-right");
            }

            $('.am-gallery-item').click(function () {
                spimgclick(this);
            });

            $('#sptmScan').keypress(function (e) {
                if (e.keyCode == 13) {
                    var tm=$('#sptmScan').val();
                    $.ajax({
                        url: "/sales/GetSpda_PD",
                        type: "post",
                        async: false,
                        data: {url:tm, timeer: new Date() },
                        success: function (data) {
                           var spJarr=JSON.parse(data);
                            if(spJarr.length<=0){return;}
                            if(spJarr.length==1){
                                var spjson=spJarr[0];
                                if(spjson.F_XJBZ == 1){
                                    alertMsg("该商品已下架！")
                                    return;
                                }
                                //var flag=checksp(spjson.F_SPTM);
                                var flag=false;
                                var spcount=0;
                                if(!flag){//如果不包含此商品
                                    if (qyck == 0){
                                        var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                                            +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.F_SPMC+"</td>"
                                            +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.F_JLDW+"</td>"
                                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\""+spjson.F_XSDJ+"\" onblur=\"resum_row(this)\" /></td>"
                                            +"<td class=\"am-text-middle\">"+spjson.F_XSDJ+"</td>"
                                            +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                            +"</tr>";
                                        $('#sptable').prepend(rowhtml);
                                    }else if (qyck == 1){
                                        var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                                            +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.F_SPMC+"</td>"
                                            +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.F_JLDW+"</td>"
                                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\""+spjson.F_XSDJ+"\" onblur=\"resum_row(this)\" /></td>"
                                            +"<td class=\"am-text-middle\">"+spjson.F_XSDJ+"</td>"
                                            +"<td class=\"am-text-middle\" style='padding: 0;'>"
                                            +"  <select class='ddckbm' data-am-selected=\"{btnWidth: '100%',btnSize: 'sm',maxHeight:'100px',}\" style='width: 100%;height:66.927px;border: 0px;text-align: center;'>"
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
                                    if($("#sptable").find("tr").length > 1) {//删除请选择 提示行
                                        $("#sptable").find("#tishitr").remove();
                                    };
                                    spcount=$("#sptable").find('tr').length;
                                    $(this).addClass("am-gallery-item-boder");
                                    var hjje=resum_hjje();
                                    $('#hjje').text(hjje);
                                    $('#jsje').text(hjje);
                                    $('#ssje').val(hjje);
                                    $('#hjpz').text(spcount);
                                    $('#sphj').text(spcount);
                                }
                                recountSppz();
                            }else {
                                var html="";
                                for(var i=0;i<spJarr.length;i++){
                                    var row=spJarr[i];
                                    if(row.F_XJBZ == 1){
                                        continue;
                                    }
                                    html+="<tr>\n" +
                                        "                            <td class=\"am-text-middle\">"+row.F_SPTM+"</td>\n" +
                                        "                            <td class=\"am-text-middle\">"+row.F_SPMC+"</td>\n" +
                                        "                            <td class=\"am-text-middle\">"+row.F_GGXH+"</td>\n" +
                                        "                            <td class=\"am-text-middle\">"+row.F_XSDJ+"</td>\n" +
                                        "                        </tr>"
                                }
                                $('#chooseSptable').html(html);
                                $('#chooseSptable tr').click(function () {
                                    var rowNum=$(this).index();
                                    var $table=$(this).parent();
                                    var sptm=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                                    var spmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(1)').text();
                                    var ggxh=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(2)').text();
                                    var xsdj=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(3)').text();
                                    if (qyck == 0){
                                        var rowhtml="<tr sptm='"+sptm+"'>"
                                            +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spmc+"</td>"
                                            +"<td class=\"am-text-middle\">"+ggxh+"</td>"
                                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+ggxh+"</td>"
                                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\""+xsdj+"\" onblur=\"resum_row(this)\" /></td>"
                                            +"<td class=\"am-text-middle\">"+xsdj+"</td>"
                                            +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                            +"</tr>";
                                        $('#sptable').prepend(rowhtml);
                                    }else if (qyck == 1){
                                        var rowhtml="<tr sptm='"+sptm+"'>"
                                            +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spmc+"</td>"
                                            +"<td class=\"am-text-middle\">"+ggxh+"</td>"
                                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+ggxh+"</td>"
                                            +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\""+xsdj+"\" onblur=\"resum_row(this)\" /></td>"
                                            +"<td class=\"am-text-middle\">"+xsdj+"</td>"
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

                                    if($("#sptable").find("tr").length > 1) {//删除请选择 提示行
                                        $("#sptable").find("#tishitr").remove();
                                    };
                                    spcount=$("#sptable").find('tr').length;
                                    $(this).addClass("am-gallery-item-boder");
                                    var hjje=resum_hjje();
                                    $('#hjje').text(hjje);
                                    $('#jsje').text(hjje);
                                    $('#ssje').val(hjje);
                                    $('#hjpz').text(spcount);
                                    $('#sphj').text(spcount);
                                    $('#chooseSpdiv').modal('close');
                                });
                                $('#chooseSpdiv').modal({
                                    closeViaDimmer: false,
                                    width:680,
                                    height:420
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
                    $("#sptmScan").val("");
                }
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
            //增加客户提交
            $("#addspbtn").click(function (){
                var sptm = $("#f_sptm").val();
                var spewm = $("#f_spewm").val();
                var djh = $("#f_djzh").val();
                var spmc = $("#f_spmc").val();
                var spfl = $("#f_spfl").val();
                if(spfl == ''){
                    alertMsg('商品分类不能为空！');
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
                var ghs = $("#f_ghs").val();
                var splx = "0";//销售只能增加商品 不存在包装物
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

                if("<%=lxbm%>" != '1'){
                    if(jxsl == ''){
                        alertMsg('进项税率不能为空！');
                        return;
                    }
                    if(xxsl == ''){
                        alertMsg('销项税率不能为空！');
                        return;
                    }
                }
                try {
                    var $subbtn = $("#addspbtn");
                    $subbtn.button('loading');
                    setTimeout(function () {
                        $.ajax({
                            url: "/commodity/saveSpda",
                            type: "post",
                            async: false,
                            data: { sptm: sptm, djh: djh,spmc:spmc, spfl: spfl, ggxh: ggxh,jldw:jldw,
                                xsj: xsj,jhj:jhj,jxsl:jxsl,xxsl:xxsl,scxkz:scxkz,ghs:ghs.toString(),scqy:scqy,splx:splx, timeer: new Date() },
                            success: function (data, textStatus) {
                                if(data == "ok"){
                                    alertMsg("保存成功！");
                                    $subbtn.button('reset');
                                    $('#newSpdiv').modal('close');
                                    $('#okbtn').click(function () {
                                        window.location.reload();
                                    });
                                }else{
                                    alertMsg("保存保存失败！");
                                    $subbtn.button('reset');
                                }
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
                            if(data != '' && data != null){
                                var json = JSON.parse(data);
                                if(json.PD != null && json.PD != 'null'){
                                    $("#f_djzh").val(json.PD);
                                }
                                $("#f_spmc").val(json.f_spmc);
                                var ggxh = json.f_ggxh;
                                var ggxhs = ggxh.split("/");
                                $("#f_bzgg").val(ggxhs[0]);
                                $("#primaryUnit").val(ggxhs[1]);
                            }else{
                                alertMsg(data);
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
            $('#ssje').blur(function () {
                var ssje=$(this).val();
                var jsje= $('#jsje').text();
                var res=(ssje-jsje).toFixed(2);
                var zlje = '0.00';
                var yhje = '0.00';
                if(res>0){
                    zlje = res;
                }else if(res <0){
                    yhje = Math.abs(res);
                }
                $(this).val(ssje);
                $('#zlje').text(zlje);
                $('#yhje').val(yhje);
            });
            //显示选择客户
            $('#khxx').click(function () {
                var sxbmList='${sxbmList}';
                var bmList=JSON.parse(sxbmList);
                for(var i=0;i<bmList.length;i++) {
                    if (bmList[i].F_YJMM != '1') {
                        //显示选择客户
                        /*$('#khxx').click(function () {
                            $('#chooseKhdiv').modal({
                                closeViaDimmer: false,
                                width:680,
                                height:500
                            });
                            loadKhxx('',null);
                            $('#chooseKhdiv').modal('open');
                        });*/
                        $('#khoption').val("");
                        var khthhtml="<tr>\n" +
                            "                            <th class=\"am-text-middle\">客户名称</th>\n" +
                            "                            <th class=\"am-text-middle\">联系电话</th>\n";
                        khthhtml += "                        </tr>";
                        $('#khth').html(khthhtml);
                        $('#chooseKhdiv').modal({
                            closeViaDimmer: false,
                            width:680,
                            height:500
                        });
                        loadKhxx('',null,null);
                        $('#chooseKhdiv').modal('open');
                        break;
                    }
                }
//                $('#chooseKhdiv').modal({
//                    closeViaDimmer: false,
//                    width:680,
//                    height:500
//                });
//                loadKhxx('',null);
//                $('#chooseKhdiv').modal('open');
            });
            //显示新增客户
            $('#addkh').click(function () {
                $('#newKhdiv').modal({
                    closeViaDimmer: false,
                    width:580,
                    height:400
                });
                $('#newKhdiv').modal('open');
                $('.am-dimmer').css("z-index","1111");
                $('#newKhdiv').css("z-index","1119");
            });

            //关闭还原遮罩蒙板z-index
            $('#newKhdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
            //关闭还原遮罩蒙板z-index
            $('#newSpdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
            //关闭还原遮罩蒙板z-index
            $('#queryKhdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
            //增加客户提交
            $('#addkhform').validator({
                H5validation: false,
                submit: function () {
                    var formValidity = this.isFormValid();
                    if (formValidity) {
                        try {
                            var $subbtn = $("#addkhbtn");
                            $subbtn.button('loading');
                            var f_khmc = $("#f_khmc").val();
                            var f_sjhm = $("#f_sjhm").val();
                            var f_sfzh = $("#f_sfzh").val();
                            var f_djbz = $("#f_djbz").val();
                            var f_zt = $("#f_zt").val();
                            var f_xxdz = "";
                            setTimeout(function () {
                                $.ajax({
                                    url: "/sales/AddKhda",
                                    type: "post",
                                    async: false,
                                    data: { f_khmc: f_khmc, f_sjhm: f_sjhm,f_sfzh:f_sfzh,f_bzxx: f_djbz, f_xxdz: f_xxdz, timeer: new Date() },
                                    success: function (data, textStatus) {
                                        if(data.toLowerCase()=="ok"){
                                        alertMsg("客户添加成功");
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

            $('#chooseCameradiv').on('close.modal.amui', function(){
                console.log('第一个演示弹窗打开了');
                mediaRecorder.stop();
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

            //根据不同类型编码，加载不同页面
            if("<%=lxbm %>" == "12"){
                //常熟
                $(".csxs").show();
                $(".tjxs").hide();
                $(".ctjxs").show();
            }else if ("<%=lxbm %>" == "13" || "<%=lxbm %>" == "14"){
                //太仓江阴
                $(".csxs").hide();
                $(".tjxs").show();
                $(".ctjxs").show();
            }else {
                //其它
                $(".csxs").hide();
                $(".tjxs").hide();
                $(".ctjxs").hide();
                $(".qtxs").remove();
            }

            $('input[type=radio][name=f_cxfs]').change(function(){
                if(this.value=='0'){
                    $('#hztable').show();
                    $('#mxtable').hide();
                }else{
                    $('#mxtable').show();
                    $('#hztable').hide();
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
                            $selected.append('<option value="'+scqymx.F_CSBM+'">'+scqymx.F_CSMC+'</option>');
                            $selected2.append('<option value="'+scqymx.F_CSBM+'">'+scqymx.F_CSMC+'</option>');
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
                width:580,
                height:480
            });
            $('#newSpdiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#newSpdiv').css("z-index","1119");
        }
        //打印
        function printBill(){
            try {
                var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));
                var html=document.getElementById('printDiv').innerHTML;
                LODOP.ADD_PRINT_HTM(0, 0, 180, 2000, html);
                LODOP.PREVIEW();
                //LODOP.PRINTA();//
            //LODOP.PRINT();
            } catch(e){
            //window.print();
            }
        }
        //获取微信扫描商品
        function getwxSpxx(event){
            $.ajax({
                url: "/sales/GetWxsp",
                type: "post",
                async: false,
                data: {f_djlx:0, timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    if(dataJson.length>0) {
                        var html="";
                        for(var i=0;i<dataJson.length;i++){
                            var spjson=dataJson[i];
                            if (qyck == 0){
                                var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                                    +"<td class=\"am-text-middle am-td-spmc\">"+spjson.F_SPMC+"</td>"
                                    +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                    +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.F_JLDW+"</td>"
                                    +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\""+spjson.F_XSDJ+"\" onblur=\"resum_row(this)\" /></td>"
                                    +"<td class=\"am-text-middle\">"+spjson.F_XSDJ+"</td>"
                                    +"<td class=\"am-hide\">"+spjson.F_PCH+"</td>"
                                    +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                    +"</tr>";
                                $('#sptable').prepend(rowhtml);
                            }else if (qyck == 1){
                                var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                                    +"<td class=\"am-text-middle am-td-spmc\">"+spjson.F_SPMC+"</td>"
                                    +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                    +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.F_JLDW+"</td>"
                                    +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"number\" min=\"1\" value=\""+spjson.F_XSDJ+"\" onblur=\"resum_row(this)\" /></td>"
                                    +"<td class=\"am-text-middle\">"+spjson.F_XSDJ+"</td>"
                                    +"<td class=\"am-hide\">"+spjson.F_PCH+"</td>"
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
                            if($("#sptable").find("tr").length > 1) {//删除请选择 提示行
                                $("#sptable").find("#tishitr").remove();
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

            this.recStop(true);

        };

        function savebills(){
            var khbm=$('#khxx').attr('sptm');
            if(khbm===undefined|| khbm.length<=0){
                alertMsg('请先选择客户');
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

            //判断购买限额是否开启
            if("<%=f_qygmxe %>" == "1"){
                var yxgmje = parseFloat($("#yxgmje").text());//允许购买金额
                var bcgmje = parseFloat($("#hjje").text());//本次购买金额
                if ("<%=lxbm %>" == "12"){
                    var bjljgmje = parseFloat($("#bjljgmje").text());//本季累计购买金额
                    if (bjljgmje + bcgmje > yxgmje){
                        alertMsg('超出允许购买金额！');
                        return;
                    }
                }else if ("<%=lxbm %>" == "13" || "<%=lxbm %>" == "14"){
                    var bnljgmje = parseFloat($("#bnljgmje").text());//本年累计购买金额
                    if (bnljgmje + bcgmje > yxgmje){
                        alertMsg('超出允许购买金额！');
                        return;
                    }
                }
            }

            var $table=$('#sptable');
            var spxx= "";
            var prtspHmtl="";
            $table.find('tr').each(function () {
                var sptm=$(this).attr('sptm');
                var spmc=$(this).find('td:eq(0)').text();
                var sphjje=$(this).find('td:eq(4)').text();
                var xssl=$(this).find('td:eq(2)').children("input:first-child").val();
                var spdj=$(this).find('td:eq(3)').children("input:first-child").val();
                var ckbm=$(this).find('td:eq(5)').children("select:first-child").val();
                var sp="{\"sptm\":\""+sptm+"\",\"spdj\":\""+spdj+"\",\"xssl\":\""+xssl+"\",\"ckbm\":\""+ckbm+"\"}";
                if(spxx==""){
                    spxx="["+sp;
                }else{
                    spxx= spxx+","+sp;
                }
                prtspHmtl+="<tr><td colspan=4 style='text-align:left'>"+spmc+"</td></tr>\n" +
                    "                    <tr><td>&nbsp;</td>\n" +
                    "                        <td>"+xssl+"</td>\n" +
                    "                        <td>"+spdj+"</td>\n" +
                    "                        <td>"+sphjje+"</td>\n" +
                    "                    </tr>"
            })
            var spxx =spxx+"]";
            var yhje=$('#yhje').val();
            if(yhje == null || yhje == ''){
                yhje = '0.00';
            }
            var jsje=$('#jsje').text();
            var f_bmbm=$('#f_bmbm').val();
            var zfbz = $('#zfbz').val();
            $("#rediostop").click();

            $.ajax({
                url: "/sales/SavaBill",
                type: "post",
                async: false,
                data: {khbm:khbm,f_bmbm:f_bmbm,yhje:yhje,jsje:jsje,spxx:spxx,zfbz:zfbz,redio:rediobolb,timeer: new Date() },
                success: function (data) {
                    var rows=data.split("|");
                    if(rows[0]=="ok"){
                        alertMsg('开票成功！')
                        $('#prt_djh').text(rows[1]);
                        $('#prt_sp').html(prtspHmtl);
                        $('#prt_xjje').text(jsje);
                        $('#prt_ysje').text(jsje);
                        $('#prt_ssje').text(eval($('#ssje').val()).toFixed(2));
                        $('#prt_xj').text(jsje);
                        $('#prt_wd').text($('#f_bmbm').text());
                        $('#prt_zl').text($('#zlje').text());
                        var dxje=toUper(jsje);
                        $('#prt_dxje').text(dxje);
                        var jysk=new Date().Format("yyyy-MM-dd hh:mm:ss");
                        $('#prt_jysk').text(jysk);

                        //豇豆提示信息打印
                        if (sfsyjdFlag == true && "<%=f_jdxsdts%>" == 1){
                            $('#prt_jdts').text("提示：请根据农药标签指导规范用药！");
                        }

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
                        var filename = $('#f_bmbm').text()+"_"+rows[1];
                    }
                    else {
                        alertMsg(data)
                    }
                    rediobolb = null;
                    redioid = null;
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
                    //$("#savaBtn").button('reset');
                }
            });
        }


        Date.prototype.Format = function (fmt) { // author: meizz
            var o = {
                "M+": this.getMonth() + 1, // 月份
                "d+": this.getDate(), // 日
                "h+": this.getHours(), // 小时
                "m+": this.getMinutes(), // 分
                "s+": this.getSeconds(), // 秒
                "q+": Math.floor((this.getMonth() + 3) / 3), // 季度
                "S": this.getMilliseconds() // 毫秒
            };
            if (/(y+)/.test(fmt))
                fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        }
        //金额转中文大写
        function toUper(v){
            v+="";
            var s=v.length;
            var j=v.indexOf(".");
            if(j==-1){v+=".00";j=v.indexOf(".");s+=3;}
            var c="";
            var s_=new Array("毫","厘","分","角","元","拾","佰","仟","万","拾","佰","仟","亿","拾","佰","仟","兆","拾","佰","仟","京","拾","佰","仟");
            var n_=new Array("零","壹","贰","叁","肆","伍","陆","柒","捌","玖");
            var r="",d=null,w=false;;
            for(var i=0;i<s;i++){
                if(j-i+4<0)break;//只能到毫
                c=v.substring(i,i+1);
                if(".".indexOf(c)!=-1)continue;
                else if("-".indexOf(c)!=-1)r+="负";
                else {
                    d=s_[j-i+(j<i?4:3)];
                    w="万亿兆京".indexOf(d)!=-1;
                    if(c=="0"&&(w||r.substring(r.length-1)=="零"))r+="";
                    else r+=n_[c];
                    if(c!="0"||w)r+=d;
                }
            }
            while((j=r.indexOf("零分"))!=-1)r=r.substring(0,j)+r.substring(j+1);
            while((j=r.indexOf("零角"))!=-1)r=r.substring(0,j)+r.substring(j+1);
            while((j=r.indexOf("零元"))!=-1)r=r.substring(0,j)+r.substring(j+1);
            while((j=r.indexOf("零拾"))!=-1)r=r.substring(0,j)+r.substring(j+1);
            while((j=r.indexOf("零佰"))!=-1)r=r.substring(0,j)+r.substring(j+1);
            while((j=r.indexOf("零仟"))!=-1)r=r.substring(0,j)+r.substring(j+1);
            while((j=r.indexOf("零万"))!=-1)r=r.substring(0,j)+r.substring(j+1);
            while((j=r.indexOf("零亿"))!=-1)r=r.substring(0,j)+r.substring(j+1);
            while((j=r.indexOf("零兆"))!=-1)r=r.substring(0,j)+r.substring(j+1);
            while((j=r.indexOf("零京"))!=-1)r=r.substring(0,j)+r.substring(j+1);
            while((j=r.indexOf("京兆"))!=-1)r=r.substring(0,j+1)+n_[0]+r.substring(j+2);
            while((j=r.indexOf("兆亿"))!=-1)r=r.substring(0,j+1)+n_[0]+r.substring(j+2);
            while((j=r.indexOf("亿万"))!=-1)r=r.substring(0,j+1)+n_[0]+r.substring(j+2);
            if(r.substring(r.length-1)==n_[0])r=r.substring(0,r.length-1);
            if(r.indexOf("角")==-1&&r.indexOf("分")==-1){
                if(r.indexOf("元")==-1)r+="元";
                r+="整";
            }
            return r;
        }


        //商品档案选择界面 选择商品事件
        function spimgclick(evnet){
            var spjson=$(evnet).children("span:last-child").text();
            spjson=JSON.parse(spjson);
            //var flag=checksp(spjson.spbm);
            var flag=false;//要求第二次点选不删除已选择商品
            var spcount=0;
            if(!flag){//如果不包含此商品
                if (qyck == 0){
                    var rowhtml="<tr sptm='"+spjson.spbm+"'>"
                        +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.spmc+"</td>"
                        +"<td class=\"am-text-middle\">"+spjson.ggxh+"</td>"
                        +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.jldw+"</td>"
                        +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\""+spjson.spdj.toFixed(2)+"\" onblur=\"resum_row(this)\" /></td>"
                        +"<td class=\"am-text-middle\">"+spjson.spdj.toFixed(2)+"</td>"
                        +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                        +"</tr>";
                    $('#sptable').prepend(rowhtml);
                }else if (qyck == 1){
                    var rowhtml="<tr sptm='"+spjson.spbm+"'>"
                        +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.spmc+"</td>"
                        +"<td class=\"am-text-middle\">"+spjson.ggxh+"</td>"
                        +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\"1\" onblur=\"resum_row(this)\"/>"+spjson.jldw+"</td>"
                        +"<td class=\"am-text-middle\" onmouseover=\"GetFocus(this)\"><input type=\"text\" min=\"1\" value=\""+spjson.spdj.toFixed(2)+"\" onblur=\"resum_row(this)\" /></td>"
                        +"<td class=\"am-text-middle\">"+spjson.spdj.toFixed(2)+"</td>"
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

                if($("#sptable").find("tr").length > 1) {//删除请选择 提示行
                    $("#sptable").find("#tishitr").remove();
                };


                //判断销售商品是否适用豇豆，适用并且参数设置打开的话给提示
                var sptms = "";
                spcount = $("#sptable").find('tr').length;//商品数量
                for (var i = 0;i < spcount; i++){
                    var sptm = $("#sptable").find("tr").eq(i).attr("sptm");
                    if (i == spcount-1){
                        sptms += sptm;
                    }else {
                        sptms += sptm + ",";
                    }
                }

                //判断商品是否适用豇豆
                sfsyjd(sptms);
                if (sfsyjdFlag == true && "<%=f_jdxsdts%>" == 1){
                    $('#jdtsdiv').html("提示:请提醒购药人根据农药标签指导规范用药!");
                }




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
                            "                        <td class=\"am-text-middle\" colspan=\"7\">选择需要出售的商品</td>\n" +
                            "                    </tr>";
                        $('#sptable').html(tshtml);
                    }else{
                        var tshtml="<tr id=\"tishitr\">\n" +
                            "                        <td class=\"am-text-middle\" colspan=\"6\">选择需要出售的商品</td>\n" +
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
            var khxx=$('#khoption').val();
            loadKhxx(khxx,null,null);
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
                                    "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\" style='height: 150px;'/>\n" +
                                    "                                <div class=\"am-gallery-desc\">规格："+spda.F_GGXH+"</div>\n" +
                                    "                            <div class=\"am-gallery-desc\">售价：<span style=\"color:red;font-size: 1.5rem;\">"+spda.F_XSDJ+"元</span></div>\n" +
                                    "                            <div class=\"am-text-sm\">"+spda.F_SPMC+"</div>\n" +
                                    "                            <span style=\"display: none\">{\"spbm\":\""+spda.F_SPTM+"\",\"spmc\": \""+spda.F_SPMC+"\",\"spdj\": "+spda.F_XSDJ+",\"ggxh\": \""+spda.F_GGXH+"\",\"jldw\": \""+spda.F_JLDW+"\"}</span>\n" +
                                    "                        </div>\n" +
                                    "                    </li>"
                            }else{
                                spdahtml+="<li>\n" +
                                    "                        <div class=\"am-gallery-item\">\n" +
                                    "                                <img src='"+spda.F_SPTP+"'  alt=\""+spda.F_SPMC+"\"  style='height: 150px;'/>\n" +
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

        //加载新销售单
        function newXsd(){
            if (qyck == 1){
                var tshtml="<tr id=\"tishitr\">\n" +
                    "                        <td class=\"am-text-middle\" colspan=\"7\">选择需要出售的商品</td>\n" +
                    "                    </tr>";
                $('#sptable').html(tshtml);
                $("#f_ckbm").val("");
            }else{
                var tshtml="<tr id=\"tishitr\">\n" +
                    "                        <td class=\"am-text-middle\" colspan=\"6\">选择需要出售的商品</td>\n" +
                    "                    </tr>";
                $('#sptable').html(tshtml);
            }
            $("#zdrq").html("<%=str%>");
            $("#hjpz").text("0");
            $("#hjje").text("0.00");

            $("#sptable").removeAttr("f_djh");
            $("#ckmcDiv").show();
            $("#morespda").show();
            $("#xzfkfsDiv").show();
            $("#kpDiv").show();
        }


        //判断商品是否适用豇豆
        function sfsyjd(sptms){
            $.ajax({
                url: "/sales/sfsyjd",
                type: "post",
                async: false,
                data: { sptms: sptms, timeer: new Date() },
                success: function (data) {
                    if (data == "ok"){
                        sfsyjdFlag=true;
                    }else if (data == "412"){
                        sfsyjdFlag=false;
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }



        //清除界面值
        function clearpage(){
            $('#khxx').val('').removeAttr('sptm');
            if (qyck == 1){
                var tshtml="<tr id=\"tishitr\">\n" +
                    "                        <td class=\"am-text-middle\" colspan=\"7\">选择需要出售的商品</td>\n" +
                    "                    </tr>";
                $('#sptable').html(tshtml);
            }else{
                var tshtml="<tr id=\"tishitr\">\n" +
                    "                        <td class=\"am-text-middle\" colspan=\"6\">选择需要出售的商品</td>\n" +
                    "                    </tr>";
                $('#sptable').html(tshtml);
            }
            $('#hjpz').text('0');
            $('#hjje').text("0.00");
            $('#jsje').text("0.00");
            $('#hjje').text(resum_hjje());
            $('#hjpz').text('0');
            $('#f_djbz').val('');
            $('#sphj').text('0');
            $('#ssje').val("0.00");
            $('#zlje').text("0.00");
            $('#sptmScan').val("");
            $('#dh').text("");
            $('#sfzh').text("");
            $('#jzps').text("");
            $('#jymj').text("");
            $('#yxgmje').text("");
            $('#bjljgmje').text("");
            $('#bnljgmje').text("");
            $('#zdrq').text("<%=str%>");
        };
        //清除增加客户界面
        function clearAdd(){
            $("input[type=reset]").trigger("click");
//            $('#f_khmc').val('');
//            $('#f_sjhm').val('');
//            $('#f_sfzh').val('');
//            $('#f_qydz').val('');
//            $('#f_xxdz').val('');
//            $('#f_djbz').val('');
        }
        //加载客户
        function loadKhxx(khxx,identity,obj){
            var getData;
            var sxbmList='${sxbmList}';
            var bmList=JSON.parse(sxbmList);
            if(khxx.length == 18){
                for(var i=0;i<bmList.length;i++){
                    if(bmList[i].F_BMBM == $("#f_bmbm").val()){
                        if(0 == bmList[i].F_JHGSBM){
                            $.ajax({type: "post", url: "<%=path%>/cardreader/identity",
                                data : {identity:khxx},
                                success: function (data) {
                                    try {
                                        var obj=eval('(' + $.trim(data) + ')');
                                    } catch(e) {
                                        alertMsg(data);
                                        //return false;
                                    }
                                    var flag = loadKhxx(obj.name,obj.identity,obj);
                                    if(!flag){
                                        setTimeout(function () {
                                            $.ajax({
                                                url: "/initialvalues/AddKhda",
                                                type: "post",
                                                async: false,
                                                data: { f_khmc: obj.name, f_sjhm: obj.mobile,f_sfzh:obj.identity, f_qydz: "", f_xxdz: "", f_bzxx: "",cslx:1, timeer: new Date() },
                                                success: function (data) {
                                                    if(data == "ok"){
                                                        var flag2 = loadKhxx(obj.name,obj.identity,obj);
                                                        $('#khoption').val(obj.identity);
                                                    }else{
                                                        alertMsg(data);
                                                    }
                                                },
                                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                                    alert(errorThrown + "||" + textStatus);
                                                    $subbtn.button('reset');
                                                }
                                            });
                                        }, 10);
                                    }else{
                                        $('#khoption').val(obj.identity);
                                    }
                                }
                            })
                        }
                    }
                }
            }else{
                $.ajax({
                    url: "/sales/GetKhda",
                    type: "post",
                    async: false,
                    data: {khxx:khxx,identity:identity, timeer: new Date() },
                    success: function (data) {
                        var dataJson = JSON.parse(data);
                        if(dataJson.length>0) {

                            //客户标题
                            if(obj != null && obj != ''){
                                var khthhtml = "";
                                khthhtml="<tr>\n" +
                                    "                            <th class=\"am-text-middle\">客户名称</th>\n" +
                                    "                            <th class=\"am-text-middle\">联系电话</th>\n";
                                for(var i = 0 ; i<obj.detailInfoList.length ; i++){
                                    var plotInfoList = obj.detailInfoList[i].plotInfoList;
                                    for(var j = 0 ; j<plotInfoList.length ; j++){
                                        khthhtml += "                            <th class=\"am-text-middle\">种养殖类型</th>\n";
                                    }
                                }
                                khthhtml += "                        </tr>";
                                $('#khth').html(khthhtml);
                                khxxobj = obj;
                            }

                            //客户数据
                            var khdahtml="";
                            for(var i=0;i<dataJson.length;i++){
                                var khda=dataJson[i];
                                if(khdahtml==""){
                                    khdahtml="<tr>\n" +
                                        "                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n" +
                                        "                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n" +
                                        /*"                            <td class=\"am-text-middle\">0.00</td>\n" +
                                        "                            <td class=\"am-text-middle\">0.00</td>\n" +*/
                                        "                            <td class=\"am-hide\">"+khda.F_CSBM+"</td>\n";
                                    if(obj != null && obj != ''){
                                        for(var h = 0 ; h<obj.detailInfoList.length ; h++){
                                            var plotInfoList = obj.detailInfoList[h].plotInfoList;
                                            for(var j = 0 ; j<plotInfoList.length ; j++){
                                                khdahtml += "                            <td class=\"am-text-middle\">"+plotInfoList[j].sclass+"/"+plotInfoList[j].bookArea+"</td>\n";
                                            }
                                        }
                                    }
                                    khdahtml +=    "                        </tr>";
                                }else{
                                    khdahtml+="<tr>\n" +
                                        "                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n" +
                                        "                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n" +
                                        /*"                            <td class=\"am-text-middle\">0.00</td>\n" +
                                        "                            <td class=\"am-text-middle\">0.00</td>\n" +*/
                                        "                            <td class=\"am-hide\">"+khda.F_CSBM+"</td>\n";
                                    if(obj != null && obj != ''){
                                        for(var h = 0 ; h<obj.detailInfoList.length ; h++){
                                            var plotInfoList = obj.detailInfoList[h].plotInfoList;
                                            for(var j = 0 ; j<plotInfoList.length ; j++){
                                                khdahtml += "                            <td class=\"am-text-middle\">"+plotInfoList[j].sclass+"/"+plotInfoList[j].bookArea+"</td>\n";
                                            }
                                        }
                                    }
                                    khdahtml +=    "                        </tr>";
                                }
                            }
                            $('#khtable').html(khdahtml);
                            $('#khtable tr').click(function () {
                                var rowNum=$(this).index();
                                var $table=$(this).parent();
                                var khmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                                var khbm=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(2)').text();
                                $('#khxx').val(khmc);
                                $('#khxx').attr('sptm',khbm);
                                $('#prt_kh').text(khmc);//设置打印客户信息



                                //当类型编码为12、13、14时，选择客户后加载对应信息
                                if ("<%=lxbm %>" == "12" || "<%=lxbm %>" == "13" || "<%=lxbm %>" == "14"){
                                    //加载客户基础信息
                                    loadKhjcxx(khbm);
                                }

                                $('#chooseKhdiv').modal('close');
                            });
                            getData = true;
                        }else{
                            $('#khtable').html("");
                            getData = false;
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
            return getData;
        };
        function closeNewKhdiv(){
            $('#newKhdiv').modal('close');
        }
        //删除
        function deleteSelf(event){
            var sptm= $(event).parent().parent().attr('sptm');
            $(event).parent().parent().remove();

            //判断销售商品是否适用豇豆，适用并且参数设置打开的话给提示
            var sptms = "";
            spcount = $("#sptable").find('tr').length;//商品数量
            for (var i = 0;i < spcount; i++){
                var f_sptm = $("#sptable").find("tr").eq(i).attr("sptm");
                if (i == spcount-1){
                    sptms += f_sptm;
                }else {
                    sptms += f_sptm + ",";
                }
            }

            //判断商品是否适用豇豆
            sfsyjd(sptms);
            if (sfsyjdFlag == false && "<%=f_jdxsdts%>" == 1){
                $('#jdtsdiv').html("");
            }

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
            $table.find('tr:eq(' + (rowNum) + ')').find('td:eq(4)').text(result.toFixed(2));
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
                localStorage.setItem("showSpdiv", "true");
            }else{
                $("#spdadiv").hide();
                $("#xsdiv").removeClass("am-u-sm-6 am-u-md-6").addClass("am-u-sm-12 am-u-md-12");
                $("#morespda").removeClass("am-icon-chevron-right").addClass("am-icon-chevron-left");
                localStorage.setItem("showSpdiv", "false");
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

        function readcard(k) {
            //打开设备
            var cpucardno = 255;


            var sxbmList='${sxbmList}';
            var bmList=JSON.parse(sxbmList);
            for(var i=0;i<bmList.length;i++) {
                $.ajax({
                    type: "post", url: "<%=path%>/cardreader/citizencard",
                    data: {card: '310246299000', serial: bmList[i].F_YJDZ},
                    success: function (data) {
                        try {
                            var obj = eval('(' + $.trim(data) + ')');
                        } catch (e) {
                            alertMsg(data);
                            //return false;
                        }

                        $('#chooseKhdiv').modal({
                            closeViaDimmer: false,
                            width: 680,
                            height: 500
                        });
                        var flag = loadKhxx(obj.name, obj.identity, obj);
                        if (!flag) {
                            setTimeout(function () {
                                $.ajax({
                                    url: "/initialvalues/AddKhda",
                                    type: "post",
                                    async: false,
                                    data: {
                                        f_khmc: obj.name,
                                        f_sjhm: obj.mobile,
                                        f_sfzh: obj.identity,
                                        f_qydz: "",
                                        f_xxdz: "",
                                        f_bzxx: "",
                                        cslx: 1,
                                        timeer: new Date()
                                    },
                                    success: function (data) {
                                        if (data == "ok") {
                                            var flag2 = loadKhxx(obj.name, obj.identity, obj);
                                            $('#khoption').val(obj.name);
                                            $('#chooseKhdiv').modal('open');
                                        } else {
                                            alertMsg(data);
                                        }
                                    },
                                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                                        alert(errorThrown + "||" + textStatus);
                                        $subbtn.button('reset');
                                    }
                                });
                            }, 10);
                        } else {
                            $('#khoption').val(obj.name);
                            $('#chooseKhdiv').modal('open');
                        }
                    }
                })
            }


            $.ajax({
                dataType: "JSONP",type: "get",async: false,url: "http://localhost:8080/api/OpenDevice",data : {Port:"100",Baud:"0"},
                success: function (data) {
                    if(data.retcode == 0){
                        isopen=true;
                        //alert("打开设备成功");
                        //卡片上电复位
                        $.ajax({dataType: "JSONP",type: "get",async: false,url: "http://localhost:8080/api/CardPowerOn",data : {CardSet:cpucardno},
                            success: function (data) {
                                if(data.retcode == 0){
                                    ispower = true;
                                    /*document.all('ReadDatacpu').value = data.retmsg;
                                    document.all('UidCpu').value = data.cardno;*/
                                    //alert("卡片上电复位成功");
                                    if(k==0) {//市民卡
                                        var sxbmList='${sxbmList}';
                                        var bmList=JSON.parse(sxbmList);
                                        for(var i=0;i<bmList.length;i++){
                                            if(bmList[i].F_BMBM == $("#f_bmbm").val()){
                                                $.ajax({dataType: "JSONP",type: "get", url: "http://localhost:8080/api/CardAPDU",
                                                    data : {CardSet:cpucardno,APDU:"00B0952704"},
                                                    success: function (data) {
                                                        if(data.retcode == 0){
                                                            var card=data.retmsg;
                                                            //alert("市民卡:"+data.retmsg);
                                                            //UidCpu.value = data.cardno;
                                                            //ReadDatacpu.value = data.retmsg;
                                                            //调用接口获取市民卡信息
                                                            $.ajax({type: "post", url: "<%=path%>/cardreader/citizencard",
                                                                data : {card:card,serial:bmList[i].F_YJDZ},
                                                                success: function (data) {
                                                                    try {
                                                                        var obj=eval('(' + $.trim(data) + ')');
                                                                    } catch(e) {
                                                                        alertMsg(data);
                                                                        //return false;
                                                                    }

                                                                    $('#chooseKhdiv').modal({
                                                                        closeViaDimmer: false,
                                                                        width:680,
                                                                        height:500
                                                                    });
                                                                    var flag = loadKhxx(obj.name,obj.identity,obj);
                                                                    if(!flag){
                                                                        setTimeout(function () {
                                                                            $.ajax({
                                                                                url: "/initialvalues/AddKhda",
                                                                                type: "post",
                                                                                async: false,
                                                                                data:   { f_khmc: obj.name, f_sjhm: obj.mobile,f_sfzh:obj.identity, f_qydz: "", f_xxdz: "", f_bzxx: "",cslx:1, timeer: new Date() },
                                                                                success: function (data) {
                                                                                    if(data == "ok"){
                                                                                        var flag2 = loadKhxx(obj.name,obj.identity,obj);
                                                                                        $('#khoption').val(obj.name);
                                                                                        $('#chooseKhdiv').modal('open');
                                                                                    }else{
                                                                                        alertMsg(data);
                                                                                    }
                                                                                },
                                                                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                                                                    alert(errorThrown + "||" + textStatus);
                                                                                    $subbtn.button('reset');
                                                                                }
                                                                            });
                                                                        }, 10);
                                                                    }else{
                                                                        $('#khoption').val(obj.name);
                                                                        $('#chooseKhdiv').modal('open');
                                                                    }
                                                                }
                                                            })
                                                        } else {
                                                            alert("卡片APDU失败，错误码为：" + data.retcode + data.errmsg);
                                                        }
                                                        //成功执行
                                                        //console.log(data);
                                                    },
                                                    error: function (e) {
                                                        //失败执行
                                                        alert(e.status + ',' + e.statusText);
                                                        //console.log(e);
                                                    }
                                                })
                                                break;
                                            }
                                        }
                                    } else {//身份证
                                        $.ajax({dataType: "JSONP",type: "get", url: "http://localhost:8080/api/ReadMsg",
                                            success: function (data) {
                                                if(data.retcode == 0){
                                                    var zh=data.cardno;
                                                    $('#chooseKhdiv').modal({
                                                        closeViaDimmer: false,
                                                        width:680,
                                                        height:500
                                                    });
/*
                                                    var flag = loadKhxx('',zh);
                                                    if(!flag){
                                                        setTimeout(function () {
                                                            $.ajax({
                                                                url: "/initialvalues/AddKhda",
                                                                type: "post",
                                                                async: false,
                                                                data: { f_khmc: obj.name, f_sjhm: obj.mobile,f_sfzh:obj.identity, f_qydz: "", f_xxdz: "", f_bzxx: "",cslx:1, timeer: new Date() },
                                                                success: function (data, textStatus) {
                                                                    if(data == "ok"){
                                                                        alertMsg("保存成功！");
                                                                    }
                                                                    loadKhxx(obj.name,obj.identity);
                                                                    $('#khoption').val(obj.name);
                                                                    $('#chooseKhdiv').modal('open');
                                                                },
                                                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                                                    alert(errorThrown + "||" + textStatus);
                                                                    $subbtn.button('reset');
                                                                }
                                                            });
                                                        }, 10);
                                                    }
*/

                                                    $('#khoption').val(data.name);
                                                    $('#chooseKhdiv').modal('open');
                                                } else{
                                                    alert("身份证读取失败，错误码为：" + data.retcode + data.errmsg);
                                                }
                                                //成功执行
                                                //console.log(data);
                                            },
                                            error: function (e) {
                                                //失败执行
                                                alert(e.status + ',' + e.statusText);
                                                //console.log(e);
                                            }
                                        })
                                    }
                                } else {
                                    alert("卡片复位失败，错误码为：" + data.retcode + data.errmsg);
                                }
                                //成功执行
                                //console.log(data);
                            },
                            error: function (e) {
                                //失败执行
                                alert(e.status + ',' + e.statusText);
                                //console.log(e);
                            }
                        })
                    } else {
                        alert("打开设备失败，错误码为：" + data.retcode + data.errmsg);
                    }
                    //成功执行
                    //console.log(data);
                },
                error: function (e) {
                    //失败执行
                    alert('请先启动读卡器服务(WebReader.exe)！');
                    //alert(e.status + ',' + e.statusText);
                    //console.log(e);
                }
            })
        }


        //加载仓库参数
        function loadCkcs() {
            var ckHtml = "";
            var sptableTitleHtml = "";
            var sptableHtml = "";
            if (qyck == 1){
                ckHtml += "     <label for=\"f_ckbm\" style=\"font-weight: 500;font-size: 1.4rem;\">仓库名称：</label> \n" +
                    "           <select id=\"f_ckbm\" data-am-selected=\"{btnWidth: '60%',btnSize: 'sm'}\" style='width: 60%;border: 1px solid #ddd;padding: 7px;font-weight: 500;font-size: 1.4rem;color: #444;'>" +
                    "           </select>";
                $("#ckmcDiv").html(ckHtml);
                loadCkxx();

                sptableTitleHtml += "   <tr>"+
                    "                       <th class=\"am-text-middle\">商品名称</th>"+
                    "                       <th class=\"am-text-middle\">规格</th>"+
                    "                       <th class=\"am-text-middle\">数量</th>"+
                    "                       <th class=\"am-text-middle\">单价</th>"+
                    "                       <th class=\"am-text-middle\">金额</th>"+
                    "                       <th class=\"am-text-middle\">仓库</th>"+
                    "                       <th class=\"am-text-middle\">操作</th>"+
                    "                   </tr>";

                sptableHtml += "<tr id=\"tishitr\">"+
                    "               <td class=\"am-text-middle\" colspan=\"7\">选择需要出售的商品</td>"+
                    "           </tr>";
                $("#sptableTitle").html(sptableTitleHtml);
                $("#sptable").html(sptableHtml);
            }else {
                sptableTitleHtml += "   <tr>"+
                    "                       <th class=\"am-text-middle\">商品名称</th>"+
                    "                       <th class=\"am-text-middle\">规格</th>"+
                    "                       <th class=\"am-text-middle\">数量</th>"+
                    "                       <th class=\"am-text-middle\">单价</th>"+
                    "                       <th class=\"am-text-middle\">金额</th>"+
                    "                       <th class=\"am-text-middle\">操作</th>"+
                    "                   </tr>";

                sptableHtml += "<tr id=\"tishitr\">"+
                    "               <td class=\"am-text-middle\" colspan=\"6\">选择需要出售的商品</td>"+
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

        function loadKhjcxx(khbm) {
            $.ajax({
                url: "/sales/getkhxx",
                type: "post",
                async: false,
                data: {khbm:khbm, timeer: new Date() },
                success: function (data) {
                    var res = JSON.parse(data);
                    var jcxxJson = JSON.parse(res.jcxxResult);
                    $("#dh").text(jcxxJson[0].F_DH);
                    $("#sfzh").text(jcxxJson[0].F_SFZH);
                    if (jcxxJson[0].F_SFJZPS == "1"){
                        $("#jzps").text("是");
                    }else if (jcxxJson[0].F_SFJZPS == "0"){
                        $("#jzps").text("否");
                    }
                    $("#jymj").text(jcxxJson[0].JYMJ);

                    var yxgmjeJson = JSON.parse(res.f_yxgmje);
                    $("#yxgmje").text(yxgmjeJson);

                    var bjljgmjeJson = JSON.parse(res.f_bjljgmje);
                    $("#bjljgmje").text(bjljgmjeJson);

                    var bnljgmjeJson = JSON.parse(res.f_bnljgmje);
                    $("#bnljgmje").text(bnljgmjeJson);
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

        //加载历史销售单
        function loadLsxsd(){
            var khbm = $("#khxx").attr("sptm");
            if (khbm == null || khbm == "" || khbm == undefined){
                alertMsg("请先选择客户！");
                return;
            }
            var f_djh = $("#sptable").attr("f_djh");

            var zdrq = $("#zdrq").text();

            $.ajax({
                url: "/sales/loadLsxsd",
                type: "post",
                async: false,
                data: {khbm:khbm,f_djh:f_djh,zdrq:zdrq, timeer: new Date() },
                success: function (data) {
                    if (data == "410"){
                        alertMsg("已经是第一张了！");
                        return;
                    }

                    var dataJson = JSON.parse(data);
                    var hjje = 0;
                    $('#sptable').html("");
                    $("#sptable").attr("f_djh",dataJson[0].F_DJH);

                    var rqstr = dataJson[0].F_RZRQ;
                    var rq = rqstr.substring(0,4) + ("-")+rqstr.substring(4,6) + ("-")+rqstr.substring(6,8);
                    $("#zdrq").html(rq);
                    for (var i = 0; i< dataJson.length; i++){
                        var spjson = dataJson[i];
                        if (qyck == 0){
                            var rowhtml = "<tr sptm='"+spjson.F_SPTM+"'>"
                                +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.F_SPMC+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_XSSL+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_DJ+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_SSJE+"</td>"
                                +"<td class=\"am-text-middle\" style='padding: 0;'>"
                                +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                +"</tr>";
                            $('#sptable').prepend(rowhtml);
                        }else if (qyck == 1){
                            var rowhtml = "<tr sptm='"+spjson.F_SPTM+"'>"
                                +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.F_SPMC+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_XSSL+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_DJ+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_SSJE+"</td>"
                                +"<td class=\"am-text-middle\" style='padding: 0;'>"
                                +"  <select class=\"xslsckbm\" disabled data-am-selected=\"{btnWidth: '100%',btnSize: 'sm',maxHeight:'100px',}\" style='width: 100%;height:66.927px;border: 0px;text-align: center;'>"
                                +"  </select>"
                                +"</td>"
                                +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                +"</tr>";
                            $('#sptable').prepend(rowhtml);

                            if (ckxxJson != null && ckxxJson != "" && ckxxJson != "[]"){
                                var ckbmHtml = "<option value=''>选择仓库</option>";
                                for (var j = 0;j < ckxxJson.length; j++){
                                    var ckssjson = ckxxJson[j];
                                    if (ckssjson.F_MJ == "0"){
                                        ckbmHtml += "<option disabled value='"+ckssjson.F_CKBM+"'>"+ckssjson.F_CKMC+"</option>";
                                    }else if (ckssjson.F_MJ == "1"){
                                        if (ckssjson.F_CKBM == spjson.F_CKBM){
                                            ckbmHtml += "<option value='"+ckssjson.F_CKBM+"' selected>"+ckssjson.F_CKMC+"</option>";
                                        }else {
                                            ckbmHtml += "<option value='"+ckssjson.F_CKBM+"'>"+ckssjson.F_CKMC+"</option>";
                                        }
                                    }
                                }
                            }
                            $("#sptable").find("tr").eq(0).find("td").eq(5).find("select").html(ckbmHtml);
                        }
                        var je = parseFloat($("#sptable").find("tr").eq(0).find("td").eq(4).text());
                        hjje += je;
                    }


                    if($("#sptable").find("tr").length > 1) {//删除请选择 提示行
                        $("#sptable").find("#tishitr").remove();
                    };

                    $("#hjpz").text($("#sptable").find("tr").length);

                    $("#hjje").text(hjje);

                    $("#ckmcDiv").hide();
                    $("#morespda").hide();
                    $("#xzfkfsDiv").hide();
                    $("#kpDiv").hide();
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

        //加载第一张单据
        function firstXsd() {
            var khbm = $("#khxx").attr("sptm");
            if (khbm == null || khbm == "" || khbm == undefined){
                alertMsg("请先选择客户！");
                return;
            }

            $.ajax({
                url: "/sales/firstXsd",
                type: "post",
                async: false,
                data: {khbm:khbm, timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    var hjje = 0;
                    $('#sptable').html("");
                    $("#sptable").attr("f_djh",dataJson[0].F_DJH);

                    var rqstr = dataJson[0].F_RZRQ;
                    var rq = rqstr.substring(0,4) + ("-")+rqstr.substring(4,6) + ("-")+rqstr.substring(6,8);
                    $("#zdrq").html(rq);
                    for (var i = 0; i< dataJson.length; i++){
                        var spjson = dataJson[i];
                        if (qyck == 0){
                            var rowhtml = "<tr sptm='"+spjson.F_SPTM+"'>"
                                +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.F_SPMC+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_XSSL+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_DJ+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_SSJE+"</td>"
                                +"<td class=\"am-text-middle\" style='padding: 0;'>"
                                +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                +"</tr>";
                            $('#sptable').prepend(rowhtml);
                        }else if (qyck == 1){
                            var rowhtml = "<tr sptm='"+spjson.F_SPTM+"'>"
                                +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.F_SPMC+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_XSSL+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_DJ+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_SSJE+"</td>"
                                +"<td class=\"am-text-middle\" style='padding: 0;'>"
                                +"  <select class=\"xslsckbm\" disabled data-am-selected=\"{btnWidth: '100%',btnSize: 'sm',maxHeight:'100px',}\" style='width: 100%;height:66.927px;border: 0px;text-align: center;'>"
                                +"  </select>"
                                +"</td>"
                                +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                +"</tr>";
                            $('#sptable').prepend(rowhtml);

                            if (ckxxJson != null && ckxxJson != "" && ckxxJson != "[]"){
                                var ckbmHtml = "<option value=''>选择仓库</option>";
                                for (var j = 0;j < ckxxJson.length; j++){
                                    var ckssjson = ckxxJson[j];
                                    if (ckssjson.F_MJ == "0"){
                                        ckbmHtml += "<option disabled value='"+ckssjson.F_CKBM+"'>"+ckssjson.F_CKMC+"</option>";
                                    }else if (ckssjson.F_MJ == "1"){
                                        if (ckssjson.F_CKBM == spjson.F_CKBM){
                                            ckbmHtml += "<option value='"+ckssjson.F_CKBM+"' selected>"+ckssjson.F_CKMC+"</option>";
                                        }else {
                                            ckbmHtml += "<option value='"+ckssjson.F_CKBM+"'>"+ckssjson.F_CKMC+"</option>";
                                        }
                                    }
                                }
                            }
                            $("#sptable").find("tr").eq(0).find("td").eq(5).find("select").html(ckbmHtml);
                        }
                        var je = parseFloat($("#sptable").find("tr").eq(0).find("td").eq(4).text());
                        hjje += je;
                    }


                    if($("#sptable").find("tr").length > 1) {//删除请选择 提示行
                        $("#sptable").find("#tishitr").remove();
                    };

                    $("#hjpz").text($("#sptable").find("tr").length);

                    $("#hjje").text(hjje);

                    $("#ckmcDiv").hide();
                    $("#morespda").hide();
                    $("#xzfkfsDiv").hide();
                    $("#kpDiv").hide();
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

        //查询最后张销售单
        function finallyXsd() {
            var khbm = $("#khxx").attr("sptm");
            if (khbm == null || khbm == "" || khbm == undefined){
                alertMsg("请先选择客户！");
                return;
            }

            $.ajax({
                url: "/sales/finallyXsd",
                type: "post",
                async: false,
                data: {khbm:khbm, timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    var hjje = 0;
                    $('#sptable').html("");
                    $("#sptable").attr("f_djh",dataJson[0].F_DJH);

                    var rqstr = dataJson[0].F_RZRQ;
                    var rq = rqstr.substring(0,4) + ("-")+rqstr.substring(4,6) + ("-")+rqstr.substring(6,8);
                    $("#zdrq").html(rq);
                    for (var i = 0; i< dataJson.length; i++){
                        var spjson = dataJson[i];
                        if (qyck == 0){
                            var rowhtml = "<tr sptm='"+spjson.F_SPTM+"'>"
                                +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.F_SPMC+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_XSSL+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_DJ+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_SSJE+"</td>"
                                +"<td class=\"am-text-middle\" style='padding: 0;'>"
                                +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                +"</tr>";
                            $('#sptable').prepend(rowhtml);
                        }else if (qyck == 1){
                            var rowhtml = "<tr sptm='"+spjson.F_SPTM+"'>"
                                +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.F_SPMC+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_XSSL+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_DJ+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_SSJE+"</td>"
                                +"<td class=\"am-text-middle\" style='padding: 0;'>"
                                +"  <select class=\"xslsckbm\" disabled data-am-selected=\"{btnWidth: '100%',btnSize: 'sm',maxHeight:'100px',}\" style='width: 100%;height:66.927px;border: 0px;text-align: center;'>"
                                +"  </select>"
                                +"</td>"
                                +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                +"</tr>";
                            $('#sptable').prepend(rowhtml);

                            if (ckxxJson != null && ckxxJson != "" && ckxxJson != "[]"){
                                var ckbmHtml = "<option value=''>选择仓库</option>";
                                for (var j = 0;j < ckxxJson.length; j++){
                                    var ckssjson = ckxxJson[j];
                                    if (ckssjson.F_MJ == "0"){
                                        ckbmHtml += "<option disabled value='"+ckssjson.F_CKBM+"'>"+ckssjson.F_CKMC+"</option>";
                                    }else if (ckssjson.F_MJ == "1"){
                                        if (ckssjson.F_CKBM == spjson.F_CKBM){
                                            ckbmHtml += "<option value='"+ckssjson.F_CKBM+"' selected>"+ckssjson.F_CKMC+"</option>";
                                        }else {
                                            ckbmHtml += "<option value='"+ckssjson.F_CKBM+"'>"+ckssjson.F_CKMC+"</option>";
                                        }
                                    }
                                }
                            }
                            $("#sptable").find("tr").eq(0).find("td").eq(5).find("select").html(ckbmHtml);
                        }
                        var je = parseFloat($("#sptable").find("tr").eq(0).find("td").eq(4).text());
                        hjje += je;
                    }


                    if($("#sptable").find("tr").length > 1) {//删除请选择 提示行
                        $("#sptable").find("#tishitr").remove();
                    };

                    $("#hjpz").text($("#sptable").find("tr").length);

                    $("#hjje").text(hjje);

                    $("#ckmcDiv").hide();
                    $("#morespda").hide();
                    $("#xzfkfsDiv").hide();
                    $("#kpDiv").hide();
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

        //后张销售单
        function afterXsd() {
            var khbm = $("#khxx").attr("sptm");
            if (khbm == null || khbm == "" || khbm == undefined){
                alertMsg("请先选择客户！");
                return;
            }
            var f_djh = $("#sptable").attr("f_djh");

            var zdrq = $("#zdrq").text();

            $.ajax({
                url: "/sales/afterXsd",
                type: "post",
                async: false,
                data: {khbm:khbm,f_djh:f_djh,zdrq:zdrq, timeer: new Date() },
                success: function (data) {
                    if (data == "411"){
                        newXsd();
                    }else{
                        var dataJson = JSON.parse(data);
                        var hjje = 0;
                        $('#sptable').html("");
                        $("#sptable").attr("f_djh",dataJson[0].F_DJH);

                        var rqstr = dataJson[0].F_RZRQ;
                        console.log(rqstr);
                        var rq = rqstr.substring(0,4) + ("-")+rqstr.substring(4,6) + ("-")+rqstr.substring(6,8);
                        $("#zdrq").html(rq);
                        for (var i = 0; i< dataJson.length; i++){
                            var spjson = dataJson[i];
                            if (qyck == 0){
                                var rowhtml = "<tr sptm='"+spjson.F_SPTM+"'>"
                                    +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.F_SPMC+"</td>"
                                    +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                    +"<td class=\"am-text-middle\">"+spjson.F_XSSL+"</td>"
                                    +"<td class=\"am-text-middle\">"+spjson.F_DJ+"</td>"
                                    +"<td class=\"am-text-middle\">"+spjson.F_SSJE+"</td>"
                                    +"<td class=\"am-text-middle\" style='padding: 0;'>"
                                    +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                    +"</tr>";
                                $('#sptable').prepend(rowhtml);
                            }else if (qyck == 1){
                                var rowhtml = "<tr sptm='"+spjson.F_SPTM+"'>"
                                    +"<td class=\"am-text-middle am-td-spmc am-text-truncate\">"+spjson.F_SPMC+"</td>"
                                    +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                    +"<td class=\"am-text-middle\">"+spjson.F_XSSL+"</td>"
                                    +"<td class=\"am-text-middle\">"+spjson.F_DJ+"</td>"
                                    +"<td class=\"am-text-middle\">"+spjson.F_SSJE+"</td>"
                                    +"<td class=\"am-text-middle\" style='padding: 0;'>"
                                    +"  <select class=\"xslsckbm\" disabled data-am-selected=\"{btnWidth: '100%',btnSize: 'sm',maxHeight:'100px',}\" style='width: 100%;height:66.927px;border: 0px;text-align: center;'>"
                                    +"  </select>"
                                    +"</td>"
                                    +"<td class=\"am-text-middle\"><a href=\"javascript:void(0);\" onclick=\"deleteSelf(this)\">删除</a></td>"
                                    +"</tr>";
                                $('#sptable').prepend(rowhtml);

                                if (ckxxJson != null && ckxxJson != "" && ckxxJson != "[]"){
                                    var ckbmHtml = "<option value=''>选择仓库</option>";
                                    for (var j = 0;j < ckxxJson.length; j++){
                                        var ckssjson = ckxxJson[j];
                                        if (ckssjson.F_MJ == "0"){
                                            ckbmHtml += "<option disabled value='"+ckssjson.F_CKBM+"'>"+ckssjson.F_CKMC+"</option>";
                                        }else if (ckssjson.F_MJ == "1"){
                                            if (ckssjson.F_CKBM == spjson.F_CKBM){
                                                ckbmHtml += "<option value='"+ckssjson.F_CKBM+"' selected>"+ckssjson.F_CKMC+"</option>";
                                            }else {
                                                ckbmHtml += "<option value='"+ckssjson.F_CKBM+"'>"+ckssjson.F_CKMC+"</option>";
                                            }
                                        }
                                    }
                                }
                                $("#sptable").find("tr").eq(0).find("td").eq(5).find("select").html(ckbmHtml);
                            }
                            var je = parseFloat($("#sptable").find("tr").eq(0).find("td").eq(4).text());
                            hjje += je;
                        }


                        if($("#sptable").find("tr").length > 1) {//删除请选择 提示行
                            $("#sptable").find("#tishitr").remove();
                        };

                        $("#hjpz").text($("#sptable").find("tr").length);

                        $("#hjje").text(hjje);

                        $("#ckmcDiv").hide();
                        $("#morespda").hide();
                        $("#xzfkfsDiv").hide();
                        $("#kpDiv").hide();
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

        //显示客户详情
        function querykhxx() {
            var f_csbm = $("#khxx").attr("sptm");
            clickCsbm = f_csbm;
            if (f_csbm == null || f_csbm == "" || f_csbm == undefined){
                alertMsg("请选择客户！");
                return;
            }
            $.ajax({
                url: "/sales/GetKhdaByCsbm",
                type: "post",
                async: false,
                data: {f_csbm:f_csbm,cslx:1, timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    var khda=dataJson[0];
                    $("#xgf_khbm").val(khda.F_CSBM);
                    $("#xgf_khmc").val(khda.F_CSMC);
                    $("#xgf_sjhm").val(khda.F_DH);
                    $("#xgf_sfzh").val(khda.F_SFZH);
                    $("#xgf_bz").val(khda.F_BZXX);
                    $("#xgf_Dz").val(khda.F_DZ);
                    $("#xgf_Khh").val(khda.F_KHH);
                    $("#xgf_Yhkh").val(khda.F_YHKH);
                    $("#xgf_Tyxym").val(khda.F_TYXYM);
                    $('#xgf_Sfjzps').val(khda.F_SFJZPS);
                    $('#xgf_Khlx').val(khda.F_KHLX);

                    $('#updateKhdiv').modal({
                        closeViaDimmer: false,
                        width:980,
                        height:1000
                    });
                    $('#updateKhdiv').modal('open');
                    $('.am-dimmer').css("z-index","1111");
                    $('#updateKhdiv').css("z-index","1119");

                    var updateKhdivHtml = "";
                    if (khda.F_LXBM==12 || khda.F_LXBM==13 || khda.F_LXBM==14){
                        updateKhdivHtml +="    <div class=\"am-form-group\">" +
                            "                   <label for=\"xgf_Sfjzps\" class=\"am-u-sm-2 am-form-label\">是否集中配送</label>" +
                            "                   <div class=\"am-u-sm-9\">" +
                            "                       <div class=\"am-u-sm-12\" style=\"padding: 0px;text-align:left;\">" +
                            "                           <select data-am-selected id=\"xgf_Sfjzps\" disabled>" +
                            "                           </select>" +
                            "                       </div>" +
                            "                   </div>" +
                            "                   <div class=\"am-u-sm-end\"></div>" +
                            "               </div>" +

                            "               <div class=\"am-form-group\">" +
                            "                   <label for=\"xgf_Khlx\" class=\"am-u-sm-2 am-form-label\">类型</label>" +
                            "                   <div class=\"am-u-sm-9\">" +
                            "                       <div class=\"am-u-sm-12\" style=\"padding: 0px;text-align:left;\">" +
                            "                           <select data-am-selected id=\"xgf_Khlx\" disabled>" +
                            "                               <option value=\"0\">农户</option>" +
                            "                               <option value=\"1\">大户</option>" +
                            "                               <option value=\"2\">合作社</option>" +
                            "                           </select>" +
                            "                       </div>" +
                            "                   </div>" +
                            "                   <div class=\"am-u-sm-end\"></div>" +
                            "               </div>";
                        $("#xgmorelxDiv").html(updateKhdivHtml);
                    }

                    var sfjzpsHtml = "";
                    if (khda.F_SFJZPS == 0){
                        sfjzpsHtml += "<option value=\"0\" selected>否</option>" +
                            "         <option value=\"1\">是</option>";
                    }else if (khda.F_SFJZPS == 1){
                        sfjzpsHtml += "<option value=\"0\">否</option>" +
                            "         <option value=\"1\" selected>是</option>";
                    }else {
                        sfjzpsHtml += "<option value=\"0\" selected>否</option>" +
                            "         <option value=\"1\">是</option>";
                    }
                    $("#xgf_Sfjzps").html(sfjzpsHtml);

                    var khlxHtml = "";
                    switch (khda.F_KHLX) {
                        case("0"):
                            khlxHtml += "<option value=\"0\" selected>农户</option>" +
                                "<option value=\"1\">大户</option>" +
                                "<option value=\"2\">合作社</option>";
                            break;
                        case("1"):
                            khlxHtml += "<option value=\"0\">农户</option>" +
                                "<option value=\"1\" selected>大户</option>" +
                                "<option value=\"2\">合作社</option>";
                            break;
                        case("2"):
                            khlxHtml += "<option value=\"0\">农户</option>" +
                                "<option value=\"1\">大户</option>" +
                                "<option value=\"2\" selected>合作社</option>";
                            break;
                        default:
                            khlxHtml += "<option value=\"0\" selected>农户</option>" +
                                "<option value=\"1\">大户</option>" +
                                "<option value=\"2\">合作社</option>";
                            break;
                    }
                    $("#xgf_Khlx").html(khlxHtml);


                    var khlx = $("#xgf_Khlx").val();
                    if (khlx == "0"){       //农户
                        loadCstjmx("f_sfsynh");
                    }else if (khlx == "1"){     //大户
                        loadCstjmx("f_sfsydh");
                    }else if (khlx == "2"){     //合作社
                        loadCstjmx("f_sfsyhzs");
                    }

                    //根据客户类型输出表格
                    $("#xgf_Khlx").change(function (){
                        var khlx = $("#xgf_Khlx").val();
                        if (khlx == "0"){       //农户
                            loadCstjmx("f_sfsynh");
                        }else if (khlx == "1"){     //大户
                            loadCstjmx("f_sfsydh");
                        }else if (khlx == "2"){     //合作社
                            loadCstjmx("f_sfsyhzs");
                        }
                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });

            //关闭还原遮罩蒙板z-index
            $('#updateKhdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
        }

        //加载厂商统计明细
        function loadCstjmx(khlx){
            $.ajax({
                url: "/initialvalues/loadcstjmx",
                type: "post",
                async: false,
                data: { khlx:khlx,timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    var tableHtml = "";
                    var cols = 0;//末级数，17
                    var rows = 0;//表格层数,3-1
                    //计算末级个数和表格层数
                    for (var i = 0; i < dataJson.length; i++){
                        if(dataJson[i].F_MJ == "1"){
                            cols++;
                        }
                        if (rows < dataJson[i].F_JB){
                            rows = dataJson[i].F_JB;
                        }
                    }

                    tableHtml += "<table class=\"am-table am-table-bordered\">";
                    tableHtml += "<tbody>";
                    //1、根据层数循环
                    //2、循环当前行
                    //3、非末级：colspan=下级包含末级数
                    //4、末级：rowspan=总层数-当前层-1
                    for (var i = 1; i <= rows; i++){
                        tableHtml += "<tr>";
                        for (var j = 0; j < dataJson.length; j++){
                            if (dataJson[j].F_JB == i){
                                if (dataJson[j].F_MJ == "0"){
                                    var xjcols = findEndNodes(dataJson,dataJson[j]);
                                    tableHtml += "<td colspan='"+xjcols+"'>"+dataJson[j].F_FLMC+"</td>";
                                }else{
                                    var sjrows = rows-(i-1);
                                    tableHtml += "<td rowspan='"+sjrows+"'>"+dataJson[j].F_FLMC+"</td>";
                                }
                            }
                        }
                        tableHtml += "</tr>";
                    }

                    //有多少末级输出多少个单位名称和input框
                    tableHtml += "<tr>";
                    for (var i = 0; i <dataJson.length; i++){
                        if (dataJson[i].F_JB == "1" && dataJson[i].F_MJ == "1"){
                            var yjflbm = dataJson[i].F_FLBM;//1级分类编码
                            //和二级分类编码比较
                            for (var j = 0; j <dataJson.length; j++){
                                if (dataJson[j].F_JB == "2") {
                                    var ejflbmTemp = dataJson[j].F_FLBM;
                                    var ejflbm = ejflbmTemp.toString().substring(0, 3);
                                    if (yjflbm == ejflbm) {
                                        var dwmc = dataJson[j].F_DWMC;
                                        tableHtml += "<td>" + dwmc + "</td>";
                                    }
                                }
                            }
                        }else if (dataJson[i].F_JB == "3" && dataJson[i].F_MJ == "1"){
                            var sjflbm = dataJson[i].F_FLBM;//3级分类编码
                            var sjsjflbm = sjflbm.toString().substring(0,6);
                            //和二级分类编码比较
                            for (var j = 0; j <dataJson.length; j++){
                                if (dataJson[j].F_JB == "2") {
                                    var ejflbm = dataJson[j].F_FLBM;
                                    if (sjsjflbm == ejflbm) {
                                        var dwmc = dataJson[j].F_DWMC;
                                        tableHtml += "<td>" + dwmc + "</td>";
                                    }
                                }
                            }
                        }else if (dataJson[i].F_JB == "2" && dataJson[i].F_MJ == "1"){
                            tableHtml += "<td>" + dataJson[i].F_DWMC + "</td>";
                        }
                    }
                    tableHtml += "</tr>";

                    loadsl();
                    tableHtml += "<tr id='sltr'>";
                    if (slJson != null && slJson != "" && slJson != "[]"){
                        for (var i = 0; i <cols; i++){
                            if (slJson[i].F_SL == 0){
                                tableHtml += "<td><input readonly type='text' style='font-size: 6px'></td>";
                                $("#sltr").find('td:eq('+i+')').find('input:eq(0)').val('');
                            }else {
                                tableHtml += "<td><input readonly type='text' value='"+slJson[i].F_SL+"' style='font-size: 6px'></td>";
                                $("#sltr").find('td:eq('+i+')').find('input:eq(0)').val();
                            }
                        }
                    }else {
                        for (var i = 0; i <cols; i++){
                            tableHtml += "<td><input readonly type='text' style='font-size: 6px'></td>";
                            $("#sltr").find('td:eq('+i+')').find('input:eq(0)').val('');
                        }
                    }
                    tableHtml += "</tr>";
                    tableHtml += "</tbody>";
                    tableHtml += "</table>";
                    $("#xgtjmxTable").html(tableHtml);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        //获取下级包含的末级数量   jarr:查询出的数据     json:循环后的单个数据jarr[i]
        function findEndNodes(jarr,json){
            var s=jarr.length;
            var jb=json.F_JB;
            var flbm=json.F_FLBM;
            var k=flbm.length,j=0;
            var record=null;
            for(var i=0;i<s;i++) {
                record=jarr[i];
                if(record.F_JB<=jb ||record.F_MJ!=1)continue;
                if(record.F_FLBM.substring(0,k)==flbm){
                    j++;
                }
            }
            return j;
        }

        //加载客户分类明细具体数量（xxx亩）
        function loadsl(){
            var csbm = clickCsbm;
            var khlx = $("#xgf_Khlx").val();
            $.ajax({
                url: "/initialvalues/loadsl",
                type: "post",
                async: false,
                data: { csbm:csbm,khlx:khlx,timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    slJson = dataJson;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        //查询季销售
        function queryJxs() {
            var khbm = $("#khxx").attr("sptm");
            var rq = "<%=str %>";
            if (khbm == null || khbm == "" || khbm == undefined){
                alertMsg("请选择客户！");
                return;
            }

            $.ajax({
                url: "/sales/getJdrqqj",
                type: "post",
                async: false,
                data: {khbm:khbm,rq:rq, timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    var rqjson=dataJson[0];
                    var start = rqjson.F_STARTTIME;
                    var end = rqjson.F_ENDTIME;
                    var startTime = start.substring(0,4)+"-"+start.substring(4,6)+"-"+start.substring(6,8);
                    var endTime = end.substring(0,4)+"-"+end.substring(4,6)+"-"+end.substring(6,8);

                    $("#f_ksrq").val(startTime);
                    $("#f_jsrq").val(endTime);

                    $('#saleDiv').modal({
                        closeViaDimmer: false,
                        width:980,
                        height:1000
                    });
                    $('#saleDiv').modal('open');
                    $('.am-dimmer').css("z-index","1111");
                    $('#saleDiv').css("z-index","1119");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });

            //关闭还原遮罩蒙板z-index
            $('#saleDiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
        }

        //查询年销售
        function queryNxs() {
            var khbm = $("#khxx").attr("sptm");
            var rq = "<%=str %>";
            var yearRq = rq.substring(0,4);
            var startTime = yearRq + "-01-01";
            var endTime = yearRq + "-12-31";
            if (khbm == null || khbm == "" || khbm == undefined){
                alertMsg("请选择客户！");
                return;
            }

            $("#f_ksrq").val(startTime);
            $("#f_jsrq").val(endTime);

            $('#saleDiv').modal({
                closeViaDimmer: false,
                width:980,
                height:1000
            });
            $('#saleDiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#saleDiv').css("z-index","1119");

            //关闭还原遮罩蒙板z-index
            $('#saleDiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
        }

        //查询销售单据
        function querySaleBill() {
            var khbm = $("#khxx").attr("sptm");
            var searchSpxx=$('#searchSpxx').val();
            var f_cxfs=$('input[type=radio][name=f_cxfs]:checked').val();
            var f_ksrq=$('#f_ksrq').val();
            var f_jsrq=$('#f_jsrq').val();
            if (f_cxfs=="0") {
                var $saletable = $('#saletable');
                $saletable.html('');
                $.ajax({
                    url: "/sales/GetBillDetailByKhbm",
                    type: "post",
                    async: false,
                    data: {khbm:khbm,searchSpxx: searchSpxx,f_ksrq:f_ksrq,f_jsrq:f_jsrq, timeer: new Date()},
                    success: function (data) {
                        var saleList = JSON.parse(data);
                        if (saleList.length > 0) {
                            var salehtml = "";
                            var zje=0;
                            for (var i = 0; i < saleList.length; i++) {
                                var sale = saleList[i];
                                salehtml += "<tr>\n" +
                                    "                        <td class=\"am-text-middle\"><a href=\"javascript:showDetail('" + sale.F_DJH + "')\" >详情</a> </td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_RZRQ + "" + sale.F_XSSJ + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_CSMC + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_ZFJE + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_ZFJE + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_ZFJE + "</td>\n" +
                                    "                    </tr>";
                                zje+=eval(sale.F_ZFJE);
                            }
                            salehtml += "<tr>\n" +
                                "                        <td class=\"am-text-left\" colspan='3'>合计：</td>\n" +
                                "                        <td class=\"am-text-middle\">" + zje.toFixed(1) + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + zje.toFixed(1) + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + zje.toFixed(1) + "</td>\n" +
                                "                    </tr>";
                            $saletable.html(salehtml);
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
            }else{
                var $saletable = $('#saleMxtable');
                $saletable.html('');
                $.ajax({
                    url: "/sales/GetSalesDetailByKhbm",
                    type: "post",
                    async: false,
                    data: {khbm:khbm,searchSpxx: searchSpxx,f_ksrq:f_ksrq,f_jsrq:f_jsrq, timeer: new Date()},
                    success: function (data) {
                        var saleList = JSON.parse(data);
                        if (saleList.length > 0) {
                            var salehtml = "";
                            var zje=0,zxl=0;
                            for (var i = 0; i < saleList.length; i++) {
                                var sale = saleList[i];
                                salehtml += "<tr>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_DJH + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_RZRQ + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_SPTM + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_SPMC + "</td>\n";
                                if(sale.F_NYBZ=="0"){
                                    salehtml +=   "                        <td class=\"am-text-middle\">禁限农药</td>\n";
                                }else{
                                    salehtml +=   "                        <td class=\"am-text-middle\">非禁限农药</td>\n";
                                }
                                salehtml += "                        <td class=\"am-text-middle\">" + sale.F_GGXH + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_SGPCH + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_JLDW + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">" + sale.F_XSDJ + "</td>\n" +
                                    "                        <td class=\"am-text-middle\">"+sale.F_XSSL+"</td>\n" +
                                    "                        <td class=\"am-text-middle\">"+sale.F_SSJE+"</td>\n" +
                                    "                    </tr>";
                                zje+=eval(sale.F_SSJE);
                                zxl+=eval(sale.F_XSSL);
                            }
                            salehtml += "<tr>\n" +
                                "                        <td class=\"am-text-left\" colspan='9'>合计：</td>\n" +
                                "                        <td class=\"am-text-middle\">" + zxl.toFixed(1) + "</td>\n" +
                                "                        <td class=\"am-text-middle\">" + zje.toFixed(1) + "</td>\n" +
                                "                    </tr>";
                            $saletable.html(salehtml);
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
        }


        //显示单据详情
        function showDetail(f_djh){
            $('#xsDetailtable').html('');
            $('#xsDetail').modal({
                closeViaDimmer: false,
                width:980,
                height:1000
            });
            $('#xsDetail').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#xsDetail').css("z-index","1119");
            $.ajax({
                url: "/sales/getXsdXq",
                type: "post",
                async: false,
                data: {f_djh:f_djh, timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    if(dataJson.length>0) {
                        var html="";
                        for(var i=0;i<dataJson.length;i++){
                            var spjson=dataJson[i];
                            var rowhtml="<tr sptm='"+spjson.F_SPTM+"'>"
                                +"<td class=\"am-text-middle am-td-spmc\">"+spjson.F_SPMC+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_GGXH+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_XSDJ+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_XSSL+"</td>"
                                +"<td class=\"am-text-middle\">"+spjson.F_SSJE+"</td>"
                                +"<td class=\"am-hide\">"+spjson.F_PCH+"</td>"
                                +"<td class=\"am-text-middle\">" +
                                "<audio src=\"/record/"+spjson.REDIOURL+"\" controls=\"controls\" >\n" +
                                "    <embed src=\"/record/"+spjson.REDIOURL+"\" autostart=\"true\" hidden=\"true\"></embed>\n" +
                                "</audio></td>"
                                +"</tr>";
                            $('#xsDetailtable').prepend(rowhtml);
                        }
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
            //关闭还原遮罩蒙板z-index
            $('#xsDetail').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
        }

        //药品使用查询
        function queryYpsycx() {
            parent.window.checkTab('农药标签检查','/infolsearch/certsearch');
        }
        
        function exist() {
            window.location = "/index";
        }


        function alertMsg(msg){
            $('#alertcontent').text(msg);
            $('#alertdlg').modal('open');
            $('#alertdlg').css("z-index","1120");
        }

    </script>

    <script>
        var dataURL = null;
        $(function(){
            //摄像头模组
            var aVideo = document.getElementById('videos-container');
            var aCanvas = document.getElementById('canvas');
            var ctx = aCanvas.getContext('2d');

            function noStream(err) {
                alert(err);
            }

            document.getElementById("picture").addEventListener("click", function() {
                ctx.drawImage(aVideo.firstChild, 0, 0, 320, 240); //将获取视频绘制在画布上

                dataURL = document.getElementById('canvas').toDataURL("image/png");

            });
            document.getElementById("read").addEventListener("click", function() {

                if(dataURL == null){
                    alertMsg("请先截图。");
                    return;
                }
                var sxbmList='${sxbmList}';
                var bmList=JSON.parse(sxbmList);
                var bmHtmle="";
                for(var i=0;i<bmList.length;i++){
                    if(bmList[i].F_BMBM == $("#f_bmbm").val()){
                        $.ajax({
                            url: "/camera/video",
                            type: "post",
                            async: false,
                            data: {base:dataURL,serial:bmList[i].F_YJZH},
                            success: function (data) {
                                try {
                                    var obj=eval('(' + $.trim(data) + ')');
                                } catch(e) {
                                    alertMsg(data);
                                    return false;
                                }
                                $('#chooseCameradiv').modal('close');
                                mediaRecorder.stop();

                                $('#chooseKhdiv').modal({
                                    closeViaDimmer: false,
                                    width:680,
                                    height:500
                                });
                                var flag = loadKhxx(obj.name,obj.identity,obj);
                                if(!flag){
                                    setTimeout(function () {
                                        $.ajax({
                                            url: "/initialvalues/AddKhda",
                                            type: "post",
                                            async: false,
                                            data: { f_khmc: obj.name, f_sjhm: obj.mobile,f_sfzh:obj.identity, f_qydz: "", f_xxdz: "",f_bzxx: "",cslx:1, timeer: new Date() },
                                            success: function (data, textStatus) {
                                                if(data == "ok"){
                                                    var flag2 = loadKhxx(obj.name,obj.identity,obj);
                                                    $('#khoption').val(obj.name);
                                                    $('#chooseKhdiv').modal('open');
                                                }else{
                                                    alertMsg(data);
                                                }
                                            },
                                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                                alert(errorThrown + "||" + textStatus);
                                                $subbtn.button('reset');
                                            }
                                        });
                                    }, 10);
                                }else{
                                    $('#khoption').val(obj.name);
                                    $('#chooseKhdiv').modal('open');
                                }
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                alertMsg(errorThrown + "||" + textStatus);
                            }
                        });
                    }
                }
            });

            document.getElementById("readsfz").addEventListener("click", function() {

                if(dataURL == null){
                    alertMsg("请先截图。");
                    return;
                }
                var sxbmList='${sxbmList}';
                var bmList=JSON.parse(sxbmList);
                var bmHtmle="";
                for(var i=0;i<bmList.length;i++){
                    if(bmList[i].F_BMBM == $("#f_bmbm").val()){
                        $.ajax({
                            url: "/camera/videosfz",
                            type: "post",
                            async: false,
                            data: {base:dataURL,serial:bmList[i].F_YJZH},
                            success: function (data) {
                                try {
                                    var obj=eval('(' + $.trim(data) + ')');
                                } catch(e) {
                                    alertMsg(data);
                                    return false;
                                }
                                $('#chooseCameradiv').modal('close');
                                mediaRecorder.stop();

                                $('#chooseKhdiv').modal({
                                    closeViaDimmer: false,
                                    width:680,
                                    height:500
                                });
                                var flag = loadKhxx(obj.name,obj.identity,obj);
                                if(!flag){
                                    setTimeout(function () {
                                        $.ajax({
                                            url: "/initialvalues/AddKhda",
                                            type: "post",
                                            async: false,
                                            data: { f_khmc: obj.name, f_sjhm: obj.mobile,f_sfzh:obj.identity, f_qydz: "", f_xxdz: "",f_bzxx: "",cslx:1, timeer: new Date() },
                                            success: function (data, textStatus) {
                                                if(data == "ok"){
                                                    var flag2 = loadKhxx(obj.name,obj.identity,obj);
                                                    $('#khoption').val(obj.name);
                                                    $('#chooseKhdiv').modal('open');
                                                }else{
                                                    alertMsg(data);
                                                }
                                            },
                                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                                alert(errorThrown + "||" + textStatus);
                                                $subbtn.button('reset');
                                            }
                                        });
                                    }, 10);
                                }else{
                                    $('#khoption').val(obj.name);
                                    $('#chooseKhdiv').modal('open');
                                }
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                alertMsg(errorThrown + "||" + textStatus);
                            }
                        });
                    }
                }
            });

        });

        //摄像头
        function captureUserMedia(mediaConstraints, successCallback, errorCallback) {
            navigator.mediaDevices.getUserMedia(mediaConstraints).then(successCallback).catch(errorCallback);
        }

        function btdownload(downloadFileUrl) {
            var a = document.createElement('a');
            a.href = downloadFileUrl;
            a.click();
        }

        var mediaConstraints = {
            audio: true, // record both audio/video in Firefox/Chrome
            video: true
        };

        document.querySelector('#start-recording').onclick = function() {
            //this.disabled = true;
            $('#chooseCameradiv').modal({
                closeViaDimmer: false,
                width:680,
                height:500
            });
            $('#chooseCameradiv').modal('open');

            var aCanvas = document.getElementById('canvas');
            var ctx = aCanvas.getContext('2d');
            ctx.fillRect(0, 0, 320, 240);

            var childs = videosContainer.childNodes;
            for(var i = childs .length - 1; i >= 0; i--) {
                videosContainer.removeChild(childs[i]);
            }

            captureUserMedia(mediaConstraints, onMediaSuccess, onMediaError);
        };

        var mediaRecorder;

        function onMediaSuccess(stream) {
            var video = document.createElement('video');

            video = mergeProps(video, {
                controls: true,
                muted: true,
                width: 320,     //videoWidth
                height: 240     //videoHeight
            });
            video.srcObject = stream;
            video.play();

            videosContainer.appendChild(video);

            mediaRecorder = new MediaStreamRecorder(stream);
            mediaRecorder.stream = stream;
            mediaRecorder.start();
        }

        function onMediaError(e) {
            console.error('media error', e);
        }

        var videosContainer = document.getElementById('videos-container');

        window.onbeforeunload = function() {
            document.querySelector('#start-recording').disabled = false;
        };

    </script>

    <script>
        $(function () {
            //录音模组
            var WaveViewBak=Recorder.WaveView;
            var ProcessWaveView;
            var LogAudios=[0];

            window.RootFolder="..";
            window.Runtime={
                LogAudios:LogAudios

                /*注册显示的控制按钮*/
                ,Ctrls:function(ctrls){
                },Import:function(jsList,win){
                    win=win||window;
                    var doc=win.document;
                    var load=function(idx){

                        var itm=jsList[idx];
                        if(itm == undefined){
                            return;
                        }
                        if(itm.check()===false){
                            load(idx+1);
                            return;
                        };
                        var url=itm.url;
                        var elem=doc.createElement("script");
                        elem.setAttribute("type","text/javascript");
                        elem.setAttribute("src",url);
                        elem.onload=function(){
                            load(idx+1);
                        };
                        elem.onerror=function(e){
                        };
                        doc.body.appendChild(elem);
                    };
                    setTimeout(function(){
                        load(0);
                    });

                },Process:function(buffers,powerLevel,bufferDuration,bufferSampleRate){
                    Recorder.WaveView=WaveViewBak;
                    /*if(!ProcessWaveView){
                        ProcessWaveView=Recorder.WaveView({elem:".ctrlProcessWave"});
                    };

                    $(".ctrlProcessX").css("width",powerLevel+"%");
                    $(".ctrlProcessT").html(bufferDuration+"/"+powerLevel);

                    ProcessWaveView.input(buffers[buffers.length-1],powerLevel,bufferSampleRate);*/
                }
                ,LogAudio:function(blob,duration,rec,data){
                    var set=rec&&rec.set||{};
                    var id=LogAudios.length;
                    redioid = id;
                    LogAudios.push({blob:blob,set:$.extend({},set),duration:duration});
                    Runtime.LogAudioDown(id,data);
                }
            };

            $(".mainCtrl").show();
            var idf = "self_base_demo";
            var code = "";
            for(var i=0;i<DemoCodeList.length;i++){
                if(DemoCodeList[i].idf==idf){
                    var o=DemoCodeList[i];
                    code = o.code;
                };
            };
            window.eval(code);

            //下载功能
            var Rnd=0;
            Runtime.LogAudioDown=function(id,data){
                var o=Runtime.LogAudios[id];
                if(o){
                    var cls="LogAudioInfo"+(++Rnd);
                    Runtime.LogAudioDown64(id,cls,data);
                };
            };

            Runtime.LogAudioDown64=function(key, cls,data){
                var o=Runtime.LogAudios[key];

                var reader = new FileReader();

                reader.onloadend = function() {
                    /*$.ajax({
                        url: "/camera/record",
                        type: "post",
                        async: false,
                        data: {base:reader.result,filename:name},
                        success: function (data) {

                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alertMsg(errorThrown + "||" + textStatus);
                        }
                    });*/
                    rediobolb = reader.result;
                    if(data){
                        savebills();
                    }
                };
                reader.readAsDataURL(o.blob);
            };
        })

        var DemoCodeList=[];
        function AddDemoCode(sort,idf,name,fn,jsn){
            DemoCodeList.push({sort:sort?sort:666-DemoCodeList.length,idf:idf,name:name,code:fn&&fn.toString().replace(/^function\s*\(\)\s*\{|\s*\}$/g,""),jsn:jsn});
        }

        AddDemoCode(999,"self_base_demo","【教程】本工具使用示例，和Recorder基础用法",function(){/******************
         《本工具使用示例，和Recorder基础用法》
         作者：高坚果
         时间：2019-9-12 21:59:19

         工具编辑框内可用编辑代码然后运行，代码内可用：
         RootFolder:"" 当前程序根目录，结尾不含/

         Runtime.Import(jsList) 导入js列表，只能调用一次，jsList:[{url:"",check:fn()},...] check返回false跳过这条的导入

         Runtime.Ctrls(ctrls) 在控制区显示按钮，只能调用一次，ctrls:[{html:"html代码"},{name:"按钮名称",click:"函数名称"},...]

         Runtime.Log(msgHtml,color) 在日志区显示日志html，color:0默认，1红色，2绿色，其他指定颜色

         Runtime.LogAudio(blob,duration,rec,msgHtml) 在日志区显示一个音频的日志信息，rec只要对象内有set属性就行

         Runtime.Process(buffers,powerLevel,bufferDuration,bufferSampleRate) 接受Recorder的实时回调，驱动图形显示
         ******************/

//加载框架
        Runtime.Import([
            {url:RootFolder+"/recorder/recorder-core.js",check:function(){return !window.Recorder}}
            ,{url:RootFolder+"/recorder/mp3.js",check:function(){return !Recorder.prototype.mp3}}
            ,{url:RootFolder+"/recorder/mp3-engine.js",check:function(){return !Recorder.lamejs}}
        ]);

//显示控制按钮
            /*        Runtime.Ctrls([
                        {name:"开始录音",click:"recStart"}
                        ,{name:"结束录音",click:"recStop"}
                    ]);*/

//调用录音
            var rec=Recorder({
                type:"mp3",sampleRate:16000,bitRate:16
                ,onProcess:function(buffers,powerLevel,bufferDuration,bufferSampleRate){
                    Runtime.Process.apply(null,arguments);
                }
            });
            function recStart(){
                //var dialog=createDelayDialog(); 我们可以选择性的弹一个对话框：为了防止移动端浏览器存在第三种情况：用户忽略，并且（或者国产系统UC系）浏览器没有任何回调，此处demo省略了弹窗的代码
                var t=setTimeout(function(){
                },8000);

                rec.open(function(){//打开麦克风授权获得相关资源
                    clearTimeout(t);
                    rec.start();//开始录音
                },function(msg,isUserNotAllow){//用户拒绝未授权或不支持
                    clearTimeout(t);
                });
                rediobolb = 1;
            };
            function recStop(data){
                if(data){
                    if(rediobolb == null || redioid != null){
                        savebills();
                    }else{
                        rec.stop(function(blob,duration){
                            rec.close();//释放录音资源
                            Runtime.LogAudio(blob,duration,rec,data);
                        },function(msg){
                        });
                    }
                }else{
                    rec.stop(function(blob,duration){
                        rec.close();//释放录音资源
                        Runtime.LogAudio(blob,duration,rec,data);
                    },function(msg){
                    });
                }

            };
        });
    </script>

    <script>
        (function(){
            var demos=[

                {n:"【Demo库】【格式转换】-mp3格式转成其他格式",k:"lib.transform.mp32other"}
                ,{n:"【Demo库】【格式转换】-wav格式转成其他格式",k:"lib.transform.wav2other"}

                ,{n:"【教程】实时转码并上传",k:"teach.realtime.encode_transfer"}

                ,{n:"【Demo库】【文件合并】-mp3多个片段文件合并",k:"lib.merge.mp3_merge"}
                ,{n:"【Demo库】【文件合并】-wav多个片段文件合并",k:"lib.merge.wav_merge"}

            ];

            var markdown=[];
            for(var i=0;i<demos.length;i++){
                var o=demos[i];
                markdown.push((i+1)+'. ['+o.n+'](https://xiangyuecn.github.io/Recorder/assets/工具-代码运行和静态分发Runtime.html?jsname='+o.k+')');
                AddDemoCode(199-i,"",o.n,null,o.k);
            };

        })();
    </script>

</body>
</html>
