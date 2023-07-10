<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.util.Calendar" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

    String title = "信息维护";
    Date date = new Date();
    SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
    String f_jsrq = dateFormat.format(date);
    String f_ksrq = null;
    //if(f_jsrq.endsWith("01")) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.add(Calendar.MONTH,-1);
        f_ksrq = dateFormat.format(c.getTime());
    //} else f_ksrq = f_jsrq.substring(0,8)+"01";


    String f_zybm=(String)session.getAttribute("f_zybm");
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
        #newstable input{
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
        #newstable td a{margin:auto 3px}
        .am-modal-dialog{width:1000px !important;}
        .eshow{display: none;}
        .half {width:50%}
    </style>
</head>
<body>
<div class="am-g">
    <div class="am-u-sm-12 am-u-md-12" id="newsdiv">
        <div class="header">
            <div class="am-g">
                <h1><%=title%></h1>
            </div>
        </div>
    </div>
    <!--选择角色div-->
    <div class="am-container am-" id="chooseMddiv">
        <div>
            <div>
                <div class="am-container">
                    <div class="am-u-sm-5 am-u-md-5 am-text-left" style="padding-left: 0;padding-right: 0;">

                        <div class="am-g">
                            <div class="am-u-sm-6">
                                <button type="button" class="am-btn am-btn-default am-margin-right" id="f_ksrq">开始日期</button><span id="f_ksrqDate"><%=f_ksrq%></span>
                            </div>
                            <div class="am-u-sm-6">
                                <button type="button" class="am-btn am-btn-default am-margin-right" id="f_jsrq">结束日期</button><span id="f_jsrqDate"><%=f_jsrq%></span>
                            </div>
                        </div>
                    </div>
                    <div class="am-u-sm-5 am-u-md-5 am-text-left" style="padding-left: 0;padding-right: 0;">

                    <label class=" am-u-md-2"> 关键字:</label>
                        <input class="am-radius am-form-field am-input-sm" id="key" style="width: 160px;display:initial;" type="text" placeholder="输入关键字">
                        <button type="button" class="am-btn am-btn-default am-radius am-btn-xs" onclick="searchNews()">搜索</button>
                    </div>
                    <div class="am-u-sm-2 am-u-md-2 am-text-right">
                        <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" id="addNews">新增</button>
                    </div>
                </div>
                <div style="margin-top: 10px;" class="am-container am-scrollable-horizontal" id="hovertables">
                    <table class="am-table am-table-bordered am-table-centered am-text-nowrap" >
                        <thead>
                        <tr>
                            <th class="am-text-middle" style="width:140px">操作</th>
                            <th class="am-text-middle" style="width:80px">分类</th>
                            <th class="am-text-middle" style="width:100px">时间</th>
                            <th class="am-text-middle" style="width:80px">发布人</th>
                            <th class="am-text-middle" style="width:50px">置顶</th>
                            <th class="am-text-middle" style="width:200px">标题</th>
                            <th class="am-text-middle">摘要</th>
                        </tr>
                        </thead>
                        <tbody id="newstable">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<!--新建div-->
