<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
	<link rel="stylesheet" href="css/tanchu.css">
	<script src="js/jquery.js"></script>
	<script src="js/pintuer.js"></script>
</head>
<body>
<form action="project/0/list" method="post" id="expertsId">
  <div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-reorder">&nbsp;&nbsp;内容列表</strong></div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
      	<shiro:hasPermission name="project0_add">
        	<li> <a class="button border-main icon-plus-square-o" href="javascript:void(0);" id="member_add" onclick="toAdd()">纵向课题</a> </li>
        </shiro:hasPermission>
        <li>搜索：</li>
        <li>
          <input type="text" placeholder="输入项目负责人" name="userName" class="input" style="width:250px; line-height:17px;display:inline-block"  value="${userName}" />
          <input type="text" placeholder="输入项目名称" name="projectName" class="input" style="width:250px; line-height:17px;display:inline-block"  value="${projectName}" />
          <input type="text" placeholder="输入项目级别" name="resource" class="input" style="width:250px; line-height:17px;display:inline-block"  value="${resource}" />
          <a href="javascript:void(0)" class="button border-main icon-search" onclick="searchExperts();"> 搜索</a></li>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th>序号</th>
		<th>财务编号</th>
		<th>项目级别</th>
		<th>项目名称</th>
		<th>项目负责人</th>
		<th>项目类型</th>
		<!-- <th>所在小组</th> -->
		<th>承担单位</th>
		<th>开始时间</th>
		<th>结束时间</th>
		<!-- <th>档案编号</th> -->
		<th>经费总额</th>
		<th>经费到账</th>
		<th>操作</th>
      </tr>
      <c:forEach items="${projectList}" var="project" varStatus="status">
			<tr>
	          <td>${(page.currPage - 1) * page.pageRows + status.index+1}</td>
	          <td>${project.financialNumber }</td>
	          <td>
	            <c:if test="${project.resource == 1 }">子课题</c:if>
	            <c:if test="${project.resource == 2 }">课题</c:if>
	            <c:if test="${project.resource == 3 }">项目</c:if>
	            <c:if test="${project.resource == 4 }">青年科学基金项目</c:if>
	            <c:if test="${project.resource == 5 }">面上项目</c:if>
	            <c:if test="${project.resource == 6 }">重点项目</c:if>
	          	<c:if test="${project.resource == 7 }">优秀青年科学基金项目</c:if>
	          	<c:if test="${project.resource == 8 }">面上资助一等</c:if>
	          	<c:if test="${project.resource == 9 }">农业部建设项目</c:if>
	          	<c:if test="${project.resource == 10 }">B类</c:if>
	          	<c:if test="${project.resource == 11 }">青年骨干个人项目</c:if>
	          	<c:if test="${project.resource == 12 }">青年拔尖个人项目</c:if>
	          	<c:if test="${project.resource == 13 }">所级</c:if>
	          	<c:if test="${project.resource == 14 }">院级</c:if>
	          	<c:if test="${project.resource == 15 }">北京市工程实验室</c:if>
	          	<c:if test="${project.resource == 16 }">北京市重点实验室</c:if>
	          	<c:if test="${project.resource == 17 }">农业部重点实验室</c:if>
	          	<c:if test="${project.resource == 18 }">储备性研究</c:if>
	          	<c:if test="${project.resource == 19 }">新学科培育</c:if>
	          	<c:if test="${project.resource == 20 }">京津冀区域协作创新</c:if>
	          	<c:if test="${project.resource == 21 }">科研示范基地</c:if>
	          	<c:if test="${project.resource == 22 }">联合类</c:if>
	          </td>
	          <td><a href="javascript:void(0)" onclick="detail('${project.id}')">${project.projectName }</a></td>
	          <td>${project.user.name }</td>
	          <td>
				<c:if test="${project.projectType == 6 }">国家重点研发计划</c:if>
	          	<c:if test="${project.projectType == 7 }">863项目</c:if>
	          	<c:if test="${project.projectType == 8 }">科技支撑</c:if>
	          	<c:if test="${project.projectType == 9 }">国家自然科学基金</c:if>
	          	<c:if test="${project.projectType == 10 }">国家重大科学仪器设备开发专项</c:if>
	          	<c:if test="${project.projectType == 11 }">星火计划</c:if>
	          	<c:if test="${project.projectType == 12 }">国家博士后基金</c:if>
	          	<c:if test="${project.projectType == 13 }">公益性行业（农业）专项</c:if>
	          	<c:if test="${project.projectType == 14 }">农业部项目</c:if>
	          	<c:if test="${project.projectType == 15 }">百千万人才资助项目</c:if>
	          	<c:if test="${project.projectType == 16 }">北京市自然科学基金</c:if>
	          	<c:if test="${project.projectType == 17 }">北京市农业科技项目</c:if>
	          	<c:if test="${project.projectType == 18 }">科技新星</c:if>
	          	<c:if test="${project.projectType == 19 }">优秀人才</c:if>
	          	<c:if test="${project.projectType == 20 }">市博士后基金</c:if>
	          	<c:if test="${project.projectType == 21 }">宁夏回族自治区科技攻关计划项目</c:if>
	          	<c:if test="${project.projectType == 22 }">院创新团队</c:if>
	          	<c:if test="${project.projectType == 23 }">院实验室建设</c:if>
	          	<c:if test="${project.projectType == 24 }">院创新能力建设专项</c:if>
	          	<c:if test="${project.projectType == 25 }">院青年基金</c:if>
	          	<c:if test="${project.projectType == 26 }">院博士后基金</c:if>
	          	<c:if test="${project.projectType == 27 }">院科技推广服务</c:if>
	            <c:if test="${project.projectType == 28 }">其他</c:if>
	          </td>
	         <%--  <td>${project.userGroup.groupName }</td> --%>
	          <td>
				<c:if test="${project.unit == 1}">北京农业信息技术研究中心</c:if> 
	          	<c:if test="${project.unit == 2}">北京农业智能装备技术研究中心</c:if> 
	          	<c:if test="${project.unit == 3}">北京派得伟业科技发展有限公司</c:if> 
	          	<c:if test="${project.unit == 4}">农芯科技（北京）有限责任公司</c:if> 
	          	<c:if test="${project.unit == 5}">北京市农林科学院</c:if> 
	          	<c:if test="${project.unit == 6}">北京智慧农业物联网产业技术创新战略联盟</c:if> 
	          	<c:if test="${project.unit == 7}">北京农业智能装备技术研究中心（软硬件实验室）</c:if> 
	          </td>
	          <td><fmt:formatDate value="${project.beginTime }" pattern="yyyy-MM-dd"/></td>
	          <td><fmt:formatDate value="${project.endTime }" pattern="yyyy-MM-dd"/></td>
	         <%--  <td>${project.fileNumber }</td> --%>
	          <td>${project.totalMoney }</td>
	          <td>
	          	  <a href="javascript:void(0)" onclick="show('${project.id}')">${project.incomeList[0].incomeAmount }</a>
	          </td>
	          <td>
		          <div  class="button-group">
		              <a class="button border-main" href="javascript:void(0)" onclick="show1('${project.id}')" >
	          			<span class=""></span>支出明细
	          		  </a>
		          	<shiro:hasPermission name="project0_edit">
		          	<a class="button border-main" onclick="edit('${project.id}')" href="javascript:;">
	          			<span class="icon-edit"></span> 修改
	          		  </a>
	          		 </shiro:hasPermission>
	          		 <shiro:hasPermission name="project0_delete">
	          		  <a class="button border-red" href="javascript:void(0)" onclick="del('${project.id}')">
	          			<span class="icon-trash-o"></span> 删除
	          		  </a>
	          		  </shiro:hasPermission>
	          		  <shiro:hasPermission name="project0_change">
	          		  <a class="button border-yellow" href="javascript:void(0)" onclick="toFundList('${project.id}')">
	          			<span class="icon-external-link"></span> 变动
	          		  </a>
	          		  </shiro:hasPermission>
		          </div>
	          </td>
			</tr>
		</c:forEach>
      	<jsp:include page="../../include/page.jsp">
      		<jsp:param value="13" name="colspan"/>
      	</jsp:include>
    </table>
  </div>
