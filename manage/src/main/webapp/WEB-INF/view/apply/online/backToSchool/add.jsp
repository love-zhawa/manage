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
    <title>返校申请</title>  
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
	<h1 class="title">信息中心学生返校申请表</h1>
		<form action="apply/online/backToSchool/add" method="post" class="form-x" id="form-article-add" >
			<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1">
			<tr style="height: 40px;">
	          <th width="150">申请人</th>
	          <td style="padding-top: 13px;">${username }</td>
	           <th width="150">所属小组</th>
	          <td width="150">${groupname }</td>
	        </tr>
			<tr>
	          <th>申请日期</th>
	          <td><input type="text" class="input" id="applyTime" name="applyTime" value="" autocomplete="off"/></td>
	          <th>性别</th>
	          <td>
	          	<label><input name="gender" type="radio" checked="checked" class="ace" value="0"><span class="lbl">男</span></label>&nbsp;&nbsp;
          		<label><input name="gender" type="radio" class="ace" value="1"><span class="lbl">女</span></label>
	          </td>
	        </tr>
	        <tr>
	          <th>就读学校</th>
	          <td><input type="text" class="input" id="school" name="school"/></td>
	          <th>入学时间</th>
	          <td><input type="text" class="input" id="entranceTime" name="entranceTime" autocomplete="off"/></td>
	        </tr>
	        <tr>
	          <th>入中心时间</th>
	          <td><input type="text" class="input" id="centerTime" name="centerTime" autocomplete="off"/></td>
	          <th>培养方式</th>
	          <td><input type="text" class="input" id="cultivationMode" name="cultivationMode"  /></td>
	        </tr>
	        <tr>
	          <th>导师姓名</th>
	          <td><input type="text" class="input" id="tutor" name="tutor"  autocomplete="off"/></td>
	          <th>拟离开中心时间</th>
	          <td><input type="text" class="input" id="leaveTime" name="leaveTime" autocomplete="off"/></td>
	        </tr>
	        <tr>
	          <th>原由</th>
	          <td colspan="3"><input type="text" class="input" id="reason" name="reason"  /></td>
	        </tr>
	      </table>
	      <div class="field">
          <button class="button bg-main icon-check-square-o" type="button" onClick="userSub();" style="margin-top:9px;margin-left:800px;"> 提交</button>
        </div>
	  </form>
     
 <script type="text/javascript">
	laydate.render({
	    elem: '#applyTime',
	    event: 'focus' 
	});
 	laydate.render({
	    elem: '#entranceTime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#centerTime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#leaveTime',
	    event: 'focus' 
	});
	function userSub(){
		if(confirm("确认提交吗？")){
			$("#form-article-add").submit();
		}
	}
	
	function back (){
		window.location.href="apply/online/backToSchool/list";
	}
	</script>
	 <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>
	</body>
</html>