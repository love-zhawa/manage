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
    <title>修改物联网卡</title>  
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
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;修改</strong></div>
  <div class="body-content">
    <form action="assets/wlw/edit" method="post" class="form-x" id="form-article-add" >
    <input type="hidden" name="id" value="${wlw.id }">
      <div class="form-group">
        <div class="label">
          <label>手机卡号：</label>
        </div>
        <div class="field">
       <input type="text" class="input" name="sim" value="${wlw.sim }"/>
        </div>
      </div>
	  <div class="form-group">
        <div class="label">
          <label>采购人：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="cgperson" value="${wlw.cgperson }"/>
        </div>
      </div>
	<div class="form-group">
        <div class="label">
          <label>采购时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="cgtime" id="cgtime" value="<fmt:formatDate value="${wlw.cgtime}" pattern="yyyy-MM-dd"/>" autocomplete="off"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>使用时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="sytime" id="sytime" value="<fmt:formatDate value="${wlw.sytime}" pattern="yyyy-MM-dd"/>" autocomplete="off"/>
        </div>
      </div>
	  <div class="form-group">
        <div class="label">
          <label>使用地点：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="dd" value="${wlw.dd }"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>使用人：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="syperson" value="${wlw.syperson }"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>领用人：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="lyperson" value="${wlw.lyperson }"/>
        </div>
      </div>
	 <div class="form-group">
        <div class="label">
          <label>备注：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="bz" value="${wlw.bz }"/>
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
	    elem: '#cgtime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#sytime',
	    event: 'focus' 
	});
	function userSub(){
		var sim = $("input[name ='sim']").val();
		var cgperson = $("input[name ='cgperson']").val();
		var cgtime = $("input[name ='cgtime']").val();
		
		if(sim == '') {
			alert("请输入手机卡号！");
			return;
		}
		
		if(cgperson == '') {
			alert("请输入采购人！");
			return;
		}
		
		if(cgtime == '') {
			alert("请输入采购时间！");
			return;
		}
		
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	function goList(){
		window.location.href="assets/wlw/list";
	}
	</script>
</html>