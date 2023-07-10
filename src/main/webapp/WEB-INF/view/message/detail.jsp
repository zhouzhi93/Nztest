<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String title = "信息详情";
    String f_zybm=(String)session.getAttribute("f_zybm");
    String f_tid = request.getParameter("tid");
%>
<%--<!DOCTYPE html>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>云平台客户端V1-<%=title%></title>
    <meta name="description" content="云平台客户端V1-<%=title%>">
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
        h2
        {
            font-size: 200%;
            color: #333;
            margin-top: 10px;
        }
        .am-container{
            padding-left: 0;
            padding-right: 0;
            max-width:100%;
        }
        #newsmain{width:90%;text-align:center;margin:8px auto;}
        #newshead,#newinfo{text-align:center}
        #newsbody,#newsannex{text-align: left;}

    </style>
</head>
<body>
<div class="am-g">
    <div class="am-u-sm-12 am-u-md-12" id="newsdiv">
        <div class="header">
            <div class="am-g">

            </div>
        </div>
    </div>
    <!--选择角色div-->
    <div class="am-container am-" id="newsmain">
        <div>
            <div>
                <div class="am-container">
                    <div style="margin-top: 10px;" class="am-container am-scrollable-horizontal" id="newshead"></div>
                    <div style="margin-top: 10px;" class="am-container am-scrollable-horizontal" id="newsinfo"></div>
                    <div style="margin-top: 10px;" class="am-container am-scrollable-horizontal" id="newsbody"></div>
                    <div style="margin-top: 10px;" class="am-container am-scrollable-horizontal" id="newsannex">
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<script src="/assets/jquery-1.8.2/jquery-1.8.2.js"></script>
<script src="/assets/js/amazeui.min.js"></script>

<!-- 配置文件 -->
<script type="text/javascript" src="/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript"  charset="utf-8" src="/ueditor/ueditor.parse.js"></script>
<script type="text/javascript" charset="utf-8" src="/ueditor/editor_api.js"></script>
<script type="text/javascript">
    function addannex(size,name,path) {
        var li = $('<div>').attr({'size':size,'name':name,'path':path}).css({'margin-right':'10px'}).appendTo($('#newsannex'));
        $('<a>').attr('href',path).html(name).appendTo(li);
        //$('<span>').html(size).css('float','right').appendTo(li);

    }
    function loadannex(f_tid) {
        $.ajax({url: "/message/annex",type: "post",async: false,data: {f_tid,timeer: new Date() },
            success: function (data) {
                data = JSON.parse(data)
                if(data.states=="0"){
                    var arr = JSON.parse(data.result);
                    var json=null;
                    for(var i=0; i<arr.length;i++) {
                        json = arr[i];
                        addannex(json.F_SIZE,json.F_NAME,json.F_PATH);
                    }
                }
                else alert(data.msg);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }

    function addRow(node){//操作、分类、时间、发布人、标题、摘要
        $('#newshead').html("<h2>"+node.F_HEAD+"</h2>" +"<hr><br/>");
        $('#newsinfo').html(node.F_TIME+"  &ensp;&ensp;&ensp;&ensp;  "+node.F_ZYMC);
        $('#newsbody').html(node.F_BODY);
        $('#newshead').html(node.F_HEAD);
    }
    var tid = null;
    $(function(){
        tid = "<%=f_tid%>";
        $.ajax({url: "/message/querynews",type: "post",async: false,data: {f_tid:tid,time:new Date().getTime()},
            success: function (data) {
                data = JSON.parse(data)
                if(data.states=="0") {
                    var dataJson = JSON.parse(data.result);
                    addRow(dataJson[0]);
                    loadannex(tid);
                }else {
                    alert(data.msg);
                }
            }
        });
    });

</script>
</body>
</html>