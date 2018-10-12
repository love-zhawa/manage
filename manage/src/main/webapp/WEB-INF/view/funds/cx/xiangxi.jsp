<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<base href="<%=request.getContextPath() %>/">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>查询详细</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;查询详细信息</strong></div>
  <div class="body-content">
    <form action="" method="post" class="form-x" id="form-article-add" >
    	<div class="form-group">
	        <div class="label">
	          <label>类别：</label>
	        </div>
	        <div class="field cc">
	          	日常报销
	        </div>
	      </div>
	      <div class="form-group">
	        <div class="label">
	          <label>申请人：</label>
	        </div>
	        <div class="field cc">
	          ${reimbursement.applyUser }
	        </div>
	      </div>
	      <div class="form-group">
	        <div class="label">
	          <label>申请时间：</label>
	        </div>
	        <div class="field cc">
	          <fmt:formatDate value="${reimbursement.reDate }" pattern="yyyy-MM-dd"/>
	        </div>
	      </div>
			
			<div class="form-group">
	        <div class="label">
	          <label>支出单位：</label>
	        </div>
	        <div class="field cc">
	      		<c:if test="${reimbursement.payUnit == '北京农业信息技术研究中心'}">北京农业信息技术研究中心</c:if>
	          	<c:if test="${reimbursement.payUnit == '北京农业智能装备技术研究中心'}">北京农业智能装备技术研究中心</c:if>
	          	<c:if test="${reimbursement.payUnit == '北京派得伟业科技发展有限公司'}">北京派得伟业科技发展有限公司</c:if>
	          	<c:if test="${reimbursement.payUnit == '农芯科技（北京）有限责任公司'}">农芯科技（北京）有限责任公司</c:if>
	          	<c:if test="${reimbursement.payUnit == '北京市农林科学院'}">>北京市农林科学院</c:if>
	          	<c:if test="${reimbursement.payUnit == '北京智慧农业物联网产业技术创新战略联盟'}">>北京智慧农业物联网产业技术创新战略联盟</c:if>
	          	<c:if test="${reimbursement.payUnit == '北京农业智能装备技术研究中心（软硬件实验室）'}">北京农业智能装备技术研究中心（软硬件实验室）</c:if>
	        </div>
	      </div>
	      
		 <div class="form-group">
	        <div class="label">
	          <label>支出项目：</label>
	        </div>
	        <div class="field cc">
	          ${reimbursement.project.projectName }
	        </div>
	      </div>
	      
	      <div class="form-group">
	        <div class="label">
	          <label>财务编号：</label>
	        </div>
	        <div class="field cc">
	           ${reimbursement.project.financialNumber }
	        </div>
	      </div>
	
	      <div class="form-group">
	        <div class="label">
	          <label>分类科目：</label>
	        </div>
	        <div class="field cc">
	          ${reimbursement.detail }
	        </div>
	      </div>
	      
	      <div class="form-group">
	        <div class="label">
	          <label>票据张数：</label>
	        </div>
	        <div class="field cc">
	          ${reimbursement.sum }
	        </div>
	      </div>
	      
	      <div class="form-group">
	        <div class="label">
	          <label>理由：</label>
	        </div>
	        <div class="field cc">
	          ${reimbursement.reason }
	        </div>
	      </div>
	      
	      <div class="form-group">
	        <div class="label">
	          <label>附件明细：</label>
	        </div>
	        <div class="field cc">
	          <table class="table table-hover text-center">
		      	 <tr>
			        <th>明细</th>
			        <th>金额</th>
			     </tr>
			     <tbody id="items">
				     <c:forEach items="${detailList}" var="item" varStatus="status">
						<tr id="item${status.index}">
							<td>${item.detail }</td>
							<td id="amount${status.index}">${item.amount }</td>
						</tr>
					</c:forEach>
				</tbody>
		      </table>
	        </div>
	      </div>
	      
	      <div class="form-group">
	        <div class="label">
	          <label></label>
	        </div>
	        <div class="field">
	          <button class="button bg-main icon-check-square-o" type="button" onClick="goList();"> 返回</button>
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
		window.location.href="funds/cx/list";
	}
	</script>
</html>