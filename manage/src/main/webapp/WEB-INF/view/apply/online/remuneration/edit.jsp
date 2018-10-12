<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<base href="<%=request.getContextPath() %>/">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>编辑劳务计算单</title>  
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
	<h1 class="title">个人所得税（劳务报酬）计算单</h1>
	<form action="apply/online/remuneration/edit" method="post" class="form-x" id="form-article-add" >
	<input type="hidden" value="${remuneration.id }" name="id"/>
		<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1" style="width: 850px;">
		<tr>
          <th>申请时间</th>
          <td colspan="7"><input type="text" class="input" id="applyDate" name="applyDate" autocomplete="off" value="<fmt:formatDate value="${remuneration.applyDate }" pattern="yyyy-MM-dd"/>"/></td>
         </tr>
         <tr>
          <th>标题</th>
          <td colspan="7"><input type="text" class="input" name="title" value="${remuneration.title }"/></td>
         </tr>
		<tr>
         	<th>姓名</th>
	        <th>身份证号码</th>
	        <th>银行卡号</th>
	        <th>开户银行</th>
	        <th>劳务金额</th>
	        <th>应交税金</th>
	        <th colspan="2">实付金额</th>
        </tr>
        <tbody id="items">
		<c:forEach items="${remuneration.detailList}" var="item" varStatus="status">
			<tr id="item${status.index}">
				<td><input type="text" class="input" name="detailList[${status.index}].name" value="${item.name }"></td>
				<td><input type="text" class="input" name="detailList[${status.index}].idCard" value="${item.idCard }"></td>
				<td><input type="text" class="input" name="detailList[${status.index}].bankCard" value="${item.bankCard }"></td>
				<td><input type="text" class="input" name="detailList[${status.index}].bankName" value="${item.bankName }"></td>
				<td><input type="text" class="input" name="detailList[${status.index}].allAmount" value="${item.allAmount }"></td>
				<td><input type="text" class="input" name="detailList[${status.index}].taxAmount" value="${item.taxAmount }"></td>
				<td><input type="text" class="input" name="detailList[${status.index}].payAmount" value="${item.payAmount }"></td>
				<td><img src="images/minus.png" style="cursor:pointer;" onclick="minusTR(${status.index})"/></td>
			</tr>
		</c:forEach>
		</tbody>
		 <tr>
		 <td colspan="8">
			<div style="text-align:center;">
				<img src="images/plus.png" style="cursor:pointer;" onclick="plusTR()"/>
			</div>
		 </td>
		</tr>
      </table>
       <div class="field">
          <button class="button bg-main icon-check-square-o" type="button" onClick="userSub();" style="margin-top:9px;margin-left:800px;"> 提交</button>
        </div>
	</form>   
	<script type="text/javascript">
	laydate.render({
	    elem: '#applyDate',
	    event: 'focus' 
	});
	
	//var num = '${fn:length(remuneration.detailList)}';
	var num = $("#items").find("tr").length-1 ;
	function plusTR(){
		num ++;
		var tr = "<tr id='item"+num+"'><td><input type='text' class='input' name='detailList[" + num + "].name'></td><td><input type='text' class='input' name='detailList[" + num + "].idCard' ></td><td><input type='text' class='input' name='detailList[" + num + "].bankCard' ></td><td><input type='text' class='input' name='detailList[" + num + "].bankName' ></td><td><input type='text' class='input' name='detailList[" + num + "].allAmount' ></td><td><input type='text' class='input' name='detailList[" + num + "].taxAmount' ></td><td><input type='text' class='input' name='detailList[" + num + "].payAmount' ></td><td><img src='images/minus.png' style='cursor:pointer;' onclick='minusTR("+ num +")'/></td></tr>";
		$("#items").append(tr);
	}
	
	function minusTR(numb){
		$("#item"+ numb).remove(); 
	}
	
	function userSub(){
		var title = $("input[name ='title']").val();
		
		if(title == '') {
			alert("标题不可以为空！");
			return ;
		}
		
		var i = 0;
		
		$("input[name$='.allAmount']").each(function(){
		    if(isNaN($(this).val())) {
		    	i++;
		    	return ;
		    }
		});
		
		if(i > 0) {
			alert("劳务金额输入错误!");
			return ;
		}
		
		var j = 0;
		
		$("input[name$='.taxAmount']").each(function(){
		    if(isNaN($(this).val())) {
		    	j++;
		    	return ;
		    }
		});
		
		if(j > 0) {
			alert("应交税金输入错误!");
			return ;
		}
		
	var k = 0;
		
		$("input[name$='.taxAmount']").each(function(){
		    if(isNaN($(this).val())) {
		    	k++;
		    	return ;
		    }
		});
		
		if(k > 0) {
			alert("实付金额输入错误!");
			return ;
		}
		
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	function goList(){
		window.location.href="apply/online/remuneration/list";
	}
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
	</body>
</html>
