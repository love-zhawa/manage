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
    <title>编辑纵向项目</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;编辑纵向项目</strong></div>
  <div class="body-content">
    <form action="project/0/edit" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
      <input name="id" type="hidden" value="${project.id }"/>
      <div class="form-group">
        <div class="label">
          <label>财务编号：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="financialNumber" value="${project.financialNumber }"/>
        </div>
      </div>
		
	  
      <div class="form-group">
        <div class="label">
          <label>项目名称：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="projectName" value="${project.projectName }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>项目负责人：</label>
        </div>
        <div class="field">
          <select name="user.id" class="input w50" style="width: 300px;">
          	<c:forEach items="${userList }" var="user">
          		<option <c:if test="${user.id == project.user.id}">selected</c:if> value="${user.id }">${user.name }</option>
          	</c:forEach>
          </select>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>项目级别：</label>
        </div>
        <div class="field">
         <%--  <input type="text" class="input" name="resource" value="${project.resource }"/> --%>
          <select name="resource" class="input w50" style="width: 300px;">
          	<option <c:if test="${6 == project.projectType}">selected</c:if> value="6">国家重点研发计划</option>
          
            <option <c:if test="${project.resource == 1 }">selected</c:if> value="1">子课题</option>
            <option <c:if test="${project.resource == 2 }">selected</c:if> value="2">课题</option>
            <option <c:if test="${project.resource == 3 }">selected</c:if> value="3">项目</option>
            <option <c:if test="${project.resource == 4 }">selected</c:if> value="4">青年科学基金项目</option>
            <option <c:if test="${project.resource == 5 }">selected</c:if> value="5">面上项目</option>
            <option <c:if test="${project.resource == 6 }">selected</c:if> value="6">重点项目</option>
          	<option <c:if test="${project.resource == 7 }">selected</c:if> value="7">优秀青年科学基金项目</option>
          	<option <c:if test="${project.resource == 8 }">selected</c:if> value="8">面上资助一等</option>
          	<option <c:if test="${project.resource == 9 }">selected</c:if> value="9">农业部建设项目</option>
          	<option <c:if test="${project.resource == 10 }">selected</c:if> value="10">B类</option>
          	<option <c:if test="${project.resource == 11 }">selected</c:if> value="11">青年骨干个人项目</option>
          	<option <c:if test="${project.resource == 12 }">selected</c:if> value="12">青年拔尖个人项目</option>
          	<option <c:if test="${project.resource == 13 }">selected</c:if> value="13">所级</option>
          	<option <c:if test="${project.resource == 14 }">selected</c:if> value="14">院级</option>
          	<option <c:if test="${project.resource == 15 }">selected</c:if> value="15">北京市工程实验室</option>
          	<option <c:if test="${project.resource == 16 }">selected</c:if> value="16">北京市重点实验室</option>
          	<option <c:if test="${project.resource == 17 }">selected</c:if> value="17">农业部重点实验室</option>
          	<option <c:if test="${project.resource == 18 }">selected</c:if> value="18">储备性研究</option>
          	<option <c:if test="${project.resource == 19 }">selected</c:if> value="19">新学科培育</option>
          	<option <c:if test="${project.resource == 20 }">selected</c:if> value="20">京津冀区域协作创新</option>
          	<option <c:if test="${project.resource == 21 }">selected</c:if> value="21">科研示范基地</option>
          	<option <c:if test="${project.resource == 22 }">selected</c:if> value="22">联合类</option>
          </select>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>项目类型：</label>
        </div>
        <div class="field">
          <select name="projectType" class="input w50" style="width: 300px;">
          	<option <c:if test="${6 == project.projectType}">selected</c:if> value="6">国家重点研发计划</option>
          	<option <c:if test="${7 == project.projectType}">selected</c:if> value="7">863项目</option>
          	<option <c:if test="${8 == project.projectType}">selected</c:if> value="8">科技支撑</option>
          	<option <c:if test="${9 == project.projectType}">selected</c:if> value="9">国家自然科学基金</option>
          	<option <c:if test="${10 == project.projectType}">selected</c:if> value="10">国家重大科学仪器设备开发专项</option>
          	<option <c:if test="${11 == project.projectType}">selected</c:if> value="11">星火计划</option>
          	<option <c:if test="${12 == project.projectType}">selected</c:if> value="12">国家博士后基金</option>
          	<option <c:if test="${13 == project.projectType}">selected</c:if> value="13">公益性行业（农业）专项</option>
          	<option <c:if test="${14 == project.projectType}">selected</c:if> value="14">农业部项目</option>
          	<option <c:if test="${15 == project.projectType}">selected</c:if> value="15">百千万人才资助项目</option>
          	<option <c:if test="${16 == project.projectType}">selected</c:if> value="16">北京市自然科学基金</option>
          	<option <c:if test="${17 == project.projectType}">selected</c:if> value="17">北京市农业科技项目</option>
          	<option <c:if test="${18 == project.projectType}">selected</c:if> value="18">科技新星</option>
          	<option <c:if test="${19 == project.projectType}">selected</c:if> value="19">优秀人才</option>
          	<option <c:if test="${20 == project.projectType}">selected</c:if> value="20">市博士后基金</option>
          	<option <c:if test="${21 == project.projectType}">selected</c:if> value="21">宁夏回族自治区科技攻关计划项目</option>
          	<option <c:if test="${22 == project.projectType}">selected</c:if> value="22">院创新团队</option>
          	<option <c:if test="${23 == project.projectType}">selected</c:if> value="23">院实验室建设</option>
          	<option <c:if test="${24 == project.projectType}">selected</c:if> value="24">院创新能力建设专项</option>
          	<option <c:if test="${25 == project.projectType}">selected</c:if> value="25">院青年基金</option>
          	<option <c:if test="${26 == project.projectType}">selected</c:if> value="26">院博士后基金</option>
          	<option <c:if test="${27 == project.projectType}">selected</c:if> value="27">院科技推广服务</option>
          	<option <c:if test="${28 == project.projectType}">selected</c:if> value="28">其他</option>
          </select>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>所在小组：</label>
        </div>
        <div class="field">
          <select name="userGroup.id" class="input w50" style="width: 300px;">
          	<c:forEach items="${groupList }" var="group">
          		<option <c:if test="${group.id == project.userGroup.id}">selected</c:if> value="${group.id }">${group.groupName }</option>
          	</c:forEach>
          </select>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>承担单位：</label>
        </div>
        <div class="field">
          <select name="unit" class="input w50" style="width: 300px;">
          	<option <c:if test="${1 == project.unit}">selected</c:if> value="1">北京农业信息技术研究中心</option>
          	<option <c:if test="${2 == project.unit}">selected</c:if> value="2">北京农业智能装备技术研究中心</option>
          	<option <c:if test="${3 == project.unit}">selected</c:if> value="3">北京派得伟业科技发展有限公司</option>
          	<option <c:if test="${4 == project.unit}">selected</c:if> value="4">农芯科技（北京）有限责任公司</option>
          	<option <c:if test="${5 == project.unit}">selected</c:if> value="5">北京市农林科学院</option>
          	<option <c:if test="${6 == project.unit}">selected</c:if> value="6">北京智慧农业物联网产业技术创新战略联盟</option>
          	<option <c:if test="${7 == project.unit}">selected</c:if> value="7">北京农业智能装备技术研究中心（软硬件实验室）</option>
          </select>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>开始时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="beginTime" name="beginTime" autocomplete="off" value="<fmt:formatDate value="${project.beginTime }" pattern="yyyy-MM-dd"/>"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>结束时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="endTime" name="endTime" autocomplete="off" value="<fmt:formatDate value="${project.endTime }" pattern="yyyy-MM-dd"/>"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>经费总额：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="totalMoney" value="${project.totalMoney }"/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>到账总额：</label>
        </div>
        <div class="field">
         ${project.incomeList[0].incomeAmount }
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>档案编号：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="fileNumber" value="${project.fileNumber }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>预算说明：</label>
        </div>
        <div class="field">
           <input type="file" class="input" name="file" value="" style="width:375px;float:left;"/>
           <div style="margin-top:14px;"><a href="upload/${projecttp.filePath }" target="_Blank" style="margin-left:25px;">${projecttp.fileName }</a></div>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>经费明细：</label>
        </div>
        <div class="field">
          <table class="table table-hover text-center">
	      	 <tr>
	      	 	<th>预算科目名称</th>
		        <th>原预算</th>
		        <th>新预算</th>
		        <th>实际支出</th>
		        <th>原结余</th>
		        <th>新结余</th>
		        <th></th>
		     </tr>							
		     <tbody id="items">
				<c:forEach items="${project.fundList}" var="item" varStatus="status">
					<tr id="item${status.index}">
						<td>
						<select name="fundList[${status.index}].name" class="input w50" style="width: 300px;">
							<option <c:if test="${item.name == 1 }">selected</c:if> value="1">直接费用-设备费-购置设备费</option>
							<option <c:if test="${item.name == 2 }">selected</c:if> value="2">直接费用-设备费-试制设备费</option>
							<option <c:if test="${item.name == 3 }">selected</c:if> value="3">直接费用-设备费-设备改造与租赁费</option>
							<option <c:if test="${item.name == 4 }">selected</c:if> value="4">直接费用-材料费</option>
							<option <c:if test="${item.name == 5 }">selected</c:if> value="5">直接费用-测试化验加工费</option>
							<option <c:if test="${item.name == 6 }">selected</c:if> value="6">直接费用-燃料动力费</option>
							<option <c:if test="${item.name == 7 }">selected</c:if> value="7">直接费用-差旅费</option>
							<option <c:if test="${item.name == 8 }">selected</c:if> value="8">直接费用-会议费</option>
							<option <c:if test="${item.name == 9 }">selected</c:if> value="9">直接费用-国际合作与交流费</option>
							<option <c:if test="${item.name == 10 }">selected</c:if> value="10">直接费用-出版文献/信息传播/知识产权事务费</option>
							<option <c:if test="${item.name == 11 }">selected</c:if> value="11">直接费用-劳务费</option>
							<option <c:if test="${item.name == 12 }">selected</c:if> value="12">直接费用-专家咨询费</option>
							<option <c:if test="${item.name == 13 }">selected</c:if> value="13">直接费用-其他支出</option>
							<option <c:if test="${item.name == 14 }">selected</c:if> value="14">间接费用-绩效支出</option>
							<option <c:if test="${item.name == 15 }">selected</c:if> value="15">间接费用-其他支出</option>
						</select>
						<%-- <input type="text" class="input" name="fundList[${status.index}].name" value="${item.name }"> --%>
						</td>
						<td><input type="text" class="input" name="fundList[${status.index}].originalBudget" value="${item.originalBudget }"></td>
						<td><input type="text" class="input" name="fundList[${status.index}].newBudget" value="${item.newBudget }"></td>
						<td><input type="text" class="input" name="fundList[${status.index}].pay" value="${item.pay }"></td>
						<td><input type="text" class="input" name="fundList[${status.index}].originalBalance" value="${item.originalBalance }"></td>
						<td><input type="text" class="input" name="fundList[${status.index}].newBalance" value="${item.newBalance }"></td>
						<td><img src="images/minus.png" style="cursor:pointer;" onclick="minusTR(${status.index})"/></td>
					</tr>
				</c:forEach>
				</tbody>
	      </table>
	      <div style="text-align:center;">
				<img src="images/plus.png" style="cursor:pointer;" onclick="plusTR()"/>
			</div>
        </div>
      </div>
      
      <%-- <div class="form-group">
        <div class="label">
          <label>外拨经费：</label>
        </div>
        <div class="field">
          <table class="table table-hover text-center">
	      	 <tr>
		        <th>单位</th>
		        <th>金额</th>
		        <th></th>
		     </tr>							
		     <tbody id="outItems">
				<c:forEach items="${project.outList}" var="item" varStatus="status">
					<tr id="outItem${status.index}">
						<td><input type="text" class="input" name="outList[${status.index}].unit" value="${item.unit }"></td>
						<td><input type="text" class="input" name="outList[${status.index}].amount" value="${item.amount }"></td>
						<td><img src="images/minus.png" style="cursor:pointer;" onclick="outMinusTR(${status.index})"/></td>
					</tr>
				</c:forEach>
			</tbody>
	      </table>
	      <div style="text-align:center;">
				<img src="images/plus.png" style="cursor:pointer;" onclick="outPlusTR()"/>
			</div>
        </div>
      </div> --%>
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
	laydate.render({
	    elem: '#beginTime',
	    event: 'focus' 
	});
	
	laydate.render({
	    elem: '#endTime',
	    event: 'focus' 
	});
	
	var num = '${fn:length(project.fundList)}';
	function plusTR(){
		num ++;
		var tr = "<tr id='item"+num+"'><td>";
		tr+="<select name='fundList[" + num + "].name' class='input w50' style='width: 300px;'>";
		tr+="<option value='1'>直接费用-设备费-购置设备费</option>";
		tr+="<option value='2'>直接费用-设备费-试制设备费</option>";
		tr+="<option value='3'>直接费用-设备费-设备改造与租赁费</option>";
		tr+="<option value='4'>直接费用-材料费</option>";
		tr+="<option value='5'>直接费用-测试化验加工费</option>";
		tr+="<option value='6'>直接费用-燃料动力费</option>";
		tr+="<option value='7'>直接费用-差旅费</option>";
		tr+="<option value='8'>直接费用-会议费</option>";
		tr+="<option value='9'>直接费用-国际合作与交流费</option>";
		tr+="<option value='10'>直接费用-出版文献/信息传播/知识产权事务费</option>";
		tr+="<option value='11'>直接费用-劳务费</option>";
		tr+="<option value='12'>直接费用-专家咨询费</option>";
		tr+="<option value='13'>直接费用-其他支出</option>";
		tr+="<option value='14'>间接费用-绩效支出</option>";
		tr+="<option value='15'>间接费用-其他支出</option>";
		tr+="</select>";
		tr+="</td><td><input type='text' class='input' name='fundList[" + num + "].originalBudget'></td><td><input type='text' class='input' name='fundList[" + num + "].newBudget' ></td><td><input type='text' class='input' name='fundList[" + num + "].pay' ></td><td><input type='text' class='input' name='fundList[" + num + "].originalBalance' ></td><td><input type='text' class='input' name='fundList[" + num + "].newBalance' ></td><td><img src='images/minus.png' style='cursor:pointer;' onclick='minusTR("+ num +")'/></td></tr>";
		$("#items").append(tr);
	}
	
	function minusTR(numb){
		$("#item"+ numb).remove(); 
	}
	
	var outNum = '${fn:length(project.outList)}';
	function outPlusTR(){
		num ++;
		var tr = "<tr id='outItem"+outNum+"'><td><input type='text' class='input' name='outList[" + outNum + "].unit'></td><td><input type='text' class='input' name='fundList[" + outNum + "].amount' ></td><td><img src='images/minus.png' style='cursor:pointer;' onclick='outMinusTR("+ outNum +")'/></td></tr>";
		$("#outItems").append(tr);
	}
	
	function outMinusTR(outNum){
		$("#outItem"+ outNum).remove(); 
	}
	
	function userSub(){
		var projectName = $("input[name ='projectName']").val();
		
		if(projectName == '') {
			alert("项目名称不可以为空！");
			return ;
		}
		
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	function goList(){
		window.location.href="apply/online/remuneration/list";
	}
	</script>
</html>