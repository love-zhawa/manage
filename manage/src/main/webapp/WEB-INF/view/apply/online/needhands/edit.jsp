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
    <title>中心用人申请</title>  
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
		<h1 class="title">中心用人申请表</h1>
		<form action="apply/online/needhands/edit" method="post" class="form-x" id="form-article-add" >
		<input type="hidden" name="id" value="${needhands.id }"/>
			<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1">
			<tr>
	          <th width="90">用人部门</th>
	          <td colspan="4"><input type="text" class="input" name="dept" value="${needhands.dept}"/></td>
	          <th width="110">申请日期</th>
	          <td><input type="text" class="input" id="applyDate" name="applyDate" value="${needhands.applyDate }" autocomplete="off"/></td>
	        </tr>
	        <tr>
	          <th style="height:40px;">聘用岗位</th>
	          <td colspan="6" style="padding-top: 18px;">
	          	 <label><input name="post" type="radio" <c:if test="${needhands.post == 1}">checked="checked" </c:if> class="ace" value="1"><span class="lbl">科研</span></label>&nbsp;&nbsp;
	           	 <label><input name="post" type="radio" <c:if test="${needhands.post == 2}">checked="checked" </c:if> class="ace" value="2"><span class="lbl">管理</span></label>
	           	 <label><input name="post" type="radio" <c:if test="${needhands.post == 3}">checked="checked" </c:if> class="ace" value="3"><span class="lbl">技术开发</span></label>&nbsp;&nbsp;
	           	 <label><input name="post" type="radio" <c:if test="${needhands.post == 4}">checked="checked" </c:if> class="ace" value="4"><span class="lbl">科研辅助</span></label>
	          </td>
	        </tr>
	        <tr>
	          <th style="height:40px;">聘用方式</th>
	          <td colspan="6" style="padding-top: 18px;">
	          	<label><input name="employType" type="radio" <c:if test="${needhands.employType == 1}">checked="checked" </c:if> class="ace" value="1"><span class="lbl">事业</span></label>&nbsp;&nbsp;
	           	<label><input name="employType" type="radio" <c:if test="${needhands.employType == 2}">checked="checked" </c:if> class="ace" value="2"><span class="lbl">企业(派得/农芯)</span></label>
	           	<label><input name="employType" type="radio" <c:if test="${needhands.employType == 3}">checked="checked" </c:if> class="ace" value="3"><span class="lbl">合同</span></label>&nbsp;&nbsp;
	           	<label><input name="employType" type="radio" <c:if test="${needhands.employType == 4}">checked="checked" </c:if> class="ace" value="4"><span class="lbl">博士后</span></label>
	          </td>
	        </tr>
	        <tr>
	          <th>拟聘人姓名</th>
	          <td colspan="2"><input type="text" class="input" name="userName" value="${needhands.userName }"/></td>
	          <th width="45">性别</th>
	          <td width="90">
	          	<label><input name="gender" <c:if test="${needhands.gender == 0}">checked="checked" </c:if> type="radio" checked="checked" class="ace" value="0"><span class="lbl">男</span></label>&nbsp;&nbsp;
           		<label><input name="gender" <c:if test="${needhands.gender == 1}">checked="checked" </c:if> type="radio" class="ace" value="1"><span class="lbl">女</span></label>
	          </td>
	          <th>年龄</th>
	          <td><input type="text" class="input" id="age" name="age" value="${needhands.age }"/></td>
	        </tr>
	        <tr>
	          <th>拟聘人学历</th>
	          <td colspan="2" width="90"><input type="text" class="input" id="education" name="education" value="${needhands.education }" /></td>
	          <th width="90">入职日期</th>
	          <td colspan="3"><input type="text" class="input" id="joinDate" name="joinDate" value="${needhands.joinDate }" autocomplete="off"/></td>
	        </tr>
	        <tr>
	           <th>合同期限</th>
	           <td colspan="2"><input type="text" class="input" id="termAmount" name="termAmount" value="${needhands.termAmount }" /></td>
	           <th>试用期期限</th>
	          <td colspan="3"><input type="text" class="input" id="trialAmount" name="trialAmount" value="${needhands.trialAmount }" /></td>
	        </tr>
	        <tr>
	          <th>岗位津贴</th>
	          <td colspan="2"><input type="text" class="input" id="amount" name="amount"  value="${needhands.amount }"/></td>
	          <th>试用期岗位津贴</th>
	          <td colspan="3"><input type="text" class="input" id="trialAmountSubsidy" name="trialAmountSubsidy"  value="${needhands.trialAmount }"/></td>
	        </tr>
	      </table>
	        <div class="field">
	          <button class="button bg-main icon-check-square-o" type="button" onClick="userSub();" style="margin-top:9px;margin-left:800px;"> 提交</button>
	        </div>
	  </form>
     
 <script type="text/javascript">
	laydate.render({
	    elem: '#applyDate',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#joinDate',
	    event: 'focus' 
	});
	function userSub(){
		if(confirm("确认提交吗？")){
			$("#form-article-add").submit();
		}
	}
	
	function back (){
		window.location.href="apply/online/needhands/list";
	}
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
	</body>
</html>
