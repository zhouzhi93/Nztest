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
    <title>云平台客户端V1-经营季设置</title>
    <meta name="description" content="云平台客户端V1-补贴标准设置">
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
    </style>
</head>
<body>
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-12" id="xsdiv">
            <div class="header">
                <div class="am-g">
                    <h1>农作物经营季设置</h1>
                </div>
            </div>
        </div>

        <div class="am-u-sm-12 am-u-md-12 am-text-right">
            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="addJyj()">增加</button>
            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="updateJyj()">修改</button>
            <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" onclick="deleteJyj()">删除</button>
        </div>

        <div>
            <table class="am-table am-table-bordered am-table-hover" style="table-layout: fixed;">
                <thead>
                    <tr>
                        <td class="am-text-middle am-text-center am-u-sm-2" style='font-weight: bolder;background-color: #eee;'>经营季</td>
                        <td class="am-text-middle am-text-center am-u-sm-3" style='font-weight: bolder;background-color: #eee;'>时间范围</td>
                        <td class="am-text-middle am-text-center am-u-sm-6" style='font-weight: bolder;background-color: #eee;'>种养类型选择</td>
                        <td class="am-text-middle am-text-center am-u-sm-1" style='font-weight: bolder;background-color: #eee;'>操作</td>
                    </tr>
                </thead>
                <tbody id="jyjtableBody">
                </tbody>
            </table>
        </div>
    </div>

    <!--选择种养类型div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="chonseZylxDiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">种养类型选择
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="chonseZylxForm">
                        <div class="am-form-group" >
                            <div id="checkZylxDiv">

                            </div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="button" onclick="saveZylxState()" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '确定...', resetText: '确定'}" class="am-btn am-btn-danger am-btn-xs">确定</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeChonseZylxDiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--新增经营季div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="addJyjDiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">新增经营季
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="addJyjForm">
                        <div class="am-form-group">
                            <label for="f_jyj" class="am-u-sm-3 am-form-label">经营季</label>
                            <div class="am-u-sm-9">
                                <input type="text" id="f_jyj" required placeholder="经营季">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="f_startTime" class="am-u-sm-3 am-form-label">开始日期</label>
                            <div class="am-u-sm-9">
                                <input type="text" id="f_startTime" class="am-form-field" data-am-datepicker="{format: 'yyyy-mm-dd', viewMode: 'years'}" placeholder="开始日期" data-am-datepicker readonly required/>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="f_endTime" class="am-u-sm-3 am-form-label">结束日期</label>
                            <div class="am-u-sm-9">
                                <input type="text" id="f_endTime" class="am-form-field" data-am-datepicker="{format: 'yyyy-mm-dd', viewMode: 'years'}" placeholder="结束日期" data-am-datepicker readonly required/>
                            </div>
                        </div>

                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="button" onclick="saveAddJyj()" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeAddJyjDiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--修改经营季div-->
    <div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="updateJyjDiv">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">修改经营季
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <div style="margin-top: 10px;" class="am-container">
                    <form class="am-form am-form-horizontal" id="updateJyjForm">
                        <div class="am-form-group">
                            <label for="xgf_jyj" class="am-u-sm-3 am-form-label">经营季</label>
                            <div class="am-u-sm-9">
                                <input type="text" id="xgf_jyj" required placeholder="经营季">
                            </div>
                            <div class="am-u-sm-end"></div>
                        </div>
                        <div class="am-form-group">
                            <label for="xgf_startTime" class="am-u-sm-3 am-form-label">开始日期</label>
                            <div class="am-u-sm-9">
                                <input type="text" id="xgf_startTime" class="am-form-field" data-am-datepicker="{format: 'yyyy-mm-dd', viewMode: 'years'}" placeholder="开始日期" data-am-datepicker readonly required/>
                            </div>
                        </div>

                        <div class="am-form-group">
                            <label for="xgf_endTime" class="am-u-sm-3 am-form-label">结束日期</label>
                            <div class="am-u-sm-9">
                                <input type="text" id="xgf_endTime" class="am-form-field" data-am-datepicker="{format: 'yyyy-mm-dd', viewMode: 'years'}" placeholder="结束日期" data-am-datepicker readonly required/>
                            </div>
                        </div>
                        <div class="am-form-group am-text-left">
                            <div class="am-u-sm-2">&nbsp;</div>
                            <div class="am-u-sm-10">
                                <button type="button" onclick="saveUpdateJyj()" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                                <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closeUpdateJyjDiv()">取消</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!--删除经营季div-->
    <div class="am-modal am-modal-confirm" tabindex="-1" id="deleteJyjdiv">
        <div class="am-modal-dialog">
            <div class="am-modal-bd">
                确定要删除这条记录吗？
            </div>
            <div class="am-modal-footer">
                <span class="am-modal-btn" data-am-modal-confirm onclick="deleteJyjbtn()">确定</span>
                <span class="am-modal-btn" data-am-modal-cancel onclick="closeDeleteJyjdiv()">取消</span>
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
        var jyjTableJson = null;
        var zylxJson = null;
        var chonseZylxJson = null;
        var clickJyjid = null;
        var clickJyjName = null;
        var clickStartTime = null;
        var clickEndTime = null;
        var clickKhlx = null;

        $(function (){
            getJyjTable();
        });

        //展示补贴基数表格中除种养类型选择的内容
        function getJyjTable(){
            $.ajax({
                url: "/initialvalues/getJyjTable",
                type: "post",
                async: false,
                data: { timmer: new Date() },
                success:function(data){
                    var dataJson = JSON.parse(data);
                    jyjTableJson = dataJson;
                    var jyjtableBodyHtml = "";
                    var khlxList = new Array("农户","大户","合作社");
                    for (var i = 0; i < dataJson.length; i++){
                        var flmcStr = "";
                        getZylx(dataJson[i].F_JYJID,1);
                        for (var h = 0; h < khlxList.length; h++){
                            flmcStr += khlxList[h] + ":&nbsp;&nbsp;";
                            for (var j = 0; j < zylxJson.length; j++){
                                if (zylxJson[j].F_KHLX == h){
                                    flmcStr += zylxJson[j].F_FLMC +"&nbsp;&nbsp;";
                                }
                            }
                            flmcStr += "\n";
                        }

                        var start = dataJson[i].F_STARTTIME;
                        var end = dataJson[i].F_ENDTIME
                        var startTime = start.substring(0,4)+"-"+start.substring(4,6)+"-"+start.substring(6,8);
                        var endTime = end.substring(0,4)+"-"+end.substring(4,6)+"-"+end.substring(6,8);

                        jyjtableBodyHtml += "   <tr id=\"tr"+dataJson[i].F_JYJID+"\" onclick='getJyjxx("+i+")'>" +
                            "                       <td class=\"am-text-middle am-u-sm-2\" style='white-space: nowrap;overflow: hidden;text-overflow: ellipsis;' title='"+dataJson[i].F_JYJNAME+"'>"+dataJson[i].F_JYJNAME+"</td>" +
                            "                       <td class=\"am-text-middle am-u-sm-3\" style='white-space: nowrap;overflow: hidden;text-overflow: ellipsis;' title='"+startTime+"&nbsp;~&nbsp;"+endTime+"'>"+startTime+"&nbsp;~&nbsp;"+endTime+"</td>";
                        jyjtableBodyHtml += "       <td class=\"am-text-middle am-u-sm-6\" style='white-space: nowrap;overflow: hidden;text-overflow: ellipsis;' title='"+flmcStr+"'>";
                        for (var h = 0; h < khlxList.length; h++){
                            jyjtableBodyHtml += "&nbsp;&nbsp;" + khlxList[h] + ":&nbsp;&nbsp;";
                            for (var j = 0; j < zylxJson.length; j++){
                                if (zylxJson[j].F_KHLX == h){
                                    jyjtableBodyHtml += zylxJson[j].F_FLMC +"&nbsp;&nbsp;";
                                }
                            }
                            jyjtableBodyHtml += "\n";
                        }
                        jyjtableBodyHtml += "       </td>";
                        jyjtableBodyHtml += "       <td class=\"am-text-middle am-u-sm-1\"><button type=\"button\" onclick='openChonseZylxDiv("+i+")' class=\"am-btn am-btn-default\" style='padding: 0px;height: 25.59px;width: 100%;'>...</button></td>" +
                            "                   </tr>";
                    }
                    $("#jyjtableBody").html(jyjtableBodyHtml);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        //展示种养类型选择中的数据
        function getZylx(jyjId,state){
            $.ajax({
                url: "/initialvalues/getZylx",
                type: "post",
                async: false,
                data: { jyjId:jyjId,state:state,timmer: new Date() },
                success:function(data){
                    var dataJson = JSON.parse(data);
                    zylxJson = dataJson;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }
        
        //弹出种养类型选择Div
        function openChonseZylxDiv(index) {
            $('#chonseZylxDiv').modal('open');
            $.ajax({
                url: "/initialvalues/getZylxByJyjid",
                type: "post",
                async: false,
                data: { index:index,timmer: new Date() },
                success:function(data){
                    var dataJson = JSON.parse(data);
                    chonseZylxJson = dataJson;
                    var checkZyLxDivHtml = "";
                    var khlxList = new Array("农户","大户","合作社");
                    for (var j = 0; j < khlxList.length; j++){
                        checkZyLxDivHtml += "<div>"+khlxList[j]+"</div>";
                        for (var i = 0; i < dataJson.length; i++){
                            if (dataJson[i].F_KHLX == j){
                                if (dataJson[i].F_STATE == 1){
                                    checkZyLxDivHtml += "   <label class=\"am-checkbox-inline\">" +
                                        "                       <input type=\"checkbox\" name='zylxItems' checked=\"checked\" value='"+dataJson[i].F_FLBM+"' f_khlx='"+dataJson[i].F_KHLX+"' data-am-ucheck checked>"+dataJson[i].F_FLMC+"" +
                                        "                   </label>";
                                }else if (dataJson[i].F_STATE == 0){
                                    checkZyLxDivHtml += "   <label class=\"am-checkbox-inline\">" +
                                        "                       <input type=\"checkbox\" name='zylxItems' value='"+dataJson[i].F_FLBM+"' f_khlx='"+dataJson[i].F_KHLX+"' data-am-ucheck>"+dataJson[i].F_FLMC+"" +
                                        "                   </label>";
                                }
                            }
                        }
                    }
                    $("#checkZylxDiv").html(checkZyLxDivHtml);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        //修改种养类型状态
        function saveZylxState() {
            var jyjId = chonseZylxJson[0].F_JYJID;
            var flbmItems = "";
            var noflbmItems = "";
            var khlxItems = "";
            var nokhlxItems = "";
            $("input[name='zylxItems']:checked").each(function (){
                flbmItems += $(this).val()+",";
                khlxItems += $(this).attr("f_khlx")+",";
            });
            $("input[name='zylxItems']").not("input:checked").each(function (){
                noflbmItems += $(this).val()+",";
                nokhlxItems += $(this).attr("f_khlx")+",";
            });
            $.ajax({
                url: "/initialvalues/saveZylxState",
                type: "post",
                async: false,
                data: { jyjId:jyjId,flbmItems:flbmItems,noflbmItems:noflbmItems,khlxItems:khlxItems,nokhlxItems:nokhlxItems,timmer: new Date() },
                success:function(data){
                    if (data == "ok"){
                        alertMsg("保存成功！");
                    }
                    $('#chonseZylxDiv').modal('close');
                    getJyjTable();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        //弹出新增经营季Div
        function addJyj() {
            $("#f_jyj").val("");
            $("#f_startTime").val("");
            $("#f_endTime").val("");
            $('#addJyjDiv').modal('open');
        }

        //保存新增经营季
        function saveAddJyj() {
            var f_jyjName = $("#f_jyj").val();
            var f_startTime = $("#f_startTime").val();
            var f_endTime = $("#f_endTime").val();

            if(f_jyjName == null || f_jyjName == "" || f_startTime == null || f_startTime == "" || f_endTime == null || f_endTime == ""){
                alertMsg("信息未填写完整！");
            }

            $.ajax({
                url: "/initialvalues/saveAddJyj",
                type: "post",
                async: false,
                data: { f_jyjName:f_jyjName,f_startTime:f_startTime,f_endTime:f_endTime,timmer: new Date() },
                success:function(data){
                    if (data == "ok"){
                        alertMsg("保存成功！");
                    }
                    $('#addJyjDiv').modal('close');
                    getJyjTable();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        //获取选中行信息
        function getJyjxx(index){
            clickJyjid = jyjTableJson[index].F_JYJID;
            clickJyjName = jyjTableJson[index].F_JYJNAME;
            clickStartTime = jyjTableJson[index].F_STARTTIME;
            clickEndTime = jyjTableJson[index].F_ENDTIME;
            clickKhlx = jyjTableJson[index].F_KHLX;
            changeClick();
        }

        //弹出修改经营季Div
        function updateJyj() {
            $("#xgf_jyj").val(clickJyjName);
            var start = clickStartTime.substring(0,4)+"-"+clickStartTime.substring(4,6)+"-"+clickStartTime.substring(6,8);
            $("#xgf_startTime").val(start);
            var end = clickEndTime.substring(0,4)+"-"+clickEndTime.substring(4,6)+"-"+clickEndTime.substring(6,8);
            $("#xgf_endTime").val(end);
            var khlxHtml = "";
            if (clickKhlx == "0"){
                khlxHtml = "<option>请选择</option>" +
                    "           <option value=\"0\" selected>农户</option>" +
                    "           <option value=\"1\">大户</option>" +
                    "           <option value=\"2\">合作社</option>";
            }else if (clickKhlx == "1"){
                khlxHtml = "<option>请选择</option>" +
                    "           <option value=\"0\">农户</option>" +
                    "           <option value=\"1\" selected>大户</option>" +
                    "           <option value=\"2\">合作社</option>";
            }else if (clickKhlx == "2"){
                khlxHtml = "<option>请选择</option>" +
                    "           <option value=\"0\">农户</option>" +
                    "           <option value=\"1\">大户</option>" +
                    "           <option value=\"2\" selected>合作社</option>";
            }else {
                khlxHtml = "<option selected>请选择</option>" +
                    "           <option value=\"0\">农户</option>" +
                    "           <option value=\"1\">大户</option>" +
                    "           <option value=\"2\">合作社</option>";
            }
            $("#xgf_Khlx").html(khlxHtml);

            if (clickJyjid == null || clickJyjid == ""){
                alertMsg("请先选择要修改的经营季！");
            }else {
                $('#updateJyjDiv').modal('open');
            }
        }

        //保存修改经营季
        function saveUpdateJyj() {
            var f_jyjId = clickJyjid;
            var f_jyjName = $("#xgf_jyj").val();
            var f_startTime = $("#xgf_startTime").val();
            var f_endTime = $("#xgf_endTime").val();

            if(f_jyjName == null || f_jyjName == "" || f_startTime == null || f_startTime == "" || f_endTime == null || f_endTime == ""){
                alertMsg("信息未填写完整！");
            }

            $.ajax({
                url: "/initialvalues/saveUpdateJyj",
                type: "post",
                async: false,
                data: { f_jyjId:f_jyjId,f_jyjName:f_jyjName,f_startTime:f_startTime,f_endTime:f_endTime,timmer: new Date() },
                success:function(data){
                    if (data == "ok"){
                        alertMsg("保存成功！");
                    }
                    $('#updateJyjDiv').modal('close');
                    getJyjTable();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }

        //弹出删除经营季div
        function deleteJyj() {
            if (clickJyjid == null || clickJyjid == ""){
                alertMsg("请先选择要删除的经营季！");
            }else {
                $('#deleteJyjdiv').modal('open');
            }
        }

        //保存删除经营季div
        function deleteJyjbtn() {
            var f_jyjId = clickJyjid;
            $.ajax({
                url: "/initialvalues/saveDeleteJyj",
                type: "post",
                async: false,
                data: { jyjId: f_jyjId, timeer: new Date() },
                success: function (data, textStatus) {
                    if (data == "ok"){
                        alertMsg("删除成功！");
                        $('#deleteJyjdiv').modal('close');
                        getJyjTable();
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown + "||" + textStatus);
                }
            });
        }
        
        function closeChonseZylxDiv(){
            $('#chonseZylxDiv').modal('close');
        }

        function closeAddJyjDiv(){
            $('#addJyjDiv').modal('close');
        }

        function closeUpdateJyjDiv(){
            $('#updateJyjDiv').modal('close');
        }

        function closeDeleteJyjDiv(){
            $('#deleteJyjDiv').modal('close');
        }

        function alertMsg(msg){
            $('#alertcontent ',parent.document).text(msg);
            $('#alertdlg',parent.document).modal('open');
        }

        function alertMsgLoad(msg){
            $('#alertcontent ',parent.document).text(msg);
            $('#alertdlg',parent.document).modal('open');
            $('#okbtn',parent.document).click(function (){
                location.reload(true);
            });
        }

        //点击角色变色显示
        function changeClick(){
            $("#jyjtableBody tr").css("background-color","white");
            $("#tr"+clickJyjid+"").css("background-color","skyblue");
        }
    </script>
</body>
</html>
