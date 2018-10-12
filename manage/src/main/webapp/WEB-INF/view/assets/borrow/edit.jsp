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
    <title>添加资产</title>  
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
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;修改借用记录</strong></div>
  <div class="body-content">
    <form action="assets/borrow/edit" method="post" class="form-x" id="form-article-add" >
    <input type="hidden" name="id" value="${assets.id }">
      <div class="form-group">
        <div class="label">
          <label>资产名称：</label>
        </div>
        <div class="field">
        <input class="input" list="assets" name="assetsname" value="${assets.assetsname }"/>
		<datalist id="assets">
		  <option value="">请选择固定资产</option>
			<c:forEach items="${lists }" var="a">
				<option value="${a.assetsName }">
			</c:forEach>
		</datalist>
          <%-- <select class="input" name="assets.id">
			<option value="">请选择固定资产</option>
			<c:forEach items="${lists }" var="a">
				<option value="${a.id }"<c:if test="${a.id eq assets.assets.id }">selected="selected"</c:if>>${a.assetsName }</option>
			</c:forEach>
		</select> --%>
        </div>
      </div>
		
		<div class="form-group">
        <div class="label">
          <label>借用人：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="person" value="${assets.person }"/>
        </div>
      </div>
	<div class="form-group">
        <div class="label">
          <label>借用时间：</label>
        </div>
        <div class="field">
           <input type="text" class="input" name="time" id="time" autocomplete="off" value="<fmt:formatDate value="${assets.time}" pattern="yyyy-MM-dd"/>"/>
        </div>
      </div>
		<div class="form-group">
        <div class="label">
          <label>所在地：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="dd" value="${assets.dd }"/>
        </div>
      </div>
	<div class="form-group">
        <div class="label">
          <label>备注：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="bz" value="${assets.bz }"/>
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
	    elem: '#time',
	    event: 'focus' 
	});
	function userSub(){
		var assetsId = $("select[name='assets.id']").val();
		var person = $("input[name ='person']").val();
		var time = $("input[name ='time']").val();
		
		if(assetsId == '') {
			alert("请选择资产！");
			return;
		}
		
		if(person == '') {
			alert("请输入借用人！");
			return;
		}
		
		if(time == '') {
			alert("请输入借用时间！");
			return;
		}
		
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	function goList(){
		window.location.href="assets/borrow/list";
	}
	</script>
</html>