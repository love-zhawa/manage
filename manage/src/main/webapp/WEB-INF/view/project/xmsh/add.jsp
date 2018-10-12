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
    <title>创建项目售后</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;项目售后</strong></div>
  <div class="body-content">
    <form action="project/xmsh/add" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
      <div class="form-group">
        <div class="label">
          <label>使用项目：</label>
        </div>
        <div class="field">
          <select name="project.id" class="input">
          	<option value="">请选择项目</option>
          	<c:forEach var="project" items="${projectList}">
          		<option value="${project.id }">${project.projectName }</option>
          	</c:forEach>
          </select>
        </div>
      </div>
	  <div class="form-group">
        <div class="label">
          <label>维修单号：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="number" name="number" value=""/>
        </div>
      </div>
	  <div class="form-group">
        <div class="label">
          <label>报修单位：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="bxdept" name="bxdept" value=""/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>报修人：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="bxperson" name="bxperson" value=""/>
        </div>
      </div>
       <div class="form-group">
        <div class="label">
          <label>报修时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="bxtime" name="bxtime" value="" autocomplete="off"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>购买日期：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="buytime" name="buytime" value="" autocomplete="off"/>
        </div>
      </div>
	  <div class="form-group">
        <div class="label">
          <label>维修类型：</label>
        </div>
        <div class="field">
          <select name="wxtype" class="input w50" style="width: 300px;">
          	<option value="1">返厂维修</option>
          	<option value="2">现场维护</option>
          	<option value="3">售后更换</option>
          </select>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>是否在报修期范围内：</label>
        </div>
        <div class="field">
          <select name="isbxq" class="input w50" style="width: 300px;">
          	<option value="1">是</option>
          	<option value="2">否</option>
          </select>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>报修设备：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="bxsb" name="bxsb" value=""/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>设备故障：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="sbgz" name="sbgz" value=""/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>维修人：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="wxperson" name="wxperson" value=""/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>报告人：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="bgperson" name="bgperson" value=""/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>故障处理结果：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="result" name="result" value=""/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>维修报告：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="wxreport" name="wxreport" value=""/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>备注：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="bz" name="bz" value=""/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>维修金额：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="wxmoney" name="wxmoney" value=""/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>到账金额：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="dzmoney" name="dzmoney" value=""/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>未到账金额：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="nomoney" name="nomoney" value=""/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>到账单位：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="dzdw" name="dzdw" value=""/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>到账时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="dztime" name="dztime" value="" autocomplete="off"/>
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
	    elem: '#bxtime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#buytime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#dztime',
	    event: 'focus' 
	});
	
	function userSub(){
		var projectid = $("select[name ='project.id']").val();
		var number = $("input[name='number']").val();
		
		if(projectid == '') {
			alert("请选择项目！");
			return ;
		}
		
		if(number == '') {
			alert("请输入维修单号！");
			return ;
		}
		
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	function goList(){
		window.location.href="project/xmsh/list";
	}
	</script>
</html>