<div class="am-modal am-modal-no-btn" closeViaDimmer="false" tabindex="-1" id="newNewsdiv">
    <div class="am-modal-dialog">
        <div class="am-modal-hd" id="newsbt">新增
            <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
        </div>
        <div class="am-modal-bd am-scrollable-vertical" style="min-height: 500px;">
            <div style="margin-top: 10px;" class="am-container">
                <form class="am-form am-form-horizontal" id="addNewsform">
                    <div class="am-form-group">
                        <label for="f_id" class="am-u-sm-2 am-form-label">类别</label>
                        <div class="am-u-sm-5">
                            <select class="data-am-selected"  id="f_id"></select>
                        </div>
                        <div class="am-u-sm-4">
                            <input type="checkbox"  value="1" id="f_top">置顶
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_head" class="am-u-sm-2 am-form-label">标题</label>
                        <div class="am-u-sm-9">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_head" placeholder="标题">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_mast" class="am-u-sm-2 am-form-label">摘要</label>
                        <div class="am-u-sm-9">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_mast" placeholder="摘要">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label for="ucontainer" class="am-u-sm-2 am-form-label">内容</label>
                        <div class="am-u-sm-9"><!-- 加载编辑器的容器 -->
                            <script type="text/plain" id="ucontainer" name="content"></script>
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group eshow">
                        <label class="am-u-sm-2 am-form-label">置顶</label>
                        <div class="am-u-sm-9 am-text-left">
                            <label class="am-radio-inline">

                            </label>
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group eshow">
                        <label for="f_time" class="am-u-sm-2 am-form-label">发布时间</label>
                        <div class="am-u-sm-9">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_time" readonly>
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    
                    <div class="am-form-group">
                        <label class="am-u-sm-2 am-form-label">附件</label>
                        <div class="am-u-sm-6">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_file" readonly>
                            <input type="hidden" class="am-form-field am-input-sm am-radius" id="f_path" readonly>
                        </div>
                        <div class="am-form-group am-form-file am-u-sm-1" style="padding: 0px;margin: 0px;">
                            <div style="text-align: left;">
                                <button type="button" class="am-btn am-btn-default am-btn-sm">浏览</button>
                            </div>
                            <input id="file" type="file">
                        </div>
                        <div class="am-u-sm-1">
                            <div style="text-align: left;">
                                <button type="button" class="am-btn am-btn-default am-btn-sm" onclick="imgUpload()">
                                    <i class="am-icon-cloud-upload"></i>上传</button>
                            </div>
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>

                    <div class="am-form-group">
                        <label class="am-u-sm-2 am-form-label"></label>
                        <div class="am-u-sm-10">
                            <div class="am-u-sm-end" id="files" style="text-align: left;"></div>
                        </div>
                    </div>


                    <div class="am-form-group am-text-left">
                        <div class="am-u-sm-2">&nbsp;</div>
                        <div class="am-u-sm-10" style="text-align: center">
                            <button type="submit" id="addNewsbtn" ata-am-loading="{spinner: 'circle-o-notch', loadingText: '保存...', resetText: '保存'}" class="am-btn am-btn-danger am-btn-xs">保存</button>&nbsp;&nbsp;
                            <button type="button" class="am-btn am-btn-default am-btn-xs" onclick="closenewNewsdiv()">取消</button>
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

