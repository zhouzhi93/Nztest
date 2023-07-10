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
    <title>云平台客户端V1-供应商管理</title>
    <meta name="description" content="云平台客户端V1-供应商管理">
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
                    <h1>供应商管理</h1>
                </div>
            </div>
        </div>
        <!--选择客户div-->
        <div class="am-container am-" id="chooseKhdiv">
            <div>
                <div>
                    <div class="am-container">
                        <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                            <input class="am-radius am-form-field am-input-sm" id="gysoption" style="width: 160px;display:initial;" type="text" placeholder="输入供应商名称、字母">
                            <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchKh()">搜索</button>
                        </div>
                        <div class="am-u-sm-6 am-u-md-6 am-text-right">
                            <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadGysxx('')" style="border: 1px solid #0E90D2;background: white;color: #0E90D2;">刷新</button>
                            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" id="addkh">新增</button>
                        </div>
                    </div>
                    <div style="margin-top: 10px;" class="am-container" id="hovertables">
                        <table class="am-table am-table-bordered am-table-centered" >
                            <thead>
                            <tr>
                                <th class="am-text-middle">操作</th>
                                <th class="am-text-middle">供应商名称</th>
                                <th class="am-text-middle">联系人</th>
                                <th class="am-text-middle">手机号码</th>
                            </tr>
                            </thead>
                            <tbody id="khtable">
                            <%--<tr>--%>
                            <%--<td class="am-text-middle">陶尚平</td>--%>
                            <%--<td class="am-text-middle">18502542669</td>--%>
                            <%--<td class="am-text-middle">0.00</td>--%>
                            <%--<td class="am-text-middle">0.00</td>--%>
                            <%--</tr>--%>
                            <%--<tr id="khtishi">--%>
                            <%--<td class="am-text-middle" colspan="4">暂无客户信息</td>--%>
                            <%--</tr>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--新建客户div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="newKhdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">新增供应商
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="addkhform">
                        <div class="am-form-group">
                            <label for="f_khmc" class="am-u-sm-2 am-form-label">供应商</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_khmc" required placeholder="供应商名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_lxr" class="am-u-sm-2 am-form-label">联系人</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_lxr" required placeholder="联系人">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sjhm" class="am-u-sm-2 am-form-label">联系电话</label>
                            <div class="am-u-sm-9">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="f_sjhm" required placeholder="联系电话">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_bz" class="am-u-sm-2 am-form-label">备注</label>
                            <div class="am-u-sm-9">
                                <textarea  class="am-form-field am-input-sm am-radius" id="f_bz" placeholder="备注"></textarea>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <%--<div class="am-form-group">
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
                                <button type="submit" id="addkhbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeNewKhdiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--修改客户div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="updateKhdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">修改供应商
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="updatekhform">
                        <div class="am-form-group">
                            <label for="xgf_khmc" class="am-u-sm-2 am-form-label">供应商</label>
                            <div class="am-u-sm-9">
                                <input type="hidden" id="xgf_khbm" />
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_khmc" required placeholder="供应商名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_lxr" class="am-u-sm-2 am-form-label">联系人</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_lxr" required placeholder="联系人">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_sjhm" class="am-u-sm-2 am-form-label">联系电话</label>
                            <div class="am-u-sm-9">
                                <input type="number" class="am-form-field am-input-sm am-radius" id="xgf_sjhm" required placeholder="联系电话">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_bz" class="am-u-sm-2 am-form-label">备注</label>
                            <div class="am-u-sm-9">
                                <textarea  class="am-form-field am-input-sm am-radius" id="xgf_bz" placeholder="备注"></textarea>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <%--<div class="am-form-group">
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
                                <button type="submit" id="updatekhbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '修改...', resetText: '修改'}" class="am-btn am-btn-danger am-btn-xs">修改</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeUpdateKhdiv()">取消</button>
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
        $(function(){
            loadGysxx("");
            //显示新增客户
            $('#addkh').click(function () {

                $("#f_khmc").val("");
                $("#f_sjhm").val("");
                $("#f_lxr").val("");
                $("#f_bz").val("");

                $('#newKhdiv').modal({
                    closeViaDimmer: false,
                    width:580,
                    height:500
                });
                $('#newKhdiv').modal('open');
                $('.am-dimmer').css("z-index","1111");
                $('#newKhdiv').css("z-index","1119");
            });
            //关闭还原遮罩蒙板z-index
            $('#newKhdiv').on('closed.modal.amui', function() {
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
                            var f_lxr = $("#f_lxr").val();
                            var f_bzxx = $("#f_bz").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/initialvalues/AddKhda",
                                    type: "post",
                                    async: false,
                                    data: { f_khmc: f_khmc, f_sjhm: f_sjhm,f_lxr:f_lxr, f_qydz: "", f_xxdz: "", f_bzxx: f_bzxx,cslx:0, timeer: new Date() },
                                    success: function (data, textStatus) {
                                        if(data == "ok"){
                                            alertMsg("保存成功！");
                                        }
                                        $subbtn.button('reset');
                                        $('#newKhdiv').modal('close');
                                        loadGysxx("");
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
            $('#updateKhdiv').on('closed.modal.amui', function() {
                $('.am-dimmer').css("z-index","1100");
            });
            //增加客户提交
            $('#updatekhform').validator({
                H5validation: false,
                submit: function () {
                    var formValidity = this.isFormValid();
                    if (formValidity) {
                        try {
                            var $subbtn = $("#updatekhbtn");
                            $subbtn.button('loading');
                            var f_khmc = $("#xgf_khmc").val();
                            var f_sjhm = $("#xgf_sjhm").val();
                            var f_lxr  = $("#xgf_lxr").val();
                            var f_bzxx = $("#xgf_bz").val();
                            var f_khbm = $("#xgf_khbm").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/initialvalues/updateKhmx",
                                    type: "post",
                                    async: false,
                                    data: { f_khmc: f_khmc, f_sjhm: f_sjhm,f_lxr:f_lxr, f_qydz: "", f_xxdz: "", f_bzxx: f_bzxx,
                                            f_khbm:f_khbm,cslx:0, timeer: new Date() },
                                    success: function (data, textStatus) {
                                        if(data == "ok"){
                                            alertMsg("修改成功！");
                                        }
                                        $subbtn.button('reset');
                                        $('#updateKhdiv').modal('close');
                                        loadGysxx("");
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

        });
        function searchKh() {
            var khxx=$('#gysoption').val();
            loadGysxx(khxx);
        };
        //加载客户
        function loadGysxx(khxx){
            $.ajax({
                url: "/initialvalues/GetKhda",
                type: "post",
                async: false,
                data: {khxx:khxx,cslx:0, timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    loadJson = dataJson;
                    if(dataJson.length>0) {
                        var khdahtml="";
                        for(var i=0;i<dataJson.length;i++){
                            var khda=dataJson[i];
                            if(khdahtml==""){
                                khdahtml="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a></td>" +
                                    /*" &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"updateCustomState(1,0)\">停用</a></td>\n" +*/
                                    "                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_LXR+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n" +
                                    "                        </tr>"
                            }else{
                                khdahtml+="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a></td>" +
                                    /*" &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"updateCustomState(1,0)\">停用</a></td>\n" +*/
                                    "                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_LXR+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n" +
                                    "                        </tr>"
                            }
                        }
                        $('#khtable').html(khdahtml);
                        $('#khtable tr').click(function () {
                            var rowNum=$(this).index();
                            var $table=$(this).parent();
                            var khmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                            $('#khxx').val(khmc);
                            //$('#khxx').attr('sptm',)
                            $('#chooseKhdiv').modal('close');
                        });
                    }else{
                        $('#khtable').html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                    $("#savaBtn").button('reset');
                }
            });
        };
        function closeNewKhdiv(){
            $('#newKhdiv').modal('close');
        }
        function closeUpdateKhdiv(){
            $('#updateKhdiv').modal('close');
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
            var khda=loadJson[index];
            $("#xgf_khbm").val(khda.F_CSBM);
            $("#xgf_khmc").val(khda.F_CSMC);
            $("#xgf_sjhm").val(khda.F_DH);
            $("#xgf_lxr").val(khda.F_LXR);
            $("#xgf_bz").val(khda.F_BZXX);
            $('#updateKhdiv').modal({
                closeViaDimmer: false,
                width:580,
                height:500
            });
            $('#updateKhdiv').modal('open');
            $('.am-dimmer').css("z-index","1111");
            $('#updateKhdiv').css("z-index","1119");
        }

        function alertMsg(msg){
            $('#alertcontent ',parent.document).text(msg);
            $('#alertdlg',parent.document).modal('open');
        }
    </script>
</body>
</html>
