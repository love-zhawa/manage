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
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;创建劳务计算单</strong></div>
  <div class="body-content">
    <form action="funds/remuneration/add" method="post" class="form-x" id="form-article-add" >
    <div class="form-group">
        <div class="label">
          <label>支出项目：</label>
        </div>
        <div class="field">
          <select name="project.id" class="input w50" style="width: 300px;" onchange="projectChange()">
          	<option value="">全部</option>
          	<c:forEach items="${projectList }" var="project">
          		<option value="${project.id }">${project.projectName }</option>
          	</c:forEach>
          </select>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>财务编号：</label>
        </div>
        <div class="field" id="financialNumber">
         
        </div>
        <input type="hidden" class="input" id="totalMoney" name="totalMoney"/>
      </div>
      <div class="form-group">
        <div class="label">
          <label>申请时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="applyDate" name="applyDate" value="" autocomplete="off"/>
        </div>
      </div>
		
		<div class="form-group">
        <div class="label">
          <label>标题：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="title" value=""/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>备注：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="remark" value="" maxlength="200"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>计算明细：</label>
        </div>
        <div class="field">
          <table class="table table-hover text-center">
	      	 <tr>
		        <th>姓名</th>
		        <th>身份证号码</th>
		        <th>银行卡号</th>
		        <th>开户银行</th>
		        <th>劳务金额</th>
		        <th>应交税金</th>
		        <th>实付金额</th>
		        <th></th>
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
		var title = $("input[name ='title']").val();
		var totalMoney = $("#totalMoney").val();
		var projectId = $("select[name ='project.id']").val();
		
		if(projectId == '') {
			alert("请选择支出项目！");
			return ;
		}
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
		var sum = 0;
		var tableId = document.getElementById("items"); 
		for(var i=0;i<tableId.rows.length;i++) { 
			amounts = tableId.rows[i].cells[6].getElementsByTagName("INPUT")[0].value;
			sum = parseFloat(sum) + parseFloat(amounts); 
		} 
		if(amounts == ''){
			alert("实付金额不能为空！");
			return;
		}
		if(eval(sum)>eval(totalMoney)){
			alert("实付金额不可超过经费总金额！");
			return;
		}
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	function goList(){
		window.location.href="funds/remuneration/list";
	}
	</script>
</html>