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
    <title>编辑专家费报销单</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
<style>
h1 {text-align: center;margin-bottom: 20px;}
.table1 {width: 1000px;border-collapse: collapse}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 th,.table1 td {border: 1px solid #333;}
.input{border: 0px;}
</style>
</head>
<body>
<h1 class="title">专家费报销单</h1>
	<form action="apply/online/expertfee/edit" method="post" class="form-x" id="form-article-add" >
	<input type="hidden" value="${expertFee.id}" name="id"/>
		<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1" style="width: 1000px">
		<tr>
		  <th>申请时间</th>
          <td colspan="8"><input type="text" class="input" id="applyDate" name="applyDate" autocomplete="off" value="<fmt:formatDate value="${expertFee.applyDate }" pattern="yyyy-MM-dd"/>"/></td>
        </tr>
        <tr>
          <th>标题</th>
          <td colspan="8"><input type="text" class="input" name="title" value="${expertFee.title }"/></td>
        </tr>
        <tr>
            <th>姓名</th>
	        <th>身份证号码</th>
	        <th>工作单位</th>
	        <th>职称</th>
	        <th>咨询天数/次数</th>
	        <th>银行卡号</th>
	        <th>开户银行</th>
	        <th>实付金额</th>
	        <th></th>
        </tr>
        <tbody id="items">
			<c:forEach items="${expertFee.detailList}" var="item" varStatus="status">
				<tr id="item${status.index}">
					<td><input type="text" class="input" name="detailList[${status.index}].name" value="${item.name }"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].idCard" value="${item.idCard }"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].unit" value="${item.unit }"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].title" value="${item.title }"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].days" value="${item.days }"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].bankCard" value="${item.bankCard }"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].baneName" value="${item.baneName }"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].amount" value="${item.amount }"></td>
					<td><img src="images/minus.png" style="cursor:pointer;" onclick="minusTR(${status.index})"/></td>
				</tr>
			</c:forEach>
			</tbody>
		<tr>
		 <td colspan="9">
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
	
	var num = '${fn:length(expertfee.detailList)}';
	function plusTR(){
		num ++;
		var tr = "<tr id='item"+num+"'><td><input type='text' class='input' name='detailList[" + num + "].name'></td><td><input type='text' class='input' name='detailList[" + num + "].idCard' ></td><td><input type='text' class='input' name='detailList[" + num + "].unit' ></td><td><input type='text' class='input' name='detailList[" + num + "].title' ></td><td><input type='text' class='input' name='detailList[" + num + "].days' ></td><td><input type='text' class='input' name='detailList[" + num + "].bankCard' ></td><td><input type='text' class='input' name='detailList[" + num + "].baneName' ></td><td><input type='text' class='input' name='detailList[" + num + "].amount' ></td><td><img src='images/minus.png' style='cursor:pointer;' onclick='minusTR("+ num +")'/></td></tr>";
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
		
		$("input[name$='.days']").each(function(){
		    if(isNaN($(this).val())) {
		    	i++;
		    	return ;
		    }
		});
		
		if(i > 0) {
			alert("咨询天数/次数错误!");
			return ;
		}
		
		var j = 0;
		
		$("input[name$='.amount']").each(function(){
		    if(isNaN($(this).val())) {
		    	j++;
		    	return ;
		    }
		});
		
		if(j > 0) {
			alert("实付金额输入错误!");
			return ;
		}
		
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	function goList(){
		window.location.href="apply/online/expertfee/list";
	}
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
	</body>
</html>
