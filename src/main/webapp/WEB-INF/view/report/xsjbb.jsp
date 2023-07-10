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
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-销售季报表</title>
    <meta name="description" content="云平台客户端V1-销售季报表">
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
            padding-bottom: 10px;
        }
        label{
            font-weight: 500;
            font-size:1.4rem;
        }
        .am-popup{
            z-index: 1200;
        }
        #ksrq,#jsrq{
            width:120px;
            display: inline-block;
        }
        #spmxtable a{
            color: #333;
        }
        #spmxtable a:focus, a:hover {
            color: #333;
        }
    </style>
</head>
<body>
<div class="am-g">
    <div class="am-container">
        <div class="am-u-sm-6 am-u-md-6"></div>
        <div class="am-u-sm-6 am-u-md-6">
            <select data-am-selected id="choseXsj"></select>&nbsp;
            <button onclick="loadInfo(1,10)" class="am-btn am-btn-default am-btn-sm am-radius am-btn-danger">查询</button>
        </div>
    </div>

    <div class="am-container am-scrollable-horizontal" style="margin-top: 20px;">
        <table class="am-table am-table-bordered am-table-centered am-text-nowrap">
            <thead id="xsjbbTitle">

            </thead>
            <tbody id="sptable">
            </tbody>
        </table>
    </div>
    <div id="pagebar"></div>
</div>

