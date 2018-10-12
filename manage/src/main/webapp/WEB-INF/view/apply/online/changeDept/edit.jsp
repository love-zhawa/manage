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
    <title>人事变动</title>  
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
	<h1 class="title">人事变动表</h1>
	  <form action="apply/online/changeDept/edit" method="post" class="form-x" id="form-article-add" >
	  <input type="hidden" name="id" value="${changeDept.id }"/>
		<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1">
		<tr>
          <th>姓名</th>
          <td><input type="text" class="input" name="userName" value="${changeDept.userName }"/></td>
          <th>入中心日期</th>
          <td><input type="text" class="input" id="centerTime" name="centerTime" value="${changeDept.centerTime }" autocomplete="off"/></td>
        </tr>
        <tr>
          <th>变动前部门</th>
          <td><input type="text" class="input" name="beforeDept" value="${changeDept.beforeDept }"/></td>
          <th>变动后部门</th>
          <td><input type="text" class="input" name="afterDept" value="${changeDept.afterDept }"/></td>
        </tr>
        <tr>
          <th>类别</th>
          <td colspan="3" style="height:40px;padding-top:14px;">
 			<label><input name="changeType" type="radio" <c:if test="${changeDept.changeType == 1 }">checked="checked"</c:if> class="ace" value="1"><span class="lbl">调岗</span></label>&nbsp;&nbsp;
           	<label><input name="changeType" type="radio" <c:if test="${changeDept.changeType == 2 }">checked="checked"</c:if> class="ace" value="2"><span class="lbl">借调</span></label>
           	<label><input name="changeType" type="radio" <c:if test="${changeDept.changeType == 3 }">checked="checked"</c:if> class="ace" value="3"><span class="lbl">调薪</span></label>&nbsp;&nbsp;
           	<label><input name="changeType" type="radio" <c:if test="${changeDept.changeType == 4 }">checked="checked"</c:if> class="ace" value="4"><span class="lbl">其他</span></label>
         </td>
        </tr>
        <tr>
          <th>截止期限</th>
          <td><input type="text" class="input" id="changeEndTime" name="changeEndTime" value="${changeDept.changeEndTime }" autocomplete="off"/></td>
          <th>其他</th>
          <td><input type="text" class="input" name="otherInfo"  value="${changeDept.otherInfo }"/></td>
        </tr>
        <tr>
          <th>变动前津贴</th>
          <td><input type="text" class="input" id="beforeAmount" name="beforeAmount" value="${changeDept.beforeAmount }"/></td>
          <th>变动后津贴</th>
          <td><input type="text" class="input" id="afterAmount" name="afterAmount" value="${changeDept.afterAmount }" /></td>
        </tr>
        <tr>
          <th>执行日期</th>
          <td><input type="text" class="input" id="changeTime" name="changeTime" value="${changeDept.changeTime }" autocomplete="off"/></td>
          <th>填报时间</th>
          <td><input type="text" class="input" id="applyTime" name="applyTime" value="${changeDept.applyTime }" autocomplete="off"/></td>
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
	    elem: '#centerTime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#changeTime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#changeEndTime',
	    event: 'focus' 
	});
	function userSub(){
		if(confirm("确认提交吗？")){
			$("#form-article-add").submit();
		}
	}
	
	function back (){
		window.location.href="apply/online/changeDept/list";
	}
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
	</body>
</html>
