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
    <title>创建劳务计算单</title>  
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
	<form action="apply/online/remuneration/add" method="post" class="form-x" id="form-article-add" >
		<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1" style="width: 850px;">
		<tr>
          <th>申请时间</th>
          <td colspan="7"><input type="text" class="input" id="applyDate" name="applyDate" value="" autocomplete="off"/></td>
         </tr>
         <tr>
          <th>标题</th>
          <td colspan="7"><input type="text" class="input" name="title" value=""/></td>
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
			<tr id="item0">
				<td><input type="text" class="input" name="detailList[0].name"></td>
				<td><input type="text" class="input" name="detailList[0].idCard"></td>
				<td><input type="text" class="input" name="detailList[0].bankCard"></td>
				<td><input type="text" class="input" name="detailList[0].bankName"></td>
				<td><input type="text" class="input" name="detailList[0].allAmount"></td>
				<td><input type="text" class="input" name="detailList[0].taxAmount"></td>
				<td><input type="text" class="input" name="detailList[0].payAmount"></td>
				<td><img src="images/minus.png" style="cursor:pointer;" onclick="minusTR(0)"/></td>
			</tr>
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
	
	var num = 0;
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