<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>
<script src="/assets/js/app.js"></script>
<script src="/assets/address/address.min.js"></script>
<script src="/assets/address/iscroll.min.js"></script>
<script src="/tree/amazeui.tree.js"></script>
<script src="/tree/amazeui.tree.min.js"></script>
<script src="/cropper/js/cropper.min.js"></script>
<script type="text/javascript">
    var zylxJson = null;
    var spdaJson = null;


    $(function (){
        loadXsj();
        loadXsjbbTitle();
        loadInfo(1,10);
        loadSj();
    })

    //加载销售季
    function loadXsj() {
        $.ajax({
            url: "/report/loadXsj",
            type: "post",
            async: false,
            data: {timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                var choseXsjHtml= "";
                for (var i = 0; i < dataJson.length; i++){
                    var jyjda = dataJson[i];
                    choseXsjHtml += "<option value='"+jyjda.F_JYJID+"'>"+jyjda.F_JYJNAME+"</option>"
                }
                $("#choseXsj").html(choseXsjHtml);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }
    
    function loadXsjbbTitle() {
        var xsjbbTitleHtml = "";
        xsjbbTitleHtml += " <tr>";
        xsjbbTitleHtml += "     <th class=\"am-text-middle\" rowspan='2'>部门编码</th>";
        xsjbbTitleHtml += "     <th class=\"am-text-middle\" rowspan='2'>部门名称</th>";
        xsjbbTitleHtml += "     <th class=\"am-text-middle\" rowspan='2'>总金额</th>";
        getZylx('0');
        xsjbbTitleHtml += "     <th class=\"am-text-middle\" colspan='"+zylxJson.length+"'>农户</th>";
        getZylx('1');
        xsjbbTitleHtml += "     <th class=\"am-text-middle\" colspan='"+zylxJson.length+"'>大户</th>";
        getZylx('2');
        xsjbbTitleHtml += "     <th class=\"am-text-middle\" colspan='"+zylxJson.length+"'>合作社</th>";
        xsjbbTitleHtml += " </tr>";

        xsjbbTitleHtml += " <tr>";
        getZylx('0');
        for (var i = 0; i < zylxJson.length;i++){
            var zylx = zylxJson[i];
            xsjbbTitleHtml += "     <th class=\"am-text-middle\">" +
                "<input type=\"hidden\" value='"+zylx.F_FLBM+"'/>" +
                "<input type=\"hidden\" value='"+zylx.F_KHLX+"'/>"+zylx.F_FLMC+"" +
                "</th>";
        }
        getZylx('1');
        for (var i = 0; i < zylxJson.length;i++){
            var zylx = zylxJson[i];
            xsjbbTitleHtml += "     <th class=\"am-text-middle\">" +
                "<input type=\"hidden\" value='"+zylx.F_FLBM+"'/>" +
                "<input type=\"hidden\" value='"+zylx.F_KHLX+"'/>"+zylx.F_FLMC+"" +
                "</th>";
        }
        getZylx('2');
        for (var i = 0; i < zylxJson.length;i++){
            var zylx = zylxJson[i];
            xsjbbTitleHtml += "     <th class=\"am-text-middle\">" +
                "<input type=\"hidden\" value='"+zylx.F_FLBM+"'/>" +
                "<input type=\"hidden\" value='"+zylx.F_KHLX+"'/>"+zylx.F_FLMC+"" +
                "</th>";
        }
        xsjbbTitleHtml += " </tr>";

        $("#xsjbbTitle").html(xsjbbTitleHtml);
    }

    //获取农户拥有的种养类型
    function getZylx(f_khlx) {
        var jyjId = $("#choseXsj").val();
        $.ajax({
            url: "/report/getZylx",
            type: "post",
            async: false,
            data: {f_khlx:f_khlx,jyjId:jyjId,timeer: new Date() },
            success: function (data) {
                var dataJson = JSON.parse(data);
                zylxJson = dataJson;
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }

    function loadTable(pageIndex) {
        $('#pagebar').html("");
        loadInfo(pageIndex,10);
    }

    function loadInfo(pageIndex,pageSize){
        var jyjId = $("#choseXsj").val()

        $.ajax({
            url: "/report/loadJxsbb",
            type: "post",
            async: false,
            data: {jyjId:jyjId,pageIndex:pageIndex,pageSize:pageSize},
            success: function (data) {
                var res = JSON.parse(data);
                var spdalist = JSON.parse(res.list);
                spdaJson = spdalist;
                var row = spdalist.length;//数据有几行
                $('#sptable').html("");
                if(row > 0) {
                    var rowhtml="";
                    for(var i = 0;i < row;i++){
                        var spjson = spdalist[i];
                        rowhtml+="<tr index='"+i+"'>";
                        rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_BMBM+"'>"+spjson.F_BMBM+"</td>";
                        rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.F_BMMC+"'>"+spjson.F_BMMC+"</td>";
                        rowhtml+="  <td class=\"am-text-middle\" title='"+spjson.ZJE+"'>"+spjson.ZJE+"</td>";
                        getZylx('0');
                        for (var j = 0; j < zylxJson.length;j++){
                            var zylx = zylxJson[j];
                            rowhtml += "     <td class=\"am-text-middle\">" +
                                "<input type=\"hidden\" value='"+zylx.F_FLBM+"'/>" +
                                "<input type=\"hidden\" value='"+zylx.F_KHLX+"'/>" +
                                "</td>";
                        }
                        getZylx('1');
                        for (var j = 0; j < zylxJson.length;j++){
                            var zylx = zylxJson[j];
                            rowhtml += "     <td class=\"am-text-middle\">" +
                                "<input type=\"hidden\" value='"+zylx.F_FLBM+"'/>" +
                                "<input type=\"hidden\" value='"+zylx.F_KHLX+"'/>" +
                                "</td>";
                        }
                        getZylx('2');
                        for (var j = 0; j < zylxJson.length;j++){
                            var zylx = zylxJson[j];
                            rowhtml += "     <td class=\"am-text-middle\">" +
                                "<input type=\"hidden\" value='"+zylx.F_FLBM+"'/>" +
                                "<input type=\"hidden\" value='"+zylx.F_KHLX+"'/>"  +
                                "</td>";
                        }
                        rowhtml+="</tr>";
                    }
                    $('#sptable').html(rowhtml);

                    loadSj();

                    pagebar(pageIndex,pageSize,res.total,"pagebar");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    }
    
    function loadSj() {
        var row = spdaJson.length;//数据有几行
        var sjcol = $("#sptable").find("tr").eq(0).find("td").length-3;//数据共有多少列，不包含部门编码，部门名称，总金额
        for(var i=0;i< row; i++){
            var spjson = spdaJson[i];
            for (var j =0;j < sjcol; j++){
                var tdflbm = $("#sptable").find("tr").eq(i).find("td").eq(j+3).find("input").eq(0).val();//从第四条数据开始循环
                var tdkhlx = $("#sptable").find("tr").eq(i).find("td").eq(j+3).find("input").eq(1).val();
                var tdtitle = tdkhlx+"-"+tdflbm;
                for(var spjsonKey in spjson){
                    if (tdtitle == spjsonKey){
                        $("#sptable").find("tr").eq(i).find("td").eq(j+3).html(spjson[spjsonKey]);
                    }
                }
            }
        }
    }

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


</script>
</body>
</html>
