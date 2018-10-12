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
    <title>创建报销单</title>  
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
  <h1 class="title">支出报销明细单</h1>
	<form action="apply/online/reimbursement/add" method="post" class="form-x" id="form-article-add" >
		<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1">
		<tr>
          <th style="width: 70px;">申请时间</th>
          <td colspan="3"><input type="text" class="input" id="reDate" name="reDate" value="" autocomplete="off"/></td>
        </tr>
		<tr>
          <th style="width: 70px;">支出单位</th>
          <td colspan="3">
			<select name="payUnit" class="input w50" style="width: 300px;">
	      		<option value="信息">信息</option>
	      		<option value="装备中心">装备中心</option>
	      		<option value="派得">派得</option>
	      		<option value="农芯">农芯</option>
      	  </select>
		  </td>
        </tr>
        <tr>
          <th>支出项目</th>
          <td>
		<select name="project.id" class="input w50" style="width: 300px;">
          	<option value="">全部</option>
          	<c:forEach items="${projectList }" var="project">
          		<option value="${project.id }">${project.projectName }</option>
          	</c:forEach>
          </select>
			</td>
          <th>财务编号</th>
          <td><input type="text" class="input" name="number" maxlength="10"/></td>
        </tr>
        <tr>
          <th>分类科目</th>
          <td><input type="text" class="input" name="detail" maxlength="30"/></td>
          <th>票据张数</th>
          <td><input type="text" class="input" name="sum" maxlength="2"/></td>
        </tr>
		<tr height="50">
          <th>附件明细</th>
          <td colspan="3">
			<div class="field">
	          <table class="table table-hover text-center">
		      	 <tr>
			        <th>明细</th>
		     		<th>金额</th>
					<th>操作</th>
			     </tr>
			     <tbody id="items">
						<tr id="item0">
							<td><input type="text" class="input" name="detailList[0].detail"></td>
							<td><input type="text" class="input" name="detailList[0].amount"></td>
							<td><img src="images/minus.png" style="cursor:pointer;" onclick="minusTR(0)"/></td>
						</tr>
					</tbody>
		      </table>
	        <div style="text-align: center;">
				<img src="images/plus.png" style="cursor:pointer;" onclick="plusTR()"/>
			</div>
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
	    elem: '#reDate',
	    event: 'focus' 
	});
	
	var num = 0;
	function plusTR(){
		num ++;
		var tr = "<tr id='item"+num+"'><td><input type='text' class='input' name='detailList[" + num + "].detail'></td><td><input type='text' class='input' name='detailList[" + num + "].amount' ></td><td><img src='images/minus.png' style='cursor:pointer;' onclick='minusTR("+ num +")'/></td></tr>";
		$("#items").append(tr);
	}
	
	function minusTR(numb){
		$("#item"+ numb).remove(); 
	}
	
	function userSub(){
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
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	function goList(){
		window.location.href="product/list";
	}
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
	</body>
</html>
