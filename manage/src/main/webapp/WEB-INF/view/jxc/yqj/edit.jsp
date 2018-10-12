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
    <title>元器件</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;编辑元器件</strong></div>
  <div class="body-content">
    <form action="jxc/yqj/edit" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
    <input type="hidden" name="id" value="${yqj.id }">
      <div class="form-group">
        <div class="label">
          <label>电板类型/类型：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="lx" name="lx" value="${yqj.lx }"/>
        </div>
      </div>
      
	  <div class="form-group">
        <div class="label">
          <label>元件名称/组件：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="name" name="name" value="${yqj.name }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>封装：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="fz" name="fz" value="${yqj.fz }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>数量：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="amount" name="amount" value="${yqj.amount }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>单位：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="dw" name="dw" value="${yqj.dw }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>品牌：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="pp" name="pp" value="${yqj.pp }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>规格：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="gg" name="gg" value="${yqj.gg }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>厂家：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="home" name="home" value="${yqj.home }"/>
        </div>
      </div>
      
      <%-- <div class="form-group">
        <div class="label">
          <label>价格：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="prize" name="prize" value="${yqj.prize }"/>
        </div>
      </div> --%>
      
      <div class="form-group">
        <div class="label">
          <label>设计信息/标号：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="number" name="number" value="${yqj.number }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>备注：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="bz" name="bz" value="${yqj.bz }"/>
        </div>
      </div>
      
     <!-- <div class="form-group">
        <div class="label">
          <label>图片：</label>
        </div>
        <div class="field">
          <input type="file" class="input" name="file">
        </div>
      </div> -->
      
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
	function userSub(){
		var lx = $("input[name ='lx']").val();
		var name = $("input[name ='name']").val();
		
		if(lx == '') {
			alert("类型不可以为空！");
			return ;
		}
		if(name == '') {
			alert("名称不可以为空！");
			return ;
		}
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	function goList(){
		window.location.href="yqj/list";
	}
	</script>
</html>