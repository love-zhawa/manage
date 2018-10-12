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
    <title>产品售后</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;产品售后</strong></div>
  <div class="body-content">
  <form action="project/cpsh/edit" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
    <div class="form-group">
        <div class="label">
          <label>售后来源：</label>
        </div>
        <div class="field">
          	<c:if test="${cpsh.ly == 1}">销售</c:if>
          	<c:if test="${cpsh.ly == 2}">项目</c:if>
        </div>
      </div>
     <div class="form-group">
        <div class="label">
          <label>项目名称：</label>
        </div>
        <div class="field"> 
	        <c:if test="${cpsh.ly ==1}">${cpsh.project}</c:if>
			<c:if test="${cpsh.ly ==2}">${cpsh.projects.projectName}</c:if>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>项目编号：</label>
        </div>
        <div class="field">
         	<c:if test="${cpsh.ly ==1}">${cpsh.projectnumber}</c:if>
		    <c:if test="${cpsh.ly ==2}">${cpsh.projects.financialNumber}</c:if>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>设备名称：</label>
        </div>
        <div class="field">
         	${cpsh.sbname }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>设备型号：</label>
        </div>
        <div class="field">
         	${cpsh.sbtype }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>生产厂家：</label>
        </div>
        <div class="field">
         	${cpsh.sbhome }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>设备编号：</label>
        </div>
        <div class="field">
         	${cpsh.sbnumber }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>使用单位：</label>
        </div>
        <div class="field">
         	${cpsh.dw }
        </div>
      </div>
	  
	  <div class="form-group">
        <div class="label">
          <label>出厂日期：</label>
        </div>
        <div class="field">
          <fmt:formatDate value="${cpsh.cctime }" pattern="yyyy-MM-dd"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>上次维护时间：</label>
        </div>
        <div class="field">
          <fmt:formatDate value="${cpsh.oldtime }" pattern="yyyy-MM-dd"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>发现故障时间：</label>
        </div>
        <div class="field">
          <fmt:formatDate value="${cpsh.gztime }" pattern="yyyy-MM-dd"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>施工人员：</label>
        </div>
        <div class="field">
         	${cpsh.person }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>报修描述：</label>
        </div>
        <div class="field">
         	${cpsh.bxms }
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>详细：</label>
        </div>
        <div class="field">
          <table class="table table-hover text-center">
	      	 <tr>
	      	    <th></th>
		        <th>故障描述</th>
		        <th>解决方法</th>
		        <th>处理意见</th>
		     </tr>							
		     <tbody id="items">
					<tr>
					    <td>工程小组</td>
						<td>${cpsh.gzms1 }</td>
						<td>${cpsh.jjff1 }</td>
						<td>${cpsh.suggest1 }</td>
					</tr>
					<tr>
					    <td>生产小组</td>
						<td>${cpsh.gzms2 }</td>
						<td>${cpsh.jjff2 }</td>
						<td>${cpsh.suggest2 }</td>
					</tr>
					<tr>
					    <td>研发小组</td>
						<td>${cpsh.gzms3 }</td>
						<td>${cpsh.jjff3 }</td>
						<td>${cpsh.suggest3 }</td>
					</tr>
					
				</tbody>
	      </table>
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
		window.location.href="project/cpsh/list";
	}
	</script>
</html>