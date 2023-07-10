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
                <div>
                    <div class="am-container">
                        <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                            <input class="am-radius am-form-field am-input-sm" id="spoption" style="width: 160px;display:initial;" type="text" placeholder="输入商品名称、字母">
                            <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchSp()">搜索</button>
                        </div>
                        <div class="am-u-sm-6 am-u-md-6 am-text-right">
                            <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadSpxx('')" style="border: 1px solid #0E90D2;background: white;color: #0E90D2;">刷新</button>
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
                                    <th class="am-text-middle">商品名称</th>
                                    <th class="am-text-middle">商品</th>
                                    <th class="am-text-middle">包装规格</th>
                                    <th class="am-text-middle">销售价</th>
                                    <th class="am-text-middle">商品类别</th>
                                    <th class="am-text-middle">生产企业</th>
                                </tr>
                            </thead>
                            <tbody id="sptable">
                            </tbody>
                        </table>
                    </div>
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
            <div class="am-modal-bd am-scrollable-vertical" style="min-height: 600px;" >
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="addkhform">
                        <div class="am-form-group">
                            <label for="f_spfl" class="am-u-sm-2 am-form-label">商品类别</label>
                            <div class="am-u-sm-10">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '70%',maxHeight: 200}" id="f_spfl" required>
                                    </select>
                                    <span style="color: #5da5fd;cursor: pointer;" onclick="loadspfl()">刷新</span>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdxs" style="display: none;">
                            <label for="f_djzh" class="am-u-sm-2 am-form-label">登记号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_djzh" placeholder="二维码扫描">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sptm" class="am-u-sm-2 am-form-label">商品条码</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_sptm" required placeholder="选填,扫码枪或手工输入商品条形码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_spmc" class="am-u-sm-2 am-form-label">商品名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_spmc" required placeholder="商品名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_bzgg" class="am-u-sm-2 am-form-label">包装规格</label>
                            <div class="am-u-sm-9 am-form-inline" style="text-align:left;">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_bzgg" required placeholder="规格" style="display:initial;width: 50%;">
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
                            <label for="f_xsj" class="am-u-sm-2 am-form-label">售价</label>
                            <div class="am-u-sm-9" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="f_xsj" required placeholder="售价" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">元/<span class="priceUnit">袋</span></span>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_jhj" class="am-u-sm-2 am-form-label">进价</label>
                            <div class="am-u-sm-9" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="f_jhj" required placeholder="进价" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">元/<span class="priceUnit">袋</span></span>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdbxs">
                            <label for="f_jxsl" class="am-u-sm-2 am-form-label">进项税率</label>
                            <div class="am-u-sm-9" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="f_jxsl" required placeholder="进项税率" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">%</span>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdbxs">
                            <label for="f_xxsl" class="am-u-sm-2 am-form-label">销项税率</label>
                            <div class="am-u-sm-9" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="f_xxsl" required placeholder="销项税率" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">%</span>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
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
                        </div>
                        <div class="am-form-group">
                            <label for="f_ghs" class="am-u-sm-2 am-form-label">供货商</label>
                            <div class="am-u-sm-9">
                                <select multiple  data-am-selected="{btnWidth: '100%',maxHeight: 200,searchBox:1}" id="f_ghs" required>
                                </select>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdbxs">
                            <label class="am-u-sm-2 am-form-label">是否称重</label>
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
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="submit" id="addspbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeNewKhdiv()">取消</button>
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
            <div class="am-modal-bd am-scrollable-vertical" style="min-height: 600px;">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="updatespform">
                        <input type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_sptm" required>
                        <div class="am-form-group">
                            <label for="xgf_spfl" class="am-u-sm-2 am-form-label">商品类别</label>
                            <div class="am-u-sm-10">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '70%',maxHeight: 200}" id="xgf_spfl" required>
                                    </select>
                                    <span style="color: #5da5fd;cursor: pointer;" onclick="loadspfl()">刷新</span>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdxs" style="display: none;">
                            <label for="xgf_djzh" class="am-u-sm-2 am-form-label">登记号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_djzh" placeholder="二维码扫描">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