</form>
<div class='alertWindow' id="alertWindow">
        <div class="bg_table bg_table1 hide-box" id="rgxq">
        	<b class= 'closeBtn'  onclick='closeWindow()'>×</b>
        	<h2 style="display:block;width:100%;text-align:center;font-weight:normal;margin-bottom:5px;">经费到账情况</h2>
        	<div class="content">	                    		
                <table class="table table-hover text-center">
                    <thead>
                        <tr>
                            <th>序号</th>
                            <th>到账时间</th>
                            <th>财务编号</th>
                            <th>到账经费</th>
                        </tr>
                    </thead>
                    <tbody id="items">
                    	
                    </tbody>
                 </table>
        	</div>
         </div>
	</div>
	<!-- 支出明细 弹框 -->
	<div class='alertWindow' id="alertWindows">
        <div class="bg_table bg_table1 hide-box" id="rgxqs" style="height:800px;margin-top:-170px;">
        	<b class= 'closeBtn'  onclick='closeWindows()'>×</b>
        	<h2 style="display:block;width:100%;text-align:center;font-weight:normal;margin-bottom:5px;">支出明细表</h2>
        	<div id="top" style="margin-top:10px;"></div>   
        	<div class="content" style="max-height:750px;">	  
                <table class="table table-hover text-center" id="itemss">
                        <tr>
                           <th rowspan="2">行号</th>
                           <th rowspan="2">科目</th>
                           <th colspan="3">预算</th>
                           <th colspan="3">累计支出</th>
                           <th colspan="3">结余</th>
                        </tr>
                        <tr>
                        	<th>专项经费</th>
                        	<th>自筹经费</th>
                        	<th>合计</th>
                        	<th>专项经费</th>
                        	<th>自筹经费</th>
                        	<th>合计</th>
                        	<th>专项经费</th>
                        	<th>自筹经费</th>
                        	<th>合计</th>
                        </tr>
                        <tr>
                        	<td>1</td>
                        	<td>经费支出合计</td>
                        	<td id="ys-sum" style="color:red;font-weight: bold;"></td>
                        	<td></td>
                        	<td id="ys-sums" style="color:red;font-weight: bold;"></td>
                        	<td id="zc-sum" style="color:red;font-weight: bold;"></td>
                        	<td></td>
                        	<td id="zc-sums" style="color:red;font-weight: bold;"></td>
                        	<td id="jy-sum" style="color:red;font-weight: bold;"></td>
                        	<td></td>
                        	<td id="jy-sums" style="color:red;font-weight: bold;"></td>
                        </tr>
                        <tr>
                        	<td>2</td>
                        	<td>（一）直接费用</td>
                        	<td id="zj-1" style="color:green;font-weight: bold;"></td>
                        	<td></td>
                        	<td id="zj-2" style="color:green;font-weight: bold;"></td>
                        	<td id="zj-3" style="color:green;font-weight: bold;"></td>
                        	<td></td>
                        	<td id="zj-4" style="color:green;font-weight: bold;"></td>
                        	<td id="zj-5" style="color:green;font-weight: bold;"></td>
                        	<td></td>
                        	<td id="zj-6" style="color:green;font-weight: bold;"></td>
                        </tr>
                        <tr>
                        	<td>3</td>
                        	<td>1、设备费</td>
                        	<td id="zj-1-1"></td>
                        	<td></td>
                        	<td id="zj-1-2"></td>
                        	<td id="zj-1-3"></td>
                        	<td></td>
                        	<td id="zj-1-4"></td>
                        	<td id="zj-1-5"></td>
                        	<td></td>
                        	<td id="zj-1-6"></td>
                        </tr>
                        <tr>
                        	<td>4</td>
                        	<td>（1）购置设备费</td>
                        	<td id="zj-1-1-1"></td>
                        	<td></td>
                        	<td id="zj-1-1-2"></td>
                        	<td id="zj-1-1-3"></td>
                        	<td></td>
                        	<td id="zj-1-1-4"></td>
                        	<td id="zj-1-1-5"></td>
                        	<td></td>
                        	<td id="zj-1-1-6"></td>
                        </tr>
                        <tr>
                        	<td>5</td>
                        	<td>（2）试制设备费</td>
                        	<td id="zj-1-2-1"></td>
                        	<td></td>
                        	<td id="zj-1-2-2"></td>
                        	<td id="zj-1-2-3"></td>
                        	<td></td>
                        	<td id="zj-1-2-4"></td>
                        	<td id="zj-1-2-5"></td>
                        	<td></td>
                        	<td id="zj-1-2-6"></td>
                        </tr>
                        <tr>
                        	<td>6</td>
                        	<td>（3）设备改造与租赁费</td>
                        	<td id="zj-1-3-1"></td>
                        	<td></td>
                        	<td id="zj-1-3-2"></td>
                        	<td id="zj-1-3-3"></td>
                        	<td></td>
                        	<td id="zj-1-3-4"></td>
                        	<td id="zj-1-3-5"></td>
                        	<td></td>
                        	<td id="zj-1-3-6"></td>
                        </tr>
                        <tr>
                        	<td>7</td>
                        	<td>2、材料费</td>
                        	<td id="zj-2-1"></td>
                        	<td></td>
                        	<td id="zj-2-2"></td>
                        	<td id="zj-2-3"></td>
                        	<td></td>
                        	<td id="zj-2-4"></td>
                        	<td id="zj-2-5"></td>
                        	<td></td>
                        	<td id="zj-2-6"></td>
                        </tr>
                        <tr>
                        	<td>8</td>
                        	<td>3、测试化验加工费</td>
                        	<td id="zj-3-1"></td>
                        	<td></td>
                        	<td id="zj-3-2"></td>
                        	<td id="zj-3-3"></td>
                        	<td></td>
                        	<td id="zj-3-4"></td>
                        	<td id="zj-3-5"></td>
                        	<td></td>
                        	<td id="zj-3-6"></td>
                        </tr>
                        <tr>
                        	<td>9</td>
                        	<td>4、燃料动力费</td>
                        	<td id="zj-4-1"></td>
                        	<td></td>
                        	<td id="zj-4-2"></td>
                        	<td id="zj-4-3"></td>
                        	<td></td>
                        	<td id="zj-4-4"></td>
                        	<td id="zj-4-5"></td>
                        	<td></td>
                        	<td id="zj-4-6"></td>
                        </tr>
                        <tr>
                        	<td>10</td>
                        	<td>5、差旅费</td>
                        	<td id="zj-5-1"></td>
                        	<td></td>
                        	<td id="zj-5-2"></td>
                        	<td id="zj-5-3"></td>
                        	<td></td>
                        	<td id="zj-5-4"></td>
                        	<td id="zj-5-5"></td>
                        	<td></td>
                        	<td id="zj-5-6"></td>
                        </tr>
                        <tr>
                        	<td>11</td>
                        	<td>6、会议费</td>
                        	<td id="zj-6-1"></td>
                        	<td></td>
                        	<td id="zj-6-2"></td>
                        	<td id="zj-6-3"></td>
                        	<td></td>
                        	<td id="zj-6-4"></td>
                        	<td id="zj-6-5"></td>
                        	<td></td>
                        	<td id="zj-6-6"></td>
                        </tr>
                        <tr>
                        	<td>12</td>
                        	<td>7、国际合作与交流费</td>
                        	<td id="zj-7-1"></td>
                        	<td></td>
                        	<td id="zj-7-2"></td>
                        	<td id="zj-7-3"></td>
                        	<td></td>
                        	<td id="zj-7-4"></td>
                        	<td id="zj-7-5"></td>
                        	<td></td>
                        	<td id="zj-7-6"></td>
                        </tr>
                        <tr>
                        	<td>13</td>
                        	<td>8、出版文献/信息传播/知识产权事务费</td>
                        	<td id="zj-8-1"></td>
                        	<td></td>
                        	<td id="zj-8-2"></td>
                        	<td id="zj-8-3"></td>
                        	<td></td>
                        	<td id="zj-8-4"></td>
                        	<td id="zj-8-5"></td>
                        	<td></td>
                        	<td id="zj-8-6"></td>
                        </tr>
                        <tr>
                        	<td>14</td>
                        	<td>9、劳务费</td>
                        	<td id="zj-9-1"></td>
                        	<td></td>
                        	<td id="zj-9-2"></td>
                        	<td id="zj-9-3"></td>
                        	<td></td>
                        	<td id="zj-9-4"></td>
                        	<td id="zj-9-5"></td>
                        	<td></td>
                        	<td id="zj-9-6"></td>
                        </tr>
                        <tr>
                        	<td>15</td>
                        	<td>10、专家咨询费</td>
                        	<td id="zj-10-1"></td>
                        	<td></td>
                        	<td id="zj-10-2"></td>
                        	<td id="zj-10-3"></td>
                        	<td></td>
                        	<td id="zj-10-4"></td>
                        	<td id="zj-10-5"></td>
                        	<td></td>
                        	<td id="zj-10-6"></td>
                        </tr>
                        <tr>
                        	<td>16</td>
                        	<td>11、其他支出</td>
                        	<td id="zj-11-1"></td>
                        	<td></td>
                        	<td id="zj-11-2"></td>
                        	<td id="zj-11-3"></td>
                        	<td></td>
                        	<td id="zj-11-4"></td>
                        	<td id="zj-11-5"></td>
                        	<td></td>
                        	<td id="zj-11-6"></td>
                        </tr>
                        <tr>
                        	<td>17</td>
                        	<td>（二）间接费用</td>
                        	<td id="jj-1" style="color:green;font-weight: bold;"></td>
                        	<td></td>
                        	<td id="jj-2" style="color:green;font-weight: bold;"></td>
                        	<td id="jj-3" style="color:green;font-weight: bold;"></td>
                        	<td></td>
                        	<td id="jj-4" style="color:green;font-weight: bold;"></td>
                        	<td id="jj-5" style="color:green;font-weight: bold;"></td>
                        	<td></td>
                        	<td id="jj-6" style="color:green;font-weight: bold;"></td>
                        </tr>
                        <tr>
                        	<td>18</td>
                        	<td>1、绩效支出</td>
                        	<td id="jj-1-1"></td>
                        	<td></td>
                        	<td id="jj-1-2"></td>
                        	<td id="jj-1-3"></td>
                        	<td></td>
                        	<td id="jj-1-4"></td>
                        	<td id="jj-1-5"></td>
                        	<td></td>
                        	<td id="jj-1-6"></td>
                        </tr>
                        <tr>
                        	<td>19</td>
                        	<td>2、其他支出</td>
                        	<td id="jj-2-1"></td>
                        	<td></td>
                        	<td id="jj-2-2"></td>
                        	<td id="jj-2-3"></td>
                        	<td></td>
                        	<td id="jj-2-4"></td>
                        	<td id="jj-2-5"></td>
                        	<td></td>
                        	<td id="jj-2-6"></td>
                        </tr>
                 </table>
        	</div>
         </div>
	</div>
	<script type="text/javascript">
		function toAdd(){
			window.location.href="project/0/toadd";
		}
		function toFundList(id){
			window.location.href="project/fundlist/"+id;
		}
		
		function searchExperts(){
			$("#expertsId").submit();
		}
		function detail(id){
			window.location.href="project/0/detail/"+id;
		}
		
		function del(id){
			if(confirm("确认删除吗？")){
				window.location.href="project/0/del/"+id;
			}
		}
		function show(id){
			$.post("project/incomce/"+id,function(data){
				$.each(data,function(index, item){
					var tr = "<tr>";
					tr += "<td>";
					tr += index+1
					tr += "</td>";
					tr += "<td>";
					tr += item.str2
					tr += "</td>";
					tr += "<td>";
					tr += item.str1
					tr += "</td>";
					tr += "<td>";
					tr += item.str3
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
		function edit(id){
			window.location.href="project/0/toedit/"+id;
		}
		$(function(){
	    	var msg = '${msg}';
	    	
	    	if(msg != '') {
	    		alert(msg);
	    	}
	    });
	    //支出明细弹框
	    function show1(id){
			$.post("project/incomces/"+id,function(data){
				$.each(data,function(index, item){
					$("#top").html("课题编号："+item.str5+"<span style='margin-left:370px;'>课题名称："+item.str4+"</span><span style='float:right'>单位：万元</span>");

					if(item.str6 == 1){//直接费用-设备费-购置设备费
						$("#zj-1-1-1").html(item.str1);$("#zj-1-1-2").html(item.str1);
						$("#zj-1-1-3").html(item.str2);$("#zj-1-1-4").html(item.str2);
						$("#zj-1-1-5").html(item.str3);$("#zj-1-1-6").html(item.str3);
					}if(item.str6 == 2){//直接费用-设备费-试制设备费
						$("#zj-1-2-1").html(item.str1);$("#zj-1-2-2").html(item.str1);
						$("#zj-1-2-3").html(item.str2);$("#zj-1-2-4").html(item.str2);
						$("#zj-1-2-5").html(item.str3);$("#zj-1-2-6").html(item.str3);
					}if(item.str6 == 3){//直接费用-设备费-设备改造与租赁费
						$("#zj-1-3-1").html(item.str1);$("#zj-1-3-2").html(item.str1);
						$("#zj-1-3-3").html(item.str2);$("#zj-1-3-4").html(item.str2);
						$("#zj-1-3-5").html(item.str3);$("#zj-1-3-6").html(item.str3);
					}if(item.str6 == 4){//直接费用-材料费
						$("#zj-2-1").html(item.str1);$("#zj-2-2").html(item.str1);
						$("#zj-2-3").html(item.str2);$("#zj-2-4").html(item.str2);
						$("#zj-2-5").html(item.str3);$("#zj-2-6").html(item.str3);
					}if(item.str6 == 5){//直接费用-测试化验加工费
						$("#zj-3-1").html(item.str1);$("#zj-3-2").html(item.str1);
						$("#zj-3-3").html(item.str2);$("#zj-3-4").html(item.str2);
						$("#zj-3-5").html(item.str3);$("#zj-3-6").html(item.str3);
					}if(item.str6 == 6){//直接费用-燃料动力费
						$("#zj-4-1").html(item.str1);$("#zj-4-2").html(item.str1);
						$("#zj-4-3").html(item.str2);$("#zj-4-4").html(item.str2);
						$("#zj-4-5").html(item.str3);$("#zj-4-6").html(item.str3);
					}if(item.str6 == 7){//直接费用-差旅费
						$("#zj-5-1").html(item.str1);$("#zj-5-2").html(item.str1);
						$("#zj-5-3").html(item.str2);$("#zj-5-4").html(item.str2);
						$("#zj-5-5").html(item.str3);$("#zj-5-6").html(item.str3);
					}if(item.str6 == 8){//直接费用-会议费
						$("#zj-6-1").html(item.str1);$("#zj-6-2").html(item.str1);
						$("#zj-6-3").html(item.str2);$("#zj-6-4").html(item.str2);
						$("#zj-6-5").html(item.str3);$("#zj-6-6").html(item.str3);
					}if(item.str6 == 9){//直接费用-国际合作与交流费
						$("#zj-7-1").html(item.str1);$("#zj-7-2").html(item.str1);
						$("#zj-7-3").html(item.str2);$("#zj-7-4").html(item.str2);
						$("#zj-7-5").html(item.str3);$("#zj-7-6").html(item.str3);
					}if(item.str6 == 10){//直接费用-出版文献/信息传播/知识产权事务费
						$("#zj-8-1").html(item.str1);$("#zj-8-2").html(item.str1);
						$("#zj-8-3").html(item.str2);$("#zj-8-4").html(item.str2);
						$("#zj-8-5").html(item.str3);$("#zj-8-6").html(item.str3);
					}if(item.str6 == 11){//直接费用-劳务费
						$("#zj-9-1").html(item.str1);$("#zj-9-2").html(item.str1);
						$("#zj-9-3").html(item.str2);$("#zj-9-4").html(item.str2);
						$("#zj-9-5").html(item.str3);$("#zj-9-6").html(item.str3);
					}if(item.str6 == 12){//直接费用-专家咨询费
						$("#zj-10-1").html(item.str1);$("#zj-10-2").html(item.str1);
						$("#zj-10-3").html(item.str2);$("#zj-10-4").html(item.str2);
						$("#zj-10-5").html(item.str3);$("#zj-10-6").html(item.str3);
					}if(item.str6 == 13){//直接费用-其他支出
						$("#zj-11-1").html(item.str1);$("#zj-11-2").html(item.str1);
						$("#zj-11-3").html(item.str2);$("#zj-11-4").html(item.str2);
						$("#zj-11-5").html(item.str3);$("#zj-11-6").html(item.str3);
					}if(item.str6 == 14){//间接费用-绩效支出
						$("#jj-1-1").html(item.str1);$("#jj-1-2").html(item.str1);
						$("#jj-1-3").html(item.str2);$("#jj-1-4").html(item.str2);
						$("#jj-1-5").html(item.str3);$("#jj-1-6").html(item.str3);
					}if(item.str6 == 15){//间接费用-其他支出
						$("#jj-2-1").html(item.str1);$("#jj-2-2").html(item.str1);
						$("#jj-2-3").html(item.str2);$("#jj-2-4").html(item.str2);
						$("#jj-2-5").html(item.str3);$("#jj-2-6").html(item.str3);
					}
				    
			    });
			        //间接
			        var jj11 = parseFloat($("#jj-1-1").html());if(isNaN(jj11)){jj11=0;}
			        var jj21 = parseFloat($("#jj-2-1").html());if(isNaN(jj21)){jj21=0;}
			        var jj12 = parseFloat($("#jj-1-2").html());if(isNaN(jj12)){jj12=0;}
			        var jj22 = parseFloat($("#jj-2-2").html());if(isNaN(jj22)){jj22=0;}
			        var jj13 = parseFloat($("#jj-1-3").html());if(isNaN(jj13)){jj13=0;}
			        var jj23 = parseFloat($("#jj-2-3").html());if(isNaN(jj23)){jj23=0;}
			        var jj14 = parseFloat($("#jj-1-4").html());if(isNaN(jj14)){jj14=0;}
			        var jj24 = parseFloat($("#jj-2-4").html());if(isNaN(jj24)){jj24=0;}
			        var jj15 = parseFloat($("#jj-1-5").html());if(isNaN(jj15)){jj15=0;}
			        var jj25 = parseFloat($("#jj-2-5").html());if(isNaN(jj25)){jj25=0;}
			        var jj16 = parseFloat($("#jj-1-6").html());if(isNaN(jj16)){jj16=0;}
			        var jj26 = parseFloat($("#jj-2-6").html());if(isNaN(jj26)){jj26=0;}
				    $("#jj-1").html(jj11+jj21);
				    $("#jj-2").html(jj12+jj22);
				    $("#jj-3").html(jj13+jj23);
				    $("#jj-4").html(jj14+jj24);
				    $("#jj-5").html(jj15+jj25);
				    $("#jj-6").html(jj16+jj26);
				    //直接-设备
				    var zj111 = parseFloat($("#zj-1-1-1").html());if(isNaN(zj111)){zj111=0;}
				    var zj121 = parseFloat($("#zj-1-2-1").html());if(isNaN(zj121)){zj121=0;}
				    var zj131 = parseFloat($("#zj-1-3-1").html());if(isNaN(zj131)){zj131=0;}
				    var zj112 = parseFloat($("#zj-1-1-2").html());if(isNaN(zj112)){zj112=0;}
				    var zj122 = parseFloat($("#zj-1-2-2").html());if(isNaN(zj122)){zj122=0;}
				    var zj132 = parseFloat($("#zj-1-3-2").html());if(isNaN(zj132)){zj132=0;}
				    var zj113 = parseFloat($("#zj-1-1-3").html());if(isNaN(zj113)){zj113=0;}
				    var zj123 = parseFloat($("#zj-1-2-3").html());if(isNaN(zj123)){zj123=0;}
				    var zj133 = parseFloat($("#zj-1-3-3").html());if(isNaN(zj133)){zj133=0;}
				    var zj114 = parseFloat($("#zj-1-1-4").html());if(isNaN(zj114)){zj114=0;}
				    var zj124 = parseFloat($("#zj-1-2-4").html());if(isNaN(zj124)){zj124=0;}
				    var zj134 = parseFloat($("#zj-1-3-4").html());if(isNaN(zj134)){zj134=0;}
				    var zj115 = parseFloat($("#zj-1-1-5").html());if(isNaN(zj115)){zj115=0;}
				    var zj125 = parseFloat($("#zj-1-2-5").html());if(isNaN(zj125)){zj125=0;}
				    var zj135 = parseFloat($("#zj-1-3-5").html());if(isNaN(zj135)){zj135=0;}
				    var zj116 = parseFloat($("#zj-1-1-6").html());if(isNaN(zj116)){zj116=0;}
				    var zj126 = parseFloat($("#zj-1-2-6").html());if(isNaN(zj126)){zj126=0;}
				    var zj136 = parseFloat($("#zj-1-3-6").html());if(isNaN(zj136)){zj136=0;}
				   
				    $("#zj-1-1").html(zj111+zj121+zj131);
				    $("#zj-1-2").html(zj112+zj122+zj132);
				    $("#zj-1-3").html(zj113+zj123+zj133);
				    $("#zj-1-4").html(zj114+zj124+zj134);
				    $("#zj-1-5").html(zj115+zj125+zj135);
				    $("#zj-1-6").html(zj116+zj126+zj136);
				    //直接
				    var zj21 = parseFloat($("#zj-2-1").html());if(isNaN(zj21)){zj21=0;}var zj31 = parseFloat($("#zj-3-1").html());if(isNaN(zj31)){zj31=0;}
				    var zj41 = parseFloat($("#zj-4-1").html());if(isNaN(zj41)){zj41=0;}var zj51 = parseFloat($("#zj-5-1").html());if(isNaN(zj51)){zj51=0;}
				    var zj61 = parseFloat($("#zj-6-1").html());if(isNaN(zj61)){zj61=0;}var zj71 = parseFloat($("#zj-7-1").html());if(isNaN(zj71)){zj71=0;}
				    var zj81 = parseFloat($("#zj-8-1").html());if(isNaN(zj81)){zj81=0;}var zj91 = parseFloat($("#zj-9-1").html());if(isNaN(zj91)){zj91=0;}
				    var zj101 = parseFloat($("#zj-10-1").html());if(isNaN(zj101)){zj101=0;}var zj111j = parseFloat($("#zj-11-1").html());if(isNaN(zj111j)){zj111j=0;}
				    var zj22 = parseFloat($("#zj-2-2").html());if(isNaN(zj22)){zj22=0;}var zj32 = parseFloat($("#zj-3-2").html());if(isNaN(zj32)){zj32=0;}
				    var zj42 = parseFloat($("#zj-4-2").html());if(isNaN(zj42)){zj42=0;}var zj52 = parseFloat($("#zj-5-2").html());if(isNaN(zj52)){zj52=0;}
				    var zj62 = parseFloat($("#zj-6-2").html());if(isNaN(zj62)){zj62=0;}var zj72 = parseFloat($("#zj-7-2").html());if(isNaN(zj72)){zj72=0;}
				    var zj82 = parseFloat($("#zj-8-2").html());if(isNaN(zj82)){zj82=0;}var zj92 = parseFloat($("#zj-9-2").html());if(isNaN(zj92)){zj92=0;}
				    var zj102 = parseFloat($("#zj-10-2").html());if(isNaN(zj102)){zj102=0;}var zj112j = parseFloat($("#zj-11-2").html());if(isNaN(zj112j)){zj112j=0;}
				    var zj23 = parseFloat($("#zj-2-3").html());if(isNaN(zj23)){zj23=0;}var zj33 = parseFloat($("#zj-3-3").html());if(isNaN(zj33)){zj33=0;}
				    var zj43 = parseFloat($("#zj-4-3").html());if(isNaN(zj43)){zj43=0;}var zj53 = parseFloat($("#zj-5-3").html());if(isNaN(zj53)){zj53=0;}
				    var zj63 = parseFloat($("#zj-6-3").html());if(isNaN(zj63)){zj63=0;}var zj73 = parseFloat($("#zj-7-3").html());if(isNaN(zj73)){zj73=0;}
				    var zj83 = parseFloat($("#zj-8-3").html());if(isNaN(zj83)){zj83=0;}var zj93 = parseFloat($("#zj-9-3").html());if(isNaN(zj93)){zj93=0;}
				    var zj103 = parseFloat($("#zj-10-3").html());if(isNaN(zj103)){zj103=0;}var zj113j = parseFloat($("#zj-11-3").html());if(isNaN(zj113j)){zj113j=0;}
				    var zj24 = parseFloat($("#zj-2-4").html());if(isNaN(zj24)){zj24=0;}var zj34 = parseFloat($("#zj-3-4").html());if(isNaN(zj34)){zj34=0;}
				    var zj44 = parseFloat($("#zj-4-4").html());if(isNaN(zj44)){zj44=0;}var zj54 = parseFloat($("#zj-5-4").html());if(isNaN(zj54)){zj54=0;}
				    var zj64 = parseFloat($("#zj-6-4").html());if(isNaN(zj64)){zj64=0;}var zj74 = parseFloat($("#zj-7-4").html());if(isNaN(zj74)){zj74=0;}
				    var zj84 = parseFloat($("#zj-8-4").html());if(isNaN(zj84)){zj84=0;}var zj94 = parseFloat($("#zj-9-4").html());if(isNaN(zj94)){zj94=0;}
				    var zj104 = parseFloat($("#zj-10-4").html());if(isNaN(zj104)){zj104=0;}var zj114j = parseFloat($("#zj-11-4").html());if(isNaN(zj114j)){zj114j=0;}
				    var zj25 = parseFloat($("#zj-2-5").html());if(isNaN(zj25)){zj25=0;}var zj35 = parseFloat($("#zj-3-5").html());if(isNaN(zj35)){zj35=0;}
				    var zj45 = parseFloat($("#zj-4-5").html());if(isNaN(zj45)){zj45=0;}var zj55 = parseFloat($("#zj-5-5").html());if(isNaN(zj55)){zj55=0;}
				    var zj65 = parseFloat($("#zj-6-5").html());if(isNaN(zj65)){zj65=0;}var zj75 = parseFloat($("#zj-7-5").html());if(isNaN(zj75)){zj75=0;}
				    var zj85 = parseFloat($("#zj-8-5").html());if(isNaN(zj85)){zj85=0;}var zj95 = parseFloat($("#zj-9-5").html());if(isNaN(zj95)){zj95=0;}
				    var zj105 = parseFloat($("#zj-10-5").html());if(isNaN(zj105)){zj105=0;}var zj115j = parseFloat($("#zj-11-5").html());if(isNaN(zj115j)){zj115j=0;}
				    var zj26 = parseFloat($("#zj-2-6").html());if(isNaN(zj26)){zj26=0;}var zj36 = parseFloat($("#zj-3-6").html());if(isNaN(zj36)){zj36=0;}
				    var zj46 = parseFloat($("#zj-4-6").html());if(isNaN(zj46)){zj46=0;}var zj56 = parseFloat($("#zj-5-6").html());if(isNaN(zj56)){zj56=0;}
				    var zj66 = parseFloat($("#zj-6-6").html());if(isNaN(zj66)){zj66=0;}var zj76 = parseFloat($("#zj-7-6").html());if(isNaN(zj76)){zj76=0;}
				    var zj86 = parseFloat($("#zj-8-6").html());if(isNaN(zj86)){zj86=0;}var zj96 = parseFloat($("#zj-9-6").html());if(isNaN(zj96)){zj96=0;}
				    var zj106 = parseFloat($("#zj-10-6").html());if(isNaN(zj106)){zj106=0;}var zj116j = parseFloat($("#zj-11-6").html());if(isNaN(zj116j)){zj116j=0;}
				    
				    var z1=zj111+zj121+zj131+zj21+zj31+zj41+zj51+zj61+zj71+zj81+zj91+zj101+zj111j;
				    var z2=zj112+zj122+zj132+zj22+zj32+zj42+zj52+zj62+zj72+zj82+zj92+zj102+zj112j;
				    var z3=zj113+zj123+zj133+zj23+zj33+zj43+zj53+zj63+zj73+zj83+zj93+zj103+zj113j;
				    var z4=zj114+zj124+zj134+zj24+zj34+zj44+zj54+zj64+zj74+zj84+zj94+zj104+zj114j;
				    var z5=zj115+zj125+zj135+zj25+zj35+zj45+zj55+zj65+zj75+zj85+zj95+zj105+zj115j;
				    var z6=zj116+zj126+zj136+zj26+zj36+zj46+zj56+zj66+zj76+zj86+zj96+zj106+zj116j;
					
					$("#zj-1").html(z1);
				    $("#zj-2").html(z2);
				    $("#zj-3").html(z3);
				    $("#zj-4").html(z4);
				    $("#zj-5").html(z5);
				    $("#zj-6").html(z6);
				    //经费支出合计  直接+间接
				    $("#ys-sum").html(z1+jj11+jj21);
				    $("#ys-sums").html(z2+jj12+jj22);
				    $("#zc-sum").html(z3+jj13+jj23);
				    $("#zc-sums").html(z4+jj14+jj24);
				    $("#jy-sum").html(z5+jj15+jj25);
				    $("#jy-sums").html(z6+jj16+jj26);
			});			
			
			$("#alertWindows").show();
			$("#rgxqs").show();
			
			
		}
		function closeWindows(){
			$("#alertWindows").hide();
			$("#rgxqs").hide();
			
			$("#zj-1-1-1").html('');$("#zj-1-1-2").html('');
			$("#zj-1-1-3").html('');$("#zj-1-1-4").html('');
			$("#zj-1-1-5").html('');$("#zj-1-1-6").html('');
			$("#zj-1-2-1").html('');$("#zj-1-2-2").html('');
			$("#zj-1-2-3").html('');$("#zj-1-2-4").html('');
			$("#zj-1-2-5").html('');$("#zj-1-2-6").html('');
			$("#zj-1-3-1").html('');$("#zj-1-3-2").html('');
			$("#zj-1-3-3").html('');$("#zj-1-3-4").html('');
			$("#zj-1-3-5").html('');$("#zj-1-3-6").html('');
			$("#zj-2-1").html('');$("#zj-2-2").html('');
			$("#zj-2-3").html('');$("#zj-2-4").html('');
			$("#zj-2-5").html('');$("#zj-2-6").html('');
			$("#zj-3-1").html('');$("#zj-3-2").html('');
			$("#zj-3-3").html('');$("#zj-3-4").html('');
			$("#zj-3-5").html('');$("#zj-3-6").html('');
			$("#zj-4-1").html('');$("#zj-4-2").html('');
			$("#zj-4-3").html('');$("#zj-4-4").html('');
			$("#zj-4-5").html('');$("#zj-4-6").html('');
			$("#zj-5-1").html('');$("#zj-5-2").html('');
			$("#zj-5-3").html('');$("#zj-5-4").html('');
			$("#zj-5-5").html('');$("#zj-5-6").html('');
			$("#zj-6-1").html('');$("#zj-6-2").html('');
			$("#zj-6-3").html('');$("#zj-6-4").html('');
			$("#zj-6-5").html('');$("#zj-6-6").html('');
			$("#zj-7-1").html('');$("#zj-7-2").html('');
			$("#zj-7-3").html('');$("#zj-7-4").html('');
			$("#zj-7-5").html('');$("#zj-7-6").html('');
			$("#zj-8-1").html('');$("#zj-8-2").html('');
			$("#zj-8-3").html('');$("#zj-8-4").html('');
			$("#zj-8-5").html('');$("#zj-8-6").html('');
			$("#zj-9-1").html('');$("#zj-9-2").html('');
			$("#zj-9-3").html('');$("#zj-9-4").html('');
			$("#zj-9-5").html('');$("#zj-9-6").html('');
			$("#zj-10-1").html('');$("#zj-10-2").html('');
			$("#zj-10-3").html('');$("#zj-10-4").html('');
			$("#zj-10-5").html('');$("#zj-10-6").html('');
			$("#zj-11-1").html('');$("#zj-11-2").html('');
			$("#zj-11-3").html('');$("#zj-11-4").html('');
			$("#zj-11-5").html('');$("#zj-11-6").html('');
			$("#jj-1-1").html('');$("#jj-1-2").html('');
			$("#jj-1-3").html('');$("#jj-1-4").html('');
			$("#jj-1-5").html('');$("#jj-1-6").html('');
			$("#jj-2-1").html('');$("#jj-2-2").html('');
			$("#jj-2-3").html('');$("#jj-2-4").html('');
			$("#jj-2-5").html('');$("#jj-2-6").html('');
		}
	</script>
	    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>
</body>
</html>