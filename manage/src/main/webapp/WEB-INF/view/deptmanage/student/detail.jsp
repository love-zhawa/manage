<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<base href="<%=request.getContextPath() %>/">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title></title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css"  media="all">
<style>
.bztable{width: 100%;max-width: 100%;}
.bztable th{border-top: 1px solid #ddd;padding: 10px;font-size:15px;}
.bztable td{border-top: 1px solid #ddd;padding: 10px;text-align: center;}
.bztable input{padding: 7px;border: solid 1px #ddd;width: 100%;border-radius: 3px;}
</style>
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;详情</strong></div>
  <div class="body-content">
    <form action="student/audit" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
     <input type="hidden" name="id" value="${stu.id}">
      <table class="bztable">
         <div class="form-group">
	        <div class="label">
	          <label>支出项目：</label>
	        </div>
	        <div class="field cc">
	          ${stu.project.projectName }
	        </div>
	     </div>
	      <div class="form-group">
	        <div class="label">
	          <label>财务编号：</label>
	        </div>
	        <div class="field cc">
	           ${stu.project.financialNumber }
	        </div>
	     </div>
      	<tr>
      		<th colspan="10"><h2>${fn:substring(stu.bztime,0,7) }学生补助发放明细</h2></th>
      	</tr>
      	<tr>
      		<th colspan="2">部门</th>
      		<th colspan="8">${user.userGroup.groupName}</th>
      	</tr>
      	<tr>
      		<th>序号</th>
      		<th>姓名</th>
      		<th>类别</th>
      		<th>身份证号</th>
      		<th>开户银行</th>
      		<th>账号</th>
      		<th>工作时间(天)</th>
      		<th>劳务金额(元)</th>
      		<th>其他补助(元)</th>
      		<th>小计金额(元)</th>
      	</tr>
      	<tbody id="items">
	      	<c:forEach items="${stu.bzlist}" var="bz" varStatus="i">
				<tr>
		          <td><input type="hidden" name="bzlist[${i.index }].user.id" value="${bz.user.id }">${i.index+1}</td>
		          <td>${bz.user.name}</td>
		         
		          <td>
					<c:if test="${bz.user.education == 1 }">硕士</c:if>
					<c:if test="${bz.user.education == 2 }">博士</c:if>
					<c:if test="${bz.user.education == 3 }">学士</c:if>
				  </td>
		          <td>${bz.user.idCard }</td>
		          <td>${bz.user.bank }</td>
		          <td>${bz.user.cardid }</td>
		          <td>${bz.ts }</td>
		          <td>${bz.money }</td>
		          <td>${bz.qtmoney }</td>
		          <td>${bz.summoney }</td>
				</tr>
			</c:forEach>
		</tbody>
		<tr>
			<th colspan="2">合计</th>
			<th></th>
			<th colspan="6">叁仟肆佰捌拾伍元整</th>
			<th>${stu.summoney }</th>
		</tr>
      </table>
      <div class="form-group">
        <div class="label">
          <label></label>
        </div>
        <div class="field">
          <button class="button bg-main icon-check-square-o" type="button" onClick="goList();"> 返回</button>
        </div>
      </div>
    </form>
  </div>
</div>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div> 
</body>
   <script type="text/javascript">
	function goList(){
		window.location.href="student/list";
	}
	</script>
</html>