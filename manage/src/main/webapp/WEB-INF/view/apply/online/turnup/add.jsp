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
		<form action="apply/online/turnup/add" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
			<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1">
			<tr>
	          <th>姓名</th>
	          <td><input type="text" class="input" id="userName" name="userName" value=""/></td>
	          <th style="width:44px;">性别</th>
	          <td colspan="2">
	          	<label><input name="gender" type="radio" checked="checked" class="ace" value="0"><span class="lbl">男</span></label>&nbsp;&nbsp;
            	<label><input name="gender" type="radio" class="ace" value="1"><span class="lbl">女</span></label>
	          </td>
	          <th>出生年月</th>
	          <td colspan="2"><input type="text" class="input" name="birth" id="birth" value="" autocomplete="off"/></td>
	          <td rowspan="6" style="width:160px;">
	          	<input type="file" class="input" name="file">
	          </td>
	        </tr>
	        <tr>
	          <th width="63px;">民族</th>
	          <td><input type="text" class="input" name="nation" value=""/></td>
	          <th width="31px">婚否</th>
	          <td colspan="2">
	          	<label><input name="marriage" type="radio" checked="checked" class="ace" value="0"><span class="lbl">已婚</span></label>&nbsp;&nbsp;
            	<label><input name="marriage" type="radio" class="ace" value="1"><span class="lbl">未婚</span></label>
	          </td>
	          <th width="81px;">政治面貌</th>
	          <td colspan="2"><input type="text" class="input" name="outlook" value=""/></td>
	        </tr>
	        <tr>
	          <th>家庭地址</th>
	          <td colspan="4"><input type="text" class="input" name="homeAddress" value=""/></td>
	          <th>籍贯</th>
	          <td colspan="2"><input type="text" class="input" name="place" value=""/></td>
	        </tr>
	        <tr>
	          <th>手机号码</th>
	          <td colspan="3"><input type="text" class="input" name="phoneNumber" id="phoneNumber" value=""/></td>
	          <th>部门</th>
	          <td colspan="3"><input type="text" class="input" name="dept" id="dept" value=""/></td>
	        </tr>
	        <tr>
	         	<th>身份证号</th>
	            <td colspan="7"><input type="text" class="input" name="idCard" value=""/></td>
	        </tr>
	        <tr>
	          <th>毕业院校</th>
	          <td colspan="4"><input type="text" class="input" name="school" value=""/></td>
	          <th>专业</th>
	          <td colspan="2"><input type="text" class="input" name="major" value=""/></td>
	        </tr>
	        <tr>
	          <th>毕业时间</th>
	          <td colspan="4"><input type="text" class="input" id="graduationTime" name="graduationTime" value="" autocomplete="off"/></td>
	          <th>学历</th>
	          <td colspan="3"><input type="text" class="input" name="education" value=""/></td>
	        </tr>
	        <tr>
	          <th>学位</th>
	          <td colspan="4"><input type="text" class="input" name="degree" value=""/></td>
	          <th colspan="2">参加工作时间</th>
	          <td colspan="3"><input type="text" class="input" id="joinWorkTime" name="joinWorkTime" value="" autocomplete="off"/></td>
	        </tr>
	        <tr>
	          <th colspan="2">现工作岗位</th>
	          <td colspan="3"><input type="text" class="input" name="post" value=""/></td>
	          <th colspan="2">宅电</th>
	          <td colspan="3"><input type="text" class="input" name="mobile" value=""/></td>
	        </tr>
	        
	        <tr>
	          <th colspan="2">来中心时间</th>
	          <td colspan="3"><input type="text" class="input" id="centerTime" name="centerTime" value="" autocomplete="off"/></td>
	          <th colspan="2">连续工龄</th>
	          <td colspan="3"><input type="text" class="input" name="workingYears" value=""/></td>
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
							<tr>
								<td><input type="text" class="input" value=""  id="beginTime0" name="workExperienceList[0].beginTime" ></td>
								<td><input type="text" class="input" value=""  id="endTime0" name="workExperienceList[0].endTime" ></td>
								<td><input type="text" class="input" value=""  name="workExperienceList[0].unit" ></td>
								<td>
									<label><input name="workExperienceList[0].insurance" type="radio" checked="checked" class="ace" value="0"><span class="lbl">是</span></label>&nbsp;&nbsp;
		            				<label><input name="workExperienceList[0].insurance" type="radio" class="ace" value="1"><span class="lbl">否</span></label>
								</td>
							</tr>
							<tr>
								<td><input type="text" class="input" value=""  id="beginTime1" name="workExperienceList[1].beginTime" ></td>
								<td><input type="text" class="input" value=""  id="endTime1" name="workExperienceList[1].endTime" ></td>
								<td><input type="text" class="input" value=""  name="workExperienceList[1].unit" ></td>
								<td style="width:95px;">
									<label><input name="workExperienceList[1].insurance" type="radio" checked="checked" class="ace" value="0"><span class="lbl">是</span></label>&nbsp;&nbsp;
		            				<label><input name="workExperienceList[1].insurance" type="radio" class="ace" value="1"><span class="lbl">否</span></label>
								</td>
							</tr>
							<tr>
								<td><input type="text" class="input" value=""  id="beginTime2" name="workExperienceList[2].beginTime" ></td>
								<td><input type="text" class="input" value=""  id="endTime2" name="workExperienceList[2].endTime" ></td>
								<td><input type="text" class="input" value=""  name="workExperienceList[2].unit" ></td>
								<td>
									<label><input name="workExperienceList[2].insurance" type="radio" checked="checked" class="ace" value="0"><span class="lbl">是</span></label>&nbsp;&nbsp;
		            				<label><input name="workExperienceList[2].insurance" type="radio" class="ace" value="1"><span class="lbl">否</span></label>
								</td>
							</tr>
							<tr>
								<td><input type="text" class="input" value=""  id="beginTime3" name="workExperienceList[3].beginTime" ></td>
								<td><input type="text" class="input" value=""  id="endTime3" name="workExperienceList[3].endTime" ></td>
								<td><input type="text" class="input" value=""  name="workExperienceList[3].unit" ></td>
								<td>
									<label><input name="workExperienceList[3].insurance" type="radio" checked="checked" class="ace" value="0"><span class="lbl">是</span></label>&nbsp;&nbsp;
		            				<label><input name="workExperienceList[3].insurance" type="radio" class="ace" value="1"><span class="lbl">否</span></label>
								</td>
							</tr>
							<tr>
								<td><input type="text" class="input" value=""  id="beginTime4" name="workExperienceList[4].beginTime" ></td>
								<td><input type="text" class="input" value=""  id="endTime4" name="workExperienceList[4].endTime" ></td>
								<td><input type="text" class="input" value=""  name="workExperienceList[4].unit" ></td>
								<td>
									<label><input name="workExperienceList[4].insurance" type="radio" checked="checked" class="ace" value="0"><span class="lbl">是</span></label>&nbsp;&nbsp;
		            				<label><input name="workExperienceList[4].insurance" type="radio" class="ace" value="1"><span class="lbl">否</span></label>
								</td>
							</tr>
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