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
<form action="apply/online/overtime/list" method="post" id="searchForm">
  <jsp:include page="../include.jsp"/>
  <div class="panel admin-panel">
    <div class="panel-head cl">
    	<strong class="icon-reorder">&nbsp;&nbsp;内容列表</strong>
    </div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
        <shiro:hasPermission name="apply_overtime_add">
        <li> <a class="button border-main icon-plus-square-o" href="javascript:void(0);" onclick="toadd()">加班申请</a> </li>
        </shiro:hasPermission>
        <li>搜索：</li>
        <li>
          <input type="text" placeholder="请输入申请人" name="userName" class="input" style="width:200px; line-height:17px;display:inline-block;margin-left: 5px;"  value="${userName }" />
          <a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()" > 搜索</a></li>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th>序号</th>
		<th>申请人</th>
		<th>所属小组</th>
		<th>加班事由</th>
		<th>联系电话</th>
		<th>紧急联系人</th>
		<th>紧急联系电话</th>
		<th>开始时间</th>
		<th>结束时间</th>
		<th>操作</th>
      </tr>
      <c:forEach items="${overtimeList}" var="overtime" varStatus="status">
			<tr>
	          <td>${(page.currPage - 1) * page.pageRows + status.index+1}</td>
	          <td>${overtime.user.name }</td>
	          <td>${overtime.user.userGroupName }</td>
	          <td>${overtime.reason }</td>
	          <td>
	          	${overtime.phoneNumber }
	          </td>
	          <td>${overtime.concatUser }</td>
	          <td>${overtime.concatMobile }</td>
	          <td><fmt:formatDate value="${overtime.beginTime }" pattern="yyyy-MM-dd HH"/></td>
	          <td><fmt:formatDate value="${overtime.endTime }" pattern="yyyy-MM-dd HH"/></td>
	          <td>
	          	<div class="button-group">
		          	<shiro:hasPermission name="apply_overtime_edit">
			          	<a class="button border-main" onclick="toedit('${overtime.id}')" href="javascript:;">
			       			<span class="icon-edit"></span> 编辑
			       		</a>
		          	</shiro:hasPermission>
		          	<shiro:hasPermission name="apply_overtime_print">
			          	<a class="button border-yellow" onclick="toprint('${overtime.id}')" href="javascript:;">
			       			<span class="icon-print"></span> 打印
		       				</a>
		          	</shiro:hasPermission>
		          	<shiro:hasPermission name="apply_overtime_delete">
		          	<a class="button border-red" onclick="todel('${overtime.id}')" href="javascript:;">
	         			<span class="icon-trash-o"></span> 删除
	         		</a>
	         		</shiro:hasPermission>
		          </div>
	          </td>
			</tr>
		</c:forEach>
      	<jsp:include page="../../../include/page.jsp">
      		<jsp:param value="10" name="colspan"/>
      	</jsp:include>
    </table>
  </div>
</form>
	<script type="text/javascript">
		function changesearch(){
			$("#searchForm").submit();
		}
		
		function toadd(){
			window.location.href="apply/online/overtime/toadd";
		}
		function todel(id) {
			if(confirm("确认删除？")){
				$.post("common/del",{"id":id,"entry" :"ApplyOvertime"},function(data){
					if(data == 0) {
						alert("删除成功！");
					} else {
						alert("删除失败！");
					}
					window.location.reload(); 
				});
			}
		}
		
		function toedit(id){
			window.location.href="apply/online/overtime/toedit/"+ id;
		}
		
		$(function(){
	    	var msg = '${msg}';
	    	if(msg != '') {
	    		alert(msg);
	    	}
	    });
		function toprint(id){
			window.location.href="apply/online/overtime/toprint/"+ id;
		}
		
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
</body>
</html>