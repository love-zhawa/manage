<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<base href="<%=request.getContextPath() %>/">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>考勤统计</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" href="css/tanchu.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
    <!-- <script src="js/highcharts.js"></script>
	<script src="js/highcharts-3d.js"></script>
	<script src="js/exporting.js"></script> -->
<script>
function FormatDate (strTime) {
    var date = new Date(strTime);
    return date.getHours()+":"+date.getMinutes();
}
$(function(){
    var sb = $("#sb").val();
    var sbb =  sb.substring(11,16);
    if(sbb<"09:00"){
    	$("#sbzt").html("正常");
    }else{
    	$("#sbzt").html("异常");
    }
    var xb = $("#xb").val();
    var xbb =  xb.substring(11,16);
    if(xbb>"17:30"){
    	$("#xbzt").html("正常");
    }else{
    	$("#xbzt").html("异常");
    }
});
</script>
</head>
<body>
<div class="panel admin-panel">
	<div class="panel-head"><strong class="icon-reorder">&nbsp;&nbsp;我的考勤</strong></div>
  <div class="body-content">
	<!-- <div id="container" style = "float: left;width: 48%"></div> -->
	<div style = "float: left; border: solid 1px #EEE;width: 100%;">
		<table class="table table-hover text-center">
      <tr>
        <th>序号</th>
		<th>用户姓名</th>
		<th>上班时间</th>
		<th>下班时间</th>
		<th colspan="2">状态</th>
      </tr>
      <c:forEach items="${dk}" var="today" varStatus="status">
      	<tr>
          <td>${status.index+1}</td>
          <td>${today.user.name}</td>
          <td>${fn:substring(today.attendanceTime,0,16)}<input type="hidden" value="${today.attendanceTime}" id="sb"></td>
          <td>${fn:substring(today.attendanceTime2,0,16)}<input type="hidden" value="${today.attendanceTime2}" id="xb"></td>
          <td><div id="sbzt"></div></td>
          <td><div id="xbzt"></div></td>
        </tr>
      </c:forEach>
      </table>
	</div>
  </div>
</div>
<div class="panel admin-panel">
	<div class="panel-head"><strong class="icon-reorder">&nbsp;&nbsp;${dataTime}考勤明细</strong></div>
    <form action="attendance/stat" method="post" id="searchForm">
    	<div class="padding border-bottom">
	      <ul class="search" style="padding-left:10px;">
	       <!-- 	<shiro:hasPermission name="attendance_set">
	       		<li> <a class="button border-main icon-plus-square-o" href="javascript:void(0);" id="member_add" onclick="toSet()">考勤组设置</a> </li>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="attendance_add">
	       		<li> <a class="button border-main icon-plus-square-o" href="javascript:void(0);" id="member_add" onclick="toAdd()">考勤填报</a> </li>
	        </shiro:hasPermission> -->
	        <li>搜索：</li>
	        <li>
	          <input type="text" placeholder="考勤日期" id="startTime" name="startTime" class="input" style="width:200px; line-height:17px;display:inline-block"  value="${startTime}" autocomplete="off"/>
	          <a href="javascript:void(0)" class="button border-main icon-search" onclick="searchExperts();"> 搜索</a>
	        </li>
	        <li>数据汇总：</li>
	        <li>
	          <input type="text" placeholder="开始日期" id="beginTime" name="beginTime" class="input" style="width:200px; line-height:17px;display:inline-block"  value="${beginTime}" autocomplete="off"/> -
	          <input type="text" placeholder="结束日期" id="endTime" name="endTime" class="input" style="width:200px; line-height:17px;display:inline-block"  value="${endTime}" autocomplete="off"/>
	          <a href="javascript:void(0)" class="button border-main icon-search" onclick="show();"> 统计</a>
	        </li>
	      </ul>
	    </div>
    </form>
    <table class="layui-hide" id="test"></table>
    
    
    <div style="overflow-y: scroll;height: 560px;">
		<table class="table table-hover text-center">
	      <tr>
	        <th>序号</th>
			<th>用户姓名</th>
			<th  onclick="sortAge()">上班时间</th>
			<th>下班时间</th>
			<th>请假</th>
			<th>旷工</th>
			<th>出差</th>
			<th>加班</th>
	      </tr>
	      <%-- <c:forEach items="${statList}" var="stat" varStatus="status">
	      	<tr>
	          <td>${status.index+1}</td>
	          <td>${stat.user.name}</td>
	          <td>
	          	<c:if test="${stat.zaodaka == 0}">正常</c:if>
	          	<c:if test="${stat.zaodaka == 1}">异常</c:if>
	          </td>
	          <td>
	          	<c:if test="${stat.wandaka == 0}">正常</c:if>
	          	<c:if test="${stat.wandaka == 1}">异常</c:if>
	          </td>
	          <td>
	          	<c:if test="${stat.qingjia == 1}">请假</c:if>
	          </td>
	          <td>
	          	<c:if test="${stat.chuchai == 1}">出差</c:if>
	          </td>
	          <td>
	          	<c:if test="${stat.waichu == 1}">外出</c:if>
	          </td>
	          <td>
	          	<c:if test="${stat.kuanggong == 1}">旷工</c:if>
	          </td>
	          <td>
	          	<c:if test="${stat.jiaban == 1}">加班</c:if>
	          </td>
	        </tr>
	      </c:forEach> --%>
	      <c:forEach items="${dkmx}" var="d" varStatus="status">
		      <tr>
		          <td>${status.index+1}</td>
		          <td>${d.user.name}</td>
		          <td>
		          <c:if test="${fn:substring(day,10,16) ne fn:substring(d.attendanceTime,10,16)}">
		             ${fn:substring(d.attendanceTime,10,16) }
		          </c:if>
		          </td>
		          <td>${fn:substring(d.attendanceTime2,10,16) }</td>
		          <td>${qjmap[d.user.id] }</td>
		          <td>
		          	<c:if test="${(d.attendanceTime eq null || fn:substring(day,10,16) eq fn:substring(d.attendanceTime,10,16)) && d.attendanceTime2 eq null && qjmap[d.user.id] eq null && ccmap[d.user.id] eq null && jbmap[d.user.id] eq null}">
		          		旷工
		          	</c:if>
		          </td>
		          <td>${ccmap[d.user.id] }</td>
		          <td>${jbmap[d.user.id] }</td>
		      </tr>
	      </c:forEach>
	      </table>
      </div>
