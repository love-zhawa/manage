<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<title>装备中心协同办公系统</title>
	<link href="<%=request.getContextPath()%>/css/zxstyle.css" rel="stylesheet" />
</head>
<body class="bgbj">
	<div class="top">
	    <ul class="logocon clear"  style="background: url(<%=request.getContextPath()%>/images/bg.jpg) no-repeat 0 -1000px;">
	        <li class="top_logo" style="line-hight:73px;">
	        	<img src="../images/newtop.png" style="margin-left:5%;margin-top: -2%;">
	        </li>
	    <div style="float:right">
	        <li class="top_logo" style="margin-top: 7px;width: 66%;">
		      
<iframe src="//www.seniverse.com/weather/weather.aspx?uid=U6AF9A0935&cid=CHBJ000000&l=zh-CHS&p=SMART&a=0&u=C&s=31&m=0&x=1&d=2&fc=FFFFFF&bgc=&bc=&ti=0&in=0&li=" frameborder="0" scrolling="no" width="530" height="90" allowTransparency="true"></iframe>
            </li>
	    
			<li class="top_button clear">
	        	<p class="topuser"><a href="javascript:modifyPwd(0);" onclick="modifyPwd();"></a></p>
	        	<p>
            		<span class="toppass">${sessionScope.user.name }</span>
            		<a class="topexit" href="javascript:void(0);" onclick="logout();">安全退出</a>
            	</p>
	        </li>
	        </div>   
	    </ul>
	</div>
	<script type="text/javascript">
		function logout(){
			if (confirm("确认退出？")) {
				window.location.href = '<%=request.getContextPath()%>';
			}
		}
		
		function modifyPwd(){
			window.parent.mainFrame.location.href = '<%=request.getContextPath()%>/user/pass';
		}
	</script>
</body>
</html>