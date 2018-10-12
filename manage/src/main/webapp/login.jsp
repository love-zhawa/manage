<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>装备中心协同办公系统</title>
	<!-- Meta tag Keywords -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="UTF-8" />
	<meta name="keywords" content="Video Login Form Responsive Widget,Login form widgets, Sign up Web forms , Login signup Responsive web form,Flat Pricing table,Flat Drop downs,Registration Forms,News letter Forms,Elements"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-2.2.3.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.vide.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
	<script>
		addEventListener("load", function () {
			setTimeout(hideURLbar, 0);
		}, false);

		function hideURLbar() {
			window.scrollTo(0, 1);
		}
	</script>
	<!-- Meta tag Keywords -->
	<!-- css files -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css" type="text/css" media="all" />
	<!-- Style-CSS -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/fontawesome-all.css">
	<!-- Font-Awesome-Icons-CSS -->
	<!-- //css files -->
	<!-- web-fonts -->
	<link href="//fonts.googleapis.com/css?family=Marck+Script&amp;subset=cyrillic,latin-ext" rel="stylesheet">
	<link href="//fonts.googleapis.com/css?family=Montserrat:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&amp;subset=cyrillic,latin-ext"
	    rel="stylesheet">
	<!-- //web-fonts -->
	
</head>

<body onkeydown="formkeydown();">
	<div class="video-w3l" data-vide-bg="video/1">
		<!-- title -->
		<h1 style="padding-top: 6vw;">
			<!-- <span>N</span>ercita
			<span>L</span>ogin
			<span>F</span>orm -->
			<img src="<%=request.getContextPath()%>/images/newlogin.png">
			</h1>
		<!-- //title -->
		<!-- content -->
		<div class="sub-main-w3">
			<form id="loginForm" action="<%=request.getContextPath()%>/checklogin" method="post">
				<div class="form-style-agile">
					<label>
						<i class="fas fa-user"></i>用户名</label>
					<input name="username" type="text" id="username">
				</div>
				<div class="form-style-agile">
					<label>
						<i class="fas fa-unlock-alt"></i>密码</label>
					<input name="password" type="password" id="password">
				</div>
				<!-- //switch -->
				<input type="button" value="确 定" onclick="login();">
			</form>
		</div>
		<!-- //content -->

		<!-- copyright -->
		<div class="footer">
			<p>版权所有：Copyright © 2018 国家农业智能装备工程技术研究中心
			</p>
		</div>
		<!-- //copyright -->
	</div>
<script type="text/javascript">
		if (window != top){     
        	top.location.href = location.href;
    	}
	
		$(document).ready(function(){
			$("#username").focus();
		});	
	
		function login() {
			var username = $("#username").val();
			var password = $("#password").val();
			
			if ($.trim(username).length <= 0) {
				alert("登录帐号不能为空！");
				return;
			}
			if ($.trim(password).length <= 0) {
				alert("登录密码不能为空！");
				return;
			}
			
			$.post("login",{userName : username, password:password},function(info){
          		if(info.code == 'success'){
  					window.location.href = "index";
  				} else {
  					alert(info.desc);
  				}
          	});
		}
		function checkLength(pwd) {
			if(pwd.length< 6 || pwd.length>12) {
				return false;
			} else {
				return true;
			}
		}
		
		function formkeydown(){
			if(window.event){
				if (window.event.keyCode == 13){
					$("#submitForm").click();
				}	
			} else {
				var event = arguments.callee.caller.arguments[0];
				if (event.keyCode == 13){
					$("#submitForm").click();
				}
			}
		}
	</script>
	     <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>
</body>
</html>