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
    <title>研究生登记</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
<style type="text/css">
.cc{line-height: 34px;}
h1 {text-align: center;margin-bottom: 20px;}
.table1 {width: 780px;border-collapse: collapse}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 th,.table1 td {border: 1px solid #333;}
.input{border:0px;}
</style>
</head>
<body>
		<h1 class="title">学生登记表</h1>
		<form action="apply/online/register/edit" method="post" class="form-x" id="form-article-add" >
		 <input type="hidden" value="${register.id }" name="id"/>
			<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1">
			<tr>
	          <th width="67">姓名</th>
	          <td width="95"><input type="text" class="input" id="userName" name="userName" value="${register.userName }"/></td>
	          <th width="42">性别</th>
	          <td width="90">
	          	<label><input name="gender" type="radio" <c:if test="${register.gender == 0 }">checked="checked" </c:if> class="ace" value="0"><span class="lbl">男</span></label>&nbsp;&nbsp;
         		<label><input name="gender" type="radio" <c:if test="${register.gender == 1 }">checked="checked" </c:if> class="ace" value="1"><span class="lbl">女</span></label>
	          <th width="40">民族</th>
	          <td width="60"><input type="text" class="input" name="nation" value="${register.nation }"/></td>
	          <th width="60">籍贯</th>
	          <td width="216"><input type="text" class="input" name="place" value="${register.place }"/></td>
	        </tr>
	        <tr>
	          <th>学历</th>
	          <td><input type="text" class="input" name="education" value="${register.education }"//></td>
	          <th colspan="2" width="42">是否在读</th>
	          <td width="90">
	            <label><input name="readingStudent" <c:if test="${register.readingStudent == 0 }">checked="checked" </c:if> type="radio" class="ace" value="0"><span class="lbl">是</span></label>&nbsp;&nbsp;
            	<label><input name="readingStudent" <c:if test="${register.readingStudent == 1 }">checked="checked" </c:if> type="radio" class="ace" value="1"><span class="lbl">否</span></label>
	          </td>
	          <th colspan="2">出生日期</th>
	          <td><input type="text" class="input" id="birth" name="birth" value="${register.birth }" autocomplete="off"/></td>
	        </tr>
	        <tr>
	          <th>E-mail</th>
	          <td colspan="4"><input type="text" class="input" name="email" value="${register.email }"/></td>
	          <th colspan="2">联系电话（手机）</th>
	          <td><input type="text" class="input" name="phone" value="${register.phone }"/></td>
	        </tr>
	        <tr>
	          <th>专业</th>
	          <td colspan="4"><input type="text" class="input" name="major" value="${register.major }"/></td>
	          <th colspan="2">入学时间</th>
	          <td><input type="text" class="input" id="entranceTime" name="entranceTime" autocomplete="off" value="${register.entranceTime }"/></td>
	        </tr>
	        <tr>
	          <th>就读学校</th>
	          <td colspan="4"><input type="text" class="input" name="school" value="${register.school }"/></td>
	          <th colspan="2">毕业时间</th>
	          <td><input type="text" class="input" id="graduationTime" name="graduationTime" value="${register.graduationTime }" autocomplete="off"/></td>
	        </tr>
	        <tr>
	          <th>第一导师</th>
	          <td colspan="4"><input type="text" class="input" name="firstMentor" value="${register.firstMentor }"/></td>
	          <th colspan="2">到中心时间</th>
	          <td><input type="text" class="input" id="centerTime" name="centerTime" value="${register.centerTime }" autocomplete="off"/></td>
	        </tr>
	        <tr>
	          <th>第二导师</th>
	          <td colspan="4"><input type="text" class="input" name="secondMentor" value="${register.secondMentor }"/></td>
	          <th colspan="2">中心责任导师</th>
	          <td><input type="text" class="input" name="centerMentor" value="${register.centerMentor }"/></td>
	        </tr>
	        <tr>
	          <th>所在课题组</th>
	          <td colspan="4"><input type="text" class="input" name="projectGroup" value="${register.projectGroup }"/></td>
	          <th colspan="2">预计离开时间</th>
	          <td><input type="text" class="input" id="departureTime" name="departureTime" value="${register.departureTime }" autocomplete="off"/></td>
	        </tr>
	        <tr>
	          <th>课题组负责人</th>
	          <td colspan="4"><input type="text" class="input" name="projectGroupPerson" value="${register.projectGroupPerson }"/></td>
	          <th colspan="2">兴趣爱好</th>
	          <td><input type="text" class="input" name="hobby" value="${register.hobby }"/></td>
	        </tr>
	        <tr>
	          <th>身份证号码</th>
	          <td colspan="4"><input type="text" class="input" name="idCard" value="${register.idCard }"/></td>
	          <th colspan="2">办公电话（座机）</th>
	          <td><input type="text" class="input" name="mobile" value="${register.mobile }"/></td>
	        </tr>
	        <tr>
	          <th>紧急情况联系人</th>
	          <td>
	          	<input type="text" class="input" name="contacts" value="${register.contacts }"/>
	          </td>
	          <th>联系电话</th>
	          <td colspan="2"><input type="text" class="input" name="contactsPhone" value="${register.contactsPhone }"/></td>
	          <th>与本人关系</th>
	          <td colspan="2" style="text-align: left;">
		          <input type="text" class="input" name="relationship" value="${register.relationship }"/>
	          </td>
	        </tr>
	        <tr>
	          <th>是否担任过学生干部</th>
	          <td>
	          	 <label><input name="cadres" <c:if test="${register.cadres == 0 }">checked="checked" </c:if> type="radio" checked="checked" class="ace" value="0"><span class="lbl">是</span></label>&nbsp;&nbsp;
           		<label><input name="cadres" <c:if test="${register.cadres == 1 }">checked="checked" </c:if> type="radio" class="ace" value="1"><span class="lbl">否</span></label>
	          </td>
	          <th>任过何种职务</th>
	          <td colspan="2"><input type="text" class="input" name="post" value="${register.post }"/></td>
	          <th>培养方式</th>
	          <th colspan="2" style="text-align: left;">
		           <select name="mode" class="input">
					<option <c:if test="${register.mode == 1 }">selected</c:if> value="1">联合培养</option>
					<option <c:if test="${register.mode == 2 }">selected</c:if> value="2">客座培养</option>
					<option <c:if test="${register.mode == 3 }">selected</c:if> value="3">短期实习</option>
				  </select>
	          </th>
	        </tr>
	        <tr>
	          <th><span style="display:-moz-inline-box;display:inline-block;width:10px; ">自我介绍</span></th>
	          <th colspan="7">
	          	<div style="height: 77px;text-align: left;">
	          		<input type="text" class="input" name="selfInfo" value="${register.selfInfo }"/>
	          	</div>
	          </th>
	        </tr>
	      </table>
     
     <div id="printDiv" style="text-align: center;margin-top: 10px;">
     	 <button class="button bg-main icon-check-square-o" type="button" onClick="userSub();" style="margin-top:10px;margin-left:80px;"> 提交</button>
     </div>
     </form>
<script type="text/javascript">
	laydate.render({
	    elem: '#birth',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#entranceTime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#centerTime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#graduationTime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#departureTime',
	    event: 'focus' 
	});
	
	function userSub(){
		if(confirm("确认提交吗？")){
			$("#form-article-add").submit();
		}
	}
	
	function back (){
		window.location.href="apply/online/register/list";
	}
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
	</body>
</html>
