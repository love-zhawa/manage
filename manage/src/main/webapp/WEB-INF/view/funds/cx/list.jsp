<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
</head>
<body>
<form action="funds/cx/list" method="post" id="searchForm">
  <div class="panel admin-panel">
    <div class="panel-head cl">
    	<strong class="icon-reorder">&nbsp;&nbsp;内容列表</strong>
    </div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
        <li>选择项目：</li>
        <li>
          <select name="projectId" class="input w50" style="width: 250px;">
          	<option value="">全部</option>
          	<c:forEach items="${projectList }" var="project">
          		<option <c:if test="${project.id == projectId}">selected</c:if> value="${project.id }">${project.projectName }</option>
          	</c:forEach>
          </select>
          <input type="text" placeholder="请输入报销人" name="applyUser" class="input" style="width:200px; line-height:17px;display:inline-block;margin-left: 5px;"  value="${applyUser }" />
          <a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()" > 搜索</a></li>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th>序号</th>
        <th>支出类别</th>
        <th>姓名</th>
        <th style="width:16%;">支出单位</th>				
		<th style="width:18%;">支出项目</th>
		<th>财务编号</th>
		<th>时间</th>
		<th>票据张数</th>
		<th>操作</th> 
      </tr>
      <c:forEach items="${sementList}" var="record" varStatus="status">
      <c:if test="${record.status == 1  }">
	     <tr>
		      <td>${(page.currPage - 1) * page.pageRows + status.index+1}</td>
		      <td>日常报销</td>
		      <td>${record.addUser.name }</td>
		      <td>${record.payUnit}</td>
		      <td>${record.project.projectName }</td>
		      <td>${record.project.financialNumber }</td>
		      <td><fmt:formatDate value="${record.reDate}" pattern="yyyy-MM-dd"/></td>
		      <td>${record.sum}</td>
		      <td class="td-manage">
	      		<div class="button-group">
	       			<a class="button border-dot" onclick="todetail('${record.id}')" href="javascript:;">
		       			<span class="icon-rocket"></span> 详细信息
		       		</a>
	       		</div>
	         </td>
	     </tr>
	     
	  </c:if>
     </c:forEach>
      	<jsp:include page="../../include/page.jsp">
      		<jsp:param value="9" name="colspan"/>
      	</jsp:include>
    </table>
  </div>
</form>
	<script type="text/javascript">
		function todetail(id){
			window.location.href = "funds/cx/todetail/"+id;
		}
		function changesearch(){
			$("#searchForm").submit();
		}
		
		$(function(){
	    	var msg = '${msg}';
	    	if(msg != '') {
	    		alert(msg);
	    	}
	    });
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
</body>
</html>