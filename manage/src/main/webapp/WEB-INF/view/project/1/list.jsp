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
	<link rel="stylesheet" href="css/tanchu.css">
	<script src="js/jquery.js"></script>
	<script src="js/pintuer.js"></script>
</head>
<body>
<form action="project/1/list" method="post" id="expertsId">
  <div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-reorder">&nbsp;&nbsp;内容列表</strong></div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
      	<shiro:hasPermission name="project1_add">
        	<li> <a class="button border-main icon-plus-square-o" href="javascript:void(0);" id="member_add" onclick="toAdd()">添加横向课题</a> </li>
        </shiro:hasPermission>
        <li>搜索：</li>
        <li>
          <input type="text" placeholder="输入项目负责人" name="userName" class="input" style="width:250px; line-height:17px;display:inline-block"  value="${userName}" />
          <input type="text" placeholder="输入项目名称" name="projectName" class="input" style="width:250px; line-height:17px;display:inline-block"  value="${projectName}" />
          <input type="text" placeholder="输入项目来源" name="resource" class="input" style="width:250px; line-height:17px;display:inline-block"  value="${resource}" />
          <a href="javascript:void(0)" class="button border-main icon-search" onclick="searchExperts();"> 搜索</a></li>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th>序号</th>
		<th>财务编号</th>
		<th>项目名称</th>
		<th>项目负责人</th>
		<th>项目类型</th>
		<th>所在小组</th>
		<th>承担单位</th>
		<th>委托单位</th>
		<th>开始时间</th>
		<th>结束时间</th>
		<th>档案编号</th>
		<th>经费到账</th>
		<th>操作</th>
      </tr>
      <c:forEach items="${projectList}" var="project" varStatus="status">
			<tr>
	          <td>${(page.currPage - 1) * page.pageRows + status.index+1}</td>
	          <td>${project.financialNumber }</td>
	          <td><a href="javascript:void(0)" onclick="detail('${project.id}')">${project.projectName }</a></td>
	          <td>${project.user.name }</td>
	          <td>
	          	<c:if test="${project.projectType == 1 }">技术开发</c:if>
				<c:if test="${project.projectType == 2 }">技术服务</c:if>
				<c:if test="${project.projectType == 3 }">技术咨询</c:if>
				<c:if test="${project.projectType == 4 }">横向工程</c:if>
				<c:if test="${project.projectType == 5 }">横向产品</c:if>
				<c:if test="${project.projectType == 29}">科研横向</c:if> 
          		<c:if test="${project.projectType == 30}">技术成本</c:if>
	          </td>
	          <td>${project.userGroup.groupName }</td>
	          <td>
	          	<c:if test="${project.unit == 1}">北京农业信息技术研究中心</c:if> 
	          	<c:if test="${project.unit == 2}">北京农业智能装备技术研究中心</c:if> 
	          	<c:if test="${project.unit == 3}">北京派得伟业科技发展有限公司</c:if> 
	          	<c:if test="${project.unit == 4}">农芯科技（北京）有限责任公司</c:if> 
	          	<c:if test="${project.unit == 5}">北京市农林科学院</c:if> 
	          	<c:if test="${project.unit == 6}">北京智慧农业物联网产业技术创新战略联盟</c:if> 
	          	<c:if test="${project.unit == 7}">北京农业智能装备技术研究中心（软硬件实验室）</c:if> 
	          </td>
	          <td>${project.deputeUnit }</td>
	          <td><fmt:formatDate value="${project.beginTime }" pattern="yyyy-MM-dd"/></td>
	          <td><fmt:formatDate value="${project.endTime }" pattern="yyyy-MM-dd"/></td>
	          <td>${project.fileNumber }</td>
	          <td>
	          	  <a href="javascript:void(0)" onclick="show('${project.id}')">${project.incomeList[0].incomeAmount }</a>
	          </td>
	          <td>
		          <div  class="button-group">
		          	<shiro:hasPermission name="project1_edit">
		          	  <a class="button border-main" onclick="edit('${project.id}')" href="javascript:;">
	          			<span class="icon-edit"></span> 修改
	          		  </a>
	          		</shiro:hasPermission>
	          		<shiro:hasPermission name="project1_delete">
	          		  <a class="button border-red" href="javascript:void(0)" onclick="del('${project.id}')">
	          			<span class="icon-trash-o"></span> 删除
	          		  </a>
	          		</shiro:hasPermission>
		          </div>
	          </td>
			</tr>
		</c:forEach>
      	<jsp:include page="../../include/page.jsp">
      		<jsp:param value="13" name="colspan"/>
      	</jsp:include>
    </table>
  </div>
</form>
<div class='alertWindow' id="alertWindow">
        <div class="bg_table bg_table1 hide-box" id="rgxq">
        	<b class= 'closeBtn'  onclick='closeWindow()'>×</b>
        	<h2 style="display:block;width:100%;text-align:center;font-weight:normal;margin-bottom:5px;">经费到账情况</h2>
        	<div class="content">	                    		
                <table class="table table-hover text-center">
                    <thead>
                        <tr>
                            <th>序号</th>
                            <th>到账时间</th>
                            <th>财务编号</th>
                            <th>到账经费</th>
                        </tr>
                    </thead>
                    <tbody id="items">
                    	
                    </tbody>
                 </table>
        	</div>
         </div>
	</div>
	<script type="text/javascript">
		function toAdd(){
			window.location.href="project/1/toadd";
		}
		function searchExperts(){
			$("#expertsId").submit();
		}
		function detail(id){
			window.location.href="project/1/detail/"+id;
		}
		
		function del(id){
			if(confirm("确认删除吗？")){
				window.location.href="project/1/del/"+id;
			}
		}
		
		function show(id){
			$.post("project/incomce/"+id,function(data){
				$.each(data,function(index, item){
					var tr = "<tr>";
					tr += "<td>";
					tr += index+1
					tr += "</td>";
					tr += "<td>";
					tr += item.str2
					tr += "</td>";
					tr += "<td>";
					tr += item.str1
					tr += "</td>";
					tr += "<td>";
					tr += item.str3
					tr += "</td>";
					tr += "</tr>";
					
					$("#items").append(tr);
				});
			});			
			
			$("#alertWindow").show();
			$("#rgxq").show();
		}
		function closeWindow(){
			$("#alertWindow").hide();
			$("#rgxq").hide();
			$("#items").empty();
		}
		function edit(id){
			window.location.href="project/1/toedit/"+id;
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