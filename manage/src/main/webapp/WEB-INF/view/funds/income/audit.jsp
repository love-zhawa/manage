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
    <title>编辑经费到账</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
    <style type="text/css">
    	.cc{line-height: 34px;}
    </style>
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;编辑经费到账</strong></div>
  <div class="body-content">
    <form action="funds/audit" method="post" class="form-x" id="form-article-add" >
    <input type="hidden" name="id" value="${fundsIncome.id }"/>
		
	  <div class="form-group">
        <div class="label">
          <label>隶属项目：</label>
        </div>
        <div class="field">
          ${fundsIncome.project.projectName }
        </div>
      </div>
       <div class="form-group">
        <div class="label">
          <label>财务编号：</label>
        </div>
       <div class="field cc">
          ${fundsIncome.project.financialNumber }
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>总经费：</label>
        </div>
        <div class="field cc">
           ${fundsIncome.project.totalMoney }
        </div>
       </div>
       <%-- <div class="form-group">
        <div class="label">
          <label>已到账经费：</label>
        </div>
        <div class="field">
           ${fundsIncome.incomeAmount }
        </div>
      </div> --%>
      <div class="form-group">
        <div class="label">
          <label>本次经费金额：</label>
        </div>
        <div class="field">
          ${fundsIncome.amount }
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>到账时间：</label>
        </div>
        <div class="field">
         <fmt:formatDate value="${fundsIncome.changeTime }" pattern="yyyy-MM-dd"/>
        </div>
      </div>
       <div class="form-group">
        <div class="label">
          <label>发票情况：</label>
        </div>
        <div class="field">
         <c:if test="${fundsIncome.billInfo == 0 }">已开发票</c:if>
         <c:if test="${fundsIncome.billInfo == 1 }">未开发票</c:if>
        
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>备注：</label>
        </div>
        <div class="field">
          ${fundsIncome.remark }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>审核：</label>
        </div>
        <div class="field">
        	<select class="input" name="status" style="width: 200px;">
				<option value="1">通过</option>
				<option value="2">拒绝</option>
        	</select>
        </div>
      </div> 
     <div class="form-group">
        <div class="label">
          <label></label>
        </div>
        <div class="field">
          <button class="button bg-main icon-check-square-o" type="button" onClick="userSub();"> 提交</button>
        </div>
      </div>
     </form>
       
  </div>
     
  </div>
</div>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>
</body>
	<script type="text/javascript">
	function userSub(){
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	function goList(){
		window.location.href="apply/online/remuneration/list";
	}
	</script>
</html>