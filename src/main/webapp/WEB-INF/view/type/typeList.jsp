<%--
  Created by IntelliJ IDEA.
  User: hello
  Date: 2019/12/27
  Time: 13:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>text</title>
    <link rel="stylesheet" href="/bootstrap/css/bootstrap.min.css">
    <%--  <link rel="icon" href="/common/shop/assets/img/favicon.ico">
      <link rel="stylesheet" type="text/css" href="/common/shop/css/webbase.css" />
      <link rel="stylesheet" type="text/css" href="/common/shop/css/pages-JD-index.css" />
      <link rel="stylesheet" type="text/css" href="/common/shop/css/widget-jquery.autocomplete.css" />
      <link rel="stylesheet" type="text/css" href="/common/shop/css/widget-cartPanelView.css" />--%>



</head>








<body>

<div id="nav-bottom">
    <!--顶部-->
    <div class="nav-top">
        <!--头部-->
        <div class="header">
            <div class="py-container">
                <div class="yui3-g NavList">
                    <div class="yui3-u Left all-sort">
                        <h4>全部商品分类</h4>
                    </div>
                    <div class="yui3-u Center navArea">
                        <button type="button" class="btn btn-success" onclick="toUpdateType();"><i class="glyphicon glyphicon-plus"></i>操作分类信息</button>
                        <ul class="nav">
                            <li class="f-item"></li>
                            <li class="f-item"></li>
                            <li class="f-item"></li>
                            <li class="f-item"></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--列表-->
<div class="sort">
    <div class="py-container">
        <div class="yui3-g SortList ">
            <div class="yui3-u Left all-sort-list">
                <div class="all-sort-list2" id="dataTypeHtml">

                </div>
            </div>
        </div>
    </div>
</div>

<script src="/bootstrap/js/jquery-3.3.1.min.js"></script>
<script src="/bootstrap/js/bootstrap.min.js"></script>
<%--<script type="text/javascript" src="/common/shop/js/pages/index.js"></script>
<script  src="/common/bootbox/bootbox.min.js"></script>--%>
<script>
    $(function () {
        initTypeList();
    });
    function initCss() {
        $('.all-sort-list2 > .item').hover(function() {
            //父类分类列表容器的高度
            $(this).addClass('hover');
            $(this).children('.item-list').css('display', 'block');
        }, function() {
            $(this).removeClass('hover');
            $(this).children('.item-list').css('display', 'none');
        });
        $('.item > .item-list > .close').click(function() {
            $(this).parent().parent().removeClass('hover');
            $(this).parent().hide();
        });
    }
    var dataList;
    function initTypeList(){
        $.ajax({
            type:"post",
            dataType:"json",
            url:"/type/queryTypeList.jhtml",
            success:function (result) {
                if(result.code==200){
                    dataList=result.data;
                    console.log(dataList);
                    var htmls='';
                    for (var i = 0; i < dataList.length; i++) {
                        if(dataList[i].pid==0){
                            htmls+='<div class="item"><h3><a href="#">'+dataList[i].name+'</a></h3>';
                            htmls+='<div class="item-list clearfix"><div class="subitem">';
                            for (var j = 0; j <dataList.length ; j++) {
                                if(dataList[j].pid==dataList[i].id){
                                    htmls+=' <dl class="fore1"><dt><a href="#">'+dataList[j].name+'</a></dt>';
                                    htmls+='<dd>';
                                    for (var k = 0; k < dataList.length; k++) {
                                        if(dataList[k].pid==dataList[j].id){
                                            htmls+='<em><a href="#"">'+dataList[k].name+'</a></em>';
                                        }
                                    }
                                    htmls+="</dd></dl>";
                                }
                            }
                            htmls+="</div></div>";
                        }
                        htmls+='</div>';
                    }

                    $("#dataTypeHtml").html(htmls);
                    initCss();
                }else {
                    alert(result.message)
                }
            }
        })
    }

    function toUpdateType() {
        location.href='/type/toType.jhtml';
    }
</script>

</body>
</html>
