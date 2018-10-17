<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<head>
	<base href="<%=request.getContextPath() %>/">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>编辑差旅报销单</title>  
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
	<h1 class="title">差 旅 费 报 销 单</h1>
	<form action="apply/online/trval/edit" method="post" class="form-x" id="form-article-add" >
	<input type="hidden" value="${trval.id }" name="id"/>
		<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1" style="width: 1000px">
		<tr>
		  <th colspan="2">出差人</th>
          <td colspan="3">${username}</td>
          <th colspan="2">申请时间</th>
          <td colspan="2"><input type="text" class="input" id="travelDate" name="travelDate" autocomplete="off" value="<fmt:formatDate value="${trval.travelDate }" pattern="yyyy-MM-dd"/>"/></td>
          <th colspan="2">出差事由</th>
          <td colspan="7"><input type="text" class="input" name="reason" value="${trval.reason }"/></td>
        </tr>
        <tr>
          <th colspan="3">出发</th>
          <th colspan="3">到达</th>
          <th></th>
          <th colspan="2">交通费</th>
          <th colspan="2">住宿费</th>
          <th colspan="2">交通补助</th>
          <th colspan="2">伙食补助</th>
          <th colspan="3">其他</th>
        </tr>
        <tr>
          <th colspan="2">出发日期</th>
          <th>地点</th>
          <th colspan="2">到达日期</th>
          <th>地点</th>
          <th>城市间<br/>交通工具</th>
          <th>单据<br/>张数</th>
          <th>金额</th>
          <th>单据<br/>张数</th>
          <th>金额</th>
          <th>天数</th>
          <th>金额</th>
          <th>天数</th>
          <th>金额</th>
          <th>单据<br/>张数</th>
          <th colspan="2">金额</th>
        </tr>
        <tbody id="items">
	     	<c:forEach items="${trval.detailList}" var="item" varStatus="status">
				<tr id="item${status.index}">
					<td colspan="2"><input type="text" class="input" id="outDate${status.index}" name="detailList[${status.index}].outDate" value="<fmt:formatDate value="${item.outDate }" pattern="yyyy-MM-dd"/>"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].outAddr" value="${item.outAddr }"></td>
					<td colspan="2"><input type="text" class="input" id="arriveDate${status.index}" name="detailList[${status.index}].arriveDate" value="<fmt:formatDate value="${item.arriveDate }" pattern="yyyy-MM-dd"/>"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].arriveAddr" value="${item.arriveAddr }"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].vehicle" value="${item.vehicle }"></td>
					
					<td><input type="text" class="input" name="detailList[${status.index}].trafficSum" value="${item.trafficSum }"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].trafficAmount" value="${item.trafficAmount }"></td>
					
					<td><input type="text" class="input" name="detailList[${status.index}].liveSum" value="${item.liveSum }"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].liveAmount" value="${item.liveAmount }"></td>
					
					<td><input type="text" class="input" name="detailList[${status.index}].trafficSubsidyDays" value="${item.trafficSubsidyDays }"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].trafficSubsidyAmount" value="${item.trafficSubsidyAmount }"></td>
					
					<td><input type="text" class="input" name="detailList[${status.index}].foodSubsidyDays" value="${item.foodSubsidyDays }"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].foodSubsidyAmount" value="${item.foodSubsidyAmount }"></td>
					
					<td><input type="text" class="input" name="detailList[${status.index}].otherSum" value="${item.otherSum }"></td>
					<td><input type="text" class="input" name="detailList[${status.index}].otherAmount" value="${item.otherAmount }"></td>
					<td><img src="images/minus.png" style="cursor:pointer;" onclick="minusTR(${status.index})"/></td>
				</tr>
			</c:forEach>
		</tbody>
		<tr>
		 <td colspan="18">
			<div style="text-align:center;">
				<img src="images/plus.png" style="cursor:pointer;" onclick="plusTR()"/>
			</div>
		 </td>
		</tr>
		<tr>
          <th colspan="7">报销金额</th>
          <td colspan="11">
          	公务卡：<span style="width: 70px; display: inline-block;"><input type="text" class="input" name="card" value="${trval.card }"/></span>
          	支票：<span style="width: 70px; display: inline-block;"><input type="text" class="input" name="cheque" value="${trval.cheque }"/></span>
          	现金：<span style="width: 70px; display: inline-block;"><input type="text" class="input" name="money" value="${trval.money }"/></span>
          </td>
        </tr>
      </table>
      <div class="field">
         <button class="button bg-main icon-check-square-o" type="button" onClick="userSub();" style="margin-top:9px;margin-left:800px;"> 提交</button>
       </div>
     </form>
	<script type="text/javascript">
	laydate.render({
	    elem: '#travelDate',
	    event: 'focus' 
	});
	
	var num = '${fn:length(trval.detailList)}';
	
	$(function () {
		for( var a =0; a<num; a++) {
			laydate.render({
			    elem: '#arriveDate' + a,
			    event: 'focus' 
			});
			laydate.render({
			    elem: '#outDate' + a,
			    event: 'focus' 
			});
		}
	});
	
	function plusTR(){
		num ++;
		var tr = "<tr id='item"+num+"'>";
		tr += "<td colspan='2'><input type='text' class='input' id='outDate"+num+"' name='detailList["+num+"].outDate'></td>";
		tr += "<td><input type='text' class='input' name='detailList["+num+"].outAddr'></td>";
		tr += "<td colspan='2'><input type='text' class='input' id='arriveDate"+num+"' name='detailList["+num+"].arriveDate'></td>";
		tr += "<td><input type='text' class='input' name='detailList["+num+"].arriveAddr'></td>";
		tr += "<td><input type='text' class='input' name='detailList["+num+"].vehicle'></td>";
		
		tr += "<td><input type='text' class='input' name='detailList["+num+"].trafficSum'></td>";
		tr += "<td><input type='text' class='input' name='detailList["+num+"].trafficAmount'></td>";
		
		tr += "<td><input type='text' class='input' name='detailList["+num+"].liveSum'></td>";
		tr += "<td><input type='text' class='input' name='detailList["+num+"].liveAmount'></td>";
		
		tr += "<td><input type='text' class='input' name='detailList["+num+"].trafficSubsidyDays'></td>";
		tr += "<td><input type='text' class='input' name='detailList["+num+"].trafficSubsidyAmount'></td>";
		
		tr += "<td><input type='text' class='input' name='detailList["+num+"].foodSubsidyDays'></td>";
		tr += "<td><input type='text' class='input' name='detailList["+num+"].foodSubsidyAmount'></td>";
		
		tr += "<td><input type='text' class='input' name='detailList["+num+"].otherSum'></td>";
		tr += "<td><input type='text' class='input' name='detailList["+num+"].otherAmount'></td>";
		tr += "<td><img src='images/minus.png' style='cursor:pointer;' onclick='minusTR("+num+")'/></td>";
		tr += "</tr>";
		$("#items").append(tr);
		
		laydate.render({
		    elem: '#outDate' + num,
		    event: 'focus' 
		});
		
		laydate.render({
		    elem: '#arriveDate' + num,
		    event: 'focus' 
		});
	}
	
	function minusTR(numb){
		$("#item"+ numb).remove(); 
	}
	
	function userSub(){
		var name = $("input[name ='name']").val();
		var card = $("input[name ='card']").val();
		var cheque = $("input[name ='cheque']").val();
		var money = $("input[name ='money']").val();
		if(name == '') {
			alert("出差人不可以为空！");
			return ;
		}
		
		if(card != ''){
			if(isNaN(card)) {
				alert("公务卡输入错误!");
				return ;
			}
		}
		
		if(cheque != ''){
			if(isNaN(cheque)) {
				alert("支票输入错误!");
				return ;
			}
		}
		
		if(money != ''){
			if(isNaN(money)) {
				alert("现金输入错误!");
				return ;
			}
		}
		
		var names = ['trafficSum','trafficAmount','liveSum','liveAmount','trafficSubsidyDays','trafficSubsidyAmount','foodSubsidyDays','foodSubsidyAmount','otherSum','otherAmount'];
		var errs = ['交通费单据张数','交通费金额','住宿费单据张数','住宿费金额','交通补助天数','交通补助金额','伙食补助天数','伙食补助金额','其他单据张数','其他金额'];
		
		var j = 0;
		$.each(names,function(index,value){
			
			var i = 0;
			$("input[name$='."+value+"']").each(function(){
			    if(isNaN($(this).val())) {
			    	i++;
				    j++;
			    }
			});
			
			if(i > 0) {
				alert(errs[index] + "输入错误!");
				i = 0;
				return false;
			}
		});
		
		if(j == 0) {
			if(confirm("确认提交？")) {
				$("#form-article-add").submit();
			}
		}
		
	}
	function goList(){
		window.location.href="apply/online/trval/list";
	}
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
	</body>
</html>
