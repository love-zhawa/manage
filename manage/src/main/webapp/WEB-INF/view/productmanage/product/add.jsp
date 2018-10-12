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
    <title>创建任务</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;创建任务</strong></div>
  <div class="body-content">
    <form action="product/add" method="post" class="form-x" id="form-article-add" >
      <div class="form-group">
        <div class="label">
          <label>任务名称：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="taskName" name="taskName" value=""/>
        </div>
      </div>
		
		<div class="form-group">
        <div class="label">
          <label>任务编号：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="taskNumber" name="taskNumber" value=""/>
        </div>
      </div>
      
		<div class="form-group">
        <div class="label">
          <label>下单时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="taskDate" name="taskDate" value="" autocomplete="off"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>截止时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="endDate" id="endDate" value="" maxlength="30" autocomplete="off"/>
        </div>
      </div>

      <div class="form-group">
        <div class="label">
          <label>问题：</label>
        </div>
        <div class="field">
          <textarea name="content" class="textarea" maxlength="200"></textarea>
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
	    elem: '#taskDate',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#endDate',
	    event: 'focus' 
	});
	function userSub(){
		var taskName = $("input[name ='taskName']").val();
		var taskNumber = $("input[name ='taskNumber']").val();
		var beginTime = $("input[name ='taskDate']").val();
		var endTime = $("input[name ='endDate']").val();
		var content = $("textarea[name ='content']").val();
		
		if(taskName == '') {
			alert("请输入任务名称！");
			return;
		}
		
		if(taskNumber == '') {
			alert("请输入任务编号！");
			return;
		}
		
		if(taskDate == '') {
			alert("请选择下单时间！");
			return;
		}
		
		if(endDate == '') {
			alert("请选择截止时间！");
			return;
		}
		
		if(content == '') {
			alert("请输入工作内容！");
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