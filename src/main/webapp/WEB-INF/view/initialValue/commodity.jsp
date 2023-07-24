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
    String ypd = (String) session.getAttribute("f_lxbm");
%>
<%--<!DOCTYPE html>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-商品管理</title>
    <meta name="description" content="云平台客户端V1-商品管理">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="apple-touch-icon-precomposed" href="/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="/cropper/css/cropper.min.css">
    <link rel="stylesheet" href="/cropper/css/ImgCropping.css">
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
            max-width:100%;
        }
        label{
            font-weight: 500;
            font-size:1.4rem;
        }
        .am-popup{
            z-index: 1200;
        }
        .am-form-group {
            margin-bottom: 1.1rem;
        }
        td{
            overflow:hidden;
            text-overflow:ellipsis;
        }
    </style>
</head>
<body>
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-12" id="xsdiv">
            <div class="header">
                <div class="am-g">
                    <h1>商品管理</h1>
                </div>
            </div>
        </div>
        <!--选择客户div-->
        <div class="am-container am-" id="chooseKhdiv">
            <div>
                <div class="am-container">
                    <div class="am-u-sm-4 am-u-md-4 am-text-left" style="padding-left: 0;padding-right: 0;">
                        <input class="am-radius am-form-field am-input-sm" id="spoption" style="width: 160px;display:initial;" type="text" placeholder="输入商品名称、字母">
                        <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchSp()">搜索</button>
                        <label class="am-checkbox-inline">
                            <input id="xjbz" type="checkbox"  value="" name="xjbz" data-am-ucheck checked onchange="loadSpxx(1,10,'')"> 包含下架商品
                        </label>
                        <%--<button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" id="savebjkc">保存</button>--%>
                    </div>
                    <%--<div class="am-u-sm-4 am-u-md-4 am-text-left" style="padding-left: 0;padding-right: 0;">
                        报警库存：<input class="am-radius am-form-field am-input-sm" id="bjkc" onKeypress="return (/[\d]/.test(String.fromCharCode(event.keyCode || event.which))) || event.which === 8" style="width: 160px;display:initial;" type="number" placeholder="输入报警库存">
                        <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="saveBjkc('',null)">保存</button>
                    </div>--%>
                    <div class="am-u-sm-4 am-u-md-4 am-text-right">
                        <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadSpxx(1,10,'')" style="border: 1px solid #0E90D2;background: white;color: #0E90D2;">刷新</button>
                        <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" id="addsp">新增</button>
                    </div>
                </div>
                <div style="margin-top: 10px;" class="am-container am-scrollable-horizontal" id="hovertables">
                    <table class="am-table am-table-bordered am-table-centered am-text-nowrap">
                        <thead>
                            <tr>
                                <th class="am-text-middle">操作</th>
                                <th class="am-text-middle">商品图片</th>
                                <th class="am-text-middle">商品条形码</th>
                                <th class="am-text-middle">登记证号</th>
                                <th class="am-text-middle">商品类别</th>
                                <th class="am-text-middle">商品名称</th>
                                <th class="am-text-middle">包装规格</th>
                                <th class="am-text-middle">销售价</th>
                                <th class="am-text-middle">进价</th>
                                <%--<th class="am-text-middle sfbj">报警库存</th>--%>
                                <th class="am-text-middle">供应商</th>
                                <%--<th class="am-text-middle">生产企业</th>--%>
                                <th class="am-text-middle nycsxs">农药登记证</th>
                                <th class="am-text-middle nycsxs">产品包装</th>
                                <th class="am-text-middle nycsxs">产品标签</th>
                                <th class="am-text-middle nycsxs">产品说明书</th>
                                <th class="am-text-middle nycsxs">有关许可证明文件编号</th>
                            </tr>
                        </thead>
                        <tbody id="sptable">
                        </tbody>
                    </table>
                </div>
                <div id="pagebar"></div>
            </div>
        </div>
    </div>
    <!--报警库存div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="BJKCdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">报警库存
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div style="margin-top: 10px;" class="am-container am-scrollable-horizontal" id="hoverbjkctables">
                <table class="am-table am-table-bordered am-table-centered am-text-nowrap">
                    <thead>
                    <tr>
                        <th class="am-text-middle">商品图片</th>
                        <th class="am-text-middle">商品条形码</th>
                        <th class="am-text-middle">登记证号</th>
                        <th class="am-text-middle">商品类别</th>
                        <th class="am-text-middle">商品名称</th>
                        <th class="am-text-middle">包装规格</th>
                        <th class="am-text-middle">销售价</th>
                        <th class="am-text-middle">进价</th>
                        <th class="am-text-middle sfbj">报警库存</th>
                        <th class="am-text-middle">供应商</th>
                        <th class="am-text-middle nycsxs">农药登记证</th>
                        <th class="am-text-middle nycsxs">产品包装</th>
                        <th class="am-text-middle nycsxs">产品标签</th>
                        <th class="am-text-middle nycsxs">产品说明书</th>
                        <th class="am-text-middle nycsxs">有关许可证明文件编号</th>
                    </tr>
                    </thead>
                    <tbody id="bjkctble">
                    </tbody>
                </table>
            </div>
            <div id="pagebarByBjkc"></div>
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
                                <input readonly type="hidden" class="am-form-field am-input-sm am-radius" id="f_spfl" required>
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

                        <div class="am-form-group shflzs">
                            <label for="f_scqy" class="am-u-sm-2 am-form-label" style="padding: 0px;">生产企业</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_scqy" placeholder="生产企业">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group shflzs">
                            <label for="f_ppmc" class="am-u-sm-2 am-form-label" style="padding: 0px;">品牌名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_ppmc" placeholder="品牌名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group qbflzs">
                            <label for="f_yxcf" class="am-u-sm-2 am-form-label" style="padding: 0px;">有效成分</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_yxcf" placeholder="有效成分">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group qbflzs">
                            <label for="f_dx" class="am-u-sm-2 am-form-label" style="padding: 0px;">毒性</label>
                            <div class="am-u-sm-9">
                                <select data-am-selected="{btnWidth: '100%',maxHeight: 200}" id="f_dx" placeholder="选择毒性">
                                </select>
                            </div>
                           <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group qbflzs">
                            <label for="f_yxq" class="am-u-sm-2 am-form-label" style="padding: 0px;">有效期</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_yxq" placeholder="有效期">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group qbflzs">
                            <label for="f_syfw" class="am-u-sm-2 am-form-label" style="padding: 0px;">适用范围</label>
                            <div class="am-u-sm-9">
                                <select data-am-selected="{btnWidth: '100%',maxHeight: 200}" multiple id="f_syfw" placeholder="适用范围">
                                </select>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>

                        <div class="am-form-group spflzs">
                            <label for="f_zhl" class="am-u-sm-2 am-form-label" style="padding: 0px;">总含量</label>
                            <div class="am-u-sm-4">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_zhl" placeholder="如: 1.8%、2.5%等">
                            </div>
                            <label for="f_jx" class="am-u-sm-1 am-form-label" style="padding: 0px;">剂型</label>
                            <div class="am-u-sm-4">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_jx" placeholder="如水剂、乳油、可湿性粉剂等">
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
                        <%--<div class="am-form-group">
                            <label for="f_scqy" class="am-u-sm-2 am-form-label">生产企业</label>
                            <div class="am-u-sm-9">
                                <select data-am-selected="{btnWidth: '100%',maxHeight: 200}" id="f_scqy">
                                </select>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_scxkz" class="am-u-sm-2 am-form-label">生产许可</label>
                            <div class="am-u-sm-9">
                                <input type="text" disabled class="am-form-field am-input-sm am-radius" id="f_scxkz" required placeholder="生产许可">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>--%>
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
                                    <input type="radio"  value="0" checked name="f_sfcz"> 否
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="f_sfcz"> 是
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group gdzwxs">
                            <label class="am-u-sm-2 am-form-label" style="padding: 0px;">禁限农药</label>
                            <div class="am-u-sm-4 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="0" name="f_nybz" checked> 否
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="f_nybz"> 禁止
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="2" name="f_nybz"> 限用
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
                        <div class="am-form-group gdzwxs">
                            <label for="f_fzdx" class="am-u-sm-2 am-form-label" style="padding: 0px;">防治对象</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_fzdx" required placeholder="防治对象">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <%--<div class="am-form-group">
                            <label for="f_bz" class="am-u-sm-2 am-form-label">备注</label>
                            <div class="am-u-sm-9">
                                <textarea  class="am-form-field am-input-sm am-radius" id="f_bz" placeholder="备注"></textarea>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label class="am-u-sm-2 am-form-label">状态</label>
                            <div class="am-u-sm-9 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="0" name="f_zt"> 启用
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="f_zt"> 停用
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>--%>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-5">&nbsp;</div>
                            <div class="am-u-sm-7">
                                <button type="button" id="addspbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeNewSpdiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--修改客户div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="updateSpdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">修改商品
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd am-scrollable-vertical" style="min-height: 500px;">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="updatespform">
                        <input type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_sptm" required>
                        <%--<div class="am-form-group">
                            <label for="xgf_spfl" class="am-u-sm-2 am-form-label" style="padding: 0px;">商品类别</label>
                            <div class="am-u-sm-10">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '70%',maxHeight: 200}" id="xgf_spfl" required>
                                    </select>
                                    <span style="color: #5da5fd;cursor: pointer;" onclick="loadspfl()">刷新</span>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>--%>
                        <div class="am-form-group ypdxs" style="display: none;">
                            <label for="xgf_djzh" class="am-u-sm-2 am-form-label" style="padding: 0px;">登记号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_djzh" placeholder="请扫描二维码或手工录入PD号后回车">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_spfl" class="am-u-sm-2 am-form-label">商品类别</label>
                            <div class="am-u-sm-9">
                                <input readonly type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_spfl" required placeholder="">
                                <input readonly type="text" class="am-form-field am-input-sm am-radius" id="xgf_spflmc" placeholder="">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_spmc" class="am-u-sm-2 am-form-label" style="padding: 0px;">商品名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_spmc" placeholder="商品名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>


                        <div class="am-form-group xgshflzs">
                            <label for="xgf_scqy" class="am-u-sm-2 am-form-label" style="padding: 0px;">生产企业</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_scqy" placeholder="生产企业">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group xgshflzs">
                            <label for="xgf_ppmc" class="am-u-sm-2 am-form-label" style="padding: 0px;">品牌名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_ppmc" placeholder="品牌名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group xgqbflzs">
                            <label for="xgf_yxcf" class="am-u-sm-2 am-form-label" style="padding: 0px;">有效成分</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_yxcf" placeholder="有效成分">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group xgqbflzs">
                            <label for="xgf_dx" class="am-u-sm-2 am-form-label" style="padding: 0px;">毒性</label>
                            <div class="am-u-sm-9">
                                <select data-am-selected="{btnWidth: '100%',maxHeight: 200}" id="xgf_dx" placeholder="选择毒性">
                                </select>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group xgqbflzs">
                            <label for="xgf_yxq" class="am-u-sm-2 am-form-label" style="padding: 0px;">有效期</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_yxq" placeholder="有效期">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group xgqbflzs">
                            <label for="xgf_syfw" class="am-u-sm-2 am-form-label" style="padding: 0px;">适用范围</label>
                            <div class="am-u-sm-9">
                                <select data-am-selected="{btnWidth: '100%',maxHeight: 200}" multiple id="xgf_syfw" placeholder="适用范围">
                                </select>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>

                        <div class="am-form-group xgspflzs">
                            <label for="xgf_zhl" class="am-u-sm-2 am-form-label" style="padding: 0px;">总含量</label>
                            <div class="am-u-sm-4">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_zhl" placeholder="如: 1.8%、2.5%等">
                            </div>
                            <label for="xgf_jx" class="am-u-sm-1 am-form-label" style="padding: 0px;">剂型</label>
                            <div class="am-u-sm-4">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_jx" placeholder="如水剂、乳油、可湿性粉剂等">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>


                        <div class="am-form-group">
                            <label for="xgf_bzgg" class="am-u-sm-2 am-form-label" style="padding: 0px;">包装规格</label>
                            <div class="am-u-sm-4 am-form-inline" style="text-align:left;">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_bzgg" placeholder="规格" style="display:initial;width: 50%;">
                                <span class="pull-left" style="line-height: 34px; margin: 0 5px;">/</span>
                                <select data-am-selected="{btnWidth: '30%',maxHeight: 200}" id="xgprimaryUnit">
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
                                <label for="xgf_mbzzl" class="am-u-sm-1 am-form-label" style="padding: 0px;">每包装重量</label>
                                <div class="am-u-sm-4 am-form-inline" style="text-align:left;">
                                    <input type="number" class="am-form-field am-input-sm am-radius" id="xgf_mbzzl" placeholder="每包装重量" style="display:initial;width: 50%;">
                                    <span class="pull-left" style="line-height: 34px; margin: 0 5px;">/</span>
                                    <select data-am-selected="{btnWidth: '30%',maxHeight: 200}" id="xgf_mbzzldw">
                                        <option value="ML" selected>ML</option>
                                        <option value="G">G</option>
                                    </select>
                                </div>
                                <div class="am-u-sm-end"></div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_xsj" class="am-u-sm-2 am-form-label" style="padding: 0px;">售价</label>
                            <div class="am-u-sm-4" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="xgf_xsj" required placeholder="售价" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">元/<span class="priceUnit">袋</span></span>
                            </div>
                            <div class="am-form-group">
                                <label for="xgf_jhj" class="am-u-sm-1 am-form-label" style="padding: 0px;">进价</label>
                                <div class="am-u-sm-4" style="text-align:left;">
                                    <input type="number" class="am-form-field am-input-sm am-radius" id="xgf_jhj" placeholder="进价" style="display:initial;width: 80%;">
                                    <span style="margin-left: 4px; line-height: 34px;">元/<span class="priceUnit">袋</span></span>
                                </div>
                                <div class="am-u-sm-end"></div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdbxs">
                            <label for="xgf_jxsl" class="am-u-sm-2 am-form-label" style="padding: 0px;">进项税率</label>
                            <div class="am-u-sm-9" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="xgf_jxsl" required placeholder="进项税率" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">%</span>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdbxs">
                            <label for="xgf_xxsl" class="am-u-sm-2 am-form-label" style="padding: 0px;">销项税率</label>
                            <div class="am-u-sm-9" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="xgf_xxsl" required placeholder="销项税率" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">%</span>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <%--<div class="am-form-group">
                            <label for="xgf_scqy" class="am-u-sm-2 am-form-label">生产企业</label>
                            <div class="am-u-sm-9">
                                <select data-am-selected="{btnWidth: '100%',maxHeight: 200}" id="xgf_scqy">
                                </select>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_scxkz" class="am-u-sm-2 am-form-label">生产许可</label>
                            <div class="am-u-sm-9">
                                <input type="text" disabled class="am-form-field am-input-sm am-radius" id="xgf_scxkz" required placeholder="生产许可">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>--%>
                        <div class="am-form-group">
                            <label for="xgf_ghs" class="am-u-sm-2 am-form-label" style="padding: 0px;">供货商</label>
                            <div class="am-u-sm-9">
                                <select multiple data-am-selected="{btnWidth: '100%',maxHeight: 200,searchBox: 1}" id="xgf_ghs">
                                </select>
                                <input  id="xginputselect" type="text" class="am-form-field am-input-sm am-radius"
                                        style="width:90%;position: absolute;top: 3px"/>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="xgf_nycpdjz" class="am-u-sm-2 am-form-label" style="padding: 0px;">登记证</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_nycpdjz" placeholder="农药登记证" readonly>
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_nycpdjzfwqdz" placeholder="农药登记证服务器地址" readonly>
                            </div>
                            <!--file上传文件-->
                            <div class="am-form-group am-form-file am-u-sm-2" style="padding: 0px;margin: 0px;">
                                <div style="text-align: left;">
                                    <button type="button" class="am-btn am-btn-default am-btn-sm">
                                        <i class="am-icon-cloud-upload"></i>浏览</button>
                                </div>
                                <input id="xgf_nycpdjzFile" type="file">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="xgf_nycpbz" class="am-u-sm-2 am-form-label" style="padding: 0px;">产品包装</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_nycpbz" placeholder="产品包装" readonly>
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_nycpbzfwqdz" placeholder="产品包装服务器地址" readonly>
                            </div>
                            <!--file上传文件-->
                            <div class="am-form-group am-form-file am-u-sm-2" style="padding: 0px;margin: 0px;">
                                <div style="text-align: left;">
                                    <button type="button" class="am-btn am-btn-default am-btn-sm">
                                        <i class="am-icon-cloud-upload"></i>浏览</button>
                                </div>
                                <input id="xgf_nycpbzFile" type="file">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="xgf_nycpbq" class="am-u-sm-2 am-form-label" style="padding: 0px;">产品标签</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_nycpbq" placeholder="产品标签" readonly>
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_nycpbqfwqdz" placeholder="产品标签服务器地址" readonly>
                            </div>
                            <!--file上传文件-->
                            <div class="am-form-group am-form-file am-u-sm-2" style="padding: 0px;margin: 0px;">
                                <div style="text-align: left;">
                                    <button type="button" class="am-btn am-btn-default am-btn-sm">
                                        <i class="am-icon-cloud-upload"></i>浏览</button>
                                </div>
                                <input id="xgf_nycpbqFile" type="file">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="xgf_nycpsms" class="am-u-sm-2 am-form-label" style="padding: 0px;">说明书</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_nycpsms" placeholder="产品说明书" readonly>
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_nycpsmsfwqdz" placeholder="产品说明书服务器地址" readonly>
                            </div>
                            <!--file上传文件-->
                            <div class="am-form-group am-form-file am-u-sm-2" style="padding: 0px;margin: 0px;">
                                <div style="text-align: left;">
                                    <button type="button" class="am-btn am-btn-default am-btn-sm">
                                        <i class="am-icon-cloud-upload"></i>浏览</button>
                                </div>
                                <input id="xgf_nycpsmsFile" type="file">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="xgf_nycpzmwjbh" class="am-u-sm-2 am-form-label" style="padding: 0px;">许可证明</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_nycpzmwjbh" placeholder="有关许可证明文件编号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdbxs">
                            <label class="am-u-sm-2 am-form-label" style="padding: 0px;">是否称重</label>
                            <div class="am-u-sm-9 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="0" name="xgf_sfcz"> 否
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="xgf_sfcz"> 是
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group xggdzwxs">
                            <label class="am-u-sm-2 am-form-label" style="padding: 0px;">禁限农药</label>
                            <div class="am-u-sm-4 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="0" name="xgf_nybz"> 否
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="xgf_nybz"> 禁止
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="2" name="xgf_nybz"> 限用
                                </label>
                            </div>
                            <div class="am-form-group ypdxs">
                                <label class="am-u-sm-1 am-form-label" style="padding: 0px;">商品类型</label>
                                <div class="am-u-sm-4 am-text-left">
                                    <label class="am-radio-inline">
                                        <input type="radio"  value="0" checked name="xgf_splx"> 商品
                                    </label>
                                    <label class="am-radio-inline">
                                        <input type="radio" value="1" name="xgf_splx"> 包装物
                                    </label>
                                </div>
                                <div class="am-u-sm-end"></div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group xggdzwxs">
                            <label for="xgf_fzdx" class="am-u-sm-2 am-form-label" style="padding: 0px;">防治对象</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_fzdx" required placeholder="防治对象">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <%--<div class="am-form-group">
                            <label for="f_bz" class="am-u-sm-2 am-form-label">备注</label>
                            <div class="am-u-sm-9">
                                <textarea  class="am-form-field am-input-sm am-radius" id="xgf_bz" placeholder="备注"></textarea>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label class="am-u-sm-2 am-form-label">状态</label>
                            <div class="am-u-sm-9 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="0" name="f_zt"> 启用
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="f_zt"> 停用
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>--%>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-5">&nbsp;</div>
                            <div class="am-u-sm-7">
                                <button type="button" id="updatespbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeUpdateSpdiv()">取消</button>
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

    <!--图片裁剪框 start-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="Tpjj">
        <button id="replaceImg" class="l-btn">更换图片</button>
        <div style="width: 320px;height: 320px;border: solid 1px #555;padding: 5px;margin-top: 10px">
            <img id="finalImg" src="" width="100%">
        </div>
    </div>

    <!--图片裁剪框 start-->
    <div style="display: none" class="tailoring-container">
        <div class="black-cloth" onClick="closeTailor(this)"></div>
        <div class="tailoring-content">
            <div class="tailoring-content-one">
                <label title="上传图片" for="chooseImg" class="l-btn choose-btn">
                    <input type="file" style="display: none;" accept="image/jpg,image/jpeg,image/png" name="file" id="chooseImg"  onChange="selectImg(this)">
                    选择图片
                </label>
                <div class="close-tailoring"  onclick="closeTailor(this)">×</div>
            </div>
            <div class="tailoring-content-two">
                <div class="tailoring-box-parcel">
                    <img id="tailoringImg">
                </div>
                <div class="preview-box-parcel">
                    <p>图片预览：</p>
                    <div class="square previewImg"></div>
                    <div class="circular previewImg"></div>
                </div>
            </div>
            <div class="tailoring-content-three">
                <button class="l-btn cropper-reset-btn">复位</button>
                <button class="l-btn cropper-rotate-btn">旋转</button>
                <button class="l-btn cropper-scaleX-btn">换向</button>
                <button class="l-btn sureCut" id="sureCut">确定</button>
            </div>
        </div>
    </div>
    <!--图片裁剪框 end-->

    <script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
    <script src="/assets/js/amazeui.min.js"></script>
    <script src="/assets/js/app.js"></script>
    <script src="/assets/address/address.min.js"></script>
    <script src="/assets/address/iscroll.min.js"></script>
    <script src="/tree/amazeui.tree.js"></script>
    <script src="/tree/amazeui.tree.min.js"></script>
    <script src="/cropper/js/cropper.min.js"></script>
    <script type="text/javascript">
        var loadJson = null;
        var scqyJson = null;
        var sptmtp = null;
        var dxJson = null;
        var syfwJson = null;

        $(function(){
            loadSpxx(1,10,"");
            //loadspfl("","");
            loadspfl();
            //loadScqy();
            loadGhs();

            //显示新增客户
            $('#addsp').click(function () {
                loadGhs();
                $("#f_spfl").val("");
                $("#f_spflmc").val("");
                $("#f_djzh").val("");
                $("#f_sptm").val("");
                $("#f_spmc").val("");
                $("#f_bzgg").val("");
                $("#f_zhl").val("");
                $("#f_jx").val("");
                $("#f_mbzzl").val("");
                $("#f_mbzzldw").val("");
                $("#primaryUnit").val("");
                $("#f_xsj").val("");
                $("#f_jhj").val("");
                $("#f_jxsl").val("");
                $("#f_xxsl").val("");
                $("#f_scqy").val("");
                $("#f_scxkz").val("");
                $("#f_ghs").val("");
                $("#f_nycpzmwjbh").val("");
                $("#f_fzdx").val("");

                $('#f_scqy').trigger('changed.selected.amui');
                $('#f_ghs').trigger('changed.selected.amui');

                $(".shflzs").hide();
                $(".spflzs").hide();
                $(".qbflzs").hide();
                $(".gdzwxs").hide();

                //商户类型为农资店或农药厂商
                if("<%=ypd%>" == '0' || "<%=ypd%>" == '1'){
                    $(".shflzs").show();
                    $(".spflzs").hide();
                    $(".qbflzs").show();

                    loadDx();
                    var dxHtml = "";
                    dxHtml += "<option selected value=''></option>";
                    for (var i = 0; i < dxJson.length;i++){
                        dxHtml += "<option value='"+dxJson[i].F_DXBM+"'>"+dxJson[i].F_DXMC+"</option>";
                    }
                    $("#f_dx").html(dxHtml);

                    loadSyfw();
                    var syfwHtml = "";
                    syfwHtml += "<option selected value=''></option>";
                    for (var i = 0; i < syfwJson.length;i++){
                        var syfwda = syfwJson[i];
                        syfwHtml += "<option value='"+syfwda.F_FLBM+"'>"+syfwda.F_FLMC+"</option>";
                    }
                    $("#f_syfw").html(syfwHtml);
                }

                //农药厂商、农资店、常熟、江阴、太仓类型时，显示防治对象和禁限类型
                if("<%=ypd%>" == '0' || "<%=ypd%>" == '1' || "<%=ypd%>" == '12' || "<%=ypd%>" == '13' || "<%=ypd%>" == '14' ){
                    $(".gdzwxs").show();
                }

                $('#newSpdiv').modal({
                    closeViaDimmer: false,
                    width:880,
                    height:570
                });
                $('#newSpdiv').modal('open');
                $('.am-dimmer').css("z-index","1111");
                $('#newSpdiv').css("z-index","1119");
            });

            //关闭还原遮罩蒙板z-index
            $('#newSpdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });

            //显示新增客户
            /*$('#openbjkc').click(function () {
                loadGhs();
                loadSpxxByBjkc(1,10,"");
                $('#BJKCdiv').modal({
                    closeViaDimmer: false,
                    width:880,
                    height:570
                });
                $('#BJKCdiv').modal('open');
                $('.am-dimmer').css("z-index","1111");
                $('#BJKCdiv').css("z-index","1119");
            });*/
            //保存报警库存
            /*$('#savebjkc').click(function () {
                var json = "[";
                $('#sptable tr').each(function () {
                    var rowNum=$(this).index();
                    var $table=$(this).parent();
                    var sptm=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(2)').text();
                    var bjkc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(9)').find('input:eq(0)').val();
                    saveBjkc(sptm,bjkc);
                });
                json+="]";
            });*/


            //增加商品提交
            $("#addspbtn").click(function (){
                var sptm = $("#f_sptm").val();
                var djh = $("#f_djzh").val();
                var spmc = $("#f_spmc").val();
                var spfl = $("#f_spfl").val();
                //var bjkc = $("#f_bjkc").val();

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
                var ppmc = "";
                var yxcf = "";
                var dx = "";
                var yxq = "";
                var syfw = "";
                var scxkz = $("#f_scxkz").val();
                var ghs = $("#inputselect").val();
                ghs = ghs.trim();
                var sfcz = $("input[name='f_sfcz']:checked").val();
                var splx = $("input[name='f_splx']:checked").val();
                var nybz = "";
                var nycpdjz = "";
                var nycpbz = "";
                var nycpbq = "";
                var nycpsms = "";
                var zhl = "";
                var jx = "";
                var mbzzl = "";
                var mbzzldw = "";
                var nycpzmwjbh = $("#f_nycpzmwjbh").val();
                var fzdx = "";
                var jxlx = "";

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

                if("<%=ypd%>" != '1'  && "<%=ypd%>" != '0'){
                    if(jxsl == ''){
                        alertMsg('进项税率不能为空！');
                        return;
                    }
                    if(xxsl == ''){
                        alertMsg('销项税率不能为空！');
                        return;
                    }
                }
                if("<%=ypd%>" == '1'){
                    mbzzl = $("#f_mbzzl").val();
                    mbzzldw = $("#f_mbzzldw").val();
                }

                if("<%=ypd%>" == '0'){
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

                //商户类型为农资店或农药厂商，同时商品类别名称是农药分类
                var f_splbbm = $("#f_spfl").val().substring(0,2);
                if (f_splbbm == "01" && ("<%=ypd%>" == '0' || "<%=ypd%>" == '1')){
                    scqy = $("#f_scqy").val();
                    ppmc = $("#f_ppmc").val();
                    yxcf = $("#f_yxcf").val();
                    dx = $("#f_dx").val();
                    yxq = $("#f_yxq").val();
                    syfw = $("#f_syfw").val();
                    if(syfw == null || syfw == ""){
                        alertMsg('适用范围不能为空！');
                        return;
                    }
                    zhl = $("#f_zhl").val();
                    jx = $("#f_jx").val();
                }else if (f_splbbm == "01" && ("<%=ypd%>" != '0' && "<%=ypd%>" != '1')){
                    //商户类型非农资店和农药厂商，但商品类别名称是农药分类
                    yxcf = $("#f_yxcf").val();
                    dx = $("#f_dx").val();
                    yxq = $("#f_yxq").val();
                    syfw = $("#f_syfw").val();
                    if(syfw == null || syfw == ""){
                        alertMsg('适用范围不能为空！');
                        return;
                    }
                    zhl = $("#f_zhl").val();
                    jx = $("#f_jx").val();
                }else if (f_splbbm != "01" && ("<%=ypd%>" == '0' || "<%=ypd%>" == '1')){
                    //商户类型为农资店和农药厂商，但商品类别名称非农药分类
                    yxcf = $("#f_yxcf").val();
                    dx = $("#f_dx").val();
                    yxq = $("#f_yxq").val();
                    syfw = $("#f_syfw").val();
                    if(syfw == null || syfw == ""){
                        alertMsg('适用范围不能为空！');
                        return;
                    }
                    scqy = $("#f_scqy").val();
                    ppmc = $("#f_ppmc").val();
                }


                var $subbtn = $("#addspbtn");
                $subbtn.button('loading');
                if(ghs == null){
                    ghs = "";
                }


                if ("<%=ypd%>" == '0' || "<%=ypd%>" == '1' || "<%=ypd%>" == '12' || "<%=ypd%>" == '13' || "<%=ypd%>" == '14'){
                    fzdx = $("#f_fzdx").val();
                    nybz = $("input[name='f_nybz']:checked").val();
                }


                $.ajax({
                    url: "/commodity/saveSpda",
                    type: "post",
                    async: false,
                    data: { sptm: sptm, djh: djh,spmc:spmc, spfl: spfl, ggxh: ggxh,jldw:jldw,
                        xsj: xsj,jhj:jhj,jxsl:jxsl,xxsl:xxsl,scxkz:scxkz,ghs:ghs.toString(),scqy:scqy,splx:splx,nybz:nybz,
                        nycpdjz:nycpdjz,nycpbz:nycpbz,nycpbq:nycpbq,nycpsms:nycpsms,nycpzmwjbh:nycpzmwjbh,
                        zhl:zhl,jx:jx,mbzzl:mbzzl,mbzzldw:mbzzldw,ppmc:ppmc,yxcf:yxcf,dx:dx,yxq:yxq,syfw:syfw.toString(),
                        fzdx:fzdx,sfcz:sfcz,timeer: new Date() },
                    success: function (data, textStatus) {
                        if(data == "ok"){
                            //saveBjkc(sptm,bjkc);
                            alertMsg("保存成功！");
                        }else{
                            alertMsg(data);
                            $subbtn.button('reset');
                            return false;
                        }
                        $subbtn.button('reset');
                        $('#newSpdiv').modal('close');
                        loadSpxx(1,10,"");
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alertMsg(errorThrown + "||" + textStatus);
                        $subbtn.button('reset');
                    }
                });

            });

            //关闭还原遮罩蒙板z-index
            $('#updateSpdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
            //修改商品提交
            $("#updatespbtn").click(function (){
                var sptm = $("#xgf_sptm").val();
                var djh = $("#xgf_djzh").val();
                var spmc = $("#xgf_spmc").val();
                var spfl = $("#xgf_spfl").val();
                var bjkc = $("#xgf_bjkc").val();
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
                var ggxh = $("#xgf_bzgg").val()
                var jldw = $("#xgprimaryUnit").val();
                var xsj = $("#xgf_xsj").val();
                var jhj = $("#xgf_jhj").val();
                var jxsl = $("#xgf_jxsl").val();
                var xxsl = $("#xgf_xxsl").val();
                //var scqy = $("#xgf_scqy").val();
                var scqy = "";
                var ppmc = "";
                var yxcf = "";
                var dx = "";
                var yxq = "";
                var syfw = "";
                var scxkz = $("#xgf_scxkz").val();
                var ghs = $("#xginputselect").val();
                var sfcz = $("input[name='xgf_sfcz']:checked").val();
                var splx = $("input[name='xgf_splx']:checked").val();
                var nybz = "";
                var fzdx = "";
                var nycpdjz = "";
                var nycpbz = "";
                var nycpbq = "";
                var nycpsms = "";
                var nycpzmwjbh = $("#xgf_nycpzmwjbh").val();
                var zhl = "";
                var jx = "";
                var mbzzl = "";
                var mbzzldw = "";
                if(splx != '1'){
                    if(ggxh == ''){
                        alertMsg('包装规格不能为空！');
                        return;
                    }
                    if(jhj == ''){
                        alertMsg('进价不能为空！');
                        return;
                    }
                    if(ghs == ''){
                        alertMsg('供货商不能为空！');
                        return;
                    }
                }
                if(xsj == ''){
                    alertMsg('售价不能为空！');
                    return;
                }
                if("<%=ypd%>" != '1' && "<%=ypd%>" != '0'){
                    if(jxsl == ''){
                        alertMsg('进项税率不能为空！');
                        return;
                    }
                    if(xxsl == ''){
                        alertMsg('销项税率不能为空！');
                        return;
                    }
                }
                if("<%=ypd%>" == '0'){
                    var result = uploadFiles($("#xgf_nycpdjzFile"));
                    nycpdjz = result;
                    nycpbz = uploadFiles($("#xgf_nycpbzFile"));
                    nycpbq = uploadFiles($("#xgf_nycpbqFile"));
                    nycpsms = uploadFiles($("#xgf_nycpsmsFile"));
                }
                if("<%=ypd%>" == '1'){
                    mbzzl = $("#xgf_mbzzl").val();
                    mbzzldw = $("#xgf_mbzzldw").val();
                }

                /*if(scxkz == ''){
                    alertMsg('生产企业不能为空！');
                    return;
                }*/
                var $subbtn = $("#updatespbtn");
                $subbtn.button('loading');

                if(ghs == null){
                    ghs = "";
                }

                //商户类型为农资店或农药厂商，同时商品类别名称是农药分类
                var f_splbbm = $("#xgf_spfl").val().substring(0,2);
                if (f_splbbm == "01" && ("<%=ypd%>" == '0' || "<%=ypd%>" == '1')){
                    scqy = $("#xgf_scqy").val();
                    ppmc = $("#xgf_ppmc").val();
                    yxcf = $("#xgf_yxcf").val();
                    dx = $("#xgf_dx").val();
                    yxq = $("#xgf_yxq").val();
                    syfw = $("#xgf_syfw").val();
                    if(syfw == null || syfw == ""){
                        alertMsg('适用范围不能为空！');
                        return;
                    }
                    zhl = $("#xgf_zhl").val();
                    jx = $("#xgf_jx").val();
                }else if (f_splbbm == "01" && ("<%=ypd%>" != '0' && "<%=ypd%>" != '1')){
                    //商户类型非农资店和农药厂商，但商品类别名称是农药分类
                    yxcf = $("#xgf_yxcf").val();
                    dx = $("#xgf_dx").val();
                    yxq = $("#xgf_yxq").val();
                    syfw = $("#xgf_syfw").val();
                    if(syfw == null || syfw == ""){
                        alertMsg('适用范围不能为空！');
                        return;
                    }
                    zhl = $("#xgf_zhl").val();
                    jx = $("#xgf_jx").val();
                }else if (f_splbbm != "01" && ("<%=ypd%>" == '0' || "<%=ypd%>" == '1')){
                    //商户类型为农资店和农药厂商，但商品类别名称非农药分类
                    yxcf = $("#xgf_yxcf").val();
                    dx = $("#xgf_dx").val();
                    yxq = $("#xgf_yxq").val();
                    syfw = $("#xgf_syfw").val();
                    if(syfw == null || syfw == ""){
                        alertMsg('适用范围不能为空！');
                        return;
                    }
                    scqy = $("#xgf_scqy").val();
                    ppmc = $("#xgf_ppmc").val();
                }

                if ("<%=ypd%>" == '0' || "<%=ypd%>" == '1' || "<%=ypd%>" == '12' || "<%=ypd%>" == '13' || "<%=ypd%>" == '14'){
                    $(".xggdzwxs").show();
                    nybz = $("input[name='xgf_nybz']:checked").val();
                    fzdx = $("#xgf_fzdx").val();
                }else {
                    $(".xggdzwxs").hide();
                }

                $.ajax({
                    url: "/commodity/updateSpda",
                    type: "post",
                    async: false,
                    data: { sptm: sptm, djh: djh,spmc:spmc, spfl: spfl, ggxh: ggxh,jldw:jldw,
                        xsj: xsj,jhj:jhj,jxsl:jxsl,xxsl:xxsl,scxkz:scxkz,ghs:ghs.toString(),scqy:scqy,splx:splx,nybz:nybz,
                        nycpdjz:nycpdjz,nycpbz:nycpbz,nycpbq:nycpbq,nycpsms:nycpsms,nycpzmwjbh:nycpzmwjbh,
                        zhl:zhl,jx:jx,mbzzl:mbzzl,mbzzldw:mbzzldw,ppmc:ppmc,yxcf:yxcf,dx:dx,yxq:yxq,syfw:syfw.toString(),
                        sfcz:sfcz,fzdx:fzdx,timeer: new Date() },
                    success: function (data, textStatus) {
                        if(data == "ok"){
                            //saveBjkc(sptm,bjkc);
                            alertMsg("修改成功！");
                        }
                        $subbtn.button('reset');
                        $('#updateSpdiv').modal('close');
                        loadSpxx(1,10,"");
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alertMsg(errorThrown + "||" + textStatus);
                        $subbtn.button('reset');
                    }
                });
            });

            //修改销售价单位
            $('#primaryUnit').change(function () {
                $('.priceUnit').html($('#primaryUnit').val());
            });

            $('#hoverbjkctables').hover(function(){
                $('#hoverbjkctables').css("overflow","auto")
            },function(){
                $('#hoverbjkctables').css("overflow","hidden")
            });

            //显示选择权限
            $('#f_spflmc').click(function () {
                $('#SPFLdiv').modal({
                    closeViaDimmer: false,
                    width:720,
                    height:550
                });
                $('#SPFLdiv').modal('open');
                $('#SPFLdiv').css("z-index","1219");
            });

            //显示选择权限
            $('#xgf_spflmc').click(function () {
                $('#SPFLdiv').modal({
                    closeViaDimmer: false,
                    width:720,
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

            $('#addFlxz').click(function () {
                $('#SPFLdiv').modal('close');

                $("#f_spfl").val(spflbm);
                $("#f_spflmc").val(spflmc);
                $("#xgf_spfl").val(spflbm);
                $("#xgf_spflmc").val(spflmc);
                setsptm(spflbm);

                //根据不同的商户类型和商品分类，加载不同页面
                var f_splbbm = $("#f_spfl").val().substring(0,2);
                var xgf_splbbm = $("#xgf_spfl").val().substring(0,2);
                loadDx();
                var dxHtml = "";
                dxHtml += "<option selected value=''></option>";
                for (var i = 0; i < dxJson.length;i++){
                    dxHtml += "<option value='"+dxJson[i].F_DXBM+"'>"+dxJson[i].F_DXMC+"</option>";
                }
                $("#f_dx").html(dxHtml);
                $("#xgf_dx").html(dxHtml);

                loadSyfw();
                var syfwHtml = "";
                syfwHtml += "<option selected value=''></option>";
                for (var i = 0; i < syfwJson.length;i++){
                    var syfwda = syfwJson[i];
                    syfwHtml += "<option value='"+syfwda.F_FLBM+"'>"+syfwda.F_FLMC+"</option>";
                }
                $("#f_syfw").html(syfwHtml);
                $("#xgf_syfw").html(syfwHtml);
                //商户类型为农资店或农药厂商，同时商品类别名称是农药分类
                if (f_splbbm == "01" && ("<%=ypd%>" == '0' || "<%=ypd%>" == '1')){
                    $(".shflzs").show();
                    $(".spflzs").show();
                    $(".qbflzs").show();
                }else if (f_splbbm == "01" && ("<%=ypd%>" != '0' && "<%=ypd%>" != '1')){
                    //商户类型非农资店和农药厂商，但商品类别名称是农药分类
                    $(".shflzs").hide();
                    $(".spflzs").show();
                    $(".qbflzs").show();
                }else if (f_splbbm != "01" && ("<%=ypd%>" == '0' || "<%=ypd%>" == '1')){
                    //商户类型为农资店和农药厂商，但商品类别名称非农药分类
                    $(".shflzs").show();
                    $(".spflzs").hide();
                    $(".qbflzs").show();
                }else{
                    //商户类型非农资店和农药厂商，且商品类别名称非农药分类
                    $(".shflzs").hide();
                    $(".spflzs").hide();
                    $(".qbflzs").hide();
                }


                //商户类型为农资店或农药厂商，同时商品类别名称是农药分类
                if (xgf_splbbm == "01" && ("<%=ypd%>" == '0' || "<%=ypd%>" == '1')){
                    $(".xgshflzs").show();
                    $(".xgspflzs").show();
                    $(".xgqbflzs").show();
                }else if (xgf_splbbm == "01" && ("<%=ypd%>" != '0' && "<%=ypd%>" != '1')){
                    //商户类型非农资店和农药厂商，但商品类别名称是农药分类
                    $(".xgshflzs").hide();
                    $(".xgspflzs").show();
                    $(".xgqbflzs").show();
                }else if (xgf_splbbm != "01" && ("<%=ypd%>" == '0' || "<%=ypd%>" == '1')){
                    //商户类型为农资店和农药厂商，但商品类别名称非农药分类
                    $(".xgshflzs").show();
                    $(".xgspflzs").hide();
                    $(".xgqbflzs").show();
                }else{
                    //商户类型非农资店和农药厂商，且商品类别名称非农药分类
                    $(".xgshflzs").hide();
                    $(".xgspflzs").hide();
                    $(".xgqbflzs").hide();
                }
            });

            $('#f_scqy').change(function () {
                var scqymx = $('#f_scqy').val();
                if(scqymx != ''){
                    for(var i=0;i<scqyJson.length;i++){
                        var scqymxs=scqyJson[i];
                        if(scqymxs.F_CSBM == scqymx){
                            $('#f_scxkz').val(scqymxs.F_SCXKZH);
                        }
                    }
                }
            });

            $('#xgf_scqy').change(function () {
                var scqymx = $('#xgf_scqy').val();
                if(scqymx != ''){
                    for(var i=0;i<scqyJson.length;i++){
                        var scqymxs=scqyJson[i];
                        if(scqymxs.F_CSBM == scqymx){
                            $('#xgf_scxkz').val(scqymxs.F_SCXKZH);
                        }
                    }
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

            $('#xgf_ghs').change(function () {
                var ghs = $('#xgf_ghs').val();
                if(ghs != null){
                    $('#xginputselect').val(ghs);
                }else{
                    $('#xginputselect').val('');
                }
            });

            if("<%=ypd%>" == '1' || "<%=ypd%>" == '0'){
                $('.ypdxs').show();
                $('.ypdbxs').hide();
            }

            if("<%=ypd%>" == '12' || "<%=ypd%>" == '13' || "<%=ypd%>" == '14'){
                $('.ypdxs').show();
                $('.ypdbxs').show();
            }

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
                                /*if(json.PD != null && json.PD != 'null'){
                                    $("#f_djzh").val(json.PD);
                                }*/
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
                                /*$("#f_spmc").val(json.f_spmc);
                                var ggxh = json.f_ggxh;
                                var ggxhs = ggxh.split("/");
                                $("#f_bzgg").val(ggxhs[0]);
                                $("#primaryUnit").val(ggxhs[1]);*/
                            }else{
                                if(data == 'err'){
                                    alertMsg("该商品已添加！");
                                }else{
                                    if(data == 'err'){
                                        alertMsg("该商品已添加！");
                                    }else if(data == '' || data == '[]'){
                                        alertMsg("无国家标准农药信息！");
                                    }
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

            $('#xgf_djzh').keypress(function (e) {
                if (e.keyCode == 13) {
                    var djzh = $("#xgf_djzh").val();
                    $.ajax({
                        url: "/goodsAnalysis/goodsInfo",
                        type: "post",
                        async: false,
                        data: {url:djzh, timeer: new Date() },
                        success: function (data) {
                            if(data != '' && data != null && data != 'err'){
                                var json = JSON.parse(data);
                                /*if(json.PD != null && json.PD != 'null'){
                                    $("#xgf_djzh").val(json.PD);
                                }
                                $("#xgf_spmc").val(json.f_spmc);
                                var ggxh = json.f_ggxh;
                                var ggxhs = ggxh.split("/");
                                $("#xgf_bzgg").val(ggxhs[0]);
                                $("#xgprimaryUnit").val(ggxhs[1]);*/
                                if(json.length > 0){
                                    $("#xgf_spmc").val(json[0].YPMC);
                                    $("#xgf_zhl").val(json[0].YPZJL);
                                    $("#xgf_jx").val(json[0].YPJX);
                                    $("#xgf_spfl").val(json[0].F_SPLBBM);
                                    $("#xgf_spflmc").val(json[0].YPLB);
                                    $("#xginputselect").val(json[0].DJHSCCJ);
                                    $("#xgf_djzh").val(json[0].YPDJH);
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

            if("<%=ypd%>" == '0'){
                $('.nycsxs').show();
            }else{
                $('.nycsxs').hide();
            }
            if("<%=ypd%>" == '1'){
                $('.nzdxs').show();
            }
            if("<%=ypd%>" == '0'){
                $('.nzdxs').hide();
            }

            //弹出框水平垂直居中
            (window.onresize = function () {
                var win_height = $(window).height();
                var win_width = $(window).width();
                if (win_width <= 768){
                    $(".tailoring-content").css({
                        "top": (win_height - $(".tailoring-content").outerHeight())/2,
                        "left": 0
                    });
                }else{
                    $(".tailoring-content").css({
                        "top": (win_height - $(".tailoring-content").outerHeight())/2,
                        "left": (win_width - $(".tailoring-content").outerWidth())/2
                    });
                }
            })();

        });



        function searchSp() {
            var spxx=$('#spoption').val();
            loadSpxx(1,10,spxx);
        };

        function loadTable(pageIndex) {
            $('#pagebar').html("");
            var spxx=$('#spoption').val();
            loadSpxx(pageIndex,10,spxx);
        }

        //加载商品
        function loadSpxx(pageIndex,pageSize,spxx){
            var xjbz = $("#xjbz").is(':checked');
            if($("#xjbz").is(':checked')){
                xjbz = 1;
            }else{
                xjbz = 0;
            }
            $.ajax({
                url: "/commodity/getSpda",
                type: "post",
                async: false,
                data: {f_spxx:spxx,pageIndex:pageIndex,pageSize:pageSize,xjbz:xjbz, timeer: new Date() },
                success: function (data) {
                    var res = JSON.parse(data);
                    var dataJson = JSON.parse(res.list);
                    $('#sptable').html("");
                    loadJson = dataJson;
                    if(dataJson.length>0) {
                        var splbhtml="";
                        for(var i=0;i<dataJson.length;i++){
                            var spda=dataJson[i];
                            if(splbhtml==""){
                                splbhtml="<tr>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">";
                                splbhtml+="<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>";
                                    /*" &nbsp;&nbsp;&nbsp; ";
                                    "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+spda.F_SPTM+"')\">删除</a></td>";*/
                                splbhtml+="&nbsp;&nbsp;";
                                if(spda.F_XJBZ == 1){
                                    splbhtml+="<a href=\"#\" class=\"redlink\" onclick=\"stopstart('"+spda.F_SPTM+"',0)\">上架</a></td>\n";
                                }else{
                                    splbhtml+="<a href=\"#\" class=\"redlink\" onclick=\"stopstart('"+spda.F_SPTM+"',1)\">下架</a></td>\n";
                                }
                                splbhtml+="                            <td class=\"am-text-middle\" aria-describedby=\"grid-table_oneImageUrl\"><img onclick=\"uploadFilesSptp('"+spda.F_SPTM+"')\" style=\"height: 25px;\" src=\""+spda.F_SPTP+"\"  alt=\""+spda.F_SPMC+"\"/></td>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_SPTM+"</td>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_YPZJH+"</td>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_SPLBMC+"</td>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_SPMC+"</td>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">"+(spda.F_GGXH+"/"+spda.F_JLDW)+"</td>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_XSDJ+"</td>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_ZHJJ+"</td>\n";
                                /*if(spda.F_BJKC != undefined && spda.F_BJKC != ''){
                                    splbhtml+="                            <td class=\"am-text-middle\"><input class='bjkcinput' onchange='changeBjkc(this)' value='"+spda.F_BJKC+"'><input type='hidden' value='"+spda.F_SPTM+"'></td>\n";
                                    $(".sfbj").show();
                                }else{
                                    $(".sfbj").hide();
                                }*/
                                /*splbhtml+="                            <td class=\"am-text-middle\"><input class='bjkcinput' onchange='changeBjkc(this)' value='"+spda.F_BJKC+"'><input type='hidden' value='"+spda.F_SPTM+"'></td>\n";*/
                                splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_GYSMC+"</td>\n";
                                    //"                            <td class=\"am-text-middle\">"+spda.F_CSMC+"</td>\n";
                                if('<%=ypd%>' == '0'){
                                    if(spda.F_NYCPDJZ.length >0){
                                        splbhtml += "                            <td class=\"am-text-middle\"><a href='"+spda.F_NYCPDJZ+"' target='_blank'><img src='"+spda.F_NYCPDJZ+"' height='20px;'/></td>\n";
                                    }else{
                                        splbhtml += "                            <td class=\"am-text-middle\"></td>\n";
                                    }
                                    if(spda.F_NYCPBZ.length >0){
                                        splbhtml += "                            <td class=\"am-text-middle\"><a href='"+spda.F_NYCPBZ+"' target='_blank'><img src='"+spda.F_NYCPBZ+"' height='20px;'/></td>\n";
                                    }else{
                                        splbhtml += "                            <td class=\"am-text-middle\"></td>\n";
                                    }
                                    if(spda.F_NYCPBQ.length >0){
                                        splbhtml += "                            <td class=\"am-text-middle\"><a href='"+spda.F_NYCPBQ+"' target='_blank'><img src='"+spda.F_NYCPBQ+"' height='20px;'/></td>\n";
                                    }else{
                                        splbhtml += "                            <td class=\"am-text-middle\"></td>\n";
                                    }
                                    if(spda.F_NYCPSMS.length >0){
                                        splbhtml += "                            <td class=\"am-text-middle\"><a href='"+spda.F_NYCPSMS+"' target='_blank'><img src='"+spda.F_NYCPSMS+"' height='20px;'/></td>\n";
                                    }else{
                                        splbhtml += "                            <td class=\"am-text-middle\"></td>\n";
                                    }
                                    splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_NYCPZMWJBH+"</td>\n";
                                }
                                splbhtml+="                        </tr>";
                            }else{
                                splbhtml+="<tr>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">";
                                splbhtml+="<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>";
                                splbhtml+="&nbsp;&nbsp;";
                                if(spda.F_XJBZ == 1){
                                    splbhtml+="<a href=\"#\" class=\"redlink\" onclick=\"stopstart('"+spda.F_SPTM+"',0)\">上架</a></td>\n";
                                }else{
                                    splbhtml+="<a href=\"#\" class=\"redlink\" onclick=\"stopstart('"+spda.F_SPTM+"',1)\">下架</a></td>\n";
                                }
                                splbhtml+="                            <td class=\"am-text-middle\" aria-describedby=\"grid-table_oneImageUrl\"><img onclick=\"uploadFilesSptp('"+spda.F_SPTM+"')\" style=\"height: 25px;\" src=\""+spda.F_SPTP+"\"  alt=\""+spda.F_SPMC+"\"/></td>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_SPTM+"</td>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_YPZJH+"</td>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_SPLBMC+"</td>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_SPMC+"</td>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">"+(spda.F_GGXH+"/"+spda.F_JLDW)+"</td>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_XSDJ+"</td>\n";
                                splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_ZHJJ+"</td>\n";
                                /*if(spda.F_BJKC != ''){
                                    splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_BJKC+"</td>\n";
                                    $(".sfbj").show();
                                }else{
                                    $(".sfbj").hidden();
                                }*/
                                /*splbhtml+="                            <td class=\"am-text-middle\"><input class='bjkcinput' onchange='changeBjkc(this)' value='"+spda.F_BJKC+"'><input type='hidden' value='"+spda.F_SPTM+"'></td>\n";*/
                                splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_GYSMC+"</td>\n";
                                    //"                            <td class=\"am-text-middle\">"+spda.F_CSMC+"</td>\n";
                                if('<%=ypd%>' == '0'){
                                    if(spda.F_NYCPDJZ.length >0){
                                        splbhtml += "                            <td class=\"am-text-middle\"><a href='"+spda.F_NYCPDJZ+"' target='_blank'><img src='"+spda.F_NYCPDJZ+"' height='20px;'/></td>\n";
                                    }else{
                                        splbhtml += "                            <td class=\"am-text-middle\"></td>\n";
                                    }
                                    if(spda.F_NYCPBZ.length >0){
                                        splbhtml += "                            <td class=\"am-text-middle\"><a href='"+spda.F_NYCPBZ+"' target='_blank'><img src='"+spda.F_NYCPBZ+"' height='20px;'/></td>\n";
                                    }else{
                                        splbhtml += "                            <td class=\"am-text-middle\"></td>\n";
                                    }
                                    if(spda.F_NYCPBQ.length >0){
                                        splbhtml += "                            <td class=\"am-text-middle\"><a href='"+spda.F_NYCPBQ+"' target='_blank'><img src='"+spda.F_NYCPBQ+"' height='20px;'/></td>\n";
                                    }else{
                                        splbhtml += "                            <td class=\"am-text-middle\"></td>\n";
                                    }
                                    if(spda.F_NYCPSMS.length >0){
                                        splbhtml += "                            <td class=\"am-text-middle\"><a href='"+spda.F_NYCPSMS+"' target='_blank'><img src='"+spda.F_NYCPSMS+"' height='20px;'/></td>\n";
                                    }else{
                                        splbhtml += "                            <td class=\"am-text-middle\"></td>\n";
                                    }
                                    splbhtml+="                            <td class=\"am-text-middle\">"+spda.F_NYCPZMWJBH+"</td>\n";
                                }
                                splbhtml+="                        </tr>";
                            }
                        }
                        $('#sptable').html(splbhtml);
                        /*$('#sptable tr').click(function () {
                            var rowNum=$(this).index();
                            var $table=$(this).parent();
                            var khmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                            $('#khxx').val(khmc);
                            $('#chooseKhdiv').modal('close');
                        });*/
                        pagebar(pageIndex,pageSize,res.total,"pagebar");
                    }else{
                        $('#sptable').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alertMsg(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        };

        function pagebar(pageIndex,pageSize,totalCount,parbarid){
            pageIndex=parseInt(pageIndex);
            pageSize=parseInt(pageSize);
            totalCount=parseInt(totalCount);
            pageSize = pageSize == 0 ? 50 : pageSize;
            var pageCount = parseInt((totalCount + pageSize - 1) / pageSize); //总页数
            var template="<div id='totalCount' class='am-cf'>共{0}条记录<div class='am-fr'>";
            var output=template.format(totalCount);
            if(pageCount>1){
                output+="<ul class='am-pagination am-pagination-centered'>";
                if (pageIndex <= 1)
                {//处理上一页的连接
                    output+=(" <li class='am-disabled'><a href='javascript:void(0);'>&laquo;</a></li>");
                }
                else {
                    template=("<li><a href='javascript:void(0);'onclick=\"loadTable({0})\">&laquo;</a></li>");
                    output+=template.format(pageIndex - 1);
                }
                var start = pageIndex - 5;
                start = start < 1 ? 1 : start;
                var end = start + 9;
                end = end > pageCount ? pageCount : end;
                if(end==pageCount){
                    start = end - 9;
                    start = start < 1 ? 1 : start;
                }
                for (var i = start; i <= end; i++)
                {
                    if (i == pageIndex)
                    {
                        template="<li  class='am-active'><a href='javascript:void(0);'>{0}</a></li>";
                        output+=template.format(i);
                    }
                    else
                    {
                        template="<li><a href='javascript:void(0);'onclick=\"loadTable({0})\">{1}</a></li>", i,i;
                        output+=template.format(i,i);
                    }
                }
                if(end<pageCount){
                    output+="<li><span>...</span></li>";
                    template="<li><a href='javascript:void(0);'onclick=\"loadTable({0})\">{1}</a></li>";
                    output+=template.format(pageCount,pageCount);
                }
                if (pageIndex < pageCount)
                {//处理下一页的链接
                    template="<li><a href='javascript:void(0);'onclick=\"loadTable({0})\">&raquo;</a></li>";
                    output+=template.format(pageIndex + 1);
                }
                else {
                    output+="<li><a class='am-disabled' href='javascript:void(0);'>&raquo;</a></li>";
                }
            }
            output+="</div></div>";
            $('#'+parbarid).html(output);
        }
        String.prototype.format = function(args)
        {
            if (arguments.length > 0)
            {
                var result = this;
                if (arguments.length == 1 && typeof (args) == "object")
                {
                    for (var key in args)
                    {
                        var reg = new RegExp("({" + key + "})", "g");
                        result = result.replace(reg, args[key]);
                    }
                }
                else
                {
                    for (var i = 0; i < arguments.length; i++)
                    {
                        if (arguments[i] == undefined)
                        {
                            return "";
                        }
                        else
                        {
                            var reg = new RegExp("({[" + i + "]})", "g");
                            result = result.replace(reg, arguments[i]);
                        }
                    }
                }
                return result;
            }
            else
            {
                return this;
            }
        }

        function closeNewSpdiv(){
            $('#newSpdiv').modal('close');
        }
        function closeUpdateSpdiv(){
            $('#updateSpdiv').modal('close');
        }
        //计算总合计金额
        function resum_hjje() {
            var $table=$('#sptable');
            var hjje=0;
            $table.find('tr').each(function () {
               var spdj=  $(this).find('td:eq(2)').children("input:first-child").val();
               var xssl=$(this).find('td:eq(3)').children("input:first-child").val();
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
        
        function UpdatePage(index) {
            loadGhs();
            loadSyfw();
            var syfwHtml = "";
            syfwHtml += "<option selected value=''></option>";
            for (var i = 0; i < syfwJson.length;i++){
                var syfwda = syfwJson[i];
                syfwHtml += "<option value='"+syfwda.F_FLBM+"'>"+syfwda.F_FLMC+"</option>";
            }
            $("#xgf_syfw").html(syfwHtml);
            var spda=loadJson[index];
            var splbbm = spda.F_SPLBBM;
            /*if(spda.F_JB != 0){
                loadspfl(splbbm.substring(0,splbbm.length-4),spda.F_JB);
            }*/
            $("#xgf_sptm").val(spda.F_SPTM);
            $("#xgf_spewm").val();
            $("#xgf_djzh").val(spda.F_YPZJH);
            $("#xgf_spmc").val(spda.F_SPMC);
            $('#xgf_spfl').val(spda.F_SPLBBM);
            $('#xgf_spflmc').val(spda.F_SPLBMC);
            $("#xgf_bzgg").val(spda.F_GGXH);
            $("#xgf_scqy").val(spda.F_SCQY);
            $("#xgf_ppmc").val(spda.F_PPMC);
            $("#xgf_yxcf").val(spda.F_YXCF);
            $("#xgf_yxq").val(spda.F_YXQ);
            $("#xgf_zhl").val(spda.F_ZHL);
            $("#xgf_jx").val(spda.F_JX);
            $("#xgf_mbzzl").val(spda.F_MBZZL);
            $("#xgf_mbzzldw").val(spda.F_MBZZLDW);
            $("#xgprimaryUnit").val(spda.F_JLDW);
            $('#xgprimaryUnit').trigger('changed.selected.amui');
            $("#xgf_xsj").val(spda.F_XSDJ);
            //$("#xgf_scqy").val(spda.F_CSBM);
            //$('#xgf_scqy').trigger('changed.selected.amui');
            $("#xgf_jhj").val(spda.F_ZHJJ);
            $("#xgf_jxsl").val(spda.F_SL);
            $("#xgf_xxsl").val(spda.F_XXSL);
            $("#xgf_scxkz").val(spda.F_SCXKZH);
            var ghs = spda.F_GYSMC.split(",");
            $("#xgf_ghs").val(ghs);
            $('#xgf_ghs').trigger('changed.selected.amui');

            $("input[name='xgf_sfcz']").each(function() {
                if ($(this).val() == parseInt(spda.F_SFCZ)) {
                    $(this).prop("checked", true);
                }
            });

            var xgf_splbbm = $("#xgf_spfl").val().substring(0,2);
            loadDx();
            var dxHtml = "";
            dxHtml += "<option selected value=''></option>";
            for (var i = 0; i < dxJson.length;i++){
                if (dxJson[i].F_DXBM == spda.F_DXBM){
                    dxHtml += "<option value='"+dxJson[i].F_DXBM+"' selected>"+dxJson[i].F_DXMC+"</option>";
                }else {
                    dxHtml += "<option value='"+dxJson[i].F_DXBM+"'>"+dxJson[i].F_DXMC+"</option>";
                }
            }
            $("#xgf_dx").html(dxHtml);

            loadSyfw();
            var syfwHtml = "";
            syfwHtml += "<option value=''></option>";
            for (var i = 0; i < syfwJson.length;i++){
                var syfwda = syfwJson[i];
                if (syfwda.F_FLBM == spda.F_FLBM){
                    syfwHtml += "<option value='"+syfwda.F_FLBM+"' selected>"+syfwda.F_FLMC+"</option>";
                }else {
                    syfwHtml += "<option value='"+syfwda.F_FLBM+"'>"+syfwda.F_FLMC+"</option>";
                }
            }
            $("#xgf_syfw").html(syfwHtml);
            var syfw = spda.F_SYFW.split(",");
            $("#xgf_syfw").val(syfw);
            $('#xgf_syfw').trigger('changed.selected.amui');

            //商户类型为农资店或农药厂商，同时商品类别名称是农药分类
            if (xgf_splbbm == "01" && ("<%=ypd%>" == '0' || "<%=ypd%>" == '1')){
                $(".xgshflzs").show();
                $(".xgspflzs").show();
                $(".xgqbflzs").show();
            }else if (xgf_splbbm == "01" && ("<%=ypd%>" != '0' && "<%=ypd%>" != '1')){
                //商户类型非农资店和农药厂商，但商品类别名称是农药分类
                $(".xgshflzs").hide();
                $(".xgspflzs").show();
                $(".xgqbflzs").show();
            }else if (xgf_splbbm != "01" && ("<%=ypd%>" == '0' || "<%=ypd%>" == '1')){
                //商户类型为农资店和农药厂商，但商品类别名称非农药分类
                $(".xgshflzs").show();
                $(".xgspflzs").hide();
                $(".xgqbflzs").show();
            }else{
                //商户类型非农资店和农药厂商，且商品类别名称非农药分类
                $(".xgshflzs").hide();
                $(".xgspflzs").hide();
                $(".xgqbflzs").hide();
            }

            //农药厂商、农资店、常熟、江阴、太仓类型时，显示防治对象和禁限类型
            if("<%=ypd%>" == '0' || "<%=ypd%>" == '1' || "<%=ypd%>" == '12' || "<%=ypd%>" == '13' || "<%=ypd%>" == '14' ){
                $(".xggdzwxs").show();
                $("input[name='xgf_nybz']").each(function() {
                    if ($(this).val() == parseInt(spda.F_NYBZ)) {
                        $(this).prop("checked", true);
                    }
                });
                $("#xgf_fzdx").val(spda.F_FZDX);
            }else {
                $(".xggdzwxs").hide();
            }


            $("input[name='xgf_splx']").each(function() {
                if ($(this).val() == parseInt(spda.F_SPLX)) {
                    $(this).prop("checked", true);
                }
            });

            $("#xgf_nycpzmwjbh").val(spda.F_NYCPZMWJBH);

            //$("#xgf_bz").val();
            $('#updateSpdiv').modal({
                closeViaDimmer: false,
                width:880,
                height:550
            });
            $('#updateSpdiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#updateSpdiv').css("z-index","1119");
        }
        
        function deletePage(sptm) {
            $.ajax({
                url: "/commodity/removeSpda",
                type: "post",
                async: false,
                data: { sptm: sptm, timeer: new Date() },
                success: function (data, textStatus) {
                    loadSpxx(1,10,"");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alertMsg(errorThrown + "||" + textStatus);
                    $subbtn.button('reset');
                }
            });
        }

        function stopstart(sptm,xjbz) {
            $.ajax({
                url: "/commodity/stopstart",
                type: "post",
                async: false,
                data: { sptm: sptm,xjbz:xjbz, timeer: new Date() },
                success: function (data, textStatus) {
                    loadSpxx(1,10,"");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alertMsg(errorThrown + "||" + textStatus);
                    $subbtn.button('reset');
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

        //保存报警库存
        function saveBjkc(sptm,bjkc){
            if(bjkc == null){
                bjkc = $("#bjkc").val();
            }
            $.ajax({
                url: "/commodity/saveBjkc",
                type: "post",
                async: false,
                data: {sptm:sptm,bjkc:bjkc,timeer: new Date() },
                success: function (data) {
                    return data;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alertMsg(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        }

        function closeQyxzdiv(){
            $('#SPFLdiv').modal('close');
        }

        //加载客户
        function loadScqy(){
            $.ajax({
                url: "/initialvalues/GetKhda",
                type: "post",
                async: false,
                data: {khxx:"",cslx:2, timeer: new Date() },
                success: function (data) {
                    var $selected = $('#f_scqy');
                    var $selected2 = $('#xgf_scqy');
                    $selected.html("");
                    $selected.append('<option value=""></option>');
                    $selected2.html("");
                    $selected2.append('<option value=""></option>');
                    var res = JSON.parse(data);
                    var dataJson = JSON.parse(res.list);
                    scqyJson = dataJson;
                    if(dataJson.length>0) {
                        for(var i=0;i<dataJson.length;i++){
                            var scqymx=dataJson[i];
                            $selected.append('<option value="'+scqymx.F_CSBM+'">'+scqymx.F_CSMC+'</option>');
                            $selected2.append('<option value="'+scqymx.F_CSBM+'">'+scqymx.F_CSMC+'</option>');
                        }
                        $selected.trigger('changed.selected.amui');
                        $selected2.trigger('changed.selected.amui');
                    }else{
                        $('#f_scqy').html("");
                        $('#xgf_scqy').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alertMsg(errorThrown + "||" + textStatus);
                }
            });
        };

        //加载客户
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

        function alertMsg(msg){
            $('#alertcontent ',parent.document).text(msg);
            $('#alertdlg',parent.document).modal('open');
        }

        $('#f_nycpdjzFile').on('change', function () {
            var files = $('#f_nycpdjzFile')[0].files;
            var name = files[0].name.substring(files[0].name.lastIndexOf(".")+1);
            if (name !== "png" && name !== "jpg" && name !== 'png') {
                alertMsg("上传图片格式不正确，请重新上传");
                return;
            }
            var result = "";
            for(var i =0 ; i<files.length ; i++){
                var file  = files[i];
                result += file.name+",";
            }
            result = result.substring(0,result.length-1);
            $('#f_nycpdjz').val(result);

            //var fwqResult = uploadFiles($('#f_jyxkzFile'));
        });

        $('#f_nycpbzFile').on('change', function () {
            var files = $('#f_nycpbzFile')[0].files;
            var name = files[0].name.substring(files[0].name.lastIndexOf(".")+1);
            if (name !== "png" && name !== "jpg" && name !== 'png') {
                alertMsg("上传图片格式不正确，请重新上传");
                return;
            }
            var result = "";
            for(var i =0 ; i<files.length ; i++){
                var file  = files[i];
                result += file.name+",";
            }
            result = result.substring(0,result.length-1);
            $('#f_nycpbz').val(result);
        });

        $('#f_nycpbqFile').on('change', function () {
            var files = $('#f_nycpbqFile')[0].files;
            var name = files[0].name.substring(files[0].name.lastIndexOf(".")+1);
            if (name !== "png" && name !== "jpg" && name !== 'png') {
                alertMsg("上传图片格式不正确，请重新上传");
                return;
            }
            var result = "";
            for(var i =0 ; i<files.length ; i++){
                var file  = files[i];
                result += file.name+",";
            }
            result = result.substring(0,result.length-1);
            $('#f_nycpbq').val(result);
        });

        $('#f_nycpsmsFile').on('change', function () {
            var files = $('#f_nycpsmsFile')[0].files;
            var name = files[0].name.substring(files[0].name.lastIndexOf(".")+1);
            if (name !== "png" && name !== "jpg" && name !== 'png') {
                alertMsg("上传图片格式不正确，请重新上传");
                return;
            }
            var result = "";
            for(var i =0 ; i<files.length ; i++){
                var file  = files[i];
                result += file.name+",";
            }
            result = result.substring(0,result.length-1);
            $('#f_nycpsms').val(result);

            //var fwqResult = uploadFiles($('#f_jyxkzFile'));
        });

        $('#xgf_nycpdjzFile').on('change', function () {
            var files = $('#xgf_nycpdjzFile')[0].files;
            var name = files[0].name.substring(files[0].name.lastIndexOf(".")+1);
            if (name !== "png" && name !== "jpg" && name !== 'png') {
                alertMsg("上传图片格式不正确，请重新上传");
                return;
            }
            var result = "";
            for(var i =0 ; i<files.length ; i++){
                var file  = files[i];
                result += file.name+",";
            }
            result = result.substring(0,result.length-1);
            $('#xgf_nycpdjz').val(result);

            //var fwqResult = uploadFiles($('#f_jyxkzFile'));
        });

        $('#xgf_nycpbzFile').on('change', function () {
            var files = $('#xgf_nycpbzFile')[0].files;
            var name = files[0].name.substring(files[0].name.lastIndexOf(".")+1);
            if (name !== "png" && name !== "jpg" && name !== 'png') {
                alertMsg("上传图片格式不正确，请重新上传");
                return;
            }
            var result = "";
            for(var i =0 ; i<files.length ; i++){
                var file  = files[i];
                result += file.name+",";
            }
            result = result.substring(0,result.length-1);
            $('#xgf_nycpbz').val(result);
        });

        $('#xgf_nycpbqFile').on('change', function () {
            var files = $('#xgf_nycpbqFile')[0].files;
            var name = files[0].name.substring(files[0].name.lastIndexOf(".")+1);
            if (name !== "png" && name !== "jpg" && name !== 'png') {
                alertMsg("上传图片格式不正确，请重新上传");
                return;
            }
            var result = "";
            for(var i =0 ; i<files.length ; i++){
                var file  = files[i];
                result += file.name+",";
            }
            result = result.substring(0,result.length-1);
            $('#xgf_nycpbq').val(result);
        });

        $('#xgf_nycpsmsFile').on('change', function () {
            var files = $('#xgf_nycpsmsFile')[0].files;
            var name = files[0].name.substring(files[0].name.lastIndexOf(".")+1);
            if (name !== "png" && name !== "jpg" && name !== 'png') {
                alertMsg("上传图片格式不正确，请重新上传");
                return;
            }
            var result = "";
            for(var i =0 ; i<files.length ; i++){
                var file  = files[i];
                result += file.name+",";
            }
            result = result.substring(0,result.length-1);
            $('#xgf_nycpsms').val(result);

            //var fwqResult = uploadFiles($('#f_jyxkzFile'));
        });


        function uploadFiles(idName){
            var url = idName.val();
            var files = idName[0].files;
            var result = "";
            for(var i =0 ; i<files.length ; i++){
                var file  = files[i];
                var formData = new FormData();
                formData.append("files", file);
                $.ajax({
                    url: "/file/uploadFiles",
                    type: "post",
                    async: false,
                    cache: false,
                    data: formData,
                    processData: false,
                    contentType: false,
                    mimeType:"multipart/form-data",
                    success: function (data, textStatus) {
                        result += data+",";
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert(errorThrown + "||" + textStatus);
                        $subbtn.button('reset');
                    }
                });
            }
            return result.substring(0,result.length-1);
        }

        function uploadFilesSptp(sptm){
            sptmtp = sptm;
            $("#finalImg").prop("src","");
            $(".tailoring-container").toggle();
        }


        $(function(){
            //弹出图片裁剪框
            $("#replaceImg").on("click",function () {
                $(".tailoring-container").toggle();
            });
            //cropper图片裁剪
            $('#tailoringImg').cropper({
                aspectRatio: 1/1,//默认比例
                preview: '.previewImg',//预览视图
                guides: false,  //裁剪框的虚线(九宫格)
                autoCropArea: 0.5,  //0-1之间的数值，定义自动剪裁区域的大小，默认0.8
                movable: false, //是否允许移动图片
                dragCrop: true,  //是否允许移除当前的剪裁框，并通过拖动来新建一个剪裁框区域
                movable: true,  //是否允许移动剪裁框
                resizable: true,  //是否允许改变裁剪框的大小
                zoomable: false,  //是否允许缩放图片大小
                mouseWheelZoom: false,  //是否允许通过鼠标滚轮来缩放图片
                touchDragZoom: true,  //是否允许通过触摸移动来缩放图片
                rotatable: true,  //是否允许旋转图片
                crop: function(e) {
                    // 输出结果数据裁剪图像。
                }
            });
            //旋转
            $(".cropper-rotate-btn").on("click",function () {
                $('#tailoringImg').cropper("rotate", 45);
            });
            //复位
            $(".cropper-reset-btn").on("click",function () {
                $('#tailoringImg').cropper("reset");
            });
            //换向
            var flagX = true;
            $(".cropper-scaleX-btn").on("click",function () {
                if(flagX){
                    $('#tailoringImg').cropper("scaleX", -1);
                    flagX = false;
                }else{
                    $('#tailoringImg').cropper("scaleX", 1);
                    flagX = true;
                }
                flagX != flagX;
            });

            //裁剪后的处理
            $("#sureCut").on("click",function () {
                if ($("#tailoringImg").attr("src") == null ){
                    return false;
                }else{
                    var cas = $('#tailoringImg').cropper('getCroppedCanvas');//获取被裁剪后的canvas
                    var base64url = cas.toDataURL('image/png'); //转换为base64地址形式
                    $("#finalImg").prop("src",base64url);//显示为图片的形式

                    $.ajax({
                        url: "/file/uploadBase64",
                        type: "post",
                        async: false,
                        data: {sptm:sptmtp,file64:base64url},
                        success: function (data) {
                            if(data != ''){
                                alertMsg("上传成功");
                                sptmtp = null;
                                loadSpxx(1,10,"");
                            }
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alertMsg(errorThrown + "||" + textStatus);
                        }
                    });
                    //关闭裁剪框
                    closeTailor();
                }
            });
        });

        //图像上传
        function selectImg(file) {
            if (!file.files || !file.files[0]){
                return;
            }
            var reader = new FileReader();
            reader.onload = function (evt) {
                var replaceSrc = evt.target.result;
                //更换cropper的图片
                $('#tailoringImg').cropper('replace', replaceSrc,false);//默认false，适应高度，不失真
            }
            reader.readAsDataURL(file.files[0]);
        }

        //关闭裁剪框
        function closeTailor() {
            $(".tailoring-container").toggle();
        }

        //单个保存报警库存
        function changeBjkc(e){
            var bjkc = $(e).val();
            var sptm = $(e).next().val();
            saveBjkc(sptm,bjkc);
        };

        //加载毒性
        function loadDx() {
            $.ajax({
                url: "/commodity/loadDx",
                type: "post",
                async: false,
                data: {},
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    dxJson = dataJson;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alertMsg(errorThrown + "||" + textStatus);
                }
            });
        }

        //加载适用范围
        function loadSyfw() {
            $.ajax({
                url: "/commodity/loadSyfw",
                type: "post",
                async: false,
                data: {},
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    syfwJson = dataJson;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alertMsg(errorThrown + "||" + textStatus);
                }
            });
        }


    </script>
</body>
</html>
