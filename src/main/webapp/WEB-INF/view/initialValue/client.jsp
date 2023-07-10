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
    <title>云平台客户端V1-客户资料</title>
    <meta name="description" content="云平台客户端V1-客户资料">
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
                    <h1>客户资料</h1>
                </div>
            </div>
        </div>
        <!--选择客户div-->
        <div class="am-container am-" id="chooseKhdiv">
            <div>
                <div>
                    <div class="am-container">
                        <div class="am-u-sm-6 am-u-md-6 am-text-left" style="padding-left: 0;padding-right: 0;">
                            <input class="am-radius am-form-field am-input-sm" id="khoption" style="width: 160px;display:initial;" type="text" placeholder="输入客户名称、字母">
                            <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchKh()">搜索</button>
                        </div>
                        <div class="am-u-sm-6 am-u-md-6 am-text-right">
                            <button type="button" class="am-btn am-btn-xs am-radius" onclick="loadKhxx(1,10,'')" style="border: 1px solid #0E90D2;background: white;color: #0E90D2;">刷新</button>
                            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" id="addkh">新增</button>
                        </div>
                    </div>
                    <div style="margin-top: 10px;" class="am-scrollable-horizontal" id="hovertables">
                        <table class="am-table am-table-bordered am-table-striped am-text-nowrap" >
                            <thead id="khtableTitle">
                            </thead>
                            <tbody id="khtable">
                            </tbody>
                        </table>
                    </div>
                    <div id="pagebar"></div>
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
                            <label for="f_khmc" class="am-u-sm-2 am-form-label">客户名称</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_khmc" required placeholder="客户名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>

                        <div class="am-form-group">
                            <label for="f_sjhm" class="am-u-sm-2 am-form-label">联系电话</label>
                            <div class="am-u-sm-9">
                                <input type="tel" class="am-form-field am-input-sm am-radius" id="f_sjhm" placeholder="联系电话">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_sfzh"  class="am-u-sm-2 am-form-label">身份证号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_sfzh" placeholder="身份证号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_Dz"  class="am-u-sm-2 am-form-label">地址</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_Dz" placeholder="地址">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_Khh"  class="am-u-sm-2 am-form-label">开户行</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_Khh" placeholder="开户行">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_Yhkh"  class="am-u-sm-2 am-form-label">银行账号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_Yhkh" placeholder="银行账号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_Tyxym"  class="am-u-sm-2 am-form-label">统一信用码</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="f_Tyxym" placeholder="统一信用码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>

                        <%--是否集中配送和客户类型div放在这里--%>
                        <div id="morelxDiv">

                        </div>

                        <div class="am-form-group">
                            <label for="f_bz" class="am-u-sm-2 am-form-label">备注</label>
                            <div class="am-u-sm-9">
                                <textarea  class="am-form-field am-input-sm am-radius" id="f_bz" placeholder="备注"></textarea>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>

                        <%--统计明细Div在这--%>
                        <div id="tjmxTable" class="am-g">

                        </div>

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
            <div class="am-modal-hd">修改客户
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="updatekhform">
                        <div class="am-form-group">
                            <label for="xgf_khmc" class="am-u-sm-2 am-form-label">客户名称</label>
                            <div class="am-u-sm-9">
                                <input type="hidden" id="xgf_khbm" />
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_khmc" required placeholder="客户名称">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>

                        <div class="am-form-group">
                            <label for="xgf_sjhm" class="am-u-sm-2 am-form-label">联系电话</label>
                            <div class="am-u-sm-9">
                                <input type="tel" class="am-form-field am-input-sm am-radius" id="xgf_sjhm" placeholder="联系电话">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_sfzh"  class="am-u-sm-2 am-form-label">身份证号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_sfzh" placeholder="身份证号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_Dz"  class="am-u-sm-2 am-form-label">地址</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_Dz" placeholder="地址">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_Khh"  class="am-u-sm-2 am-form-label">开户行</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_Khh" placeholder="开户行">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_Yhkh"  class="am-u-sm-2 am-form-label">银行账号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_Yhkh" placeholder="银行账号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_Tyxym"  class="am-u-sm-2 am-form-label">统一信用码</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_Tyxym" placeholder="统一信用码">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>

                        <%--是否集中配送和客户类型div放在这里--%>
                        <div id="xgmorelxDiv">

                        </div>
                        <div class="am-form-group">
                            <label for="xgf_bz" class="am-u-sm-2 am-form-label">备注</label>
                            <div class="am-u-sm-9">
                                <textarea  class="am-form-field am-input-sm am-radius" id="xgf_bz" placeholder="备注"></textarea>
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>

                        <%--统计明细Div在这--%>
                        <div id="xgtjmxTable" class="am-g">

                        </div>

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

    <!--删除客户div-->
    <div class="am-modal am-modal-confirm" tabindex="-1" id="deleteKhdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-bd">
                确定要删除这条记录吗？
            </div>
            <div class="am-modal-footer">
                <span class="am-modal-btn" data-am-modal-confirm onclick="deleteKhbtn()">确定</span>
                <span class="am-modal-btn" data-am-modal-cancel onclick="closeDeleteKhdiv()">取消</span>
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
        var deletekhbm = null;
        var clickCsbm = null;
        var slJson = null;
        var mjxhJson = null;

        $(function(){
            loadKhxx(1,10,"");

            //显示新增客户
            $('#addkh').click(function () {
                $("#f_khmc").val("");
                $("#f_sjhm").val("");
                $("#f_sfzh").val("");
                $("#f_bz").val("");
                $("#f_Dz").val("");
                $("#f_Khh").val("");
                $("#f_Yhkh").val("");
                $("#f_Tyxym").val("");
                $("#f_Sfjzps").val("");
                $("#f_Khlx").val("");
                clickCsbm = null;
                $("#tjmxTable").html("");

                $('#newKhdiv').modal({
                    closeViaDimmer: false,
                    width:980,
                    height:1000
                });
                $('#newKhdiv').modal('open');
                $('.am-dimmer').css("z-index","1111");
                $('#newKhdiv').css("z-index","1119");

                var newKhdivHtml = "";
                //常熟、江阴、太仓版显示是否集中配送和类型
                if ("<%=ypd %>"=="12" || "<%=ypd %>"=="13" ||"<%=ypd %>"=="14"){
                    newKhdivHtml +="    <div class=\"am-form-group\">" +
                        "                   <label for=\"f_Sfjzps\" class=\"am-u-sm-2 am-form-label\">是否集中配送</label>" +
                        "                   <div class=\"am-u-sm-9\">" +
                        "                       <div class=\"am-u-sm-12\" style=\"padding: 0px;text-align:left;\">" +
                        "                           <select data-am-selected id=\"f_Sfjzps\">" +
                        "                               <option value=\"0\">否</option>" +
                        "                               <option value=\"1\">是</option>" +
                        "                           </select>" +
                        "                       </div>" +
                        "                   </div>" +
                        "                   <div class=\"am-u-sm-end\"></div>" +
                        "               </div>" +

                        "               <div class=\"am-form-group\">" +
                        "                   <label for=\"f_Khlx\" class=\"am-u-sm-2 am-form-label\">类型</label>" +
                        "                   <div class=\"am-u-sm-9\">" +
                        "                       <div class=\"am-u-sm-12\" style=\"padding: 0px;text-align:left;\">" +
                        "                           <select data-am-selected id=\"f_Khlx\">" +
                        "                               <option value=\"0\">农户</option>" +
                        "                               <option value=\"1\">大户</option>" +
                        "                               <option value=\"2\">合作社</option>" +
                        "                           </select>" +
                        "                       </div>" +
                        "                   </div>" +
                        "                   <div class=\"am-u-sm-end\"></div>" +
                        "               </div>";
                    $("#morelxDiv").html(newKhdivHtml);

                    //根据客户类型输出表格
                    $("#f_Khlx").change(function (){
                        var khlx = $("#f_Khlx").val();
                        if (khlx == "0"){       //农户
                            loadCstjmx("f_sfsynh");
                        }else if (khlx == "1"){     //大户
                            loadCstjmx("f_sfsydh");
                        }else if (khlx == "2"){     //合作社
                            loadCstjmx("f_sfsyhzs");
                        }
                    });
                }
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
                            var f_sfzh = $("#f_sfzh").val();
                            var f_bzxx = $("#f_bz").val();
                            var f_Dz = $("#f_Dz").val();
                            var f_Khh = $("#f_Khh").val();
                            var f_Yhkh = $("#f_Yhkh").val();
                            var f_Tyxym = $("#f_Tyxym").val();
                            var f_Sfjzps = $("#f_Sfjzps").val();
                            var f_Khlx = $("#f_Khlx").val();

                            //获取需要修改序号的数量
                            loadmjxh(f_Khlx);
                            var flbms = "";
                            var sls = "";
                            for (var i = 0; i < mjxhJson.length; i++){
                                var inputVal = $("#sltr").find('td:eq('+i+')').find('input:eq(0)').val();
                                if (inputVal != null && inputVal != "" && inputVal != undefined){
                                    if (i == mjxhJson.length - 1){
                                        flbms += mjxhJson[i].F_FLBM;
                                        sls += inputVal;
                                    }else {
                                        flbms += mjxhJson[i].F_FLBM+",";
                                        sls += inputVal + ",";
                                    }
                                }
                            }

                            setTimeout(function () {
                                $.ajax({
                                    url: "/initialvalues/AddKhdaNew",
                                    type: "post",
                                    async: false,
                                    data: {
                                            f_khmc: f_khmc,
                                            f_sjhm: f_sjhm,
                                            f_sfzh:f_sfzh,
                                            f_Dz:f_Dz,
                                            f_Khh:f_Khh,
                                            f_Yhkh:f_Yhkh,
                                            f_Tyxym:f_Tyxym,
                                            f_Sfjzps:f_Sfjzps,
                                            f_Khlx:f_Khlx,
                                            f_qydz: "",
                                            f_xxdz: "",
                                            f_bzxx: f_bzxx,
                                            cslx:1,
                                            flbms:flbms,
                                            sls:sls,
                                            timeer: new Date(),
                                          },
                                    success: function (data, textStatus) {
                                        if(data == "ok"){
                                            alertMsg("保存成功！");
                                        }
                                        $subbtn.button('reset');
                                        $('#newKhdiv').modal('close');
                                        loadKhxx(1,10,"");
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
            //修改客户提交
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
                            var f_sfzh = $("#xgf_sfzh").val();
                            var f_bzxx = $("#xgf_bz").val();
                            var f_khbm = $("#xgf_khbm").val();
                            var f_Dz = $("#xgf_Dz").val();
                            var f_Khh = $("#xgf_Khh").val();
                            var f_Yhkh = $("#xgf_Yhkh").val();
                            var f_Tyxym = $("#xgf_Tyxym").val();
                            var f_Sfjzps = $("#xgf_Sfjzps").val();
                            var f_Khlx = $("#xgf_Khlx").val();


                            //获取需要修改序号的数量
                            loadmjxh(f_Khlx);
                            var flbms = "";
                            var sls = "";
                            for (var i = 0; i < mjxhJson.length; i++){
                                var inputVal = $("#sltr").find('td:eq('+i+')').find('input:eq(0)').val();
                                if (inputVal != null && inputVal != "" && inputVal != undefined){
                                    if (i == mjxhJson.length - 1){
                                        flbms += mjxhJson[i].F_FLBM;
                                        sls += inputVal;
                                    }else {
                                        flbms += mjxhJson[i].F_FLBM+",";
                                        sls += inputVal + ",";
                                    }
                                }
                            }


                            setTimeout(function () {
                                $.ajax({
                                    url: "/initialvalues/updateKhmx",
                                    type: "post",
                                    async: false,
                                    data: { f_khmc: f_khmc, f_sjhm: f_sjhm,f_sfzh:f_sfzh, f_qydz: "", f_xxdz: "", f_bzxx: f_bzxx,
                                            f_khbm:f_khbm,cslx:1, timeer: new Date(),f_Dz:f_Dz,f_Khh:f_Khh,f_Yhkh:f_Yhkh,f_Tyxym:f_Tyxym,
                                            f_Sfjzps:f_Sfjzps,f_Khlx:f_Khlx,flbms:flbms,sls:sls},
                                    success: function (data, textStatus) {
                                        if(data == "ok"){
                                            alertMsg("修改成功！");
                                        }
                                        $subbtn.button('reset');
                                        $('#updateKhdiv').modal('close');
                                        loadKhxx(1,10,"");
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

            if('<%=ypd%>' == '1'  || "<%=ypd%>" == '0'){
                $('#f_sfzh').attr("required","true");
                $('#xgf_sfzh').attr("required","true");
                $('#f_sjhm').attr("required","true");
                $('#xgf_sjhm').attr("required","true");
            }

        });

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

        function searchKh() {
            var khxx=$('#khoption').val();
            loadKhxx(1,10,khxx);
        };
        function loadTable(pageIndex) {
            $('#pagebar').html("");
            var khxx=$('#khoption').val();
            loadKhxx(pageIndex,10,khxx);
        }
        //加载客户
        function loadKhxx(pageIndex,pageSize,khxx){
            $.ajax({
                url: "/initialvalues/GetKhda",
                type: "post",
                async: false,
                data: {khxx:khxx,cslx:1,pageIndex:pageIndex,pageSize:pageSize, timeer: new Date() },
                success: function (data) {
                    var res = JSON.parse(data);
                    var dataJson = JSON.parse(res.list);
                    loadJson = dataJson;
                    if(dataJson.length>0) {
                        var khdatitlehtml="";
                        var khdahtml="";
                        if (dataJson[0].F_LXBM==12 || dataJson[0].F_LXBM==13 ||dataJson[0].F_LXBM==14){
                            khdatitlehtml += "<tr>" +
                                "<th class=\"am-text-middle\">操作</th>" +
                                "<th class=\"am-text-middle\">客户名称</th>" +
                                "<th class=\"am-text-middle\">手机号码</th>" +
                                "<th class=\"am-text-middle\">身份证号码</th>" +
                                "<th class=\"am-text-middle\">地址</th>" +
                                "<th class=\"am-text-middle\">开户行</th>" +
                                "<th class=\"am-text-middle\">银行账号</th>" +
                                "<th class=\"am-text-middle\">统一信用码</th>" +
                                "<th class=\"am-text-middle\">是否集中配送</th>" +
                                "<th class=\"am-text-middle\">类型</th>" +
                                "</tr>";
                            for(var i=0;i<dataJson.length;i++){
                                var khda=dataJson[i];
                                khdahtml+="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>" +
                                    " &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+khda.F_CSBM+"')\">删除</a>" +
                                    "                            </td>" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_SFZH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_DZ+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_KHH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_YHKH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_TYXYM+"</td>\n";

                                if (khda.F_SFJZPS == 0){
                                    khdahtml+="<td class=\"am-text-middle\">否</td>\n";
                                }else if (khda.F_SFJZPS == 1){
                                    khdahtml+="<td class=\"am-text-middle\">是</td>\n";
                                }else {
                                    khdahtml+="<td class=\"am-text-middle\">未选择</td>\n";
                                }

                                switch (khda.F_KHLX) {
                                    case("0"):
                                        khdahtml+="<td class=\"am-text-middle\">农户</td>\n";
                                        break;
                                    case("1"):
                                        khdahtml+="<td class=\"am-text-middle\">大户</td>\n";
                                        break;
                                    case("2"):
                                        khdahtml+="<td class=\"am-text-middle\">合作社</td>\n";
                                        break;
                                    default:
                                        khdahtml+="<td class=\"am-text-middle\">无</td>\n";
                                        break;
                                }
                                khdahtml+="</tr>";
                            }
                            $('#khtableTitle').html(khdatitlehtml);
                            $('#khtable').html(khdahtml);
                        }else {
                            //不显示是否集中配送和类型
                            khdatitlehtml += "<tr>" +
                                "<th class=\"am-text-middle\">操作</th>" +
                                "<th class=\"am-text-middle\">客户名称</th>" +
                                "<th class=\"am-text-middle\">手机号码</th>" +
                                "<th class=\"am-text-middle\">身份证号码</th>" +
                                "<th class=\"am-text-middle\">地址</th>" +
                                "<th class=\"am-text-middle\">开户行</th>" +
                                "<th class=\"am-text-middle\">银行账号</th>" +
                                "<th class=\"am-text-middle\">统一信用码</th>" +
                                "</tr>";
                            for(var i=0;i<dataJson.length;i++){
                                var khda=dataJson[i];
                                khdahtml+="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>" +
                                    " &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+khda.F_CSBM+"')\">删除</a>" +
                                    "                            </td>" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_CSMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_DH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_SFZH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_DZ+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_KHH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_YHKH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+khda.F_TYXYM+"</td>\n" +
                                    "     </tr>";
                            }
                            $('#khtableTitle').html(khdatitlehtml);
                            $('#khtable').html(khdahtml);
                        }
                        $('#khtable tr').click(function () {
                            var rowNum=$(this).index();
                            var $table=$(this).parent();
                            var khmc=$table.find('tr:eq(' + (rowNum) + ')').find('td:eq(0)').text();
                            $('#khxx').val(khmc);
                            //$('#khxx').attr('sptm',)
                            $('#chooseKhdiv').modal('close');
                        });
                        pagebar(pageIndex,pageSize,res.total,"pagebar");
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
        function pagebar(pageIndex,pageSize,totalCount,parbarid){
            pageIndex=parseInt(pageIndex);//当前页数
            pageSize=parseInt(pageSize);//单页条数
            totalCount=parseInt(totalCount);//总记录数
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
                if(pageIndex>6){
                    template="<li><a href='javascript:void(0);'onclick=\"loadTable({0})\">1</a></li>";
                    output+=template.format(1);
                    output+="<li><span>...</span></li>";
                }
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

        function closeNewKhdiv(){
            $('#newKhdiv').modal('close');
        }
        function closeUpdateKhdiv(){
            $('#updateKhdiv').modal('close');
        }
        //计算总合计金额
        function resum_hjje() {
            var $table=$('#khtable');
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
            clickCsbm = khda.F_CSBM;
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
                    "                           <select data-am-selected id=\"xgf_Sfjzps\">" +
                    "                           </select>" +
                    "                       </div>" +
                    "                   </div>" +
                    "                   <div class=\"am-u-sm-end\"></div>" +
                    "               </div>" +

                    "               <div class=\"am-form-group\">" +
                    "                   <label for=\"xgf_Khlx\" class=\"am-u-sm-2 am-form-label\">类型</label>" +
                    "                   <div class=\"am-u-sm-9\">" +
                    "                       <div class=\"am-u-sm-12\" style=\"padding: 0px;text-align:left;\">" +
                    "                           <select data-am-selected id=\"xgf_Khlx\">" +
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
        }

        //删除按钮弹出确认框
        function deletePage(csbm) {
            deletekhbm = csbm;
            $('#deleteKhdiv').modal('open');
        }

        //点击确认删除职员
        function deleteKhbtn(){
            $.ajax({
                url: "/initialvalues/DeleteKhda",
                type: "post",
                async: false,
                data: { f_Csbm: deletekhbm, timeer: new Date() },
                success: function (data, textStatus) {
                    if (data == "ok"){
                        alertMsg("删除成功！");
                    }
                    $('#deleteKhdiv').modal('close');
                    loadKhxx(1,10,"");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
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
                        var flda = dataJson[i];
                        if(flda.F_MJ == "1"){
                            cols++;
                        }
                        if (rows < flda.F_JB){
                            rows = flda.F_JB;
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
                            var flda = dataJson[j];
                            if (flda.F_JB == i){
                                if (flda.F_MJ == "0"){
                                    var xjcols = findEndNodes(dataJson,flda);
                                    tableHtml += "<td colspan='"+xjcols+"'>"+flda.F_FLMC+"</td>";
                                }else{
                                    var sjrows = rows-(i-1);
                                    tableHtml += "<td rowspan='"+sjrows+"'>"+flda.F_FLMC+"</td>";
                                }
                            }
                        }
                        tableHtml += "</tr>";
                    }

                    //有多少末级输出多少个单位名称和input框
                    tableHtml += "<tr>";
                    for (var i = 0; i <dataJson.length; i++){
                        var flda = dataJson[i];
                        if (flda.F_JB == "1" && flda.F_MJ == "1"){
                            var yjflbm = flda.F_FLBM;//1级分类编码
                            //和二级分类编码比较
                            for (var j = 0; j <dataJson.length; j++){
                                var flda1 = dataJson[j];
                                if (flda1.F_JB == "2") {
                                    var ejflbmTemp = flda1.F_FLBM;
                                    var ejflbm = ejflbmTemp.toString().substring(0, 3);
                                    if (yjflbm == ejflbm) {
                                        var dwmc = flda1.F_DWMC;
                                        tableHtml += "<td>" + dwmc + "</td>";
                                    }
                                }
                            }
                        }else if (flda.F_JB == "3" && flda.F_MJ == "1"){
                            var sjflbm = flda.F_FLBM;//3级分类编码
                            var sjsjflbm = sjflbm.toString().substring(0,6);
                            //和二级分类编码比较
                            for (var j = 0; j <dataJson.length; j++){
                                var flda1 = dataJson[j];
                                if (flda1.F_JB == "2") {
                                    var ejflbm = flda1.F_FLBM;
                                    if (sjsjflbm == ejflbm) {
                                        var dwmc = flda1.F_DWMC;
                                        tableHtml += "<td>" + dwmc + "</td>";
                                    }
                                }
                            }
                        }else if (flda.F_JB == "2" && flda.F_MJ == "1"){
                            tableHtml += "<td>" + flda.F_DWMC + "</td>";
                        }
                    }
                    tableHtml += "</tr>";

                    //判断是增加界面还是修改界面，增加界面不用显示数据
                    if (clickCsbm==null){
                        tableHtml += "<tr id='sltr'>";
                        for (var i = 0; i <cols; i++){
                            tableHtml += "<td><input type='text''></td>";
                        }
                        tableHtml += "</tr>";
                        tableHtml += "</tbody>";
                        tableHtml += "</table>";
                        $("#tjmxTable").html(tableHtml);
                    }else {
                        loadsl();
                        tableHtml += "<tr id='sltr'>";
                        if (slJson != null && slJson != "" && slJson != "[]"){
                            for (var i = 0; i <cols; i++){
                                var sl = slJson[i].F_SL;
                                if (sl == 0){
                                    tableHtml += "<td><input type='text' style='font-size: 6px'></td>";
                                    $("#sltr").find('td:eq('+i+')').find('input:eq(0)').val('');
                                }else {
                                    tableHtml += "<td><input type='text' value='"+sl+"' style='font-size: 6px'></td>";
                                    $("#sltr").find('td:eq('+i+')').find('input:eq(0)').val();
                                }
                            }
                        }else {
                            for (var i = 0; i <cols; i++){
                                tableHtml += "<td><input type='text' style='font-size: 6px'></td>";
                                $("#sltr").find('td:eq('+i+')').find('input:eq(0)').val('');
                            }
                        }
                        tableHtml += "</tr>";
                        tableHtml += "</tbody>";
                        tableHtml += "</table>";
                        $("#xgtjmxTable").html(tableHtml);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
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

        //加载当前客户类型末级明细的序号和名称
        function loadmjxh(f_Khlx){
            $.ajax({
                url: "/initialvalues/loadmjxh",
                type: "post",
                async: false,
                data: { khlx:f_Khlx,timeer: new Date() },
                success: function (data) {
                    var dataJson = JSON.parse(data);
                    mjxhJson = dataJson;
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

        function closeDeleteKhdiv(){
            $('#deleteKhdiv').modal('close');
        }
    </script>
</body>
</html>
