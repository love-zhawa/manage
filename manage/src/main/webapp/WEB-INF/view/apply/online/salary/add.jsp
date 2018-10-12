<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<base href="<%=request.getContextPath() %>/">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>调薪申请</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
<style>
h1 {text-align: center;margin-bottom: 20px;}
.table1 {width: 700px;border-collapse: collapse}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 th,.table1 td {border: 1px solid #333;}
.input{border: 0px;}
</style>
</head>
<body>
  	<h1 class="title">调薪申请表</h1>
		<form action="apply/online/salary/add" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
			<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1">
			<tr>
	          <th width="120">所属部门</th>
	          <td width="130"><input type="text" class="input" id="dept" name="dept" value=""/></td>
	          <th width="90">姓名</th>
	          <td width="130"><input type="text" class="input" name="userName" id="userName" value=""/></td>
	        </tr>
	        <tr>
	          <th width="90">学历/位</th>
	          <td width="130"><input type="text" class="input" name="education" id="education" value=""/></td>
	          <th>职称</th>
	          <td><input type="text" class="input" name="titleName" value=""/></td>
	        </tr>
	        <tr>
	          <th>入中心时间</th>
	          <td><input type="text" class="input" id="centerTime" name="centerTime" value="" autocomplete="off"/></td>
	          <th>编制</th>
	          <td><input type="text" class="input" name="organization" value=""/></td>
	        </tr>
	        <tr>
	          <th>现岗位津贴</th>
	          <td><input type="text" class="input" name="beforeAmount" value=""/></td>
	          <th>调整后岗贴</th>
	          <td><input type="text" class="input" name="afterAmount" value=""/></td>
	        </tr>
	        <tr>
	          <th>月工资</th>
	          <td><input type="text" class="input" name="beforeWages" value=""/></td>
	          <th>调整后月工资</th>
	          <td><input type="text" class="input" name="afterWages" value=""/></td>
	        </tr>
	        <tr>
	          <th>申请日期</th>
	          <td><input type="text" class="input" id="applyTime" name="applyTime" value="" autocomplete="off"/></td>
	          <th>变动日期</th>
	          <td><input type="text" class="input" id="changeTime" name="changeTime"  value="" autocomplete="off"/></td>
	        </tr>
	      </table>
	        <div class="field">
	          <button class="button bg-main icon-check-square-o" type="button" onClick="userSub();" style="margin-top:9px;margin-left:800px;"> 提交</button>
	        </div>
	  </form>
     <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>
</body>
	<script type="text/javascript">
	laydate.render({
	    elem: '#centerTime',
	    event: 'focus' 
	});
 	laydate.render({
	    elem: '#applyTime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#changeTime',
	    event: 'focus' 
	});
	function userSub(){
		if(confirm("确认提交吗？")){
			$("#form-article-add").submit();
		}
	}
	
	function back (){
		window.location.href="apply/online/salary/list";
	}
	</script>
</html