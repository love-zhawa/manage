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
<form action="project/xmsh/list" method="post" id="searchForm">
  <div class="panel admin-panel">
    <div class="panel-head cl">
    	<strong class="icon-reorder">&nbsp;&nbsp项目售后</strong>
    </div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
        <shiro:hasPermission name="startup_add">
        	<li> <a class="button border-main icon-plus-square-o" href="javascript:void(0);" onclick="toAdd()">添加项目售后</a> </li>
        </shiro:hasPermission>
         <li>搜索：</li>
         <li>
          <select name="projectid" class="input" style="width:250px;">
          	<option value="">请选择项目</option>
          	<c:forEach items="${projectList}" var="pro">
          		<option value="${pro.id }" <c:if test="${pro.id == projectid }">selected</c:if>>${pro.projectName }</option>
          	</c:forEach>
          </select>
          </li>
          <li>
	          <input type="text" placeholder="输入维修编号" name="number" class="input" style="width:200px; line-height:17px;display:inline-block"  value="${number }" />
	      </li>
	      <li>   
	          <a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()" > 搜索</a>
          </li>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th>序号</th>
		<th>使用项目</th>
		<th>维修单号</th>
		<th>报修单位/部门</th>
		<th>报修人</th>
		<th>报修时间</th>
		<th>维修类型</th>
		<th>是否在报修期范围内</th>
		<th>保修设备</th>
		<th>操作</th>
      </tr>
      <c:forEach items="${xmshList}" var="xmsh" varStatus="status">
			<tr>
	          <td>${(page.currPage - 1) * page.pageRows + status.index+1}</td>
	          <td><a onclick="detail('${xmsh.id}')" href="javascript:void(0);">${xmsh.project.projectName}</a></td>
	          <td>${xmsh.number}</td>
	          <td>${xmsh.bxdept }</td>
	          <td>${xmsh.bxperson }</td>
	          <td><fmt:formatDate value="${xmsh.bxtime }" pattern="yyyy-MM-dd"/></td>
	          <td>
				<c:if test="${xmsh.wxtype == 1 }">返厂维修</c:if>
	          	<c:if test="${xmsh.wxtype == 2 }">现场维护</c:if>
	          	<c:if test="${xmsh.wxtype == 3 }">售后更换</c:if>
			  </td>
	          <td>
	          	<c:if test="${xmsh.isbxq == 1 }">是</c:if>
	          	<c:if test="${xmsh.isbxq == 2 }">否</c:if>
	          </td>
	          <td>${xmsh.bxsb }</td>
	          <td class="td-manage">
	          <div class="button-group">
		          <shiro:hasPermission name="startup_edit">
			          <a class="button border-main" onclick="toedit('${xmsh.id}')" href="javascript:;">
	          			<span class="icon-edit"></span> 编辑
	          		</a>
			      </shiro:hasPermission>
			      <shiro:hasPermission name="startup_delete">
				      <a class="button border-red" onclick="todel('${xmsh.id}')" href="javascript:;">
	         			<span class="icon-trash-o"></span> 删除
	         		  </a>
         		</shiro:hasPermission>
	          </div>
	          </td>
			</tr>
		</c:forEach>
      	<jsp:include page="../../include/page.jsp">
      		<jsp:param value="11" name="colspan"/>
      	</jsp:include>
    </table>
  </div>
</form>
	<script type="text/javascript">
		function changesearch(){
			$("#searchForm").submit();
		}
		
		function toAdd(){
			window.location.href="project/xmsh/toadd";
		}
		
		function toedit(id){
			window.location.href = "project/xmsh/toedit/"+id;
		}
		
		function detail(id){
			window.location.href="project/xmsh/detail/"+id;
		}
		function todel(id) {
			if(confirm("确认删除？")){
				$.post("common/del",{"id":id,"entry" :"ProjectXmsh"},function(data){
					if(data == 0) {
						alert("删除成功！");
					} else {
						alert("删除失败！");
					}
					window.location.reload(); 
				});
			}
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