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
<form action="jxc/income/list" method="post" id="searchForm">
  <div class="panel admin-panel">
    <div class="panel-head cl">
    	<strong class="icon-reorder">&nbsp;&nbsp;入库列表</strong>
    </div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
        <shiro:hasPermission name="jxc_out_add">
        <li> <a class="button border-main icon-plus-square-o" href="javascript:void(0);" onclick="toAdd()">添加入库单</a> </li>
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
          	<input type="text" placeholder="输入产品用途" name="purpose" class="input" style="width:200px; line-height:17px;display:inline-block"  value="${purpose }" />
          </li>
          <li>
          	<a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()" > 搜索</a>
          </li>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th>序号</th>
		<th>产品用途</th>
		<th>产品名称</th>
		<th>产品型号</th>
		<th>厂家</th>
		<th>数量</th>
		<th>备注</th>
		<th>图片</th>
		<th>操作</th>
      </tr>
      <c:forEach items="${detailList}" var="detail" varStatus="status">
			<tr>
	          <td>${(page.currPage - 1) * page.pageRows + status.index+1}</td>
	          <td>
	          	<c:if test="${detail.ly == 1 || detail.ly == 2}">${detail.outStore.purpose}</c:if>
	          	<c:if test="${detail.purchaseApply.purpose ne null }">${detail.purchaseApply.purpose}</c:if>
	          </td>
	          <td>${detail.productType.typeName }</td>
	          <td>${detail.model }</td>
	          <td>${detail.manufacturer }</td>
	          <td>${detail.amount }</td>
	          <td>${detail.remark }
	            <c:if test="${detail.ly == 1 }">(来源：借用返还)</c:if>
				<c:if test="${detail.ly == 2 }">(来源：其他)</</c:if></td>
	          <td>
	          	<c:if test="${detail.image != null }">
	          		<img src="/upload/${detail.image }">
	          	</c:if>
	          </td>
	          <td class="td-manage">
	          	<div class="button-group">
	          		<c:if test="${detail.status == 1 }">
	          			<shiro:hasPermission name="jxc_income_edit">
	          			<a class="button border-main" onclick="toedit('${detail.id}')" href="javascript:;">
		          			<span class="icon-edit"></span> 编辑
		          		</a>
		          		</shiro:hasPermission>
		          		<shiro:hasPermission name="jxc_income_store">
		          		<a class="button border-green" onclick="incomestore('${detail.id}')" href="javascript:;">
		          			<span class="icon-plus"></span> 入库
		          		</a>
		          		</shiro:hasPermission>
		          		<shiro:hasPermission name="jxc_income_cancel">
		          		<a class="button border-red" href="javascript:void(0)" onclick="canclestore('${detail.id}')">
		          			<span class="icon-trash-o"></span> 取消
		          		</a>
		          		</shiro:hasPermission>
	          		</c:if>
	          		<c:if test="${detail.status == 5 && (detail.ly == 1 || detail.ly == 2)}">
	          			<shiro:hasPermission name="jxc_income_edit">
	          			<a class="button border-main" onclick="toedits('${detail.id}')" href="javascript:;">
		          			<span class="icon-edit"></span> 编辑
		          		</a>
		          		</shiro:hasPermission>
		          		<shiro:hasPermission name="jxc_income_store">
		          		<a class="button border-green" onclick="incomestore('${detail.id}')" href="javascript:;">
		          			<span class="icon-plus"></span> 入库
		          		</a>
		          		</shiro:hasPermission>
		          		<shiro:hasPermission name="jxc_income_cancel">
		          		<a class="button border-red" href="javascript:void(0)" onclick="todel('${detail.id}')">
		          			<span class="icon-trash-o"></span> 删除
		          		</a>
		          		</shiro:hasPermission>
	          		</c:if>
	          	</div>
	          </td>
			</tr>
		</c:forEach>
      	<jsp:include page="../../include/page.jsp">
      		<jsp:param value="9" name="colspan"/>
      	</jsp:include>
    </table>
  </div>
</form>
	<script type="text/javascript">
		function changesearch(){
			$("#searchForm").submit();
		}
		function toAdd(){
			window.location.href="jxc/income/toadd";
		}
		function toedit(id){
			window.location.href="jxc/income/toedit/"+id;
		}
		function toedits(id){
			window.location.href="jxc/income/toedits/"+id;
		}
		
		function incomestore(id){
			window.location.href = "jxc/income/plus/"+id;
		}
		
		function canclestore(id){
			window.location.href = "jxc/income/cancel/"+id;
		}
		function todel(id) {
			if(confirm("确认删除？")){
				$.post("jxc/income/del",{"id":id},function(data){
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