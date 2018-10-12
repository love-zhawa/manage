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
<form action="project/cpsh/list" method="post" id="searchForm">
  <div class="panel admin-panel">
    <div class="panel-head cl">
    	<strong class="icon-reorder">&nbsp;&nbsp产品售后</strong>
    </div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
        <shiro:hasPermission name="startup_add">
        	<li> <a class="button border-main icon-plus-square-o" href="javascript:void(0);" onclick="toAdd()">添加产品售后</a> </li>
        </shiro:hasPermission>
         <li>搜索：</li>
         <li>
          </li>
          <li>
              <input type="text" placeholder="输入设备名称" name="sbname" class="input" style="width:200px; line-height:17px;display:inline-block"  value="${sbname }" />
	          <input type="text" placeholder="输入设备类型" name="sbtype" class="input" style="width:200px; line-height:17px;display:inline-block"  value="${sbtype }" />
	          <input type="text" placeholder="输入生产厂家" name="sbhome" class="input" style="width:200px; line-height:17px;display:inline-block"  value="${sbhome }" />
	      </li>
	      <li>   
	          <a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()" > 搜索</a>
          </li>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th>序号</th>
        <th>售后来源</th>
		<th>项目</th>
		<th>项目编号</th>
		<th>设备名称</th>
		<th>设备类型</th>
		<th>生产厂家</th>
		<th>设备编号</th>
		<th>使用单位</th>
		<th>施工人员</th>
		<th>操作</th>
      </tr>
      <c:forEach items="${cpshList}" var="cpsh" varStatus="status">
			<tr>
	          <td>${(page.currPage - 1) * page.pageRows + status.index+1}</td>
	          <td>
	          	  <c:if test="${cpsh.ly ==1}">销售</c:if>
		          <c:if test="${cpsh.ly ==2}">项目</c:if>
	          </td>
	          <td><a onclick="detail('${cpsh.id}')" href="javascript:void(0);">
		          <c:if test="${cpsh.ly ==1}">${cpsh.project}</c:if>
		          <c:if test="${cpsh.ly ==2}">${cpsh.projects.projectName}</c:if>
	          </a></td>
	          <td>
	          	  <c:if test="${cpsh.ly ==1}">${cpsh.projectnumber}</c:if>
		          <c:if test="${cpsh.ly ==2}">${cpsh.projects.financialNumber}</c:if>
	          </td>
	          <td>${cpsh.sbname }</td>
	          <td>${cpsh.sbtype }</td>
	          <td>${cpsh.sbhome }</td>
	          <td>${cpsh.sbnumber }</td>
	          <td>${cpsh.dw }</td>
	          <td>${cpsh.person }</td>
	          <td class="td-manage">
	          <div class="button-group">
		          <shiro:hasPermission name="startup_edit">
			          <a class="button border-main" onclick="toedit('${cpsh.id}')" href="javascript:;">
	          			<span class="icon-edit"></span> 编辑
	          		</a>
			      </shiro:hasPermission>
			      <shiro:hasPermission name="startup_delete">
				      <a class="button border-red" onclick="todel('${cpsh.id}')" href="javascript:;">
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
			window.location.href="project/cpsh/toadd";
		}
		
		function toedit(id){
			window.location.href = "project/cpsh/toedit/"+id;
		}
		
		function detail(id){
			window.location.href="project/cpsh/detail/"+id;
		}
		function todel(id) {
			if(confirm("确认删除？")){
				$.post("common/del",{"id":id,"entry" :"ProjectCpsh"},function(data){
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