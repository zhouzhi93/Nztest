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
    <title>云平台客户端V1-门店管理</title>
    <meta name="description" content="云平台客户端V1-门店管理">
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
        #mdtable input{
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
                    <h1>门店管理</h1>
                </div>
            </div>
        </div>
        <!--选择角色div-->
        <div class="am-container am-" id="chooseMddiv">
            <div>
                <div>
                    <div class="am-container">
                        <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                            <input class="am-radius am-form-field am-input-sm" id="mdoption" style="width: 160px;display:initial;" type="text" placeholder="输入门店名称、字母">
                            <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchMd()">搜索</button>
                        </div>
                        <div class="am-u-sm-6 am-u-md-6 am-text-right">
                            <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadMdxx('')" style="border: 1px solid #0E90D2;background: white;color: #0E90D2;">刷新</button>
                            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" id="addmd">新增</button>
                        </div>
                    </div>
                    <div style="margin-top: 10px;" class="am-container am-scrollable-horizontal" id="hovertables">
                        <table class="am-table am-table-bordered am-table-centered am-text-nowrap" >
                            <thead>
                            <tr>
                                <th class="am-text-middle">操作</th>
                                <th class="am-text-middle">门店名称</th>
                                <th class="am-text-middle">地址</th>
                                <th class="am-text-middle">电话</th>
                                <th class="am-text-middle">开户行</th>
                                <th class="am-text-middle nzdxs">经营许可证号</th>
                                <th class="am-text-middle nzdxs">发证日期</th>
                                <th class="am-text-middle nzdxs">有效日期</th>
                                <th class="am-text-middle nzdxs">许可证号图片</th>
                                <th class="am-text-middle nzdxs">产品合法证明</th>
                                <th class="am-text-middle nzdxs">境外机构设立</th>
                                <th class="am-text-middle nzdxs">销售机构说明</th>
                                <th class="am-text-middle nycsxs">生产许可证编号</th>
                                <th class="am-text-middle nycsxs">生产许可证发证日期</th>
                                <th class="am-text-middle nycsxs">生产许可证失效日期</th>
                                <th class="am-text-middle nycsxs">生产许可证</th>
                                <th class="am-text-middle nycsxs">产品执行标准</th>
                                <th class="am-text-middle nycsxs">安全生产标准化等级</th>
                                <th class="am-text-middle nycsxs">环保等级评定</th>
                            </tr>
                            </thead>
                            <tbody id="mdtable">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--新建门店div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="newMddiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">新增门店
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd am-scrollable-vertical" style="min-height: 500px;">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="addmdform">
                        <div class="am-form-group">
                            <label for="f_bmmc" class="am-u-sm-2 am-form-label">门店名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_bmmc" required placeholder="门店名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_dz" class="am-u-sm-2 am-form-label">地址</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_dz" placeholder="地址">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_dh" class="am-u-sm-2 am-form-label">电话</label>
                            <div class="am-u-sm-9">
                                <input type="tel" class="am-form-field am-input-sm am-radius" id="f_dh" placeholder="电话">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_khh" class="am-u-sm-2 am-form-label">开户行</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_khh" placeholder="开户行">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_zh" class="am-u-sm-2 am-form-label">账号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_zh" placeholder="账号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sh" class="am-u-sm-2 am-form-label">税号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_sh" placeholder="税号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_fr" class="am-u-sm-2 am-form-label">负责人</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_fr" placeholder="负责人">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_jwd" class="am-u-sm-2 am-form-label">经纬度</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_jwd" placeholder="经纬度">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="f_jyxkzbh" class="am-u-sm-2 am-form-label">许可证号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_jyxkzbh" placeholder="经营许可证编号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="f_jyxkzfzrq" class="am-u-sm-2 am-form-label">发证日期</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_jyxkzfzrq" data-am-datepicker readonly placeholder="经营许可证发证日期">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="f_jyxkzsxrq" class="am-u-sm-2 am-form-label">失效日期</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_jyxkzsxrq" data-am-datepicker readonly placeholder="经营许可证失效日期">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="f_jyxkz" class="am-u-sm-2 am-form-label">许可证</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_jyxkz" placeholder="经营许可证" readonly>
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="f_jyxkzfwqdz" placeholder="经营许可证服务器地址" readonly>
                            </div>
                            <!--file上传文件-->
                            <div class="am-form-group am-form-file am-u-sm-2" style="padding: 0px;margin: 0px;">
                                <div style="text-align: left;">
                                    <button type="button" class="am-btn am-btn-default am-btn-sm">
                                        <i class="am-icon-cloud-upload"></i>浏览</button>
                                </div>
                                <input id="f_jyxkzFile" type="file">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label class="am-u-sm-2 am-form-label">合法证明</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius upload-file-img" id="f_cphfzm" placeholder="产品合法证明" readonly>
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="f_cphfzmfwqdz" placeholder="产品合法证明服务器地址" readonly>
                            </div>
                            <!--file上传文件-->
                            <div class="am-form-group am-form-file am-u-sm-2" style="padding: 0px;margin: 0px;">
                                <div style="text-align: left;">
                                    <button type="button" class="am-btn am-btn-default am-btn-sm">
                                        <i class="am-icon-cloud-upload"></i>浏览</button>
                                </div>
                                <input id="f_cphfzmFile" type="file" multiple>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="f_slxsjgsm" class="am-u-sm-2 am-form-label">销售机构</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_slxsjgsm" placeholder="设立销售机构（其他委托代理机构）说明">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="f_xxqy" class="am-u-sm-2 am-form-label">详细区域</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_xxqy" placeholder="详细区域">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_dkqppbm" class="am-u-sm-2 am-form-label">读卡器品牌</label>
                            <div class="am-u-sm-10">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '100%',maxHeight: 200,searchBox:1}" id="f_dkqppbm">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="f_yjdz" class="am-u-sm-2 am-form-label">读卡器序列号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_yjdz" placeholder="读卡器序列号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="f_yjzh" class="am-u-sm-2 am-form-label">摄像头序列号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_yjzh" placeholder="摄像头序列号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label class="am-u-sm-2 am-form-label">销售控制</label>
                            <div class="am-u-sm-9 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio" value="" checked  name="f_yjmm"> 停用
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio"  value="1" name="f_yjmm"> 启用
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_jhgsbm" class="am-u-sm-2 am-form-label">交互公司</label>
                            <div class="am-u-sm-10">
                                <select data-am-selected="{btnWidth: '100%',maxHeight: 200,searchBox:1}" id="f_jhgsbm">
                                </select>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label class="am-u-sm-2 am-form-label">境外机构</label>
                            <div class="am-u-sm-9 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="0" checked name="f_sfjwjg"> 否
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="f_sfjwjg"> 是
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="f_scxkzbh" class="am-u-sm-2 am-form-label">许可证号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_scxkzbh" placeholder="生产许可证编号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="f_scxkzfzrq" class="am-u-sm-2 am-form-label">发证日期</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_scxkzfzrq" data-am-datepicker readonly placeholder="生产许可证发证日期">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="f_scxkzsxrq" class="am-u-sm-2 am-form-label">失效日期</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_scxkzsxrq" data-am-datepicker readonly placeholder="生产许可证失效日期">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="f_scxkz" class="am-u-sm-2 am-form-label">许可证</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_scxkz" placeholder="生产许可证" readonly>
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="f_scxkzfwqdz" placeholder="生产许可证服务器地址" readonly>
                            </div>
                            <!--file上传文件-->
                            <div class="am-form-group am-form-file am-u-sm-2" style="padding: 0px;margin: 0px;">
                                <div style="text-align: left;">
                                    <button type="button" class="am-btn am-btn-default am-btn-sm">
                                        <i class="am-icon-cloud-upload"></i>浏览</button>
                                </div>
                                <input id="f_scxkzFile" type="file">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="f_sczxbz" class="am-u-sm-2 am-form-label">执行标准</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_sczxbz" placeholder="产品执行标准">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="f_scaqbz" class="am-u-sm-2 am-form-label">生产标准</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_scaqbz" placeholder="安全生产标准化等级">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="f_schbbz" class="am-u-sm-2 am-form-label">环保等级</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_schbbz" placeholder="环保等级评定">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label class="am-u-sm-2 am-form-label">状态</label>
                            <div class="am-u-sm-9 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="1" checked name="f_Tybz"> 启用
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="0" name="f_Tybz"> 停用
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="submit" id="addMdbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeNewMddiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--修改部门div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="updateMddiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">修改门店
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd am-scrollable-vertical" style="min-height: 500px;">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="updateMdform">
                        <div class="am-form-group">
                            <label for="xgf_bmmc" class="am-u-sm-2 am-form-label">门店名称</label>
                            <div class="am-u-sm-9">
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_bmbm" required placeholder="门店编码">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_bmmc" required placeholder="门店名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_dz" class="am-u-sm-2 am-form-label">地址</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_dz" placeholder="地址">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_dh" class="am-u-sm-2 am-form-label">电话</label>
                            <div class="am-u-sm-9">
                                <input type="tel" class="am-form-field am-input-sm am-radius" id="xgf_dh" placeholder="电话">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_khh" class="am-u-sm-2 am-form-label">开户行</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_khh" placeholder="开户行">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_zh" class="am-u-sm-2 am-form-label">账号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_zh" placeholder="账号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_sh" class="am-u-sm-2 am-form-label">税号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_sh" placeholder="税号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_fr" class="am-u-sm-2 am-form-label">负责人</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_fr" placeholder="负责人">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div style="margin-bottom: 5px;" class="am-form-group">
                            <label for="xgf_jwd" class="am-u-sm-2 am-form-label">经纬度</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_jwd" placeholder="经纬度">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="xgf_jyxkzbh" class="am-u-sm-2 am-form-label">许可证号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_jyxkzbh" placeholder="经营许可证编号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="xgf_jyxkzfzrq" class="am-u-sm-2 am-form-label">发证日期</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_jyxkzfzrq" data-am-datepicker readonly placeholder="经营许可证发证日期">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="xgf_jyxkzsxrq" class="am-u-sm-2 am-form-label">失效日期</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_jyxkzsxrq" data-am-datepicker readonly placeholder="经营许可证失效日期">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="xgf_jyxkz" class="am-u-sm-2 am-form-label">许可证</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_jyxkz" placeholder="经营许可证" readonly>
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_jyxkzfwqdz" placeholder="经营许可证服务器地址" readonly>
                            </div>
                            <!--file上传文件-->
                            <div class="am-form-group am-form-file am-u-sm-2" style="padding: 0px;margin: 0px;">
                                <div style="text-align: left;">
                                    <button type="button" class="am-btn am-btn-default am-btn-sm">
                                        <i class="am-icon-cloud-upload"></i>浏览</button>
                                </div>
                                <input id="xgf_jyxkzFile" type="file">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="xgf_cphfzm" class="am-u-sm-2 am-form-label">合法证明</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius upload-file-img" id="xgf_cphfzm" placeholder="产品合法证明" readonly>
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_cphfzmfwqdz" placeholder="产品合法证明服务器地址" readonly>
                            </div>
                            <!--file上传文件-->
                            <div class="am-form-group am-form-file am-u-sm-2" style="padding: 0px;margin: 0px;">
                                <div style="text-align: left;">
                                    <button type="button" class="am-btn am-btn-default am-btn-sm">
                                        <i class="am-icon-cloud-upload"></i>浏览</button>
                                </div>
                                <input id="xgf_cphfzmFile" type="file" multiple>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="xgf_slxsjgsm" class="am-u-sm-2 am-form-label">销售机构</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_slxsjgsm" placeholder="设立销售机构（其他委托代理机构）说明">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="xgf_xxqy" class="am-u-sm-2 am-form-label">详细区域</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_xxqy" placeholder="详细区域">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_dkqppbm" class="am-u-sm-2 am-form-label">读卡器品牌</label>
                            <div class="am-u-sm-10">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '100%',maxHeight: 200,searchBox:1}" id="xgf_dkqppbm">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="xgf_yjdz" class="am-u-sm-2 am-form-label">读卡器序列号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_yjdz" placeholder="读卡器序列号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label for="xgf_yjzh" class="am-u-sm-2 am-form-label">摄像头序列号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_yjzh" placeholder="摄像头序列号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label class="am-u-sm-2 am-form-label">销售控制</label>
                            <div class="am-u-sm-9 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio" value="" checked  name="xgf_yjmm"> 停用
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio"  value="1" name="xgf_yjmm"> 启用
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_jhgsbm" class="am-u-sm-2 am-form-label">交互公司</label>
                            <div class="am-u-sm-10">
                                <div class="am-u-sm-12" style="padding: 0px;text-align:left;">
                                    <select data-am-selected="{btnWidth: '100%',maxHeight: 200,searchBox:1}" id="xgf_jhgsbm">
                                    </select>
                                </div>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nzdxs">
                            <label class="am-u-sm-2 am-form-label">境外机构</label>
                            <div class="am-u-sm-9 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="0" checked name="xgf_sfjwjg"> 否
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="xgf_sfjwjg"> 是
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="xgf_scxkzbh" class="am-u-sm-2 am-form-label">许可证号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_scxkzbh" placeholder="生产许可证编号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="xgf_scxkzfzrq" class="am-u-sm-2 am-form-label">发证日期</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_scxkzfzrq" data-am-datepicker readonly placeholder="生产许可证发证日期">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="xgf_scxkzsxrq" class="am-u-sm-2 am-form-label">失效日期</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_scxkzsxrq" data-am-datepicker readonly placeholder="生产许可证失效日期">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="xgf_scxkz" class="am-u-sm-2 am-form-label">许可证</label>
                            <div class="am-u-sm-7">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_scxkz" placeholder="生产许可证" readonly>
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_scxkzfwqdz" placeholder="生产许可证服务器地址" readonly>
                            </div>
                            <!--file上传文件-->
                            <div class="am-form-group am-form-file am-u-sm-2" style="padding: 0px;margin: 0px;">
                                <div style="text-align: left;">
                                    <button type="button" class="am-btn am-btn-default am-btn-sm">
                                        <i class="am-icon-cloud-upload"></i>浏览</button>
                                </div>
                                <input id="xgf_scxkzFile" type="file">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="xgf_sczxbz" class="am-u-sm-2 am-form-label">执行标准</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_sczxbz" placeholder="产品执行标准">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="xgf_scaqbz" class="am-u-sm-2 am-form-label">生产标准</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_scaqbz" placeholder="安全生产标准化等级">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group nycsxs">
                            <label for="xgf_schbbz" class="am-u-sm-2 am-form-label">环保等级</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_schbbz" placeholder="环保等级评定">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div style="margin-bottom: 5px;" class="am-form-group">
                            <label class="am-u-sm-2 am-form-label">状态</label>
                            <div class="am-u-sm-9 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="1" name="xgf_Tybz"> 启用
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="0" name="xgf_Tybz"> 停用
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="submit" id="updateMdbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeUpdateMddiv()">取消</button>
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

        function searchMd() {
            var bmxx=$('#mdoption').val();
            loadMdxx(bmxx);
        };
        //加载门店
        function loadMdxx(bmxx){
            $.ajax({
                url: "/stor/getStor",
                type: "post",
                async: false,
                data: {bmxx:bmxx, timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    loadJson = dataJson;
                    if(dataJson.length>0) {
                        var bmmxhtml="";
                        for(var i=0;i<dataJson.length;i++){
                            var bmda=dataJson[i];
                            if(bmmxhtml==""){
                                var bmmxhtml="<tr>\n";
                                bmmxhtml+="                            <td class=\"am-text-middle\">";
                                bmmxhtml+="<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>";
                                bmmxhtml+=" &nbsp;&nbsp;&nbsp; ";
                                bmmxhtml+="<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+bmda.F_BMBM+"')\">删除</a>";
                                bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_BMMC+"</td>\n";
                                bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_DZ+"</td>\n";
                                bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_DH+"</td>\n";
                                bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_KHH+"</td>\n";
                                if("<%=ypd%>" == '1'){
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_JYXKZH+"</td>\n";
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_FZRQ+"</td>\n";
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_ZJYXRQ+"</td>\n";
                                    if(bmda.F_JYXK.length >0){
                                        bmmxhtml += "                            <td class=\"am-text-middle\"><a href='"+bmda.F_JYXK+"' target='_blank'><img src='"+bmda.F_JYXK+"' height='20px;'/></td>\n";
                                    }else{
                                        bmmxhtml += "                            <td class=\"am-text-middle\"></td>\n";
                                    }
                                    if(bmda.F_CPHFZM.length >0){
                                        var cphfzms = bmda.F_CPHFZM.split(',');
                                        bmmxhtml += "                            <td class=\"am-text-middle\">";
                                        for(var j = 0 ; j<cphfzms.length ; j++){
                                            bmmxhtml += "<a href='"+cphfzms[j]+"' target='_blank'><img src='"+cphfzms[j]+"' height='20px;'/>";
                                        }
                                        bmmxhtml += "</td>\n";
                                    }else{
                                        bmmxhtml += "                            <td class=\"am-text-middle\"></td>\n";
                                    }
                                    var sfjwjg = '';
                                    if(bmda.F_SFJWJG == 0){
                                        sfjwjg = '否';
                                    }else{
                                        sfjwjg = '是';
                                    }
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+sfjwjg+"</td>\n";
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_SLXSJGSM+"</td>\n";
                                }else if('<%=ypd%>' == '0'){
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_SCXKZBH+"</td>\n";
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_SCXKZFZRQ+"</td>\n";
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_SCXKZSXRQ+"</td>\n";
                                    if(bmda.F_SCXKZ.length >0){
                                        bmmxhtml += "                            <td class=\"am-text-middle\"><a href='"+bmda.F_SCXKZ+"' target='_blank'><img src='"+bmda.F_SCXKZ+"' height='20px;'/></td>\n";
                                    }else{
                                        bmmxhtml += "                            <td class=\"am-text-middle\"></td>\n";
                                    }
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_SCZXBZ+"</td>\n";
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_SCAQBZ+"</td>\n";
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_SCHBBZ+"</td>\n";
                                }
                                bmmxhtml +="                        </tr>";
                            }else{
                                bmmxhtml+="<tr>\n";
                                bmmxhtml+="                            <td class=\"am-text-middle\">";
                                bmmxhtml+="<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>";
                                bmmxhtml+=" &nbsp;&nbsp;&nbsp; ";
                                bmmxhtml+="<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+bmda.F_BMBM+"')\">删除</a>";
                                bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_BMMC+"</td>\n";
                                bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_DZ+"</td>\n";
                                bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_DH+"</td>\n";
                                bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_KHH+"</td>\n";
                                if("<%=ypd%>" == '1'){
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_JYXKZH+"</td>\n";
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_FZRQ+"</td>\n";
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_ZJYXRQ+"</td>\n";
                                    if(bmda.F_JYXK.length >0){
                                        bmmxhtml += "                            <td class=\"am-text-middle\"><a href='"+bmda.F_JYXK+"' target='_blank'><img src='"+bmda.F_JYXK+"' height='20px;'/></td>\n";
                                    }else{
                                        bmmxhtml += "                            <td class=\"am-text-middle\"></td>\n";
                                    }
                                    if(bmda.F_CPHFZM.length >0){
                                        var cphfzms = bmda.F_CPHFZM.split(',');
                                        bmmxhtml += "                            <td class=\"am-text-middle\">";
                                        for(var j = 0 ; j<cphfzms.length ; j++){
                                            bmmxhtml += "<a href='"+cphfzms[j]+"' target='_blank'><img src='"+cphfzms[j]+"' height='20px;'/>";
                                        }
                                        bmmxhtml += "</td>\n";
                                    }else{
                                        bmmxhtml += "                            <td class=\"am-text-middle\"></td>\n";
                                    }
                                    var sfjwjg = '';
                                    if(bmda.F_SFJWJG == 0){
                                        sfjwjg = '否';
                                    }else{
                                        sfjwjg = '是';
                                    }
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+sfjwjg+"</td>\n";
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_SLXSJGSM+"</td>\n";
                                }else if('<%=ypd%>' == '0'){
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_SCXKZBH+"</td>\n";
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_SCXKZFZRQ+"</td>\n";
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_SCXKZSXRQ+"</td>\n";
                                    if(bmda.F_SCXKZ.length >0){
                                        bmmxhtml += "                            <td class=\"am-text-middle\"><a href='"+bmda.F_SCXKZ+"' target='_blank'><img src='"+bmda.F_SCXKZ+"' height='20px;'/></td>\n";
                                    }else{
                                        bmmxhtml += "                            <td class=\"am-text-middle\"></td>\n";
                                    }
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_SCZXBZ+"</td>\n";
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_SCAQBZ+"</td>\n";
                                    bmmxhtml+="                            <td class=\"am-text-middle\">"+bmda.F_SCHBBZ+"</td>\n";
                                }
                                bmmxhtml +="                        </tr>";
                            }
                        }
                        $('#mdtable').html(bmmxhtml);
                    }else{
                        $('#mdtable').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        };
        function closeNewMddiv(){
            $('#newMddiv').modal('close');
        }
        function closeUpdateMddiv(){
            $('#updateMddiv').modal('close');
        }
        
        function UpdatePage(index) {
            var bmda=loadJson[index];

            $("#xgf_bmbm").val(bmda.F_BMBM);
            $("#xgf_bmmc").val(bmda.F_BMMC);
            $("#xgf_dz").val(bmda.F_DZ);
            $("#xgf_dh").val(bmda.F_DH);
            $("#xgf_khh").val(bmda.F_KHH);
            $("#xgf_zh").val(bmda.F_ZH);
            $("#xgf_sh").val(bmda.F_SH);
            $("#xgf_fr").val(bmda.F_FR);
            $("#xgf_jwd").val(bmda.F_JWD);
            $("#xgf_xxqy").val(bmda.F_XXQY);
            $("#xgf_dkqppbm").val(bmda.F_DKQPPBM);
            $("#xgf_yjdz").val(bmda.F_YJDZ);
            $("#xgf_yjzh").val(bmda.F_YJZH);
            $("input[name='xgf_yjmm']").each(function() {
                if ($(this).val() == bmda.F_YJMM) {
                    $(this).prop("checked", true);
                }
            });
            $("#xgf_jhgsbm").val(bmda.F_JHGSBM);
            $('#xgf_dkqppbm').trigger('changed.selected.amui');
            $('#xgf_jhgsbm').trigger('changed.selected.amui');
            $("input[name='xgf_Tybz']").each(function() {
                if ($(this).val() == bmda.F_TYBZ) {
                    $(this).prop("checked", true);
                }
            });
            $("#xgf_jyxkzbh").val(bmda.F_JYXKZH);
            if(bmda.F_FZRQ != null && bmda.F_FZRQ != ""){
                var jyfzrq = bmda.F_FZRQ.substring(0,4)+"-"+bmda.F_FZRQ.substring(4,6)+"-"+bmda.F_FZRQ.substring(6,8);
                $("#xgf_jyxkzfzrq").datepicker('setValue', jyfzrq);
            }else{
                $("#xgf_jyxkzfzrq").val("");
            }

            if(bmda.F_ZJYXRQ != null && bmda.F_ZJYXRQ != ""){
                var jysxrq = bmda.F_ZJYXRQ.substring(0,4)+"-"+bmda.F_ZJYXRQ.substring(4,6)+"-"+bmda.F_ZJYXRQ.substring(6,8);
                $("#xgf_jyxkzsxrq").datepicker('setValue', jysxrq);
            }else{
                $("#xgf_jyxkzsxrq").val("");
            }

            if(bmda.F_SCXKZFZRQ != null && bmda.F_SCXKZFZRQ != ""){
                var scfzrq = bmda.F_SCXKZFZRQ.substring(0,4)+"-"+bmda.F_SCXKZFZRQ.substring(4,6)+"-"+bmda.F_SCXKZFZRQ.substring(6,8);
                $("#xgf_scxkzfzrq").datepicker('setValue', scfzrq);
            }else{
                $("#xgf_scxkzfzrq").val("");
            }

            if(bmda.F_SCXKZSXRQ != null && bmda.F_SCXKZSXRQ != ""){
                var scsxrq = bmda.F_SCXKZSXRQ.substring(0,4)+"-"+bmda.F_SCXKZSXRQ.substring(4,6)+"-"+bmda.F_SCXKZSXRQ.substring(6,8);
                $("#xgf_scxkzsxrq").datepicker('setValue', scsxrq);
            }else{
                $("#xgf_scxkzsxrq").val("");
            }

            /*var result = uploadFiles($("#xgf_jyxkzFile"));
            scxkztp = result;*/
            $("input[name='xgf_sfjwjg']").each(function() {
                if ($(this).val() == bmda.F_SFJWJG) {
                    $(this).prop("checked", true);
                }
            });
            //uploadFiles($("#xgf_cphfzmFile"));
            $("#xgf_slxsjgsm").val(bmda.F_SLXSJGSM);
            $("#xgf_scxkzbh").val(bmda.F_SCXKZBH);
            /*var result = uploadFiles($("#xgf_scxkzFile"));
            scxkztp = result;*/
            $("#xgf_sczxbz").val(bmda.F_SCZXBZ);
            $("#xgf_scaqbz").val(bmda.F_SCAQBZ);
            $("#xgf_schbbz").val(bmda.F_SCHBBZ);
            $('#updateMddiv').modal({
                closeViaDimmer: false,
                width:590,
                height:550
            });
            $('#updateMddiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#updateMddiv').css("z-index","1119");
        }
        
        function deletePage(bmbm) {
            $.ajax({
                url: "/stor/removeStor",
                type: "post",
                async: false,
                data: { bmbm: bmbm, timeer: new Date() },
                success: function (data, textStatus) {
                    loadMdxx("");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $subbtn.button('reset');
                }
            });
        }

        function alertMsg(msg){
            $('#alertcontent ',parent.document).text(msg);
            $('#alertdlg',parent.document).modal('open');
        }

        $('#f_jyxkzFile').on('change', function () {
            var files = $('#f_jyxkzFile')[0].files;
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
            $('#f_jyxkz').val(result);

            //var fwqResult = uploadFiles($('#f_jyxkzFile'));
        });

        $('#f_cphfzmFile').on('change', function () {
            var files = $('#f_cphfzmFile')[0].files;
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
            $('#f_cphfzm').val(result);
        });

        $('#f_scxkzFile').on('change', function () {
            var files = $('#f_scxkzFile')[0].files;
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
            $('#f_scxkz').val(result);
        });

        $('#xgf_jyxkzFile').on('change', function () {
            var files = $('#xgf_jyxkzFile')[0].files;
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
            $('#xgf_jyxkz').val(result);

            //var fwqResult = uploadFiles($('#f_jyxkzFile'));
        });

        $('#xgf_cphfzmFile').on('change', function () {
            var files = $('#xgf_cphfzmFile')[0].files;
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
            $('#xgf_cphfzm').val(result);
        });

        $('#xgf_scxkzFile').on('change', function () {
            var files = $('#xgf_scxkzFile')[0].files;
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
            $('#xgf_scxkz').val(result);
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

        function loadjhgsda(){
            $.ajax({
                url: "/stor/getjhgsda",
                type: "post",
                async: false,
                data: {bmxx:"", timeer: new Date() },
                success: function (data) {
                    var $selected = $('#f_jhgsbm');
                    var $selected2 = $('#xgf_jhgsbm');
                    $selected.html("");
                    $selected.append('<option value=""></option>');
                    $selected2.html("");
                    $selected2.append('<option value=""></option>');
                    var dataJson = JSON.parse(data);
                    if(dataJson.length>0) {
                        for(var i=0;i<dataJson.length;i++){
                            var sxbmmx=dataJson[i];
                            $selected.append('<option value="'+sxbmmx.F_JHGSBM+'">'+sxbmmx.F_JHGSMC+'</option>');
                            $selected2.append('<option value="'+sxbmmx.F_JHGSBM+'">'+sxbmmx.F_JHGSMC+'</option>');
                        }
                        $selected.trigger('changed.selected.amui');
                        $selected2.trigger('changed.selected.amui');
                    }else{
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        function loaddkqppda(){
            $.ajax({
                url: "/stor/getdkqppda",
                type: "post",
                async: false,
                data: {bmxx:"", timeer: new Date() },
                success: function (data) {
                    var $selected = $('#f_dkqppbm');
                    var $selected2 = $('#xgf_dkqppbm');
                    $selected.html("");
                    $selected.append('<option value=""></option>');
                    $selected2.html("");
                    $selected2.append('<option value=""></option>');
                    var dataJson = JSON.parse(data);
                    if(dataJson.length>0) {
                        for(var i=0;i<dataJson.length;i++){
                            var sxbmmx=dataJson[i];
                            $selected.append('<option value="'+sxbmmx.F_DKQPPBM+'">'+sxbmmx.F_DKQPPMC+'</option>');
                            $selected2.append('<option value="'+sxbmmx.F_DKQPPBM+'">'+sxbmmx.F_DKQPPMC+'</option>');
                        }
                        $selected.trigger('changed.selected.amui');
                        $selected2.trigger('changed.selected.amui');
                    }else{
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        $(function(){
            loadMdxx("");
            loadjhgsda();
            loaddkqppda();
            //显示新增门店
            $('#addmd').click(function () {
                $("#f_bmmc").val("");
                $("#f_dz").val("");
                $("#f_dh").val("");
                $("#f_khh").val("");
                $("#f_zh").val("");
                $("#f_sh").val("");
                $("#f_fr").val("");
                $("#f_jwd").val("");
                $("#f_jyxkzbh").val("");
                $("#f_jyxkzfzrq").val("");
                $("#f_jyxkzsxrq").val("");
                $("#f_cphfzm").val("");
                $("#f_slxsjgsm").val("");
                $("#f_scxkzbh").val("");
                $("#f_scxkzfzrq").val("");
                $("#f_scxkzsxrq").val("");
                $("#f_sczxbz").val("");
                $("#f_scaqbz").val("");
                $("#f_schbbz").val("");
                $("#f_xxqy").val("");
                $("#f_dkqppbm").val("");
                $("#f_yjdz").val("");
                $("#f_yjzh").val("");
                $("input[name='f_yjmm']").each(function() {
                    if ($(this).val() == "") {
                        $(this).prop("checked", true);
                    }
                });
                $("#f_jhgsbm").val("");
                $('#f_dkqppbm').trigger('changed.selected.amui');
                $('#f_jhgsbm').trigger('changed.selected.amui');
                $('#newMddiv').modal({
                    closeViaDimmer: false,
                    width:590,
                    height:550
                });
                $('#newMddiv').modal('open');
                $('.am-dimmer').css("z-index","1111");
                $('#newMddiv').css("z-index","1119");
            });
            //关闭还原遮罩蒙板z-index
            $('#newMddiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
            //增加门店提交
            $('#addmdform').validator({
                H5validation: false,
                submit: function () {
                    var formValidity = this.isFormValid();
                    if (formValidity) {
                        try {
                            var $subbtn = $("#addMdbtn");
                            $subbtn.button('loading');
                            var bmmc = $("#f_bmmc").val();
                            var dz = $("#f_dz").val();
                            var dh = $("#f_dh").val();
                            var khh = $("#f_khh").val();
                            var zh = $("#f_zh").val();
                            var sh = $("#f_sh").val();
                            var fr = $("#f_fr").val();
                            var jwd = $("#f_jwd").val();
                            var xxqy=$("#f_xxqy").val();
                            var dkqppbm = $("#f_dkqppbm").val();
                            var yjdz = $("#f_yjdz").val();
                            var yjzh = $("#f_yjzh").val();
                            var yjmm = $("input[name='f_yjmm']:checked").val();
                            var jhgsbm = $("#f_jhgsbm").val();
                            //农资店特殊字段
                            var jyxkzh = "";
                            var jyfzrq = "";
                            var jysxrq = "";
                            var jyxkztp = "";
                            var jwjg = "";
                            var hfzm = "";
                            var xsjg = "";
                            //农药厂商特殊字段
                            var scxkzh = "";
                            var scfzrq = "";
                            var scsxrq = "";
                            var scxkztp = "";
                            var zxbz = "";
                            var aqbz = "";
                            var hbdj = "";

                            if("<%=ypd%>" == '1'){
                                jyxkzh = $("#f_jyxkzbh").val();
                                jyfzrq = $("#f_jyxkzfzrq").val();
                                jysxrq = $("#f_jyxkzsxrq").val();
                                var result = uploadFiles($("#f_jyxkzFile"));
                                jyxkztp = result;
                                jwjg = $("input[name='f_sfjwjg']:checked").val();
                                hfzm = uploadFiles($("#f_cphfzmFile"));
                                xsjg = $("#f_slxsjgsm").val();
                            }
                            if("<%=ypd%>" == '0'){
                                scxkzh = $("#f_scxkzbh").val();
                                scfzrq = $("#f_scxkzfzrq").val();
                                scsxrq = $("#f_scxkzsxrq").val();
                                var result = uploadFiles($("#f_scxkzFile"));
                                scxkztp = result;
                                zxbz = $("#f_sczxbz").val();
                                aqbz = $("#f_scaqbz").val();
                                hbdj = $("#f_schbbz").val();
                            }
                            var tybz = $("input[name='f_Tybz']:checked").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/stor/addStor",
                                    type: "post",
                                    async: false,
                                    data: { bmmc: bmmc,yb:"", dz: dz,dh: dh,cz: "",email: "",khh: khh,zh: zh,sh: sh,xxqy:xxqy,
                                        fr:fr,tybz: tybz,jwd:jwd,jyxkzh:jyxkzh,jyfzrq:jyfzrq,jysxrq:jysxrq,jyxkztp:jyxkztp,jwjg:jwjg,hfzm:hfzm,xsjg:xsjg,
                                        scxkzh:scxkzh,scfzrq:scfzrq,scsxrq:scsxrq,scxkztp:scxkztp,zxbz:zxbz,aqbz:aqbz,hbdj:hbdj,
                                        dkqppbm:dkqppbm,yjdz:yjdz,yjmm:yjmm,yjzh:yjzh,jhgsbm:jhgsbm,timeer: new Date() },
                                    success: function (data, textStatus) {
                                        if(data == "ok"){
                                            alertMsg("保存成功！");
                                        }
                                        $subbtn.button('reset');
                                        $('#newMddiv').modal('close');
                                        loadMdxx("");
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
            $('#updateMddiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
            //修改门店提交
            $('#updateMdform').validator({
                H5validation: false,
                submit: function () {
                    var formValidity = this.isFormValid();
                    if (formValidity) {
                        try {
                            var $subbtn = $("#updateMdbtn");
                            $subbtn.button('loading');
                            var bmbm = $("#xgf_bmbm").val();
                            var bmmc = $("#xgf_bmmc").val();
                            var dz = $("#xgf_dz").val();
                            var dh = $("#xgf_dh").val();
                            var khh = $("#xgf_khh").val();
                            var zh = $("#xgf_zh").val();
                            var sh = $("#xgf_sh").val();
                            var fr = $("#xgf_fr").val();
                            var jwd = $("#xgf_jwd").val();
                            var xxqy= $("#xgf_xxqy").val();
                            var dkqppbm = $("#xgf_dkqppbm").val();
                            var yjdz = $("#xgf_yjdz").val();
                            var yjzh = $("#xgf_yjzh").val();
                            var yjmm = $("input[name='xgf_yjmm']:checked").val();
                            var jhgsbm = $("#xgf_jhgsbm").val();
                            //农资店特殊字段
                            var jyxkzh = "";
                            var jyfzrq = "";
                            var jysxrq = "";
                            var jyxkztp = "";
                            var jwjg = "";
                            var hfzm = "";
                            var xsjg = "";
                            //农药厂商特殊字段
                            var scxkzh = "";
                            var scfzrq = "";
                            var scsxrq = "";
                            var scxkztp = "";
                            var zxbz = "";
                            var aqbz = "";
                            var hbdj = "";

                            if("<%=ypd%>" == '1'){
                                jyxkzh = $("#xgf_jyxkzbh").val();
                                jyfzrq = $("#xgf_jyxkzfzrq").val();
                                jysxrq = $("#xgf_jyxkzsxrq").val();
                                if($("#xgf_jyxkzFile").val() != ''&& $("#xgf_jyxkzFile").val != null){
                                    var result = uploadFiles($("#xgf_jyxkzFile"));
                                    jyxkztp = result;
                                }
                                jwjg = $("input[name='xgf_sfjwjg']:checked").val();
                                if($("#xgf_cphfzmFile").val() != ''&& $("#xgf_cphfzmFile").val != null){
                                    hfzm = uploadFiles($("#xgf_cphfzmFile"));
                                }
                                xsjg = $("#xgf_slxsjgsm").val();
                            }
                            if("<%=ypd%>" == '0'){
                                scxkzh = $("#xgf_scxkzbh").val();
                                scfzrq = $("#xgf_scxkzfzrq").val();
                                scsxrq = $("#xgf_scxkzsxrq").val();
                                if($("#xgf_scxkzFile").val() != ''&& $("#xgf_scxkzFile").val != null){
                                    var result = uploadFiles($("#xgf_scxkzFile"));
                                    scxkztp = result;
                                }
                                zxbz = $("#xgf_sczxbz").val();
                                aqbz = $("#xgf_scaqbz").val();
                                hbdj = $("#xgf_schbbz").val();
                            }
                            var tybz = $("input[name='xgf_Tybz']:checked").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/stor/updateStor",
                                    type: "post",
                                    async: false,
                                    data: { bmbm:bmbm,bmmc: bmmc,yb:"", dz: dz,dh: dh,cz: "",email: "",khh: khh,zh: zh,sh: sh,xxqy:xxqy,
                                        fr:fr,tybz: tybz,jwd:jwd,jyxkzh:jyxkzh,jyfzrq:jyfzrq,jysxrq:jysxrq,jyxkztp:jyxkztp,jwjg:jwjg,hfzm:hfzm,xsjg:xsjg,
                                        scxkzh:scxkzh,scfzrq:scfzrq,scsxrq:scsxrq,scxkztp:scxkztp,zxbz:zxbz,aqbz:aqbz,hbdj:hbdj,
                                        dkqppbm:dkqppbm,yjdz:yjdz,yjmm:yjmm,yjzh:yjzh,jhgsbm:jhgsbm,timeer: new Date() },
                                    success: function (data, textStatus) {
                                        if(data == "ok"){
                                            alertMsg("修改成功！");
                                        }
                                        $subbtn.button('reset');
                                        $('#updateMddiv').modal('close');
                                        loadMdxx("");
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


            $('#hovertables').hover(function(){
                $('#hovertables').css("overflow","auto")
            },function(){
                $('#hovertables').css("overflow","hidden")
            });

            if("<%=ypd%>" == '1'){
                $('.nzdxs').show();
                $('.nycsxs').hide();
            }
            if("<%=ypd%>" == '0'){
                $('.nycsxs').show();
                $('.nzdxs').hide();
            }

        });

    </script>
</body>
</html>
