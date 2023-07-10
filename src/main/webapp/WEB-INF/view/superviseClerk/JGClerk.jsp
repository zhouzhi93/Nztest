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
    <title>云平台管理平台-监管人员管理</title>
    <meta name="description" content="云平台管理平台-监管人员管理">
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
        #zytable input{
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
                    <h1>监管人员管理</h1>
                </div>
            </div>
        </div>
        <!--选择客户div-->
        <div class="am-container am-" id="chooseZydiv">
            <div>
                <div>
                    <div class="am-container">
                        <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                            <input class="am-radius am-form-field am-input-sm" id="spoption" style="width: 160px;display:initial;" type="text" placeholder="输入职员名称、字母">
                            <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchZy()">搜索</button>
                        </div>
                        <div class="am-u-sm-6 am-u-md-6 am-text-right">
                            <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadZyxx('')" style="border: 1px solid #0E90D2;background: white;color: #0E90D2;">刷新</button>
                            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" id="addzy">新增</button>
                        </div>
                    </div>
                    <div style="margin-top: 10px;" class="am-container am-scrollable-horizontal" id="hovertables">
                        <table class="am-table am-table-bordered am-table-centered am-text-nowrap" >
                            <thead>
                                <tr>
                                    <th class="am-text-middle">操作</th>
                                    <th class="am-text-middle">人员类型</th>
                                    <th class="am-text-middle">人员名称</th>
                                    <th class="am-text-middle">电话</th>
                                    <th class="am-text-middle">单位</th>
                                    <th class="am-text-middle">分管区域</th>
                                </tr>
                            </thead>
                            <tbody id="zytable">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--新建职员div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="newZydiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">新增职员
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="addzyform">
                        <div class="am-form-group">
                            <label class="am-u-sm-2 am-form-label">人员类型</label>
                            <div class="am-u-sm-9 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="0" checked name="f_zylx"> 管理员
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="f_zylx"> 普通人员
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_zymc" class="am-u-sm-2 am-form-label">人员名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_zymc" required placeholder="人员名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_zykl" class="am-u-sm-2 am-form-label">登录密码</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_zykl" required placeholder="登录密码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_dh" class="am-u-sm-2 am-form-label">电话</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_dh" required placeholder="电话">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_dw" class="am-u-sm-2 am-form-label">单位</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_dw" required placeholder="单位">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_zydz" class="am-u-sm-2 am-form-label">所在地区</label>
                            <div class="am-u-sm-9">
                                <input readonly type="hidden" class="am-form-field am-input-sm am-radius" id="f_zydz" required placeholder="">
                                <input readonly type="text" class="am-form-field am-input-sm am-radius" id="f_zydzmc" required placeholder="">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="submit" id="addzybtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeNewZydiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--修改客户div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="updateZydiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">修改职员
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="updatezyform">
                        <div class="am-form-group">
                            <label class="am-u-sm-2 am-form-label">人员类型</label>
                            <div class="am-u-sm-9 am-text-left">
                                <label class="am-radio-inline">
                                    <input type="radio"  value="0" checked name="xgf_zylx"> 管理员
                                </label>
                                <label class="am-radio-inline">
                                    <input type="radio" value="1" name="xgf_zylx"> 普通人员
                                </label>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_zymc" class="am-u-sm-2 am-form-label">人员名称</label>
                            <div class="am-u-sm-9">
                                <input type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_zybm" required placeholder="人员编码">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_zymc" required placeholder="人员名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_zykl" class="am-u-sm-2 am-form-label">登录密码</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_zykl" placeholder="登录密码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_dh" class="am-u-sm-2 am-form-label">电话</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_dh" required placeholder="电话">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_dw" class="am-u-sm-2 am-form-label">单位</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_dw" required placeholder="单位">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_zydz" class="am-u-sm-2 am-form-label">所在地区</label>
                            <div class="am-u-sm-9">
                                <input readonly type="hidden" class="am-form-field am-input-sm am-radius" id="xgf_zydz" required placeholder="">
                                <input readonly type="text" class="am-form-field am-input-sm am-radius" id="xgf_zydzmc" required placeholder="">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="submit" id="updatezybtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeUpdateZydiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--区域选择div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="QYXZdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">区域选择
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
                            <div class="am-tree-loader" role="alert">Loading...</div>
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
                    <button type="submit" id="addQyxz" class="am-btn am-btn-danger am-btn-xs">确认</button>&nbsp;&nbsp;
                    <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeQyxzdiv()">取消</button>
                </div>
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
    <script type="text/javascript">
        var loadJson = null;
        var splbJson = null;
        var xzqybm = null;
        var xzqymc = null;
        $(function() {
            loadZyxx("");
            loadQymx();
            //显示新增客户
            $('#addzy').click(function () {

                $("#f_zymc").val("");
                $("#f_dh").val("");
                $("#f_zykl").val("");
                $("#f_dlh").val("");
                $("#f_dw").val("");
                $("#f_zydz").val("");

                $('#newZydiv').modal({
                    closeViaDimmer: false,
                    width: 580,
                    height: 500
                });
                $('#newZydiv').modal('open');
                $('.am-dimmer').css("z-index", "1111");
                $('#newZydiv').css("z-index", "1119");
            });
            //关闭还原遮罩蒙板z-index
            $('#newZydiv').on('closed.modal.amui', function () {
                $('.am-dimmer').css("z-index", "1100");
            });
            //增加职员提交
            $('#addzyform').validator({
                H5validation: false,
                submit: function () {
                    var formValidity = this.isFormValid();
                    if (formValidity) {
                        try {
                            var $subbtn = $("#addzybtn");
                            $subbtn.button('loading');
                            var zymc = $("#f_zymc").val();
                            var dh = $("#f_dh").val();
                            var zykl = $("#f_zykl").val();
                            var dlh = $("#f_dlh").val();
                            var dwmc = $("#f_dw").val();
                            var fgqy = $("#f_zydz").val();
                            var zylx = $("input[name='f_zylx']:checked").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/JGClerk/addClerk",
                                    type: "post",
                                    async: false,
                                    data: {zylx:zylx, zymc: zymc, dh: dh, zykl: zykl,
                                        dlh:dlh,dwmc:dwmc,fgqy:fgqy,timeer: new Date()},
                                    success: function (data, textStatus) {
                                        if (data == "ok") {
                                            alertMsg("保存成功！");
                                        }
                                        $subbtn.button('reset');
                                        $('#newZydiv').modal('close');
                                        loadZyxx("");
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

            //关闭还原遮罩蒙板z-index
            $('#updateZydiv').on('closed.modal.amui', function () {
                $('.am-dimmer').css("z-index", "1100");
            });
            //修改商品提交
            $('#updatezyform').validator({
                H5validation: false,
                submit: function () {
                    var formValidity = this.isFormValid();
                    if (formValidity) {
                        try {
                            var $subbtn = $("#updatezybtn");
                            $subbtn.button('loading');
                            var zylx = $("input[name='xgf_zylx']:checked").val();
                            var zybm = $("#xgf_zybm").val();
                            var zymc = $("#xgf_zymc").val();
                            var dh = $("#xgf_dh").val();
                            var zykl = $("#xgf_zykl").val();
                            var dlh = $("#xgf_dlh").val();
                            var dwmc = $("#xgf_dw").val();
                            var fgqy = $("#xgf_zydz").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/JGClerk/updateClerk",
                                    type: "post",
                                    async: false,
                                    data: {zylx:zylx,zybm: zybm, zymc: zymc, dh: dh, zykl: zykl,
                                            dlh:dlh,dwmc:dwmc,fgqy:fgqy,timeer: new Date()},
                                    success: function (data, textStatus) {
                                        if (data == "ok") {
                                            alertMsg("修改成功！");
                                        }
                                        $subbtn.button('reset');
                                        $('#updateZydiv').modal('close');
                                        loadZyxx("");
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


            $('#hovertables').hover(function () {
                $('#hovertables').css("overflow", "auto")
            }, function () {
                $('#hovertables').css("overflow", "hidden")
            });

            //显示选择权限
            $('#f_zydzmc').click(function () {
                $('#QYXZdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:500
                });
                $('#QYXZdiv').modal('open');
                $('#QYXZdiv').css("z-index","1219");
            });

            //显示选择权限
            $('#xgf_zydzmc').click(function () {
                $('#QYXZdiv').modal({
                    closeViaDimmer: false,
                    width:680,
                    height:500
                });
                $('#QYXZdiv').modal('open');
                $('#QYXZdiv').css("z-index","1219");
            });

            $('#firstTree').on('selected.tree.amui', function (event, data) {
                var qybm = data.target.id;
                var qymc = data.target.title;
                xzqybm = qybm;
                xzqymc = qymc;
            });

            $('#addQyxz').click(function () {
                $('#QYXZdiv').modal('close');

                $("#f_zydz").val(xzqybm);
                $("#f_zydzmc").val(xzqymc);
                $("#xgf_zydz").val(xzqybm);
                $("#xgf_zydzmc").val(xzqymc);
            });

        });

        function loadQymx(){
            $.ajax({
                url: "/JGClerk/getQymx",
                type: "post",
                async: false,
                data: {timeer: new Date() },
                success: function (data) {
                    splbJson = data;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
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

        function searchZy() {
            var zyxx=$('#spoption').val();
            loadZyxx(zyxx);
        };
        //加载人员
        function loadZyxx(zyxx){
            $.ajax({
                url: "/JGClerk/getClerk",
                type: "post",
                async: false,
                data: {zybm:zyxx, timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    loadJson = dataJson;
                    if(dataJson.length>0) {
                        var zymxhtml="";
                        for(var i=0;i<dataJson.length;i++){
                            var zyda=dataJson[i];
                            var zylx = "";
                            if(zyda.F_ZYLX == '0'){
                                zylx = "管理员";
                            }else if(zyda.F_ZYMC == '1'){
                                zylx = "普通人员";
                            }
                            if(zymxhtml==""){
                                zymxhtml="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>" +
                                    " &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+zyda.F_ZYBM+"')\">删除</a>" +
                                    "                            <td class=\"am-text-middle\">"+zylx+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_ZYMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_DH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_DWMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_QYMC+"</td>\n" +
                                    "                        </tr>"
                            }else{
                                zymxhtml+="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>" +
                                    " &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+zyda.F_ZYBM+"')\">删除</a>" +
                                    "                            <td class=\"am-text-middle\">"+zylx+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_ZYMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_DH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_DWMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+zyda.F_QYMC+"</td>\n" +
                                    "                        </tr>"
                            }
                        }
                        $('#zytable').html(zymxhtml);
                    }else{
                        $('#zytable').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alertMsg(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        };
        function closeNewZydiv(){
            $('#newZydiv').modal('close');
        }
        function closeUpdateZydiv(){
            $('#updateZydiv').modal('close');
        }

        function closeQyxzdiv(){
            $('#QYXZdiv').modal('close');
        }
        
        function UpdatePage(index) {
            var zyda=loadJson[index];
            $("#xgf_zymc").val(zyda.F_ZYMC);
            $("#xgf_zybm").val(zyda.F_ZYBM);
            //$("#xgf_zykl").val(zyda.F_ZYKL);
            $("#xgf_dh").val(zyda.F_DH);

            $("#xgf_dw").val(zyda.F_DWMC);
            $("#xgf_zydz").val(zyda.F_FGQY);
            $("#xgf_zydzmc").val(zyda.F_QYMC);

            $("#firstTree").tree('selectItem', $("#"+zyda.F_FGQY+""));

            $("input[name='xgf_zylx']").each(function() {
                if ($(this).val() == zyda.F_ZYLX) {
                    $(this).prop("checked", true);
                }
            });
            
            $('#updateZydiv').modal({
                closeViaDimmer: false,
                width:580,
                height:500
            });
            $('#updateZydiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#updateZydiv').css("z-index","1119");
        }
        
        function deletePage(zybm) {
            $.ajax({
                url: "/JGClerk/removeClerk",
                type: "post",
                async: false,
                data: { zybm: zybm, timeer: new Date() },
                success: function (data, textStatus) {
                    loadZyxx("");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alertMsg(errorThrown + "||" + textStatus);
                    $subbtn.button('reset');
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
