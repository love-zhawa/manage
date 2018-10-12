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
    <title>编辑差旅报销单</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;编辑差旅报销单</strong></div>
  <div class="body-content">
    <form action="funds/trval/edit" method="post" class="form-x" id="form-article-add" >
    <input type="hidden" value="${trval.id }" name="id"/>
    <input type="hidden" value="${trval.status }" name="status"/>
      <div class="form-group">
        <div class="label">
          <label>申请时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="travelDate" name="travelDate" autocomplete="off" value="<fmt:formatDate value="${trval.travelDate }" pattern="yyyy-MM-dd"/>"/>
        </div>
      </div>
		 <div class="form-group">
        <div class="label">
          <label>支出项目：</label>
        </div>
        <div class="field">
          <select name="project.id" class="input w50" style="width: 300px;" onchange="projectChange()">
          	<option value="">全部</option>
          	<c:forEach items="${projectList }" var="project">
          		<option <c:if test="${trval.project.id == project.id }">selected</c:if> value="${project.id }">${project.projectName }</option>
          	</c:forEach>
          </select>
        </div>
      </div>
       <div class="form-group">
        <div class="label">
          <label>财务编号：</label>
        </div>
       <div class="field cc" id="financialNumber">
       
        </div>
        <input type="hidden" class="input" id="totalMoney" name="totalMoney"/>
      </div>
		<div class="form-group">
        <div class="label">
          <label>出差人：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="name" value="${trval.name }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>出差事由：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="reason" value="${trval.reason }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>公务卡：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="card" value="${trval.card }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>支票：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="cheque" value="${trval.cheque }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>现金：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="money" value="${trval.money }"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>备注：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="remark" value="${trval.remark }" maxlength="200"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>明细：</label>
        </div>
        <div class="field">
          <table class="table table-hover text-center">
		        <tr>
		          <th colspan="3">出发</th>
		          <th colspan="3">到达</th>
		          <th></th>
		          <th colspan="2">交通费</th>
		          <th colspan="2">住宿费</th>
		          <th colspan="2">交通补助</th>
		          <th colspan="2">伙食补助</th>
		          <th colspan="2">其他</th>
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
		          <th>金额</th>
		          <th></th>
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
	      </table>
	      <div style="text-align:center;">
				<img src="images/plus.png" style="cursor:pointer;" onclick="plusTR()"/>
			</div>
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
	projectChange();
	
	function projectChange(){
		var projectId = $("select[name='project.id']").val();
		if(projectId == '') {
		    $("#financialNumber").html('');
		    $("#totalMoney").val('');
		}
		
		$.post("project/view/" + projectId,{},function(result){
			$("#financialNumber").html(result.financialNumber);
			$("#totalMoney").val(result.totalMoney);
		});
	}
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
		var totalMoney = $("#totalMoney").val();
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
		var sums = 0;
		var sum1 = 0;
		var sum2 = 0;
		var sum3 = 0;
		var sum4 = 0;
		var sum5 = 0;
		var tableId = document.getElementById("items"); 
		for(var i=0;i<tableId.rows.length;i++) { 
			amounts1 = tableId.rows[i].cells[6].getElementsByTagName("INPUT")[0].value;
			sum1 = parseFloat(sum1) + parseFloat(amounts1); 
			amounts2 = tableId.rows[i].cells[8].getElementsByTagName("INPUT")[0].value;
			sum2 = parseFloat(sum2) + parseFloat(amounts2); 
			amounts3 = tableId.rows[i].cells[10].getElementsByTagName("INPUT")[0].value;
			sum3 = parseFloat(sum3) + parseFloat(amounts3); 
			amounts4 = tableId.rows[i].cells[12].getElementsByTagName("INPUT")[0].value;
			sum4 = parseFloat(sum4) + parseFloat(amounts4); 
			amounts5 = tableId.rows[i].cells[14].getElementsByTagName("INPUT")[0].value;
			sum5 = parseFloat(sum5) + parseFloat(amounts5); 
		} 
		sums = sum1+sum2+sum3+sum4+sum5;
		if(eval(sums)>eval(totalMoney)){
			alert("报销金额不可超过经费总金额！");
			return;
		}
		if(j == 0) {
			if(confirm("确认提交？")) {
				$("#form-article-add").submit();
			}
		}
		
	}
	function goList(){
		window.location.href="funds/trval/list";
	}
	</script>
</html>