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
	<title>信息中心学生返校申请表</title>
	<link rel="stylesheet" href="css/pintuer.css">
	<link rel="stylesheet" href="css/admin.css">
	<script src="js/jquery.js"></script>
	<script src="js/pintuer.js"></script>
	<script src="laydate/laydate.js"></script>
</head>
<body>
<form action="apply/online/backToSchool/list" method="post" id="searchForm">
  <jsp:include page="../include.jsp"/>
  <div class="panel admin-panel">
    <div class="panel-head cl">
    	<strong class="icon-reorder">&nbsp;&nbsp;内容列表</strong>
    </div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
        <shiro:hasPermission name="apply_backtoschool_add">
        <li> <a class="button border-main icon-plus-square-o" href="javascript:void(0);" onclick="toadd()">返校申请</a> </li>
        </shiro:hasPermission>
        <li>搜索：</li>
        <li>
          <input type="text" placeholder="请输入姓名" name="userName" class="input" style="width:200px; line-height:17px;display:inline-block;margin-left: 5px;"  value="${userName }" />
          <a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()" > 搜索</a></li>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th>序号</th>
		<th>所在部门</th>
		<th>申请日期</th>
		<th>学生姓名</th>
		<th>性别</th>
		<th>就读学校</th>
		<th>入学时间</th>
		<th>入中心时间</th>
		<th>培养方式</th>
		<th>导师姓名</th>
		<th>拟离开中心时间</th>
		<th>操作</th>
      </tr>
      <c:forEach items="${backToSchoolList}" var="backToSchool" varStatus="status">
			<tr>
	          <td>${(page.currPage - 1) * page.pageRows + status.index+1}</td>
	          <td>${backToSchool.deptName }</td>
	          <td>${backToSchool.applyTime }</td>
	          <td>${backToSchool.userName }</td>
	          <td>
	          	<c:if test="${backToSchool.gender == 0 }">男</c:if>
	          	<c:if test="${backToSchool.gender == 1 }">女</c:if>
	          </td>
	          <td>${backToSchool.school }</td>
	          <td>${backToSchool.entranceTime }</td>
	          <td>${backToSchool.centerTime }</td>
	          <td>${backToSchool.cultivationMode }</td>
	          <td>${backToSchool.tutor }</td>
	          <td>${backToSchool.leaveTime }</td>
	          <td>
	            <div class="button-group">
		          	<shiro:hasPermission name="apply_backToSchool_edit">
			          	<a class="button border-main" onclick="toedit('${backToSchool.id}')" href="javascript:;">
			       			<span class="icon-edit"></span> 编辑
			       		</a>
		          	</shiro:hasPermission>
		          	<shiro:hasPermission name="apply_backToSchool_print">
			          	<a class="button border-yellow" onclick="toprint('${backToSchool.id}')" href="javascript:;">
			       			<span class="icon-print"></span> 打印
		      				</a>
		          	</shiro:hasPermission>
		          	<shiro:hasPermission name="apply_backtoschool_delete">
		          	<a class="button border-red" onclick="todel('${backToSchool.id}')" href="javascript:;">
	         			<span class="icon-trash-o"></span> 删除
	         		</a>
	         		</shiro:hasPermission>
		          </div>
	          </td>
			</tr>
		</c:forEach>
      	<jsp:include page="../../../include/page.jsp">
      		<jsp:param value="12" name="colspan"/>
      	</jsp:include>
    </table>
  </div>
</form>
	<script type="text/javascript">
		function changesearch(){
			$("#searchForm").submit();
		}
		function todel(id) {
			if(confirm("确认删除？")){
				$.post("common/del",{"id":id,"entry" :"ApplyBackToSchool"},function(data){
					if(data == 0) {
						alert("删除成功！");
					} else {
						alert("删除失败！");
					}
					window.location.reload(); 
				});
			}
		}
		function toadd(){
			window.location.href="apply/online/backToSchool/toadd";
		}
		
		function toedit(id){
			window.location.href="apply/online/backToSchool/toedit/"+ id;
		}
		
		$(function(){
	    	var msg = '${msg}';
	    	if(msg != '') {
	    		alert(msg);
	    	}
	    });
		function toprint(id){
			window.location.href="apply/online/backToSchool/toprint/"+ id;
		}
		
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
</body>
</html>