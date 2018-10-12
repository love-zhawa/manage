<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<base href="<%=request.getContextPath() %>/">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>查看纵向课题</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
    <style type="text/css">
    	.cc{line-height: 34px;}
    </style>
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;查看纵向课题</strong></div>
  <div class="body-content">
    <form action="project/0/edit" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
      <div class="form-group">
        <div class="label">
          <label>财务编号：</label>
        </div>
        <div class="field cc">
          ${project.financialNumber }
        </div>
      </div>
		
      <div class="form-group">
        <div class="label">
          <label>项目名称：</label>
        </div>
        <div class="field cc">
          ${project.projectName }
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>项目负责人：</label>
        </div>
        <div class="field cc">
          ${project.user.name }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>项目级别：</label>
        </div>
        <div class="field cc">
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
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>项目类型：</label>
        </div>
        <div class="field cc">
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
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>所在小组：</label>
        </div>
        <div class="field cc">
          ${project.userGroup.groupName }
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>承担单位：</label>
        </div>
        <div class="field cc">
          	<c:if test="${1 == project.unit}">北京农业信息技术研究中心</c:if> 
          	<c:if test="${2 == project.unit}">北京农业智能装备技术研究中心</c:if> 
          	<c:if test="${3 == project.unit}">北京派得伟业科技发展有限公司</c:if> 
          	<c:if test="${4 == project.unit}">农芯科技（北京）有限责任公司</c:if> 
          	<c:if test="${5 == project.unit}">北京市农林科学院</c:if> 
          	<c:if test="${6 == project.unit}">北京智慧农业物联网产业技术创新战略联盟</c:if> 
          	<c:if test="${7 == project.unit}">北京农业智能装备技术研究中心（软硬件实验室）</c:if> 
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>开始时间：</label>
        </div>
        <div class="field cc">
          <fmt:formatDate value="${project.beginTime }" pattern="yyyy-MM-dd"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>结束时间：</label>
        </div>
        <div class="field cc">
          <fmt:formatDate value="${project.endTime }" pattern="yyyy-MM-dd"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>经费总额：</label>
        </div>
        <div class="field cc">
          ${project.totalMoney }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>到账总额：</label>
        </div>
        <div class="field cc">
          ${project.incomeList[0].incomeAmount }
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>档案编号：</label>
        </div>
        <div class="field cc">
          ${project.fileNumber }
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>预算说明：</label>
        </div>
        <div class="field cc">
          <a href="javascript:void(0)" onclick="downFile('${attachment.filePath }')">${attachment.fileName }</a>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>经费明细：</label>
        </div>
        <div class="field cc">
          <table class="table table-hover text-center">
	      	 <tr>
		        <th>原预算</th>
		        <th>新预算</th>
		        <th>实际支出</th>
		        <th>原结余</th>
		        <th>新结余</th>
		     </tr>							
		     <tbody id="items">
				<c:forEach items="${project.fundList}" var="item" varStatus="status">
					<tr>
						<td>${item.originalBudget }</td>
						<td>${item.newBudget }</td>
						<td>${item.pay }</td>
						<td>${item.originalBalance }</td>
						<td>${item.newBalance }</td>
					</tr>
				</c:forEach>
				</tbody>
	      </table>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>外拨经费：</label>
        </div>
        <div class="field cc">
          <table class="table table-hover text-center">
	      	 <tr>
		        <th>单位</th>
		        <th>金额</th>
		     </tr>							
		     <tbody>
				<c:forEach items="${project.outList}" var="item" varStatus="status">
					<tr>
						<td>${item.unit }</td>
						<td>${item.amount }</td>
					</tr>
				</c:forEach>
			</tbody>
	      </table>
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
	function downFile(path){
		window.location.href="upload/" + path;
	}
	function goList(){
		window.location.href="apply/online/remuneration/list";
	}
	</script>
</html>