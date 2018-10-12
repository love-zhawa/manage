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
    <title>外拨经费审核</title>  
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
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;外拨经费审核</strong></div>
  <div class="body-content">
    <form action="funds/out/audit" method="post" class="form-x" id="form-article-add" >
      <input type="hidden" value="${dialOutFund.id }" name="id"/>
      <div class="form-group">
        <div class="label">
          <label>时间：</label>
        </div>
        <div class="field">
         <fmt:formatDate value="${dialOutFund.outTime }" pattern="yyyy-MM-dd"/>
        </div>
      </div>
		
	  <div class="form-group">
        <div class="label">
          <label>支出项目：</label>
        </div>
        <div class="field cc">
          ${dialOutFund.project.projectName }
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>财务编号：</label>
        </div>
        <div class="field cc">
           ${dialOutFund.project.financialNumber }
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>收款单位：</label>
        </div>
        <div class="field cc" id="totalAmount">
          ${dialOutFund.unit }
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>金额：</label>
        </div>
        <div class="field">
          ${dialOutFund.amount }
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>经办人：</label>
        </div>
        <div class="field">
          ${dialOutFund.dealMan }
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>备注：</label>
        </div>
        <div class="field">
          ${dialOutFund.remark }
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