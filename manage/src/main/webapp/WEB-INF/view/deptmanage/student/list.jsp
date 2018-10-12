<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
</head>
<body>
<form action="student/list" method="post" id="searchForm">
  <div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-reorder">&nbsp;&nbsp;内容列表</strong></div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
      <c:if test="${username eq tutor }">
       <shiro:hasPermission name="student_add">
        	<li> <a class="button border-main icon-plus-square-o" href="javascript:void(0);" onclick="toadd()">添加</a> </li>
        </shiro:hasPermission>
      </c:if>
        <li>搜索：</li>
        <li>
          <select name="tutor" class="input" style="width:250px; line-height:15px;display:inline-block" >
				<c:forEach items="${tutors}" var="tutors">
					<option value="${tutors}"<c:if test="${tutors eq tutor}">selected="selected"</c:if>>${tutors}</option>
				</c:forEach>       	   		
       	   </select>
          <a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()" > 搜索</a></li>
      </ul>
      
    </div>
    <table class="table table-hover text-center"  >
      <tr>
        <th>序号</th>
		<th>导师姓名</th>
		<th>名称</th>
		<th>支出名称</th>
		<th>项目编号</th>
		<th>开始时间</th>
		<th>结束时间</th>
		<th>合计补助</th>
		<th>状态</th>
		<th>操作</th>
      </tr>
       <c:forEach items="${lists}" var="stu" varStatus="status">
			<tr>
	          <td>${status.index+1}</td>
	          <td><u style="cursor:pointer" class="text-primary" onclick="detail('${stu.id}')">${stu.username }</u></td>
	          <td>${fn:substring(stu.endTime,5,7)}月学生补助</td>
	          <td>${stu.project.projectName }</td>
	          <td>${stu.project.financialNumber }</td>
	          <td>${fn:substring(stu.beginTime,0,10)}</td>
	          <td>${fn:substring(stu.endTime,0,10)}</td>
	           <td>${stu.summoney }</td>
	          <td>
		      	<c:if test="${stu.status == null }">未提交审核</c:if>
		      	<c:if test="${stu.status == 0 }">已提交审核</c:if>
		      	<c:if test="${stu.status == 1 }">审核通过</c:if>
		      	<c:if test="${stu.status == 2 }">审核不通过</c:if>
		      </td>
	          <td>
	          
	          <c:if test="${username eq tutor || user.id eq '891b0aa0b95647e6ae5087bcdfc38d72'}">
	          	<div class="button-group">
	          	<c:if test="${stu.status == null || stu.status == 2}">
		          	<shiro:hasPermission name="student_sub">
		       			<a class="button border-green" onclick="subaudit('${stu.id}')" href="javascript:;">
			       			<span class="icon-rocket"></span> 提交审核
			       		</a>
		       		</shiro:hasPermission>
		       		<shiro:hasPermission name="student_edit">
		          		<a class="button border-main" onclick="edit('${stu.id}')" href="javascript:;">
		          			<span class="icon-edit"></span> 修改
		          		</a>
	          		</shiro:hasPermission>
		       	</c:if>
		       	<c:if test="${stu.status == 0 }">
		       	    <c:if test="${user.id eq '891b0aa0b95647e6ae5087bcdfc38d72'}">
			       	 	<shiro:hasPermission name="student_audit">
		       			<a class="button border-dot" onclick="toaudit('${stu.id}')" href="javascript:;">
			       			<span class="icon-rocket"></span> 审核
			       		</a>
			       		</shiro:hasPermission>
		       		<shiro:hasPermission name="student_edit">
		          		<a class="button border-main" onclick="edit('${stu.id}')" href="javascript:;">
		          			<span class="icon-edit"></span> 修改
		          		</a>
	          		</shiro:hasPermission>
	          		</c:if>
	       		</c:if>
	       		<c:if test="${stu.status == 1 }">
	       			<shiro:hasPermission name="student_print">
			          	<a class="button border-yellow" onclick="toprint('${stu.id}')" href="javascript:;">
			       			<span class="icon-print"></span> 打印
		      				</a>
		          	</shiro:hasPermission>
		         </c:if>
		       	
	          	</div>
	          </c:if>
	          	
	          </td>
			</tr>
		</c:forEach>
    </table>
  </div>
</form>
	<script type="text/javascript">
		function changesearch(){
			$("#searchForm").submit();
		}
		function toadd(){
			window.location.href="student/toadd";
		}
		function edit(id){
			window.location.href = "student/toedit/"+id;
		}
		function detail(id){
			window.location.href = "student/detail/"+id;
		}
		function toaudit(id){
			window.location.href = "student/toaudit/"+id;
		}
		//打印
		function toprint(id){
			window.location.href="student/toprint/"+ id;
		}
		function subaudit(id){
			if(confirm("确认提交审核？")){
				window.location.href = "student/sub/"+id;
			}
		}
		
		$(function(){
	    	var msg = '${msg}';
	    	
	    	if(msg != '') {
	    		alert(msg);
	    	}
	    	    });
		$(function(){
			
		});
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
</body>
</html>