<%--                        <div class="am-form-group">
                            <label for="xgf_sptm" class="am-u-sm-2 am-form-label">商品条码</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_sptm" required placeholder="选填,扫码枪或手工输入商品条形码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>--%>
                        <div class="am-form-group">
                            <label for="xgf_spmc" class="am-u-sm-2 am-form-label">商品名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_spmc" required placeholder="商品名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_bzgg" class="am-u-sm-2 am-form-label">包装规格</label>
                            <div class="am-u-sm-9 am-form-inline" style="text-align:left;">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_bzgg" required placeholder="规格" style="display:initial;width: 50%;">
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
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_xsj" class="am-u-sm-2 am-form-label">售价</label>
                            <div class="am-u-sm-9" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="xgf_xsj" required placeholder="售价" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">元/<span class="priceUnit">袋</span></span>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_jhj" class="am-u-sm-2 am-form-label">进价</label>
                            <div class="am-u-sm-9" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="xgf_jhj" required placeholder="进价" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">元/<span class="priceUnit">袋</span></span>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdbxs">
                            <label for="xgf_jxsl" class="am-u-sm-2 am-form-label">进项税率</label>
                            <div class="am-u-sm-9" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="xgf_jxsl" required placeholder="进项税率" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">%</span>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdbxs">
                            <label for="xgf_xxsl" class="am-u-sm-2 am-form-label">销项税率</label>
                            <div class="am-u-sm-9" style="text-align:left;">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="xgf_xxsl" required placeholder="销项税率" style="display:initial;width: 80%;">
                                <span style="margin-left: 4px; line-height: 34px;">%</span>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
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
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_ghs" class="am-u-sm-2 am-form-label">供货商</label>
                            <div class="am-u-sm-9">
                                <select multiple data-am-selected="{btnWidth: '100%',maxHeight: 200,searchBox: 1}" id="xgf_ghs" required>
                                </select>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group ypdbxs">
                            <label class="am-u-sm-2 am-form-label">是否称重</label>
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
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="submit" id="updatespbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeUpdateSpdiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
    <script src="/assets/js/amazeui.min.js"></script>
    <script src="/assets/js/app.js"></script>
    <script src="/assets/address/address.min.js"></script>
    <script src="/assets/address/iscroll.min.js"></script>
    <script type="text/javascript">
        var loadJson = null;
        var scqyJson = null;
        $(function(){
            loadSpxx("");
            loadspfl("","");
            loadScqy();
            loadGhs();
            //显示新增客户
            $('#addsp').click(function () {

                $("#f_spfl").val("");
                $("#f_djzh").val("");
                $("#f_sptm").val("");
                $("#f_spmc").val("");
                $("#f_bzgg").val("")
                $("#primaryUnit").val("");
                $("#f_xsj").val("");
                $("#f_jhj").val("");
                $("#f_jxsl").val("");
                $("#f_xxsl").val("");
                $("#f_scqy").val("");
                $("#f_scxkz").val("");
                $("#f_ghs").val("");

                $('#f_spfl').trigger('changed.selected.amui');
                $('#f_scqy').trigger('changed.selected.amui');
                $('#f_ghs').trigger('changed.selected.amui');

                $('#newSpdiv').modal({
                    closeViaDimmer: false,
                    width:580,
                    height:650
                });
                $('#newSpdiv').modal('open');
                $('.am-dimmer').css("z-index","1111");
                $('#newSpdiv').css("z-index","1119");
            });
            //关闭还原遮罩蒙板z-index
            $('#newSpdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
            //增加客户提交
            $('#addkhform').validator({
                H5validation: false,
                submit: function () {
                    var formValidity = this.isFormValid();
                    if (formValidity) {
                        try {
                            var $subbtn = $("#addspbtn");
                            $subbtn.button('loading');
                            var sptm = $("#f_sptm").val();
                            var spewm = $("#f_spewm").val();
                            var djh = $("#f_djzh").val();
                            var spmc = $("#f_spmc").val();
                            var spfls = $("#f_spfl").val();
                            if(spfls == ''){
                                alert('商品分类不能为空！');
                                return;
                            }
                            var spfl = spfls.split(",");
                            var ggxh = $("#f_bzgg").val()
                            var jldw = $("#primaryUnit").val();
                            var xsj = $("#f_xsj").val();
                            var jhj = $("#f_jhj").val();
                            var jxsl = $("#f_jxsl").val();
                            var xxsl = $("#f_xxsl").val();
                            var scqy = $("#f_scqy").val();
                            var scxkz = $("#f_scxkz").val();
                            var ghs = $("#f_ghs").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/commodity/saveSpda",
                                    type: "post",
                                    async: false,
                                    data: { sptm: sptm, djh: djh,spmc:spmc, spfl: spfl[0], ggxh: ggxh,jldw:jldw,
                                            xsj: xsj,jhj:jhj,jxsl:jxsl,xxsl:xxsl,scxkz:scxkz,ghs:ghs.toString(),scqy:scqy, timeer: new Date() },
                                    success: function (data, textStatus) {
                                        if(data == "ok"){
                                            alertMsg("保存成功！");
                                        }
                                        $subbtn.button('reset');
                                        $('#newSpdiv').modal('close');
                                        loadSpxx("");
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

            //关闭还原遮罩蒙板z-index
            $('#updateSpdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
            //修改商品提交
            $('#updatespform').validator({
                H5validation: false,
                submit: function () {
                    var formValidity = this.isFormValid();
                    if (formValidity) {
                        try {
                            var $subbtn = $("#updatespbtn");
                            $subbtn.button('loading');
                            var sptm = $("#xgf_sptm").val();
                            var spewm = $("#xgf_spewm").val();
                            var djh = $("#xgf_djzh").val();
                            var spmc = $("#xgf_spmc").val();
                            var spfls = $("#xgf_spfl").val();
                            if(spfls == ''){
                                alert('商品分类不能为空！');
                                return;
                            }
                            var spfl = spfls.split(",");
                            var ggxh = $("#xgf_bzgg").val()
                            var jldw = $("#xgprimaryUnit").val();
                            var xsj = $("#xgf_xsj").val();
                            var jhj = $("#xgf_jhj").val();
                            var jxsl = $("#xgf_jxsl").val();
                            var xxsl = $("#xgf_xxsl").val();
                            var scqy = $("#xgf_scqy").val();
                            var scxkz = $("#xgf_scxkz").val();
                            var ghs = $("#xgf_ghs").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/commodity/updateSpda",
                                    type: "post",
                                    async: false,
                                    data: { sptm: sptm, djh: djh,spmc:spmc, spfl: spfl[0], ggxh: ggxh,jldw:jldw,
                                        xsj: xsj,jhj:jhj,jxsl:jxsl,xxsl:xxsl,scxkz:scxkz,ghs:ghs.toString(),scqy:scqy, timeer: new Date() },
                                    success: function (data, textStatus) {
                                        if(data == "ok"){
                                            alertMsg("修改成功！");
                                        }
                                        $subbtn.button('reset');
                                        $('#updateSpdiv').modal('close');
                                        loadSpxx("");
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

            //修改销售价单位
            $('#primaryUnit').change(function () {
                $('.priceUnit').html($('#primaryUnit').val());
            });


            $('#hovertables').hover(function(){
                $('#hovertables').css("overflow","auto")
            },function(){
                $('#hovertables').css("overflow","hidden")
            });

            $('#f_spfl').change(function () {
                var splbmx = $('#f_spfl').val();
                if(splbmx != '' && splbmx != null){
                    var splbmxs = splbmx.split(",");
                    var jb = parseInt(splbmxs[1])+1;
                    if(splbmxs[2] == '0'){
                        loadspfl(splbmxs[0],jb);
                        $('#f_spfl').click();
                    }else if(splbmxs[2] == '1'){
                        if("<%=ypd%>" == '1'){
                            setsptm(splbmxs[0]);
                        }
                    }
                }
            });

            $('#xgf_spfl').change(function () {
                var splbmx = $('#xgf_spfl').val();
                if(splbmx != '' && splbmx != null){
                    var splbmxs = splbmx.split(",");
                    var jb = parseInt(splbmxs[1])+1;
                    if(splbmxs[2] == '0'){
                        loadspfl(splbmxs[0],jb);
                        $('#xgf_spfl').click();
                    }else if(splbmxs[2] == '1'){
                        if("<%=ypd%>" == '1'){
                            setsptm(splbmxs[0]);
                        }

                    }
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

            if("<%=ypd%>" == '1'){
                $('.ypdxs').show();
                $('.ypdbxs').hide();
            }

/*            $(".am-selected-list").mouseleave(function(){
                alert($("#f_ghs").val());
            });*/

        });



        function searchSp() {
            var spxx=$('#spoption').val();
            loadSpxx(spxx);
        };
        //加载商品
        function loadSpxx(spxx){
            $.ajax({
                url: "/commodity/getSpda",
                type: "post",
                async: false,
                data: {f_spxx:spxx, timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    loadJson = dataJson;
                    if(dataJson.length>0) {
                        var splbhtml="";
                        for(var i=0;i<dataJson.length;i++){
                            var spda=dataJson[i];
                            if(splbhtml==""){
                                splbhtml="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>" +
                                    " &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+spda.F_SPTM+"')\">删除</a></td>" +
                                    /*" &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"updateCustomState(1,0)\">停用</a></td>\n" +*/
                                    "                            <td class=\"am-text-middle\" aria-describedby=\"grid-table_oneImageUrl\"><img style=\"height: 25px;\" src=\"/images/default.png\"  alt=\""+spda.F_SPMC+"\"/></td>\n" +
                                    "                            <td class=\"am-text-middle\">"+spda.F_SPTM+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+spda.F_SPMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+spda.F_SPMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+(spda.F_GGXH+"/"+spda.F_JLDW)+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+spda.F_XSDJ+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+spda.F_SPLBMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+spda.F_CSMC+"</td>\n" +
                                    "                        </tr>"
                            }else{
                                splbhtml+="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>" +
                                    " &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+spda.F_SPTM+"')\">删除</a></td>" +
                                    /*" &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"updateCustomState(1,0)\">停用</a></td>\n" +*/
                                    "                            <td class=\"am-text-middle\" aria-describedby=\"grid-table_oneImageUrl\"><img style=\"height: 25px;\" src=\"/images/default.png\"  alt=\""+spda.F_SPMC+"\"/></td>\n" +
                                    "                            <td class=\"am-text-middle\">"+spda.F_SPTM+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+spda.F_SPMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+spda.F_SPMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+(spda.F_GGXH+"/"+spda.F_JLDW)+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+spda.F_XSDJ+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+spda.F_SPLBMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+spda.F_CSMC+"</td>\n" +
                                    "                        </tr>"
                            }
                        }
                        $('#sptable').html(splbhtml);
                        $('#sptable tr').click(function () {
                            var rowNum=$(this).index();
                            var $table=$(this).parent();
                            var khmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                            $('#khxx').val(khmc);
                            $('#chooseKhdiv').modal('close');
                        });
                    }else{
                        $('#sptable').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        };
        function closeNewKhdiv(){
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
            var spda=loadJson[index];
            var splbbm = spda.F_SPLBBM;
            if(spda.F_JB != 0){
                loadspfl(splbbm.substring(0,splbbm.length-4),spda.F_JB);
            }
            $("#xgf_sptm").val(spda.F_SPTM);
            $("#xgf_spewm").val();
            $("#xgf_djzh").val(spda.F_YPZJH);
            $("#xgf_spmc").val(spda.F_SPMC);
            splbbm = spda.F_SPLBBM+","+spda.F_JB+","+spda.F_MJ;
            $('#xgf_spfl').val(splbbm);
            $('#xgf_spfl').trigger('changed.selected.amui');
            $("#xgf_bzgg").val(spda.F_GGXH);
            $("#xgprimaryUnit").val(spda.F_JLDW);
            $('#xgprimaryUnit').trigger('changed.selected.amui');
            $("#xgf_xsj").val(spda.F_XSDJ);
            $("#xgf_scqy").val(spda.F_CSBM);
            $('#xgf_scqy').trigger('changed.selected.amui');
            $("#xgf_jhj").val(spda.F_ZHJJ);
            $("#xgf_jxsl").val(spda.F_SL);
            $("#xgf_xxsl").val(spda.F_XXSL);
            $("#xgf_scxkz").val(spda.F_SCXKZH);
            var ghs = spda.F_GYSBM.split(",");
            $("#xgf_ghs").val(ghs);
            $('#xgf_ghs').trigger('changed.selected.amui');
            //$("#xgf_bz").val();
            $('#updateSpdiv').modal({
                closeViaDimmer: false,
                width:580,
                height:650
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
                    loadSpxx("");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $subbtn.button('reset');
                }
            });
        }

        function loadspfl(splbbm,jb){
            $.ajax({
                url: "/commodity/getSplbmx",
                type: "post",
                async: false,
                data: {splbbm:splbbm,jb:jb, timeer: new Date() },
                success: function (data) {
                    var $selected = $('#f_spfl');
                    var $selected2 = $('#xgf_spfl');
                    $selected.html("");
                    $selected.append('<option value=""></option>');
                    $selected2.html("");
                    $selected2.append('<option value=""></option>');
                    var dataJson = JSON.parse(data);
                    if(dataJson.length == 0){
                        alertMsg("暂无商品类别,请先创建商品类别！");
                    }
                    if(dataJson.length>0) {
                        var splbhtml="";
                        for(var i=0;i<dataJson.length;i++){
                            var splbmx=dataJson[i];
                            /*$('#f_spfl').append('<option value='"+splbmx.F_SPLBBM+"'>"+splbmx.F_SPLBMC+"" +
                                "<input type='hidden' value='"+splbmx.F_MJ+"'/></option>');*/
                            var splbxx = splbmx.F_SPLBBM+","+splbmx.F_JB+","+splbmx.F_MJ;
                            $selected.append('<option value="'+splbxx+'">'+splbmx.F_SPLBMC+'</option>');
                            $selected2.append('<option value="'+splbxx+'">'+splbmx.F_SPLBMC+'</option>');
                        }
                        $selected.trigger('changed.selected.amui');
                        $selected2.trigger('changed.selected.amui');
                    }else{
                        $('#xgf_spfl').html("");
                        $('#f_spfl').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
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
                    var dataJson = JSON.parse(data);
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
                    alert(errorThrown + "||" + textStatus);
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
                    var dataJson = JSON.parse(data);
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
                    alert(errorThrown + "||" + textStatus);
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
                        $('#f_sptm').val(splbbm+''+data);
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
