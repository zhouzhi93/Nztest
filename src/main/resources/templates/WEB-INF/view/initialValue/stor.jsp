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
            <div class="am-modal-bd">
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
                                <input type="number" class="am-form-field am-input-sm am-radius" id="f_dh" placeholder="电话">
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
            <div class="am-modal-bd">
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
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_dz" required placeholder="地址">
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
                            <label for="xgf_khh" class="am-u-sm-2 am-form-label">开户行</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_khh" required placeholder="开户行">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_zh" class="am-u-sm-2 am-form-label">账号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_zh" required placeholder="账号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_sh" class="am-u-sm-2 am-form-label">税号</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_sh" required placeholder="税号">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_fr" class="am-u-sm-2 am-form-label">负责人</label>
                            <div class="am-u-sm-9">
                                <input type="text" class="am-form-field am-input-sm am-radius" id="xgf_fr" required placeholder="负责人">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
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
        $(function(){
            loadMdxx("");
            //显示新增门店
            $('#addmd').click(function () {
                $("#f_bmmc").val("");
                $("#f_dz").val("");
                $("#f_dh").val("");
                $("#f_khh").val("");
                $("#f_zh").val("");
                $("#f_sh").val("");
                $("#f_fr").val("")
                $('#newMddiv').modal({
                    closeViaDimmer: false,
                    width:580,
                    height:650
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
                            var tybz = $("input[name='f_Tybz']:checked").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/stor/addStor",
                                    type: "post",
                                    async: false,
                                    data: { bmmc: bmmc,yb:"", dz: dz,dh: dh,cz: "",email: "",khh: khh,zh: zh,sh: sh,
                                            fr:fr,tybz: tybz, timeer: new Date() },
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
                            var tybz = $("input[name='xgf_Tybz']:checked").val();
                            setTimeout(function () {
                                $.ajax({
                                    url: "/stor/updateStor",
                                    type: "post",
                                    async: false,
                                    data: { bmbm:bmbm,bmmc: bmmc,yb:"", dz: dz,dh: dh,cz: "",email: "",khh: khh,zh: zh,sh: sh,
                                        fr:fr,tybz: tybz,timeer: new Date() },
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

        });



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
                                bmmxhtml="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>" +
                                    " &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+bmda.F_BMBM+"')\">删除</a>" +
                                    "                            <td class=\"am-text-middle\">"+bmda.F_BMMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+bmda.F_DZ+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+bmda.F_DH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+bmda.F_KHH+"</td>\n" +
                                    "                        </tr>"
                            }else{
                                bmmxhtml+="<tr>\n" +
                                    "                            <td class=\"am-text-middle\">" +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>" +
                                    " &nbsp;&nbsp;&nbsp; " +
                                    "<a href=\"#\" class=\"redlink\" onclick=\"deletePage('"+bmda.F_BMBM+"')\">删除</a>" +
                                    "                            <td class=\"am-text-middle\">"+bmda.F_BMMC+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+bmda.F_DZ+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+bmda.F_DH+"</td>\n" +
                                    "                            <td class=\"am-text-middle\">"+bmda.F_KHH+"</td>\n" +
                                    "                        </tr>"
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
            $("input[name='xgf_Tybz']").each(function() {
                if ($(this).val() == bmda.F_TYBZ) {
                    $(this).prop("checked", true);
                }
            });
            $('#updateMddiv').modal({
                closeViaDimmer: false,
                width:580,
                height:650
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

    </script>
</body>
</html>
