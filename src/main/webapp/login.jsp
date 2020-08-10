<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/bootstrap/js/jquery-3.3.1.min.js"></script>
<link href="<%=request.getContextPath()%>/js/Wopop_files/style_log.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/Wopop_files/style.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/Wopop_files/userpanel.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/Wopop_files/jquery.ui.all.css">

</head>
<body  class="login" >
<div class="login_m"  >
<div class="login_logo"><img src="<%=request.getContextPath()%>/js/Wopop_files/xiao.gif" ></div>
<div class="login_boder">

<div class="login_padding" id="login_model" >


 <h1>用户名</h1>
  <label>
    <input type="text" id="username" class="txt_input txt_input2"  value="qwe">
  </label>
  <h1>密码</h1>
  <label>
    <input type="password" name="textfield2" id="password" class="txt_input" value="qwe">
  </label>


  <div class="rem_sub">
  
    <label>
      <input type="button" class="sub_button" onclick="login()" name="button" id="button" value="登录" style="opacity: 0.7;">
    </label>
  </div>
</div>
</div>


</div>









	<%-- <center>
	<form action="">
			用户名：<input type="text" id="username" value="qwe"/><br/>
			密码：<input type="password" id="password" value="qwe"><br>
			验证码：<input type="text" id="checkCode" >
			<img id="checkCodeImg" style="height:21.09px;" onclick="changeCheckCode()" src="<%=request.getContextPath()%>/CheckCodeServlet" /><br/>
			<input type="button" value="登录" onclick="login()"/>
	</form>
	</center> --%>
</body>
<script type="text/javascript">

	function login(){
		var username=$("#username").val().trim();
		var password=$("#password").val().trim();
			$.ajax({
				url:"<%=request.getContextPath()%>/user/login.jhtml",
				type:"post",
				data:{
					"userName":username,
					"password":password,

				},
				dataType:"json",
				success:function(result){
					if (result.code==200) {
					    location.href="/product/index.jhtml";
                    }else {
					    alert(result.msg)
                    }
					
				},
			});
			

		
	}
</script>
</html>