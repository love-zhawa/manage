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
    <title>加班申请</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
<style>
h1 {text-align: center;margin-bottom: 20px;}
.table1 {width: 700px;border-collapse: collapse}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 th,.table1 td {border: 1px solid #333;}
.input{border: 0px;}
</style>
</head>
<body>
	<h1 class="title">农业自动化员工加班申请</h1>
	<form action="apply/online/overtime/add" method="post" class="form-x" id="form-article-add" >
		<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1">
		<tr height="50">
          <th>申请人</th>
          <td style="padding-top:16px;">${username }</td>
          <th>所属小组</th>
          <td>${groupname }</td>
        </tr>
        <tr height="50">
          <th>申请时间</th>
          <td><input type="text" class="input" id="applyTime" name="applyTime" value="" autocomplete="off"/></td>
          <th>联系电话</th>
          <td><input type="text" class="input" name="phoneNumber"/></td>
        </tr>
        <tr height="50">
          <th>加班事由</th>
          <td colspan="3"><input type="text" class="input" name="reason" /></td>
        </tr>
        <tr height="50">
          <th>紧急联系人</th>
          <td><input type="text" class="input" name="concatUser" /></td>
          <th>紧急联系人电话</th>
          <td><input type="text" class="input" id="concatMobile" name="concatMobile"/></td>
        </tr>
        <tr>
          <th>开始时间</th>
          <td><input type="text" class="input" id="beginTime" name="beginTime" autocomplete="off"/></td>
          <th>结束时间</th>
          <td><input type="text" class="input" id="endTime" name="endTime" autocomplete="off" /></td>
          </th>
        </tr>
      </table>
      <div class="field">
         <button class="button bg-main icon-check-square-o" type="button" onClick="userSub();" style="margin-top:9px;margin-left:800px;"> 提交</button>
       </div>
     </form>
	<script type="text/javascript">
	laydate.render({
	    elem: '#applyTime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#beginTime',
	    type: 'datetime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#endTime',
	    type: 'datetime',
	    event: 'focus' 
	});
	function userSub(){
		if(confirm("确认提交吗？")){
			$("#form-article-add").submit();
		}
	}
	
	function back (){
		window.location.href="apply/online/overtime/list";
	}
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
	</body>
</html>
