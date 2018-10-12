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
    <title>创建转账单</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
<style>
h1 {text-align: center;margin-bottom: 20px;}
.table1 {width: 700px;border-collapse: collapse}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 th,.table1 td {border: 1px solid #333;}
.input{border: 0px;}
</style>
</head>
<body>
  	<h1 class="title">转账单《汇款单：本市、外埠》</h1>
		<form action="apply/online/transfer/add" method="post" class="form-x" id="form-article-add" >
			<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1">
			<tr>
	          <th style="width: 170px;">申请时间</th>
	          <td colspan="3"><input type="text" class="input" id="transDate" name="transDate" value="" autocomplete="off"/></td>
	        </tr>
			<tr>
	          <th style="width: 170px;">收款单位</th>
	          <td colspan="3"><input type="text" class="input" name="receiveUnit" value=""/></td>
	        </tr>
	        <tr>
	          <th>账&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号</th>
	          <td colspan="3"><input type="text" class="input" name="accountId" value=""/></td>
	        </tr>
	        <tr>
	          <th>开户银行</th>
	          <td colspan="3"><input type="text" class="input" name="bank" maxlength="50"/></td>
	        </tr>
	        <tr>
	          <th>金&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;额</th>
	          <td colspan="3"><input type="text" class="input" name="amount" maxlength="10"/></td>
	        </tr>
	        
	        <tr>
	          <th>汇款用途</th>
	          <td><input type="text" class="input" name="useInfo" maxlength="50"/></td>
	          <th style="width: 170px;">支出单位</th>
	          <td style="width: 180px;"><input type="text" class="input" name="payUnit" maxlength="20"/></td>
	        </tr>
	        
	        <tr>
	          <th>支出项目</th>
	          <td>
				<select class="input" name="project.id" style="width: 300px;">
		          	<c:forEach var="project" items="${projectList}">
		          		<option value="${project.id }">${project.projectName }</option>
		          	</c:forEach>
	            </select>
			  </td>
	          <th>财务编号</th>
	          <td><input type="text" class="input" name="number" maxlength="10"/></td>
	        </tr>
	        
	        <tr>
	          <th>分类明细</th>
	          <td><input type="text" class="input" name="detail" maxlength="10"/></td>
	          <th>合&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;同</th>
	          <td>
		          <label><input name="pact" type="radio" checked="checked" class="ace" value="0"><span class="lbl">有</span></label>&nbsp;&nbsp;
				  <label><input name="pact" type="radio" class="ace" value="1"><span class="lbl">无</span></label>&nbsp;&nbsp;
	          </td>
	        </tr>
	        <tr>
	          <th>发票状态</th>
	          <td>
	              <label><input name="status" type="radio" checked="checked" class="ace" value="0"><span class="lbl">有</span></label>&nbsp;&nbsp;
				  <label><input name="status" type="radio" class="ace" value="1"><span class="lbl">无</span></label>&nbsp;&nbsp;
	          </td>
	          <th>归还天数</th>
	          <td><input type="text" class="input" name="workDay" maxlength="10"/></td>
	        </tr>
	        <tr>
	          <th>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
	          <td colspan="3"><input type="text" class="input" name="remark" maxlength="100"/></td>
	        </tr>
	      </table>
      		<div class="field">
	          <button class="button bg-main icon-check-square-o" type="button" onClick="userSub();" style="margin-top:9px;margin-left:800px;"> 提交</button>
	        </div>
	  </form>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	   
</body>
<script type="text/javascript">
	laydate.render({
	    elem: '#transDate',
	    event: 'focus' 
	});
	function userSub(){
		var amount = $("input[name ='amount']").val();
		var workDay = $("input[name ='workDay']").val();
		var status = $("select[name ='status']").val();
		if(status == 0) {
			$("input[name ='workDay']").val("");
		}
		
		if(amount != '') {
			if(isNaN(amount)) {
				alert("金额输入错误！");
				return ;
			}
		}
		
		if(workDay != '') {
			if(isNaN(workDay)) {
				alert("归还天数输入错误！");
				return ;
			}
		}
		
		
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	function goList(){
		window.location.href="product/list";
	}
	</script>
</html>