<!-- 配置文件 -->
<script type="text/javascript" src="/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript"  charset="utf-8" src="/ueditor/ueditor.parse.js"></script>
<script type="text/javascript" charset="utf-8" src="/ueditor/editor_api.js"></script>
<script type="text/javascript">
    var loadJson = null,types=null;
    $('#file').on('change', function () {
        var files = $('#file')[0].files;
        var name = files[0].name.substring(files[0].name.lastIndexOf(".")+1);
        var result = "";
        for(var i =0 ; i<files.length ; i++){
            var file  = files[i];
            result += file.name+",";
        }
        result = result.substring(0,result.length-1);
        $('#f_file').val(result);
    });
    function addannex(size,name,path) {
        var li = $('<span>').attr({'size':size,'name':name,'path':path}).css({'margin-right':'10px'}).html(name).appendTo($('#files'));
        $('<button>').html('删除').click(function(){$(this).parent().remove();}).appendTo(li);
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
    function imgUpload() {
        try {
            var formData = new FormData();
            var $imgFile = document.getElementById("file");
            formData.append("files", $imgFile.files[0]);
            $.ajax({url: "/file/upfile",async: false, cache: false,data: formData,processData: false,contentType: false,
                mimeType:"multipart/form-data",type: "post",
                success: function (data) {
                    data = JSON.parse(data)
                    if(data.states=="0"){
                        var json = data.result;
                        addannex(json.f_size,json.f_name,json.f_path);
                        $('#f_file').val("");
                    }
                    else alert(data.msg);
                    //{"result":{"f_path":"/fileImages/a22410ca111d46ca8e56f2fc691bab21.png","f_size":1639614,"f_name":"草原羊.png"},"states":"0"}
                },
                error: function () {
                    alert("上传失败！");
                }
            });
        }
        catch (e) {
            alert(e.name);
        }
    }
    function loadtype(){
        $.ajax({url: "/message/querytype",type: "post",async: false,data: {timeer: new Date() },
            success: function (data) {
                data = JSON.parse(data)
                if(data.states=="0"){
                    types = JSON.parse(data.result);
                    var jarr = toTree('0','');
                    $('#f_id').html(opts.join());
                }
                else alert(data.msg);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }
    var opts=[];
    function toTree(pid,pre) {
        var narr=[],json=null,txt='';
        var allmj='';
        types.forEach(item => {
            if(item.F_SID==pid) {
                json = {pid,id:item.F_ID,title:item.F_NAME,pre};
                if(item.F_MJ=="0"){
                    json.child = toTree(item.F_ID,(pre==''?'':(pre+'->'))+item.F_NAME);
                } else txt+="<option value='"+item.F_ID+"' pre='"+pre+"'>"+item.F_NAME+"</option>";
                narr.push(json);
            }
        })
        if(txt!='')allmj+='<optgroup label="'+pre+'">'+txt+'</optgroup>';
        opts.push(allmj);
        return narr;
    }
    function searchNews() {
        loadNews($('#key').val());
    };
    function loadNews(key){
        var data={timeer: new Date() };
        if(key!=null&&key!='')data.f_title=key;
        var ksrq=$('#f_ksrq').val();
        var jsrq=$('#f_jsrq').val();
        $('#newstable').html("");
        $.ajax({url: "/message/querynews",type: "post",async: false,data: data,
            success: function (data) {
                data = JSON.parse(data)
                if(data.states=="0") {
                    var dataJson = JSON.parse(data.result);
                    loadJson = dataJson;
                    if (dataJson.length > 0) {
                        var html = "";
                        for (var i = 0; i < dataJson.length; i++) {
                            html+=addRow(dataJson[i],i);
                        }
                        $('#newstable').html(html);
                    }
                }else {
                    alert(data.msg);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
    };
    function addRow(node,i){//操作、分类、时间、发布人、标题、摘要
        var str = "<tr tid='"+node.F_TID+"' cid='"+node.F_ID+"'>\n"
        +"<td class=\"am-text-middle\">";
        if(node.F_ZYBM=="<%=f_zybm%>"){
            str+="<a href=\"#\" class=\"redlink\" onclick=\"UpdatePage("+i+")\">编辑</a>"
                +"<a href=\"#\" class=\"redlink\" onclick=\"deletePage(this)\">删除</a>";
        }
        str += "<a href=\"#\" class=\"redlink\" onclick=\"showPage("+i+")\">查看</a>";
        str+="</td><td class=\"am-text-middle\">"+node.F_NAME+"</td>\n"
        +"<td class=\"am-text-middle\">"+node.F_TIME+"</td>\n"
        +"<td class=\"am-text-middle\">"+node.F_ZYMC+"</td>\n"
        +"<td class=\"am-text-middle\">"+(node.F_TOP=="1"?"是":"否")+"</td>\n"
        +"<td class=\"am-text-middle\">"+node.F_HEAD+"</td>\n"
        +"<td class=\"am-text-middle\">"+node.F_MAST+"</td>\n</tr>";
        return str;
    }
    function closenewNewsdiv(){
        $('#newNewsdiv').modal('close');
    }
    function  showPage(index) {
        var node=loadJson[index];
         window.open("/message/detail?tid="+node.F_TID,"detail");
    }
    var tid = null;
    function UpdatePage(index) {
        var node=loadJson[index];
        tid = node.F_TID;

        $('#files').html('');
        loadannex(tid);
        var id=node.F_ID;
        $('#f_id').find('option').each(function () {
            $(this).attr('selected', $(this).val()==id);
            $(this).selected = $(this).val()==id;
        });
        $('#f_id').trigger('changed.selected.amui');
        $("#f_name").val(node.F_NAME);
        $("#f_head").val(node.F_HEAD);
        $("#f_mast").val(node.F_MAST);
        $("#f_top").val(node.F_TOP).prop('checked',node.F_TOP=="1");
        $("#f_time").val(node.F_TIME);
        $.ajax({url: "/message/querynews",type: "post",async: false,data:{f_tid:tid,time:new Date().getTime()},
            success: function (data) {
                data = JSON.parse(data)
                if(data.states=="0") {
                    var dataJson = JSON.parse(data.result);
                    if (dataJson.length > 0) {
                        for (var i = 0; i < dataJson.length; i++) {
                            ue.setContent(dataJson[i].F_BODY);
                        }
                    }
                }else {
                    alert(data.msg);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $("#savaBtn").button('reset');
            }
        });
        //ue.setContent(node.F_BODY);
        $('#newNewsdiv').modal({
            closeViaDimmer: false,
            width:590,
            height:550
        });
        $('#newsbt').text('修改');
        $('#newNewsdiv').modal('open');
        //$('.am-dimmer').css("z-index","1111");
        //$('#updateMddiv').css("z-index","1119");
    }

    function deletePage(obj) {
        var tr=$(obj).parent().parent();
        var f_tid = tr.attr('tid');
        $.ajax({
            url: "/message/delnews",type: "post",async: false,
            data: { f_tid, timeer: new Date() },
            success: function (data, textStatus) {
                data = JSON.parse(data)
                if(data.states=="0"){
                    alert('删除成功!');
                    tr.remove();
                } else alert(data.msg);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
                $subbtn.button('reset');
            }
        });
    }

    function getannex() {
        var jarr=[],json=null;
        var spans=$('#files').find("span");
        var item=null;
        for(var i=0,s=spans.length;i<s;i++){
            item=spans.eq(i);
            jarr.push({f_size:item.attr('size'),f_name:item.attr('name'),f_path:item.attr('path')});
        }
        return jarr;
    }
    var ue=null;
    $(function(){
        //window.UEDITOR_HOME_URL = "/ueditor/"
        //全部图标就去掉toolbars
        ue = UE.getEditor('ucontainer',{toolbars: [[
                'fullscreen', 'source', '|', 'undo', 'redo', '|',
                'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
                'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
                 'fontfamily', 'fontsize', '|',
                'directionalityltr', 'directionalityrtl', 'indent', '|',
                'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
                'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
                 'emotion', 'scrawl',  'attachment',  'insertframe', 'insertcode', 'pagebreak',  'background', '|',
                'horizontal', 'spechars',  '|',
                'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|',
                ]],wordCount:false,elementPathEnabled:false,initialFrameHeight:500});
        //对编辑器的操作最好在编辑器ready之后再做
        /*ue.ready(function(){
            //设置编辑器的内容
            ue.setContent('hello');
            //获取html内容，返回: <p>hello</p>
            var html = ue.getContent();
            //获取纯文本内容，返回: hello
            var txt = ue.getContentTxt();
        });*/
        $('#f_ksrq').datepicker().
        on('changeDate.datepicker.amui', function(event) {
            $('#f_ksrqDate').text($('#f_ksrq').data('date'));
            $(this).datepicker('close');
        });

        $('#f_jsrq').datepicker().
        on('changeDate.datepicker.amui', function(event) {
            $('#f_jsrqDate').text($('#f_jsrq').data('date'));
            $(this).datepicker('close');
        });
        loadtype();
        loadNews("");
        //显示新增
        $('#addNews').click(function () {
            $("#f_name").val("");
            $("#f_head").val("");
            $("#f_mast").val("");
            $("#f_top").val("").prop('checked',false);
            $("#f_time").val("");
            $('#files').html("");
            $('#newsbt').text('新增');
            ue.setContent('');
            $('#files').html('');
            tid = null;
            $('#newNewsdiv').modal({
                closeViaDimmer: false,
                width:590,
                height:550
            });

            $('#newNewsdiv').modal('open');
            //$('.am-dimmer').css("z-index","1111");
            //$('#newNewsdiv').css("z-index","1119");
        });
        //关闭还原遮罩蒙板z-index
        /*$('#newNewsdiv').on('closed.modal.amui', function() {
            $('.am-dimmer').css("z-index","1100");
        });*/
        //增加提交
        $('#addNewsform').validator({
            H5validation: false,
            submit: function () {
                var formValidity = this.isFormValid();
                if (formValidity) {
                    try {
                        var $subbtn = $("#addNewsbtn");
                        $subbtn.button('loading');
                        var f_id = $("#f_id").val();
                        var f_head = $("#f_head").val();
                        var f_mast = $("#f_mast").val();
                        var f_zybm="<%=f_zybm%>";
                        var annex=getannex();//f_head,f_mast,f_body,f_id,f_zybm,f_top
                        var f_body=ue.getContent();
                        var f_top=$('#f_top')[0].checked?"1":"0";
                        var info={f_id,f_head,f_mast,f_top,f_body,f_zybm};
                        if(tid!=null)info.f_tid=tid;
                        var datas={info:JSON.stringify(info),annex:JSON.stringify(annex),time:new Date().getTime()};
                        setTimeout(function () {
                            $.ajax({url: "/message/setnews",type: "post",async: false,data: datas,
                                success: function (data, textStatus) {
                                    data = JSON.parse(data)
                                    if(data.states=="0"){
                                        alert("保存成功！");
                                    }
                                    $subbtn.button('reset');
                                    $('#newNewsdiv').modal('close');
                                    loadNews("");
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
                }
                //阻止原生form提交
                return false;
            }
        });
    });

</script>
</body>
</html>