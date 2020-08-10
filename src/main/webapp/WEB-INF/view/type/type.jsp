<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>地区列表</title>
</head>

<%--bootstrap--%>
<link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<%--引入ztree--%>
<link rel="stylesheet" href="/js/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<body>
<!-- 导航栏 -->



<%--展示模块--%>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-primary">
                <div class="panel-heading">分类展示</div>
                    <div class="panel-body">
                        <button type="button" class="btn btn-success" onclick="addNodes();"><i class="glyphicon glyphicon-plus"></i> 增加</button>
                        <button type="button" class="btn btn-danger" onclick="deleteNodes();"><i class="glyphicon glyphicon-trash"></i> 删除</button>
                        <button type="reset"  class="btn btn-warning"  onclick="updateNodes();"><i class="glyphicon glyphicon-pencil"></i>修改</button>
                        <ul id="ztreeDemo" class="ztree"></ul>
                    </div>
            </div>
        </div>
    </div>
</div>
<%--新增模板--%>
<div id="addTypeDiv" style="display: none">
    <form  class="form-horizontal" role="form">
        <div class="form-group">
            <label class="col-sm-2 control-label">分类名称:</label>
            <div class="col-sm-10">
                <input class="form-control" id="addName" type="text">
            </div>
        </div>
    </form>
</div>
<%--修改模板--%>
<div id="updateTypeDiv" style="display: none">
    <form  class="form-horizontal" role="form">
        <div class="form-group">
            <label class="col-sm-2 control-label">分类名称:</label>
            <div class="col-sm-10">
                <input class="form-control" id="updateName" type="text">
            </div>
        </div>
    </form>
</div>
<%--引入jquery--%>
<script src="/bootstrap/js/jquery-3.3.1.min.js "></script>
<%--bootstrap--%>
<script src="/bootstrap/js/bootstrap.min.js"></script>
<%--引入ztree--%>
<script type="text/javascript" src="/js/zTree/js/jquery.ztree.core.js"></script>
<%--bootbox的JS--%>
<script src="/bootstrap/js/bootbox.min.js"></script>
<script>
    //初始化
    $(function () {
        initZtree();
        addTypeDivHtml=$("#addTypeDiv").html();
        updateTypeDivHtml=$("#updateTypeDiv").html();
    })
    //新增的div备份
    var  addTypeDivHtml;
    //修改的div备份
    var  updateTypeDivHtml;

    var setting = {
        data: {
            simpleData: {
                enable: true,
                pIdKey:"pid"
            }
        },
        //设置ztree是否处于编辑状态
        edit:{
            enable:true,
            showRemoveBtn:false,//设置是否显示删除按钮
            showRenameBtn:false //设置是否显示编辑名称按钮
        },view:{
            selectedMulti:true //设置是否允许同时选中多个节点
        }
    };
    //初始化树列表
    function initZtree(){
        $.ajax({
            url:"/type/queryTypeList.jhtml",
            type:"post",
            dataType:"json",
            success:function (result) {
                if(result.code==200){
                    $.fn.zTree.init($("#ztreeDemo"), setting, result.data);
                }
            },error:function () {
                alert("初始化ztree失败");
            }
        });
    }
    //增加节点
    function addNodes() {
        var treeObj = $.fn.zTree.getZTreeObj("ztreeDemo");
        var nodes = treeObj.getSelectedNodes();
        if(nodes.length>1){
            bootbox.alert({
                buttons: {
                    ok: {
                        label: '确定',
                        className: 'btn-success'
                    }
                },
                message: '只能选择一个',
                title: "提示信息",
            });
        } else if(nodes.length==0){
            bootbox.alert({
                buttons: {
                    ok: {
                        label: '确定',
                        className: 'btn-success'
                    }
                },
                message: '至少选择一个',
                title: "提示信息",
            });
        }else{
            var addNodesBox=bootbox.dialog({
                title:"新增信息",
                message:$("#addTypeDiv form"),
                size:"large",
                buttons:{
                    cancel:{
                        label: "取消",
                        className: 'btn-danger',
                    },
                    ok:{
                        label: "提交",
                        className: 'btn-info',
                        callback: function(){
                            var v_pid=nodes[0].id;
                            var v_name=$("#addName",addNodesBox).val();
                            $.ajax({
                                url:"/type/addType.jhtml",
                                data:{"name":v_name,"pid":v_pid},
                                type:"post",
                                dataType:"json",
                                success:function (result) {
                                    if(result.code==200){
                                        var newNodes = {id:result.data,name:v_name,pid:v_pid};
                                        newNodes = treeObj.addNodes(nodes[0], newNodes);
                                    }
                                },error:function () {
                                    alert("增加失败");
                                }
                            });
                        }
                    }
                }
            });
            $("#addTypeDiv").html(addTypeDivHtml);
        }

    }
    //删除节点
    function deleteNodes() {
          var treeObj = $.fn.zTree.getZTreeObj("ztreeDemo");
          var nodes = treeObj.getSelectedNodes();
          var arr = treeObj.transformToArray(nodes);
          var ids=[];
          for (var i = 0; i <arr.length ; i++) {
              ids.push(arr[i].id);
          }
          //console.log(ids);
          $.ajax({
              url:"/type/deleteNodes.jhtml",
              data:{"ids":ids},
              dataType:"json",
              type:"post",
              success:function (result) {
                  if(result.code==200){
                      for (var i=0, l=nodes.length; i < l; i++) {
                          treeObj.removeNode(nodes[i]);
                      }
                  }
              },error(){
                  alert("删除失败");
              }
          });
      }
      //修改节点
      function updateNodes() {
            var treeObj = $.fn.zTree.getZTreeObj("ztreeDemo");
            var nodes = treeObj.getSelectedNodes();
            if(nodes.length>1){
                bootbox.alert({
                    buttons: {
                        ok: {
                            label: '确定',
                            className: 'btn-success'
                        }
                    },
                    message: '只能选择一个',
                    title: "提示信息",
                });
            } else if(nodes.length==0){
                bootbox.alert({
                    buttons: {
                        ok: {
                            label: '确定',
                            className: 'btn-success'
                        }
                    },
                    message: '至少选择一个',
                    title: "提示信息",
                });
            }else{
                var v_id = nodes[0].id;
                $.ajax({
                    url:"/type/findType.jhtml",
                    data:{"id":v_id},
                    dataType:"json",
                    type:"post",
                    success:function (result) {
                        var v_data=result.data;
                        //console.log(result.data);
                        if(result.code==200){
                            $("#updateName",updateNodesBox).val(v_data.name);
                        }
                    },error(){
                        alert("回显失败");
                    }
                });
                var updateNodesBox=bootbox.dialog({
                    title:"修改信息",
                    message:$("#updateTypeDiv form"),
                    size:"large",
                    buttons:{
                        cancel:{
                            label: "取消",
                            className: 'btn-danger',
                        },
                        ok:{
                            label: "提交",
                            className: 'btn-info',
                            callback: function(){
                                var v_name=$("#updateName",updateNodesBox).val();
                                $.ajax({
                                    url:"/type/update.jhtml",
                                    data:{"id":v_id,"name":v_name},
                                    dataType:"json",
                                    type:"post",
                                    success:function (result) {
                                        if(result.code==200){
                                            nodes[0].name = v_name;
                                            treeObj.updateNode(nodes[0]);
                                        }
                                    },error(){
                                        alert("回显失败");
                                    }
                                });
                            }
                        }
                    }
                });
            $("#updateTypeDiv").html(updateTypeDivHtml);
            }
        }
</script>
</body>

</html>