</div>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div> 
</body>
<div class='alertWindow' id="alertWindow">
	<div class="bg_table bg_table1 hide-box" id="rgxq" style="height:60%;">
		<b class='closeBtn' onclick='closeWindow()'>×</b>
		<h2
			style="display: block; width: 100%; text-align: center; font-weight: normal; margin-bottom: 5px;">考勤汇总明细</h2>
		<div class="content" style="max-height:450px;">
			<table class="table table-hover text-center">
				<thead>
					<tr>
						<th>序号</th>
						<th>姓名</th>
						<th>出勤天数</th>
						<th>迟到天数</th>
						<th>早退天数</th>
						<th>请假天数</th>
						<th>旷工天数</th>
						<th>出差天数</th>
					</tr>
				</thead>
				<tbody id="items">

				</tbody>
			</table>
		</div>
	</div>
</div>
<script type="text/javascript">
	    function show() {
	    	var beginTime = $("#beginTime").val();
			var endTime = $("#endTime").val();
			if(beginTime>endTime){
				alert("开始时间不能大于结束时间！");
				return;
			}
			$.post("attendance/tj",{"beginTime":beginTime,"endTime":endTime}, function(data) {
				$.each(data, function(index, item) {
					var tr = "<tr>";
					tr += "<td>";
					tr += index+1
					tr += "</td>";
					tr += "<td>";
					tr += item.str1
					tr += "</td>";
					tr += "<td>";
					tr += item.str2
					tr += "</td>";
					tr += "<td>";
					tr += item.str3
					tr += "</td>";
					tr += "<td>";
					tr += item.str4
					tr += "</td>";
					tr += "<td>";
					tr += item.str5
					tr += "</td>";
					tr += "<td>";
					tr += item.str6
					tr += "</td>";
					tr += "<td>";
					tr += "";
					tr += "</td>";
					tr += "</tr>";
					
					$("#items").append(tr);
				});
			});

			$("#alertWindow").show();
			$("#rgxq").show();
		}
	    function closeWindow(){
			$("#alertWindow").hide();
			$("#rgxq").hide();
			$("#items").empty();
		 }
		function searchExperts(){
			$("#searchForm").submit();
		}
		function toAdd(){
			window.location.href = "attendance/toadd";
		}
		function toSet(){
			window.location.href = "attendance/toset";
		}
		
		laydate.render({
		    elem: '#startTime',
		    event: 'focus' 
		});
		laydate.render({
		    elem: '#beginTime',
		    event: 'focus' 
		});
		laydate.render({
		    elem: '#endTime',
		    event: 'focus' 
		});
		/* Highcharts.chart('container', {
		    chart: {
		        type: 'pie',
		        options3d: {
		            enabled: true,
		            alpha: 45,
		            beta: 0
		        }
		    },
		    title: {
		        text: '今日出勤情况'
		    },
		    tooltip: {
		        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
		    },
		    credits: {  
		        enabled: false
		    },
		    exporting:{  
		    	enabled: false
		    },
		    plotOptions: {
		        pie: {
		            allowPointSelect: true,
		            cursor: 'pointer',
		            depth: 35,
		            dataLabels: {
		                enabled: true,
		                format: '{point.name}'
		            },
			    events: {
			        click: function(e) {
			        }
			       }
		        }
		    },
		    series: [{
		        type: 'pie',
		        name: '今日出勤情况',
		        data: [
					<c:forEach items="${curr }" var="vo">
						['${vo.name } : ${vo.count}', ${vo.count}],
					</c:forEach>
		        ]
		    }]
		}); */
	</script>
</html>