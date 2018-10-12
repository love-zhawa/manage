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
<form action="jxc/yqj/list" method="post" id="searchForm">
  <div class="panel admin-panel">
    <div class="panel-head cl">
    	<strong class="icon-reorder">&nbsp;&nbsp;元器件管理</strong>
    </div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
        <shiro:hasPermission name="jxc_production_add">
        <li> <a class="button border-main icon-plus-square-o" href="javascript:void(0);" onclick="toAdd()">&nbsp;添加</a> </li>
        </shiro:hasPermission>
        <li>搜索：</li>
        <li>
          <input type="text" placeholder="输入名称" name="name" class="input" style="width:200px; line-height:17px;display:inline-block"  value="${name }" />
          <input type="text" placeholder="输入类型" name="lx" class="input" style="width:200px; line-height:17px;display:inline-block"  value="${lx }" />
          <a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()" > 搜索</a></li>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th>序号</th>
		<th>名称</th>
		<th>类型</th>
		<th>数量</th>
		<th>规格</th>
		<th>品牌</th>
		<th>厂家</th>
		<th>图片</th>
		<th>操作</th>
      </tr>
      <c:forEach items="${yqjList}" var="y" varStatus="status">
			<tr>
	          <td>${(page.currPage - 1) * page.pageRows + status.index+1}</td>
	          <td><u style="cursor:pointer" class="text-primary" onclick="detail('${y.id}')">${y.name}</u></td>
	          <td>${y.lx}</td>
	          <td>${y.amount }</td>
	          <td>${y.gg }</td>
	          <td>${y.pp }</td>
	          <td>${y.home }</td>
	          <td>
	          	<c:if test="${y.file != null}">
	          		<img src="productImage/${y.file }" style="width: 50px;height: 50px;">
	          	</c:if>
	          </td>
	          <td class="td-manage">
	          	<div class="button-group">
		        	<shiro:hasPermission name="jxc_production_edit">
		        	<a class="button border-main" onclick="toedit('${y.id}')" href="javascript:;">
	          			<span class="icon-edit"></span> 编辑
	          		</a>
	          		</shiro:hasPermission>
	          		<shiro:hasPermission name="jxc_production_delete">
	          		<a class="button border-red" onclick="todel('${y.id}')" href="javascript:;">
	         			<span class="icon-trash-o"></span> 删除
	         		</a>
	         		</shiro:hasPermission>
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
		function changesearch(){
			$("#searchForm").submit();
		}
		
		function toAdd(){
			window.location.href="jxc/yqj/toadd";
		}
		function toedit(id){
			window.location.href="jxc/yqj/toedit/"+id;
		}
		function detail(id){
			window.location.href="jxc/yqj/detail/"+id;
		}
		
		function todel(id){
			if(confirm("确认删除？")){
				window.location.href="jxc/yqj/del/"+id;
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