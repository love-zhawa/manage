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
    <title>编辑表单</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;编辑文件</strong></div>
  <div class="body-content">
    <form action="apply/forms/edit" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
      <input type="hidden" name="id" value="${commonFormss.id}"/>
      <div class="form-group">
        <div class="label">
          <label>标题：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="title" value="${commonFormss.title }"/>
        </div>
      </div>
	  <div class="form-group">
        <div class="label">
          <label>发文单位：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="dw" value="${commonFormss.dw }"/>
        </div>
      </div>
      <!-- <div class="form-group">
        <div class="label">
          <label>上传人：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="xh" value=""/>
        </div>
      </div> -->
      
	  <div class="form-group">
        <div class="label">
          <label>附件：</label>
        </div>
        <div class="field">
          <input type="file" class="input-text" value="" placeholder="" id="" name="file">
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
	function goList(){
		window.location.href="apply/forms/list";
	}
	
	function userSub(){
		var title = $("input[name ='title']").val();
		var file = $("input[name ='file']").val();
		
		if(title == '') {
			alert("请输入标题！");
			return;
		}
		
		if(file != '') {
			var fileN =file.substring(file.lastIndexOf('.') + 1);
			
			if(fileN != 'doc' && fileN != 'docx' && fileN != 'xls' && fileN != 'xlsx' && fileN != 'pdf') {
				alert("附件应为文本文档格式，仅支持doc、docx、xls、xlsx、pdf！");
				return;
			}
		}
		
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	</script>
</html>