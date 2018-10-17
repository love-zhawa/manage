<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<base href="<%=request.getContextPath() %>/">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>用车申请</title>  
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
		<h1 class="title">公务用车使用申请表</h1>
		<form action="apply/online/usecar/edit" method="post" class="form-x" id="form-article-add" >
		<input type="hidden" name="id" value="${usecar.id }"/>
			<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1">
			<tr style="height: 40px;">
	          <th width="150">申请人</th>
	          <td style="padding-top: 13px;">${username }</td>
	           <th width="150">所属小组</th>
	          <td width="150">${groupname }<!-- <input type="text" class="input" id="applyDept" name="applyDept" value=""/> --></td>
	        </tr>
	        <tr>
	          <th>申请日期</th>
	          <td><input type="text" class="input" name="applyTime" id="applyTime" value="${usecar.applyTime }" autocomplete="off"/></td>
	          <th rowspan="2">特殊使用申请</th>
	          <th rowspan="2" style="text-align: left;">
	          	<span style="line-height: 30px;"><label class="middle" style="margin-left: 15px;"><input value="1" <c:if test="${fn:contains(usecar.specialInfo,1)}"> checked="checked" </c:if> class="ace" type="checkbox" name="special"><span class="lbl">车辆在外过夜</span></label></span></br>
		     	<span style="line-height: 30px;"><label class="middle" style="margin-left: 15px;"><input value="2" <c:if test="${fn:contains(usecar.specialInfo,2)}"> checked="checked" </c:if> class="ace" type="checkbox" name="special"><span class="lbl">特殊时期</span></label></span></br>
		     	<span style="line-height: 30px;"><label class="middle" style="margin-left: 15px;"><input value="3" <c:if test="${fn:contains(usecar.specialInfo,3)}"> checked="checked" </c:if> class="ace" type="checkbox" name="special"><span class="lbl">恶劣天气</span></label></span></br>
		     	<span style="line-height: 30px;"><label class="middle" style="margin-left: 15px;"><input value="4" <c:if test="${fn:contains(usecar.specialInfo,4)}"> checked="checked" </c:if> class="ace" type="checkbox" name="special"><span class="lbl">节假日期间</span></label></span></br>
		     	<span style="line-height: 30px;"><label class="middle" style="margin-left: 15px;"><input value="5" <c:if test="${fn:contains(usecar.specialInfo,5)}"> checked="checked" </c:if> class="ace" type="checkbox" name="special"><span class="lbl">出京</span></label></span>
	      
	          </th>
	        </tr>
	        <tr>
	          <th>使用时间</th>
	          <td><input type="text" class="input" name="useTime" id="useTime" value="${usecar.useTime }" autocomplete="off"/></td>
	        </tr>
	        <tr style="height: 40px;">
	          <th>事由（人数）</th>
	          <td colspan="3"> <input type="text" class="input" name="reason" value="${usecar.reason }"/></td>
	        </tr>
	        <tr style="height: 40px;">
	          <th>目的地</th>
	          <td colspan="3"><input type="text" class="input" name="destination" value="${usecar.destination }"//></td>
	        </tr>
	        <tr style="height: 40px;">
	          <th>车牌号码</th>
	          <td colspan="3"><input type="text" class="input" name="carNumber" value="${usecar.carNumber }"/></td>
	        </tr>
	        <tr>
	          <th style="height: 40px;">异常情况记录</th>
	          <td align="left" colspan="3"><input type="text" class="input" name="exceptionRecord" value="${usecar.exceptionRecord }"/></td>
	        </tr>
	        <tr style="height: 40px;">
	          <th>驶出时间</th>
	          <td align="left" colspan="3"><input type="text" class="input" name="beginTime" id="beginTime" value="${usecar.beginTime }" autocomplete="off"/></td>
	        </tr>
	        <tr style="height: 40px;">
	          <th>交回时间</th>
	          <td align="left" colspan="3"><input type="text" class="input" name="endTime" id="endTime" value="${usecar.endTime }" autocomplete="off"/></td>
	        </tr>
	        <tr style="height: 40px;">
	          <th>停车费用（元）</th>
	          <td align="left" colspan="3"><input type="text" class="input" name="stopCarPrice" value="${usecar.stopCarPrice }"/></td>
	        </tr>
	        <tr style="height: 40px;">
	          <th>出车驾驶员</th>
	          <td align="left" colspan="3"><input type="text" class="input" name="driver" value="${usecar.driver }"/></td>
	        </tr>
	     </table>
	     <div class="field">
          <button class="button bg-main icon-check-square-o" type="button" onClick="userSub();" style="margin-top:10px;margin-left:800px;"> 提交</button>
        </div>
       </form>
     
     <script type="text/javascript">
	laydate.render({
	    elem: '#beginTime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#endTime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#applyTime',
	    event: 'focus' 
	});
	laydate.render({
	    elem: '#useTime',
	    event: 'focus' 
	});
	
	function userSub(){
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
	</body>
</html>