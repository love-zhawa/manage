<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<base href="<%=request.getContextPath() %>/">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>项目售后</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;项目售后详情</strong></div>
  <div class="body-content">
  <form action="project/xmsh/edit" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
    <input type="hidden" class="input" id="id" name="id" value="${xmsh.id }"/>
      <div class="form-group">
        <div class="label">
          <label>使用项目：</label>
        </div>
        <div class="field">
          <c:forEach var="project" items="${projectList}">
          	<c:if test="${project.id eq xmsh.project.id }">${project.projectName }</c:if>
          </c:forEach>
        </div>
      </div>
	  <div class="form-group">
        <div class="label">
          <label>维修单号：</label>
        </div>
        <div class="field">
          ${xmsh.number }
        </div>
      </div>
	  <div class="form-group">
        <div class="label">
          <label>报修单位：</label>
        </div>
        <div class="field">
          ${xmsh.bxdept }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>报修人：</label>
        </div>
        <div class="field">
          ${xmsh.bxperson }
        </div>
      </div>
       <div class="form-group">
        <div class="label">
          <label>报修时间：</label>
        </div>
        <div class="field">
          <fmt:formatDate value="${xmsh.bxtime }" pattern="yyyy-MM-dd"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>购买日期：</label>
        </div>
        <div class="field">
          <fmt:formatDate value="${xmsh.buytime }" pattern="yyyy-MM-dd"/>
        </div>
      </div>
	  <div class="form-group">
        <div class="label">
          <label>维修类型：</label>
        </div>
        <div class="field">
          	<c:if test="${xmsh.wxtype == 1}">返厂维修</c:if>
          	<c:if test="${xmsh.wxtype == 2}">现场维护</c:if>
          	<c:if test="${xmsh.wxtype == 3}">售后更换</c:if>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>是否在报修期范围内：</label>
        </div>
        <div class="field">
          	<c:if test="${xmsh.isbxq == 1}">是</c:if>
          	<c:if test="${xmsh.isbxq == 2}">否</c:if>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>报修设备：</label>
        </div>
        <div class="field">
          ${xmsh.bxsb }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>设备故障：</label>
        </div>
        <div class="field">
          ${xmsh.sbgz }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>维修人：</label>
        </div>
        <div class="field">
          ${xmsh.wxperson }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>报告人：</label>
        </div>
        <div class="field">
          ${xmsh.bgperson }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>故障处理结果：</label>
        </div>
        <div class="field">
          ${xmsh.result }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>维修报告：</label>
        </div>
        <div class="field">
          ${xmsh.wxreport }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>备注：</label>
        </div>
        <div class="field">
          ${xmsh.bz }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>维修金额：</label>
        </div>
        <div class="field">
          ${xmsh.wxmoney }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>到账金额：</label>
        </div>
        <div class="field">
          ${xmsh.dzmoney }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>未到账金额：</label>
        </div>
        <div class="field">
          ${xmsh.nomoney }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>到账单位：</label>
        </div>
        <div class="field">
          ${xmsh.dzdw }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>到账时间：</label>
        </div>
        <div class="field">
         <fmt:formatDate value="${xmsh.dztime }" pattern="yyyy-MM-dd"/>
        </div>
      </div>
      </form>
  </div>
</div>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>
</body>
	<script type="text/javascript">
	function goList(){
		window.location.href="project/xmsh/list";
	}
	</script>
</html>