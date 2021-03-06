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
	<link href="css/jquery.searchableSelect.css" rel="stylesheet" type="text/css">
    <script src="js/jquery-1.11.1.min.js"></script>
    <script src="js/jquery.searchableSelect.js"></script>
</head>
<body>
<form action="funds/list" method="post" id="expertsId">
  <div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-reorder">&nbsp;&nbsp;内容列表</strong></div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
      	<shiro:hasPermission name="funds_fund_add">
        	<li> <a class="button border-main icon-plus-square-o" href="javascript:void(0);" id="member_add" onclick="toAdd()">添加到账</a> </li>
        </shiro:hasPermission>
        <li>搜索：</li>
        <li>
          <select name="projectId" class="input w50" style="width: 250px;">
          	<option value="">全部</option>
          	<c:forEach items="${projectList }" var="project">
          		<option <c:if test="${project.id == projectId}">selected</c:if> value="${project.id }">${project.projectName }</option>
          	</c:forEach>
          </select>
          
          <input type="text" placeholder="财务编号" name="financialNumber" class="input" style="width:250px; line-height:17px;display:inline-block;margin-left: 5px;" value="${financialNumber}" />
          <a href="javascript:void(0)" class="button border-main icon-search" onclick="searchExperts();"> 搜索</a></li>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th>序号</th>
		<th>财务编号</th>
		<th>隶属项目</th>
		<th>总经费</th>
		<th>已到位经费</th>
		<th>本次经费金额</th>
		<th>到账时间</th>
		<th>发票情况</th>
		<th>状态</th>
		<th>操作</th>
      </tr>
      <c:forEach items="${fundsList}" var="funds" varStatus="status">
			<tr>
	          <td>${(page.currPage - 1) * page.pageRows + status.index+1}</td>
	          <td>${funds.project.financialNumber }</td>
	          <td>${funds.project.projectName }</td>
	          <td>${funds.project.totalMoney }</td>
	          <td>${funds.incomeAmount }</td>
	          <td>${funds.amount }</td>
	          <td><fmt:formatDate value="${funds.changeTime }" pattern="yyyy-MM-dd"/></td>
	          <td>
	          	<c:if test="${funds.billInfo == 1 }">未开发票</c:if>
				<c:if test="${funds.billInfo == 0 }">已开发票</c:if>
	          </td>
	          <td>
		      	<c:if test="${funds.status == null }">未提交审核</c:if>
		      	<c:if test="${funds.status == 0 }">已提交审核</c:if>
		      	<c:if test="${funds.status == 1 }">审核通过</c:if>
		      	<c:if test="${funds.status == 2 }">审核不通过</c:if>
		      </td>
	          <td>
		          <div  class="button-group">
		          <c:if test="${funds.status == null || funds.status == 2}">
		          	<shiro:hasPermission name="funds_fund_edit">
		          		<a class="button border-main" onclick="edit('${funds.id}')" href="javascript:;">
	          			    <span class="icon-edit"></span> 修改
	          		    </a>
	          		  </shiro:hasPermission>
          		    <shiro:hasPermission name="funds_experfee_audit">
		       			<a class="button border-green" onclick="subaudit('${funds.id}')" href="javascript:;">
			       			<span class="icon-rocket"></span> 提交审核
			       		</a>
			       	 </shiro:hasPermission>
	          		<shiro:hasPermission name="funds_fund_delete">
		          		<a class="button border-red" onclick="todel('${funds.id}')" href="javascript:;">
		         			<span class="icon-trash-o"></span> 删除
		         		</a>
         			</shiro:hasPermission>
         		 </c:if>
         		 <c:if test="${funds.status == 0 }">
		       		<shiro:hasPermission name="funds_experfee_audit">
		       			<a class="button border-dot" onclick="toaudit('${funds.id}')" href="javascript:;">
			       			<span class="icon-rocket"></span> 审核
			       		</a>
		       		</shiro:hasPermission>
	       		</c:if>
	       		<%-- <c:if test="${funds.status == 1 && (roleid == '2df370f1f420497bbd5a1b5ef8d3a6ee' || roleid=='96e79218965eb72c92a549dd5a330112')}">
      			        <shiro:hasPermission name="funds_fund_edit">
		          		<a class="button border-main" onclick="edit('${funds.id}')" href="javascript:;">
	          				<span class="icon-edit"></span> 编辑
	          		 	</a>
	          		 </shiro:hasPermission>
	          		 <shiro:hasPermission name="funds_fund_delete">
	          		    <a class="button border-red" onclick="todel('${funds.id}')" href="javascript:;">
		         			<span class="icon-trash-o"></span> 删除
		         		</a>
         			</shiro:hasPermission>
      			</c:if> --%>
        		 
		          </div>
	          </td>
			</tr>
		</c:forEach>
      	<jsp:include page="../../include/page.jsp">
      		<jsp:param value="10" name="colspan"/>
      	</jsp:include>
    </table>
  </div>
</form>
	<script type="text/javascript">
		function toAdd(){
			window.location.href="funds/toadd";
		}
		function searchExperts(){
			$("#expertsId").submit();
		}
		function todel(id) {
			if(confirm("确认删除？")){
				$.post("common/del",{"id":id,"entry" :"FundsIncome"},function(data){
					if(data == 0) {
						alert("删除成功！");
					} else {
						alert("删除失败！");
					}
					window.location.reload(); 
				});
			}
		}
		function edit(id){
			window.location.href="funds/toedit/"+id;
		}
		/* $(function(){
			$("select[name='projectId']").searchableSelect();
		}); */
		$(function(){
	    	var msg = '${msg}';
	    	
	    	if(msg != '') {
	    		alert(msg);
	    	}
	    });
	    function subaudit(id){
			if(confirm("确认提交审核？")){
				window.location.href = "funds/sub/"+id;
			}
		}
		function toaudit(id){
			window.location.href = "funds/toaudit/"+id;
		}
	</script>
	    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>
</body>
</html>