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
    <title>合同制职工转企业编制(派得、农芯)申请表</title>  
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
		<h1 class="title">合同制职工转企业编制(派得、农芯)申请表</h1>
		<form action="apply/online/turnup/edit" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
		<input type="hidden" name="id" value="${turnup.id }"/>
			<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1">
			<tr>
	          <th>姓名</th>
	          <td><input type="text" class="input" id="userName" name="userName" value="${turnup.userName }"/></td>
	          <th style="width:44px;">性别</th>
	          <td colspan="2">
	          	<label><input name="gender" type="radio" <c:if test="${turnup.gender == 0 }">checked="checked" </c:if> class="ace" value="0"><span class="lbl">男</span></label>&nbsp;&nbsp;
          		<label><input name="gender" type="radio" <c:if test="${turnup.gender == 1 }">checked="checked" </c:if> class="ace" value="1"><span class="lbl">女</span></label>
	          </td>
	          <th>出生年月</th>
	          <td colspan="2"><input type="text" class="input" name="birth" id="birth" value="${turnup.birth }" autocomplete="off"/></td>
	          <td rowspan="6" style="width:160px;">
	          	<input type="file" class="input" name="file">
	          	
	          	<img alt="照片" src="upload/${turnup.headPath}" width="140" height="190">
	          </td>
	        </tr>
	        <tr>
	          <th width="63px;">民族</th>
	          <td><input type="text" class="input" name="nation" value="${turnup.nation }"/></td>
	          <th width="31px">婚否</th>
	          <td colspan="2">
	          	<label><input name="marriage" type="radio" <c:if test="${turnup.marriage == 0 }">checked="checked" </c:if> class="ace" value="0"><span class="lbl">已婚</span></label>&nbsp;&nbsp;
          		<label><input name="marriage" type="radio" <c:if test="${turnup.marriage == 1 }">checked="checked" </c:if> class="ace" value="1"><span class="lbl">未婚</span></label>
	          </td>
	          <th width="81px;">政治面貌</th>
	          <td colspan="2"><input type="text" class="input" name="outlook" value="${turnup.outlook }"/></td>
	        </tr>
	        <tr>
	          <th>家庭地址</th>
	          <td colspan="4"><input type="text" class="input" name="homeAddress" value="${turnup.homeAddress }"/></td>
	          <th>籍贯</th>
	          <td colspan="2"><input type="text" class="input" name="place" value="${turnup.place }"/></td>
	        </tr>
	        <tr>
	          <th>手机号码</th>
	          <td colspan="3"><input type="text" class="input" name="phoneNumber" id="phoneNumber" value="${turnup.phoneNumber }"/></td>
	          <th>部门</th>
	          <td colspan="3"><input type="text" class="input" name="dept" id="dept" value="${turnup.dept }"/></td>
	        </tr>
	        <tr>
	         	<th>身份证号</th>
	            <td colspan="7"><input type="text" class="input" name="idCard" value="${turnup.idCard }"/></td>
	        </tr>
	        <tr>
	          <th>毕业院校</th>
	          <td colspan="4"><input type="text" class="input" name="school" value="${turnup.school }"/></td>
	          <th>专业</th>
	          <td colspan="2"><input type="text" class="input" name="major" value="${turnup.major }"/></td>
	        </tr>
	        <tr>
	          <th>毕业时间</th>
	          <td colspan="4"><input type="text" class="input" id="graduationTime" name="graduationTime" value="${turnup.graduationTime }" autocomplete="off"/></td>
	          <th>学历</th>
	          <td colspan="3"><input type="text" class="input" name="education" value="${turnup.education }"/></td>
	        </tr>
	        <tr>
	          <th>学位</th>
	          <td colspan="4"><input type="text" class="input" name="degree" value="${turnup.degree }"/></td>
	          <th colspan="2">参加工作时间</th>
	          <td colspan="3"><input type="text" class="input" id="joinWorkTime" name="joinWorkTime" value="${turnup.joinWorkTime }" autocomplete="off"/></td>
	        </tr>
	        <tr>
	          <th colspan="2">现工作岗位</th>
	          <td colspan="3"><input type="text" class="input" name="post" value="${turnup.post }"/></td>
	          <th colspan="2">宅电</th>
	          <td colspan="3"><input type="text" class="input" name="mobile" value="${turnup.mobile }"/></td>
	        </tr>
	        
	        <tr>
	          <th colspan="2">来中心时间</th>
	          <td colspan="3"><input type="text" class="input" id="centerTime" name="centerTime" value="${turnup.centerTime }" autocomplete="off"/></td>
	          <th colspan="2">连续工龄</th>
	          <td colspan="3"><input type="text" class="input" name="workingYears" value="${turnup.workingYears }"/></td>
	        </tr>
	        <tr>
	          <th colspan="9">
	          	<div style="text-align: left;">
	          		工作经历:
	          	</div>
	          	<div style="text-align: left;margin-top: 5px;">
	          		<table class="table table-hover text-center">
			      	<tr>
				        <th>开始时间</th>
						<th>结束时间</th>
						<th>工作单位</th>
						<th>是否上保险</th>
			        </tr>
				     <tbody id="items">
						<c:forEach items="${turnup.workExperienceList}" var="work" varStatus="status">
							<tr>
								<td><input type="text" class="input" value="${work.beginTime }" id="beginTime${status.index }" name="workExperienceList[${status.index }].beginTime"></td>
								<td><input type="text" class="input" value="${work.endTime }" id="endTime${status.index }" name="workExperienceList[${status.index }].endTime"></td>
								<td><input type="text" class="input" value="${work.unit }" name="workExperienceList[${status.index }].unit"></td>
								<td style="width:95px;">
									<label><input <c:if test="${work.insurance == 0 }">checked="checked" </c:if> name="workExperienceList[${status.index }].insurance" type="radio" class="ace" value="0"><span class="lbl">是</span></label>&nbsp;&nbsp;
		            				<label><input <c:if test="${work.insurance == 1 }">checked="checked" </c:if> name="workExperienceList[${status.index }].insurance" type="radio" class="ace" value="1"><span class="lbl">否</span></label>
								</td>
							</tr>
						</c:forEach>
					</tbody>
			      </table>
	          		
	          	</div>
	          </th>
	        </tr>
	      </table>
	        <div class="field">
	          <button class="button bg-main icon-check-square-o" type="button" onClick="userSub();" style="margin-top:9px;margin-left:800px;"> 提交</button>
	        </div>
	  </form>
	<script type="text/javascript">
	laydate.render({
	    elem: '#birth',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#joinWorkTime',
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
	    elem: '#centerTime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#beginTime0',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#endTime0',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#beginTime1',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#endTime1',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#beginTime2',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#endTime2',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#beginTime3',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#endTime3',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#beginTime4',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#endTime4',
	    event: 'focus' 
	});
	function userSub(){
		if(confirm("确认提交吗？")){
			$("#form-article-add").submit();
		}
	}
	
	function back (){
		window.location.href="apply/online/turnup/list";
	}
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
	</body>
</html>