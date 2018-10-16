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
    <title>创建支票领用登记单</title>  
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
<h1 class="title">创建支票领用登记单</h1>
	<form action="apply/online/cheque/add" method="post" class="form-x" id="form-article-add" >
		<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1" style="width: 1000px">
		<tr>
		  <th>申请时间</th>
          <td colspan="8"> <input type="text" class="input" id="applyDate" name="applyDate" value=""autocomplete="off"/></td>
        </tr>
        <tr>
          <th>标题</th>
          <td colspan="8"> <input type="text" class="input" name="title" value=""/></td>
        </tr>
        <tr>
          <th>备注</th>
          <td colspan="8"><input type="text" class="input" name="remark" maxlength="200" value=""/></td>
        </tr>
        <tr>
            <th>支出单位</th>
	        <th>支出项目</th>
	        <th>财务编号</th>
	        <th>分类明细</th>
	        <th>支票限额</th>
	        <th>用途</th>
	        <th>备注</th>
	        <th></th>
        </tr>
        <tbody id="items">
			<tr id="item0">
				<td><!-- <input type="text" class="input" name="detailList[0].payUnit"> -->
				<select name="detailList[0].payUnit" class="input w50" style="width: 300px;margin: 8px 0 -15px 0;">
		          	<option value="1">北京农业信息技术研究中心</option>
		          	<option value="2">北京农业智能装备技术研究中心</option>
		          	<option value="3">北京派得伟业科技发展有限公司</option>
		          	<option value="4">农芯科技（北京）有限责任公司</option>
		          	<option value="5">北京市农林科学院</option>
		          	<option value="6">北京智慧农业物联网产业技术创新战略联盟</option>
		          	<option value="7">北京农业智能装备技术研究中心（软硬件实验室）</option>
		          </select>
				</td>
				<td>
					<select class="input" name="detailList[0].project.id" onchange="projectChange()">
						<option value="">请选择项目</option>
						<c:forEach items="${projectList }" var="project">
							<option value="${project.id }">${project.projectName }</option>
						</c:forEach>
					</select>
				</td>
				<td><input type="text" class="input" name="detailList[0].number"></td>
				<td><input type="text" class="input" name="detailList[0].detail"></td>
				<td><input type="text" class="input" name="detailList[0].amount"></td>
				<td><input type="text" class="input" name="detailList[0].useInfo"></td>
				<td><input type="text" class="input" name="detailList[0].remark"></td>
				<td><img src="images/minus.png" style="cursor:pointer;" onclick="minusTR(${status.index})"/></td>
			</tr>
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
	
	var num = 0;
	function plusTR(){
		$.post("project/json",function(result){
			num ++;
			
			var sel = "<td><select class='input' name='detailList["+num+"].project.id'><option value=''>请选择项目</option>";
			
			$.each(result,function(index,data){
				sel += "<option value='"+data.pid+"'>"+data.pname+"</option>";
			});
			
			sel += "</select></td>"
			
			var tr = "<tr id='item"+num+"'><td>";
			//tr+="<input type='text' class='input' name='detailList[" + num + "].payUnit'>";
			tr+="<select name='detailList[" + num + "].payUnit'class='input' style='width: 300px;margin: 8px 0 -15px 0;'>";
			tr+="<option value='1'>北京农业信息技术研究中心</option>";
			tr+="<option value='2'>北京农业智能装备技术研究中心</option>";
			tr+="<option value='3'>北京派得伟业科技发展有限公司</option>";
			tr+="<option value='4'>农芯科技（北京）有限责任公司</option>";
			tr+="<option value='5'>北京市农林科学院</option>";
			tr+="<option value='6'>北京智慧农业物联网产业技术创新战略联盟</option>";
			tr+="<option value='7'>北京农业智能装备技术研究中心（软硬件实验室）</option></select>";
			tr+="</td>"+sel+"<td><input type='text' class='input' name='detailList[" + num + "].number' ></td><td><input type='text' class='input' name='detailList[" + num + "].detail' ></td><td><input type='text' class='input' name='detailList[" + num + "].amount' ></td><td><input type='text' class='input' name='detailList[" + num + "].useInfo' ></td><td><input type='text' class='input' name='detailList[" + num + "].remark' ></td><td><img src='images/minus.png' style='cursor:pointer;' onclick='minusTR("+ num +")'/></td></tr>";
			$("#items").append(tr);
		});
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
		
		$("select[name$='.project.id']").each(function(){
		    if($(this).val() == '') {
		    	i++;
		    	return ;
		    }
		});
		
		if(i > 0) {
			alert("请选择项目!");
			return ;
		}
		
		i = 0;
		
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
		window.location.href="apply/online/cheque/list";
	}
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
	</body>
</html>
