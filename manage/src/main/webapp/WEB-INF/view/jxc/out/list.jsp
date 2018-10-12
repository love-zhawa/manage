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
	<script src="laydate/laydate.js"></script>
</head>
<body>
<form action="jxc/out/list" method="post" id="searchForm">
  <div class="panel admin-panel">
    <div class="panel-head cl">
    	<strong class="icon-reorder">&nbsp;&nbsp;出库申请列表</strong>
    </div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
        <shiro:hasPermission name="jxc_out_add">
        <li> <a class="button border-main icon-plus-square-o" href="javascript:void(0);" onclick="toAdd()">添加出库单</a> </li>
        </shiro:hasPermission>
        <li>搜索：</li>
        <li>
          <select name="typeid" class="input">
          	<option value="">请选择产品</option>
          	<c:forEach items="${typeList }" var="type">
          		<option value="${type.id }" <c:if test="${type.id ==typeid}">selected</c:if>>${type.typeName }</option>
          	</c:forEach>
          	
          </select>
          </li>
        <li>
          <input type="text" placeholder="输入用途" name="purpose" class="input" style="width:200px; line-height:17px;display:inline-block"  value="${purpose }" />
          <a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()" > 搜索</a></li>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th>序号</th>
		<th>产品名称</th>
		<th>规格/型号</th>
		<th>数量</th>
		<th>出库单号</th>
		<th>出库时间</th>
		<th>出库用途</th>
		<th>业务项目</th>
		<th>备注</th>
		<th>状态</th>
		<th>近一次审核意见</th>
		<th>操作</th>
      </tr>
      <c:forEach items="${outList}" var="apply" varStatus="status">
			<tr>
	          <td>${(page.currPage - 1) * page.pageRows + status.index+1}</td>
	          <td>${apply.productType.typeName }</td>
	          <td>${apply.model}</td>
	          <td>${apply.amount }</td>
	          <td>${apply.outNo }</td>
	          <td><fmt:formatDate value="${apply.outTime }" pattern="yyyy-MM-dd"/></td>
	          <td>${apply.purpose }</td>
	          <td>${apply.project.projectName }</td>
	          <td>${apply.remark }</td>
	          <td>
	          	<c:if test="${apply.status == 0}">未提交</c:if>
	          	<c:if test="${apply.status == 1}">待一审</c:if>
	          	<c:if test="${apply.status == 2}">待二审</c:if>
	          	<c:if test="${apply.status == 3}">未出库</c:if>
	          	<c:if test="${apply.status == 4}">已出库</c:if>
	          </td>
	          <td>${apply.auditMsg }</td>
	          <td class="td-manage">
	          	<div class="button-group">
			        <c:if test="${apply.status == 0}">
			        	<shiro:hasPermission name="jxc_out_edit">
			        	<a class="button border-main" onclick="toedit('${apply.id}')" href="javascript:;">
		          			<span class="icon-edit"></span> 编辑
		          		</a>
		          		</shiro:hasPermission>
		          		<shiro:hasPermission name="jxc_out_sub">
			        	<a class="button border-main" onclick="subaudit('${apply.id}')" href="javascript:;">
		          			<span class="icon-retweet"></span> 提交审核
		          		</a>
		          		</shiro:hasPermission>
		          		<shiro:hasPermission name="jxc_out_delete">
		          		<a class="button border-red" onclick="todel('${apply.id}')" href="javascript:;">
		         			<span class="icon-trash-o"></span> 删除
		         		</a>
		         		</shiro:hasPermission>
			        </c:if>
			        <c:if test="${apply.status == 1}">
		          		<shiro:hasPermission name="jxc_out_audit">
			        	<a class="button border-yellow" onclick="audit('${apply.id}')" href="javascript:;">
				           <span class="icon-tag"></span> 审核
				        </a> 
				        </shiro:hasPermission>
			        </c:if>
			          
			        <c:if test="${sessionScope.user.post == 0 && apply.status == 2}"><!-- 主任 -->
		          		<shiro:hasPermission name="jxc_out_audit_post">
				      <a class="button border-yellow" onclick="audit('${apply.id}')" href="javascript:;">
			          	<span class="icon-tag"></span> 审核
			          </a> 
			          </shiro:hasPermission>
			        </c:if>
			        <c:if test="${apply.status == 3}">
		          		<shiro:hasPermission name="jxc_out_store">
			        	<a class="button border-yellow" onclick="out('${apply.id}')" href="javascript:;">
				           <span class="icon-outdent"></span> 出库
				        </a> 
				        </shiro:hasPermission>
			        </c:if>
			        <c:if test="${apply.status == 4}">
			            <a class="button border-main" onclick="show('${apply.id}')" href="javascript:;">
		          			<span class=""></span>入库情况
		          		</a>
		             </c:if>
	          	</div>
	          </td>
			</tr>
		</c:forEach>
      	<jsp:include page="../../include/page.jsp">
      		<jsp:param value="12" name="colspan"/>
      	</jsp:include>
    </table>
  </div>
</form>
<div class='alertWindow' id="alertWindow" style="display:none">
		<div class="bg_table bg_table1 hide-box" id="rgxq">
			<b class='closeBtn' onclick='closeWindow()'>×</b>
			<h2
				style="display: block; width: 100%; text-align: center; font-weight: normal; margin-bottom: 5px;">历史过程</h2>
			<div class="content">
				<table class="table table-hover text-center">
					<thead>
						<tr>
							<th>序号</th>
							<th>产品名称</th>
							<th>入库时间</th>
							<th>入库数量</th>
							<th>入库类型</th>
							<th>厂家</th>
							<th>备注</th>
						</tr>
					</thead>
					<tbody id="items">

					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function changesearch(){
			$("#searchForm").submit();
		}
		
		function toAdd(){
			window.location.href="jxc/out/toadd";
		}
		function toedit(id){
			window.location.href="jxc/out/toedit/"+id;
		}
		function todel(id) {
			if(confirm("确认删除？")){
				$.post("common/del",{"id":id,"entry" :"OutStoreApply"},function(data){
					if(data == 0) {
						alert("删除成功！");
					} else {
						alert("删除失败！");
					}
					window.location.reload(); 
				});
			}
		}
		function audit(id){
			window.location.href="jxc/out/toaudit/"+id;
		}
		
		function subaudit(id){
			window.location.href = "jxc/out/subaudit/"+id;
		}
		
		function out(id){
			window.location.href="jxc/out/out/"+id;
		}
		
		$(function(){
	    	var msg = '${msg}';
	    	if(msg != '') {
	    		alert(msg);
	    	}
	    });
	    
	    function show(id) {
			$.post("jxc/out/show/" + id, function(data) {
				$.each(data, function(index, item) {
					var tr = "<tr>";
					tr += "<td>";
					tr += index + 1
					tr += "</td>";
					tr += "<td>";
					tr += item.str1
					tr += "</td>";
					tr += "<td>";
					tr += item.str2
					tr += "</td>";
					tr += "<td>";
					tr += item.str3
					tr += "</td>";
					tr += "<td>";
					tr += item.str4
					tr += "</td>";
					tr += "<td>";
					tr += item.str5
					tr += "</td>";
					tr += "<td>";
					tr += item.str6
					tr += "</td>";
					tr += "</tr>";

					$("#items").append(tr);
				});
			});

			$("#alertWindow").show();
			$("#rgxq").show();
		}
		function closeWindow() {
			$("#alertWindow").hide();
			$("#rgxq").hide();
			$("#items").empty();
		}
	</script>
	    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>
</body>
</html>