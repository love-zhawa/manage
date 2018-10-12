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
    <title>编辑产品售后</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;产品售后</strong></div>
  <div class="body-content">
    <form action="project/cpsh/edit" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
    <input type="hidden" name="id" value="${cpsh.id }">
    <div class="form-group">
        <div class="label">
          <label>售后来源：</label>
        </div>
        <div class="field">
          <select name="ly" class="input" onchange="lyChange()">
          	<option value="1" <c:if test="${cpsh.ly == 1}">selected="selected"</c:if>>销售来源</option>
          	<option value="2" <c:if test="${cpsh.ly == 2}">selected="selected"</c:if>>项目来源</option>
          </select>
        </div>
      </div>
     <div class="form-group">
        <div class="label">
          <label>项目名称：</label>
        </div>
        <div class="field" id="ly1">
         	<input type="text" class="input" name="project" value="${cpsh.project }"/>
        </div>
        <div class="field" id="ly2">
	         <select name="projects.id" class="input" onchange="projectChange()">
	          	<c:forEach var="project" items="${projectList}">
	          		<option value="${project.id }" <c:if test="${project.id eq cpsh.projects.id }">selected="selected"</c:if>>${project.projectName }</option>
	          	</c:forEach>
	          </select>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>项目编号：</label>
        </div>
        <div class="field" id="bh1">
         	<input type="text" class="input" name="projectnumber" value="${cpsh.projectnumber }"/>
        </div>
        <div class="field" id="bh2">
	        
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>设备名称：</label>
        </div>
        <div class="field">
         	<input type="text" class="input" name="sbname" value="${cpsh.sbname }"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>设备型号：</label>
        </div>
        <div class="field">
         	<input type="text" class="input" name="sbtype" value="${cpsh.sbtype }"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>生产厂家：</label>
        </div>
        <div class="field">
         	<input type="text" class="input" name="sbhome" value="${cpsh.sbhome }"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>设备编号：</label>
        </div>
        <div class="field">
         	<input type="text" class="input" name="sbnumber" value="${cpsh.sbnumber }"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>使用单位：</label>
        </div>
        <div class="field">
         	<input type="text" class="input" name="dw" value="${cpsh.dw }"/>
        </div>
      </div>
	  
	  <div class="form-group">
        <div class="label">
          <label>出厂日期：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="cctime" name="cctime" value="<fmt:formatDate value="${cpsh.cctime }" pattern="yyyy-MM-dd"/>" autocomplete="off"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>上次维护时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="oldtime" name="oldtime" value="<fmt:formatDate value="${cpsh.oldtime }" pattern="yyyy-MM-dd"/>" autocomplete="off"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>发现故障时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="gztime" name="gztime" value="<fmt:formatDate value="${cpsh.gztime }" pattern="yyyy-MM-dd"/>" autocomplete="off"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>施工人员：</label>
        </div>
        <div class="field">
         	<input type="text" class="input" name="person" value="${cpsh.person }"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>报修描述：</label>
        </div>
        <div class="field">
         	<input type="text" class="input" name="bxms" value="${cpsh.bxms }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>详细：</label>
        </div>
        <div class="field">
          <table class="table table-hover text-center">
	      	 <tr>
	      	    <th></th>
		        <th>故障描述</th>
		        <th>解决方法</th>
		        <th>处理意见</th>
		     </tr>							
		     <tbody id="items">
					<tr>
					    <td>工程小组</td>
						<td><input type="text" class="input" name="gzms1" value="${cpsh.gzms1 }"></td>
						<td><input type="text" class="input" name="jjff1" value="${cpsh.jjff1 }"></td>
						<td><input type="text" class="input" name="suggest1" value="${cpsh.suggest1 }"></td>
					</tr>
					<tr>
					    <td>生产小组</td>
						<td><input type="text" class="input" name="gzms2" value="${cpsh.gzms2 }"></td>
						<td><input type="text" class="input" name="jjff2" value="${cpsh.jjff2 }"></td>
						<td><input type="text" class="input" name="suggest2" value="${cpsh.suggest2 }"></td>
					</tr>
					<tr>
					    <td>研发小组</td>
						<td><input type="text" class="input" name="gzms3" value="${cpsh.gzms3 }"></td>
						<td><input type="text" class="input" name="jjff3" value="${cpsh.jjff3 }"></td>
						<td><input type="text" class="input" name="suggest3" value="${cpsh.suggest3 }"></td>
					</tr>
					
				</tbody>
	      </table>
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
	    elem: '#cctime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#oldtime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#gztime',
	    event: 'focus' 
	});
	lyChange();
	function lyChange(){//销售来源自己填写，项目来源下拉框
		var ly = $("select[name='ly']").val();
		if(ly == 1){
			$("#ly1").show();$("#bh1").show();
			$("#ly2").hide();$("#bh2").hide();
		}
		if(ly == 2){
			projectChange();
			$("#ly2").show();$("#bh2").show();
			$("#ly1").hide();$("#bh1").hide();
		}
	}
	//选择项目
	function projectChange(){
		var projectId = $("select[name='projects.id']").val();
		if(projectId == '') {
		    $("#bh2").html('');
		}
		$.post("project/view/" + projectId,{},function(result){
			$("#bh2").html(result.financialNumber);
		});
	}
	
	function userSub(){
		var ly = $("select[name ='ly']").val();
		var project = $("select[name ='projects.id']").val();
		
		if(ly == '') {
			alert("请选择售后来源！");
			return ;
		}
		if(ly == 2){
			if(project == '') {
				alert("请选择项目！");
				return ;
		    }
		}
		
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	function goList(){
		window.location.href="project/cpsh/list";
	}
	</script>
</html>