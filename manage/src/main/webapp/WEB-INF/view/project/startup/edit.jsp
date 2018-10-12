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
    <title>创建项目实施</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/ajaxfileupload.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;项目实施</strong></div>
  <div class="body-content">
    <form action="project/startup/edit" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
      <input name="id" value="${startup.id }" type="hidden"/>
      <div class="form-group">
        <div class="label">
          <label>业务名称：</label>
        </div>
        <div class="field">
          <select name="bus.id" class="input">
          	<option value="">请选择项目</option>
          	<c:forEach var="bus" items="${bussList}">
          		<option value="${bus.id }" <c:if test="${bus.id == startup.bus.id }">selected</c:if>>${bus.bussName }</option>
          	</c:forEach>
          </select>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>横向课题：</label>
        </div>
        <div class="field">
          <select name="project.id" class="input">
          	<option value="">请选择项目</option>
          	<c:forEach var="project" items="${projectList}">
          		<option value="${project.id }" <c:if test="${project.id == startup.project.id }">selected</c:if>>${project.projectName }</option>
          	</c:forEach>
          </select>
        </div>
      </div>
	  
	  <div class="form-group">
        <div class="label">
          <label>截止日期：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="endDate" name="endDate" autocomplete="off" value="<fmt:formatDate value="${startup.endDate }" pattern="yyyy-MM-dd"/>"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>状态：</label>
        </div>
        <div class="field">
          <select name="status" class="input w50" style="width: 300px;">
          	<option value="1" <c:if test="${startup.status == 1 }">selected</c:if>>正在进行</option>
          	<option value="2" <c:if test="${startup.status == 2 }">selected</c:if>>暂停</option>
          	<option value="3" <c:if test="${startup.status == 3 }">selected</c:if>>终止</option>
          </select>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>上传附件：</label>
        </div>
        <div class="field">
          <table class="table table-hover text-center">
	      	 <tr>
		        <th>附件类型</th>
		        <th>附件</th>
		        <th></th>
		     </tr>							
		     <tbody id="items">
					<c:forEach items="${files}" var="filespro" varStatus="i">
					 <tr id="item${i.index}">
						<td><input type="text" class="input" name="fileList[${i.index}].fileType" value="${filespro.fileType }"></td>
						<td><a href="upload/${filespro.filePath }" target="_Blank">${filespro.fileName }</a>
						
						<td><input type ="file" name= "file"/></td>
						
						<input type="hidden" name="fileList[${i.index}].fileName" value="${filespro.fileName }">
						<input type="hidden" name="fileList[${i.index}].filePath" value="${filespro.filePath }">
						<td><img src="images/minus.png" style="cursor:pointer;" onclick="minusTR(0)"/></td>
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
	    elem: '#endDate',
	    event: 'focus' 
	});
	var num = $("#items").find("tr").length-1 ;
	function plusTR(){
		num ++;
		var tr = "<tr id='item"+num+"'><td><input type='text' class='input' name='fileList[" + num + "].fileType'></td><td><input type='file' class='input' name='file' ></td><td><img src='images/minus.png' style='cursor:pointer;' onclick='minusTR("+ num +")'/></td></tr>";
		$("#items").append(tr);
	}
	
	function minusTR(numb){
		$("#item"+ numb).remove(); 
	}
	
	function userSub(){
		var busid = $("select[name ='bus.id']").val();
		var projectid = $("select[name ='project.id']").val();
		var endDate = $("input[name='endDate']").val();
		
		if(busid == '') {
			alert("请选择业务！");
			return ;
		}
		if(projectid == '') {
			alert("请选择项目！");
			return ;
		}
		
		if(endDate == '') {
			alert("请选择截止时间！");
			return ;
		}
		
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	function goList(){
		window.location.href="project/business/list";
	}
	</script>
</html>