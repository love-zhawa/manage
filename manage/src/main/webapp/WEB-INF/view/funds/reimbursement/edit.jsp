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
    <title>编辑报销单</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;编辑报销单</strong></div>
  <div class="body-content">
    <form action="funds/reimbursement/edit" method="post" class="form-x" id="form-article-add" >
    	<input type="hidden" value="${reimbursement.id}" name="id"/>
    	<input type="hidden" value="${reimbursement.status}" name="status"/>
      <div class="form-group">
        <div class="label">
          <label>申请时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="reDate" name="reDate" autocomplete="off" value="<fmt:formatDate value="${reimbursement.reDate }" pattern="yyyy-MM-dd"/>"/>
        </div>
      </div>
		
		<div class="form-group">
        <div class="label">
          <label>支出单位：</label>
        </div>
        <div class="field">
          <select name="payUnit" class="input w50" style="width: 300px;">
      		<option <c:if test="${reimbursement.payUnit == '北京农业信息技术研究中心'}">selected</c:if> value="北京农业信息技术研究中心">北京农业信息技术研究中心</option>
          	<option <c:if test="${reimbursement.payUnit == '北京农业智能装备技术研究中心'}">selected</c:if> value="北京农业智能装备技术研究中心">北京农业智能装备技术研究中心</option>
          	<option <c:if test="${reimbursement.payUnit == '北京派得伟业科技发展有限公司'}">selected</c:if> value="北京派得伟业科技发展有限公司">北京派得伟业科技发展有限公司</option>
          	<option <c:if test="${reimbursement.payUnit == '农芯科技（北京）有限责任公司'}">selected</c:if> value="农芯科技（北京）有限责任公司">农芯科技（北京）有限责任公司</option>
          	<option <c:if test="${reimbursement.payUnit == '北京市农林科学院'}">selected</c:if> value="北京市农林科学院">北京市农林科学院</option>
          	<option <c:if test="${reimbursement.payUnit == '北京智慧农业物联网产业技术创新战略联盟'}">selected</c:if> value="北京智慧农业物联网产业技术创新战略联盟">北京智慧农业物联网产业技术创新战略联盟</option>
          	<option <c:if test="${reimbursement.payUnit == '北京农业智能装备技术研究中心（软硬件实验室）'}">selected</c:if> value="北京农业智能装备技术研究中心（软硬件实验室）">北京农业智能装备技术研究中心（软硬件实验室）</option>
      	  </select>
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
          		<option <c:if test="${reimbursement.project.id == project.id }">selected</c:if> value="${project.id }">${project.projectName }</option>
          	</c:forEach>
          </select>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>财务编号：</label>
        </div>
        <div class="field" id="financialNumber">
          <%-- <input type="text" class="input" name="number" maxlength="10" value="${reimbursement.number }"/> --%>
        </div>
         <input type="hidden" class="input" id="totalMoney" name="totalMoney"/>
      </div>

      <div class="form-group">
        <div class="label">
          <label>分类科目：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="detail" maxlength="30" value="${reimbursement.detail }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>票据张数：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="sum" maxlength="2" value="${reimbursement.sum }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>理由：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="reason" maxlength="200" value="${reimbursement.reason }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>申请人：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="applyUser" maxlength="20" value="${reimbursement.applyUser }"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>附件明细：</label>
        </div>
        <div class="field">
          <table class="table table-hover text-center">
	      	 <tr>
		        <th>明细</th>
		        <th>金额</th>
		     </tr>
		     <tbody id="items">
			     <c:forEach items="${detailList}" var="item" varStatus="status">
					<tr id="item${status.index}">
						<td><input type="text" class="input" name="detailList[${status.index}].detail" value="${item.detail }"></td>
						<td><input type="text" class="input" name="detailList[${status.index}].amount" value="${item.amount }"></td>
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
	    elem: '#reDate',
	    event: 'focus' 
	});
	
	var num = $("#items").find("tr").length-1 ;
	function plusTR(){
		num ++;
		var tr = "<tr id='item"+num+"'><td><input type='text' class='input' name='detailList[" + num + "].detail'></td><td><input type='text' class='input' name='detailList[" + num + "].amount' ></td><td><img src='images/minus.png' style='cursor:pointer;' onclick='minusTR("+ num +")'/></td></tr>";
		$("#items").append(tr);
	}
	
	function minusTR(numb){
		$("#item"+ numb).remove(); 
	}
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
	function userSub(){
		var projectId = $("select[name ='project.id']").val();
		var amount = $("input[name$='.amount']").val();
		var totalMoney = $("#totalMoney").val();
		if(projectId == '') {
			alert("请选择隶属项目！");
			return ;
		}
		var sum = $("input[name ='sum']").val();
		
		if(sum != '') {
			if(isNaN(sum)) {
				alert("票据张数输入错误！");
				return ;
			}
		}
		
		var i = 0;
		
		$("input[name$='.amount']").each(function(){
		    if(isNaN($(this).val())) {
		    	i++;
		    	return ;
		    }
		});
		
		if(i > 0) {
			alert("金额输入错误!");
			return ;
		}
	
		var sum = 0;
		var tableId = document.getElementById("items"); 
		for(var i=0;i<tableId.rows.length;i++) { 
			amounts = tableId.rows[i].cells[1].getElementsByTagName("INPUT")[0].value;
			sum = parseFloat(sum) + parseFloat(amounts); 
		} 
		
		if(eval(sum)>eval(totalMoney)){
			alert("报销金额不可超过经费总金额！");
			return;
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