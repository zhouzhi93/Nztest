
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String title = "信息类别维护";
%>
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
            max-width:100%;
        }
        label{
            font-weight: 500;
            font-size:1.4rem;
        }
        .am-popup{
            z-index: 1200;
        }
        #detail-div{display: none;}
    </style>
</head>
<body>
<div class="am-g">
    <div class="am-container">
        <div class="am-text-left" style="padding-left: 0;padding-right: 0;">
            <div class="am-dropdown" data-am-dropdown>
                <button id="zjul" class="am-btn am-btn-primary am-btn-xs am-radius am-dropdown-toggle" data-am-dropdown-toggle>增加<span class="am-icon-caret-down"></span></button>
                <ul class="am-dropdown-content am-btn-xs">
                    <li onclick="showdetail(0)" ><a href="#">增加同级</a></li>
                    <li onclick="showdetail(1)"><a href="#">增加子级</a></li>
                </ul>
            </div>
            <button type="button" class="am-btn am-btn-primary am-btn-xs am-radius" onclick="showdetail(2)">修改</button>
            <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" onclick="deletetype()">删除</button>
        </div>
    </div>
    <div class="am-container">
        <ul class="am-tree" id="firstTree">
            <li class="am-tree-branch am-hide" data-template="treebranch">
                <div class="am-tree-branch-header">
                    <button class="am-tree-branch-name">
                        <span class="am-tree-icon am-tree-icon-folder"></span>
                        <span class="am-tree-label"></span>
                    </button>
                </div>
                <ul class="am-tree-branch-children"></ul>
                <div class="am-tree-loader"><span class="am-icon-spin am-icon-spinner"></span></div>
            </li>
            <li class="am-tree-item am-hide" data-template="treeitem">
                <button class="am-tree-item-name">
                    <span class="am-tree-icon am-tree-icon-item"></span>
                    <span class="am-tree-label"></span>
                </button>
            </li>
        </ul>
    </div>
    <div class="am-modal" tabindex="-1" id="detail-div">
        <div class="am-modal-dialog">
            <div class="am-modal-hd" id="detailbt">
                <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
            </div>
            <div class="am-modal-bd">
                <form class="am-form am-form-horizontal">
                    <div class="am-form-group">
                        <label for="f_sid" class="am-u-sm-3 am-form-label">上级</label>
                        <div class="am-u-sm-9">
                            <input type="text" disabled="disabled" class="am-form-field am-input-sm am-radius" id="f_sid" required placeholder="上级">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                        <label for="f_name" class="am-u-sm-3 am-form-label">名称</label>
                        <div class="am-u-sm-9">
                            <input type="text" class="am-form-field am-input-sm am-radius" id="f_name" required placeholder="名称">
                        </div>
                        <div class="am-u-sm-end"></div>
                    </div>
                    <div class="am-form-group">
                      <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius" data-am-modal-confirm>保存</button>
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
<script src="/tree/amazeui.tree.js"></script>
<script src="/tree/amazeui.tree.min.js"></script>
<script type="text/javascript">
    var curnode = null,sid = null,cid = null;
    function showdetail(k){
        console.log(curnode,k)
        if (curnode == null){
            sid = '0';
        } else sid=null;
        $('#f_name').val('');
        cid='';
        if(k==1){//下级
            if(sid ==null)sid = curnode.id;
            $('#f_sid').val(sid ==null?curnode.title:"");
            $('#detailbt').text('新增下级');
        }else if(k==0){//同级
            $('#f_sid').val(sid ==null?curnode.pname:"");
            $('#detailbt').text('新增同级');
        } else if(k==2){//修改
            $('#f_sid').val(curnode.pname);
            $('#f_name').val(curnode.title);
            cid = curnode.id;
            $('#detailbt').text('修改');
        }
        $('#detail-div').modal({relatedTarget:this,onConfirm:function(options){save()},closeOnConfirm:true});
    }
    function save(){
        var name=$('#f_name').val();
        if(name==''){
            alert('请输入名称!');
            $('#f_name').focus();
            return false;
        }
        var data={f_sid:(sid==null?"0":sid),f_name:name,timeer: new Date() };
        if(cid!=null&&cid!='')data.f_id=cid;
        $.ajax({url: "/message/settype",type: "post",async: false,data: data,
            success: function (data) {
                data = JSON.parse(data)
                if(data.states=="0"){
                    //$('#detail-div').modal('close');$('#firstTree').tree("destroy");
                    //loadtype();
                    location.reload();
                }
                else alert(data.msg);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }
    function deletetype(){
        if(typeof curnode=='undefined' || curnode==null) {
            alert('请选择要删除的节点!');
            return false;
        } else if(curnode.products!=null) {
            alert('只能删除末级节点!');
            return false;
        }
        if(!confirm('请确定要删除当前节点"'+curnode.title+'"?')){
            return false;
        }

        $.ajax({url: "/message/deletetype",type: "post",async: false,data: {f_id:curnode.id,timeer: new Date() },
            success: function (data) {
                data = JSON.parse(data)
                if(data.states=="0"){
                    alert('删除成功!');//$('#firstTree').tree("destroy");loadtype();
                    location.reload();
                }
                else alert(data.msg);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }

    function chooseme(data){
        //data.target.id;
        curnode = data.target||data;
        console.log(curnode)
    }
    $(function(){
        loadtype();
        var obj=$('#firstTree');
        obj.on('selected.tree.amui', function (event, data) {chooseme(data);});
        obj.on('deselected.tree.amui', function (event, data) {chooseme(data);});
        obj.on('disclosedFolder.tree.amui', function (event, data) {chooseme(data);});
        obj.on('closed.tree.amui', function (event, data) {chooseme(data);});
    });

    function loadtype(){
        $.ajax({url: "/message/querytype",type: "post",async: false,data: {timeer: new Date() },
            success: function (data) {
                data = JSON.parse(data)
                if(data.states=="0"){
                    ontree(data.result);
                }
                else alert(data.msg);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown + "||" + textStatus);
            }
        });
    }
    function ontree(types) {
        $('#firstTree').tree({
            dataSource: function(options, callback) {// 模拟异步加载
                setTimeout(function() {
                    var json = toTree(JSON.parse(types),"0","无",1);
                    callback({data: options.products || json});
                }, 400);
            },
            multiSelect: false,
            cacheItems: false,
            folderSelect: false
        });
    }
    function toTree(jarr,pid,pname,jb) {
        var narr=[],json=null;
        jarr.forEach(item => {
            if(item.F_SID==pid) {
                json = {pid,pname,id:item.F_ID,title:item.F_NAME,jb:jb,type:item.F_MJ=="0"?"folder":"item"};
                if(item.F_MJ=="0")json.products = toTree(jarr,item.F_ID,item.F_NAME,jb+1);
                narr.push(json);
            }
        })
        return narr;
    }

</script>
</body>
</html>
