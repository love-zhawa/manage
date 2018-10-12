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
    <title>编辑计划</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
    <style type="text/css">
    	.cc{line-height: 34px;}
    </style>
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;编辑计划</strong></div>
  <div class="body-content">
    <form action="workplan/check" method="post" class="form-x" id="form-article-add" >
    	<input type="hidden" name="id" value="${workPlan.id }"/>
      <div class="form-group">
        <div class="label">
          <label>指派给：</label>
        </div>
        <div class="field cc">
          ${workPlan.user.name }
        </div>
      </div>

		<div class="form-group">
        <div class="label">
          <label>开始时间：</label>
        </div>
        <div class="field cc">
          <fmt:formatDate value="${workPlan.beginTime }" pattern="yyyy-MM-dd"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>结束时间：</label>
        </div>
        <div class="field cc">
          <input type="hidden" name="endTime" value="<fmt:formatDate value="${workPlan.endTime }" pattern="yyyy-MM-dd"/>">
          <fmt:formatDate value="${workPlan.endTime }" pattern="yyyy-MM-dd"/>
        </div>
      </div>

	  <div class="form-group">
        <div class="label">
          <label>指派人：</label>
        </div>
        <div class="field cc">
         ${workPlan.distUser.name}
        </div>
      </div>

      <div class="form-group">
        <div class="label">
          <label>工作内容：</label>
        </div>
        <div class="field cc">
          ${workPlan.content }
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>进展情况：</label>
        </div>
        <div class="field cc">
          <c:forEach items="${workPlan.logList}" var="log" varStatus="status">
          	${status.index+1}.${log.progress }<br/>
          </c:forEach>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>完成情况：</label>
        </div>
        <div class="field cc">
           <label><input name="evaluate" type="radio" checked="checked" class="ace" value="0"><span class="lbl">已完成</span></label>&nbsp;&nbsp;
           <label><input name="evaluate" type="radio" class="ace" value="1"><span class="lbl">未完成</span></label>
           <label><input name="evaluate" type="radio" class="ace" value="2"><span class="lbl">延期</span></label>
           <div id="yq" style="display:none;">
            	<span>延期至：</span><input type="text" class="input" name="newendTime" id="endTime" value="" maxlength="30" autocomplete="off" style="width:276px;"/>
            	<span>原因：</span><input type="text" class="input" name="yy" style="width:276px;"/>
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
	$(function(){
		$("input[type=radio][name=evaluate]").change(function(){
			var v = $(this).val();
			if (v =="2"){
				$("#yq").show();
			}else{
				$("#yq").hide();
			}
		});
	});
	laydate.render({
	    elem: '#beginTime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#endTime',
	    event: 'focus' 
	});
	function goList(){
		window.location.href="workplan/list";
	}
	function userSub(){
				
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	</script>
</html>