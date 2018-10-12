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
    <title>创建纵向课题</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;创建纵向课题</strong></div>
  <div class="body-content">
    <form action="project/0/add" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
      <div class="form-group">
        <div class="label">
          <label>财务编号：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="financialNumber" value=""/>
        </div>
      </div>
		
      <div class="form-group">
        <div class="label">
          <label>项目名称：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="projectName" value=""/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>项目负责人：</label>
        </div>
        <div class="field">
          <select name="user.id" class="input w50" style="width: 300px;">
          	<c:forEach items="${userList }" var="user">
          		<option value="${user.id }">${user.name }</option>
          	</c:forEach>
          </select>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>项目级别：</label>
        </div>
        <div class="field">
         <!--  <input type="text" class="input" name="resource" value=""/> -->
         <select name="resource" class="input w50" style="width: 300px;">
          	<option value="1">子课题</option>
          	<option value="2">课题</option>
          	<option value="3">项目</option>
          	<option value="4">青年科学基金项目</option>
          	<option value="5">面上项目</option>
			<option value="6">重点项目</option>
			<option value="7">优秀青年科学基金项目</option>
			<option value="8">面上资助一等</option>
			<option value="9">农业部建设项目</option>
			<option value="10">B类</option>
			<option value="11">青年骨干个人项目</option>
			<option value="12">青年拔尖个人项目</option>
			<option value="13">所级</option>
			<option value="14">院级</option>
			<option value="15">北京市工程实验室</option>
			<option value="16">北京市重点实验室</option>
			<option value="17">农业部重点实验室</option>
			<option value="18">储备性研究</option>
			<option value="19">新学科培育</option>
			<option value="20">京津冀区域协作创新</option>
			<option value="21">科研示范基地</option>
			<option value="22">联合类</option>
          	
          </select>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>项目类型：</label>
        </div>
        <div class="field">
          <select name="projectType" class="input w50" style="width: 300px;">
          	<option value="6">国家重点研发计划</option>
          	<option value="7">863项目</option>
          	<option value="8">科技支撑</option>
          	<option value="9">国家自然科学基金</option>
          	<option value="10">国家重大科学仪器设备开发专项</option>
          	<option value="11">星火计划</option>
          	<option value="12">国家博士后基金</option>
          	<option value="13">公益性行业（农业）专项</option>
          	<option value="14">农业部项目</option>
          	<option value="15">百千万人才资助项目</option>
          	<option value="16">北京市自然科学基金</option>
          	<option value="17">北京市农业科技项目</option>
          	<option value="18">科技新星</option>
          	<option value="19">优秀人才</option>
          	<option value="20">市博士后基金</option>
          	<option value="21">宁夏回族自治区科技攻关计划项目</option>
          	<option value="22">院创新团队</option>
          	<option value="23">院实验室建设</option>
          	<option value="24">院创新能力建设专项</option>
          	<option value="25">院青年基金</option>
          	<option value="26">院博士后基金</option>
          	<option value="27">院科技推广服务</option>
          	<option value="28">其他</option>
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
          		<option value="${group.id }">${group.groupName }</option>
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
          	<option value="1">北京农业信息技术研究中心</option>
          	<option value="2">北京农业智能装备技术研究中心</option>
          	<option value="3">北京派得伟业科技发展有限公司</option>
          	<option value="4">农芯科技（北京）有限责任公司</option>
          	<option value="5">北京市农林科学院</option>
          	<option value="6">北京智慧农业物联网产业技术创新战略联盟</option>
          	<option value="7">北京农业智能装备技术研究中心（软硬件实验室）</option>
          </select>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>开始时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="beginTime" name="beginTime" value="" autocomplete="off"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>结束时间：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="endTime" name="endTime" value="" autocomplete="off"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>经费总额：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="totalMoney" value=""/>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>备注：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="remark" value=""/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>档案编号：</label>
        </div>
        <div class="field">
          <input type="text" class="input" name="fileNumber" value=""/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>预算说明：</label>
        </div>
        <div class="field">
          <input type="file" class="input" name="file" value=""/>
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
					<tr id="item0">
						<td>
						<select name="fundList[0].name" class="input w50" style="width: 300px;">
							<option value="1">直接费用-设备费-购置设备费</option>
							<option value="2">直接费用-设备费-试制设备费</option>
							<option value="3">直接费用-设备费-设备改造与租赁费</option>
							<option value="4">直接费用-材料费</option>
							<option value="5">直接费用-测试化验加工费</option>
							<option value="6">直接费用-燃料动力费</option>
							<option value="7">直接费用-差旅费</option>
							<option value="8">直接费用-会议费</option>
							<option value="9">直接费用-国际合作与交流费</option>
							<option value="10">直接费用-出版文献/信息传播/知识产权事务费</option>
							<option value="11">直接费用-劳务费</option>
							<option value="12">直接费用-专家咨询费</option>
							<option value="13">直接费用-其他支出</option>
							<option value="14">间接费用-绩效支出</option>
							<option value="15">间接费用-其他支出</option>
						</select>
						<!-- <input type="text" class="input" name="fundList[0].name"> -->
						</td>
						<td><input type="text" class="input" name="fundList[0].originalBudget"></td>
						<td><input type="text" class="input" name="fundList[0].newBudget"></td>
						<td><input type="text" class="input" name="fundList[0].pay"></td>
						<td><input type="text" class="input" name="fundList[0].originalBalance"></td>
						<td><input type="text" class="input" name="fundList[0].newBalance"></td>
						<td><img src="images/minus.png" style="cursor:pointer;" onclick="minusTR(0)"/></td>
					</tr>
				</tbody>
	      </table>
	      <div style="text-align:center;">
				<img src="images/plus.png" style="cursor:pointer;" onclick="plusTR()"/>
			</div>
        </div>
      </div>
      
      <!-- <div class="form-group">
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
					<tr id="outItem0">
						<td><input type="text" class="input" name="outList[0].unit"></td>
						<td><input type="text" class="input" name="outList[0].amount"></td>
						<td><img src="images/minus.png" style="cursor:pointer;" onclick="outMinusTR(0)"/></td>
					</tr>
				</tbody>
	      </table>
	      <div style="text-align:center;">
				<img src="images/plus.png" style="cursor:pointer;" onclick="outPlusTR()"/>
			</div>
        </div>
      </div> -->
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
	
	var num = 0;
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
	
	var outNum = 0;
	function outPlusTR(){
		num ++;
		var tr = "<tr id='outItem"+num+"'><td><input type='text' class='input' name='outList[" + num + "].unit'></td><td><input type='text' class='input' name='fundList[" + num + "].amount' ></td><td><img src='images/minus.png' style='cursor:pointer;' onclick='outMinusTR("+ num +")'/></td></tr>";
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