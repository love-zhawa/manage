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
    <title></title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery-1.9.1.min.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css"  media="all">
<style>
h1 {text-align: center;margin-bottom: 20px;padding-top:4%;}
.table1 {width: 1000px;border-collapse: collapse}
.table1 tr{height: 38px;}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 th,.table1 td {border: 1px solid #333;padding: 9px 0 0 0;text-align: center;}
.input{border: 0px;}
body{MARGIN: 0 AUTO;}
.btn{border: solid 1px #ddd;background: transparent;border-radius: 4px;font-size: 14px;padding: 6px 15px;margin: 0;display: inline-block;line-height: 20px;background-color: rgb(0, 170, 238);}
</style>
</head>
<body>
	<h1 class="title"><fmt:formatDate value="${stu.bztime }" pattern="yyyy年MM月"/>学生补助发放明细</h1>
	<p class="bold" style="text-align: center;">
		<span style="display: inline-block;text-align: center;" >支出：${stu.project.projectName }</span>
	</p>
	<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1" style="width: 1000px">
        <tr style="height: 38px;">
          <th style="padding-top: 9px;">部门</th>
          <td style="padding-top: 9px;" colspan="9">${user.userGroup.groupName}</td>
        </tr>
        <tr>
      		<th style="width:5%;padding-top: 9px;">姓名</th>
      		<th style="width:5%;padding-top: 9px;">类别</th>
      		<th style="width:15%;padding-top: 9px;">身份证号</th>
      		<th style="width:14%;padding-top: 9px;">开户银行</th>
      		<th style="width:15%;padding-top: 9px;">账号</th>
      		<th style="padding-top: 9px;">工作时间(天)</th>
      		<th style="padding-top: 9px;">劳务金额(元)</th>
      		<th style="padding-top: 9px;">其他补助(元)</th>
      		<th style="padding-top: 9px;">小计金额(元)</th>
      		<th style="padding-top: 9px;">领款人签字</th>
      	</tr>
         <c:forEach items="${stu.bzlist}" var="bz" varStatus="i">
			<tr>
	          <td>${bz.user.name}</td>
	          <td>
				<c:if test="${bz.user.education == 1 }">硕士</c:if>
				<c:if test="${bz.user.education == 2 }">博士</c:if>
				<c:if test="${bz.user.education == 3 }">学士</c:if>
			  </td>
	          <td>${bz.user.idCard }</td>
	          <td>${bz.user.bank }</td>
	          <td>${bz.user.cardid }</td>
	          <td>${bz.ts }</td>
	          <td>${bz.money }</td>
	          <td>${bz.qtmoney }</td>
	          <td>${bz.summoney }</td>
	          <td></td>
			</tr>
		</c:forEach>
        <tr>
			<th colspan="2">合计</th>
			<th></th>
			<th colspan="5">（人民币大写）${CN}</th>
			<th><c:if test="${EN != null }">￥:${EN } </c:if></th>
			<td></td>
		</tr>
      </table>
      <p style="text-align: center;">
      	制表人：<span style="width: 110px; display: inline-block;"></span>
      	部门负责人：<span style="width: 110px; display: inline-block;"></span>
      	办公室审核：<span style="width: 110px; display: inline-block;"></span>
      </p>
       <div id="printDiv" style="text-align: center;margin-top: 10px;">
     	<button class="btn" type="button" onClick="printData();" >&nbsp;&nbsp;&nbsp;打印&nbsp;&nbsp;&nbsp;</button>
     </div>
 <script>
        function pagesetup_null(){
          var hkey_root = "HKEY_CURRENT_USER",
              hkey_path = "\\Software\\Microsoft\\Internet Explorer\\PageSetup\\",
              hkey_key;
           try{
               var RegWsh = new ActiveXObject("WScript.Shell")
               hkey_key="header"
               RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
               hkey_key="footer"
               RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
           }catch(e){}
       }
       pagesetup_null();
       function  printData(){//打印
			$("#printDiv").hide();
			window.print();//打印
			$("#printDiv").show();
       }
       function back(){
    	   window.history.go(-1);
       }
    </script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
	</body>
</html>
