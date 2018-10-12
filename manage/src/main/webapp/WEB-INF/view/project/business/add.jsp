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
    <title>创建项目商务</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<style>
.field .bb{width:110px;}
.aa td{padding:9px;}
.aa input{width:230px;}
</style>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;创建项目商务</strong></div>
  <div class="body-content">
    <form action="project/business/add" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
      <div class="form-group">
        <div class="label">
          <label><b>项目信息</b></label>
        </div>
        <div class="field">
          <table class="aa">
		     <tbody>
					<tr>
						<td class="bb">项目名称：</td><td><input type="text" class="input" name="bussName" value=""/></td>
						<td class="bb">实施地点：</td><td><input type="text" class="input" name="ssdd" value=""/></td>
						<td class="bb">建设内容：</td><td><input type="text" class="input" name="bussContent" value=""/></td>
						<td class="bb">甲方单位：</td><td><input type="text" class="input" name="unit" value=""/></td>
					</tr>
					<tr>
						<td class="bb">联系人1：</td><td><input type="text" class="input" name="contact" value=""/></td>
						<td class="bb">电话1：</td><td><input type="text" class="input" name="phoneNumber" value=""/></td>
						<td class="bb">联系人2：</td><td><input type="text" class="input" name="contact1" value=""/></td>
						<td class="bb">电话2：</td><td><input type="text" class="input" name="phoneNumber1" value=""/></td>
					</tr>
					<tr>
						<td class="bb">联系人3：</td><td><input type="text" class="input" name="contact2" value=""/></td>
						<td class="bb">电话3：</td><td><input type="text" class="input" name="phoneNumber2" value=""/></td>
						<td class="bb">职务信息：</td><td><input type="text" class="input" name="zwxx" value=""/></td>
					</tr>
				</tbody>
	      </table>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label><b>项目来源信息</b></label>
        </div>
        <div class="field">
          <table class="aa">
		     <tbody>
					<tr>
						<td class="bb">单位名称：</td><td><input type="text" class="input" name="lydw" value=""/></td>
						<td class="bb">联系人1：</td><td><input type="text" class="input" name="lyperson" value=""/></td>
						<td class="bb">电话1：</td><td><input type="text" class="input" name="lyphone" value=""/></td>
						<td class="bb">职务信息：</td><td><input type="text" class="input" name="lyzwxx" value=""/></td>
					</tr>
					<tr>
						<td class="bb">联系人2：</td><td><input type="text" class="input" name="lyperson1" value=""/></td>
						<td class="bb">电话2：</td><td><input type="text" class="input" name="lyphone1" value=""/></td>
						<td class="bb">联系人3：</td><td><input type="text" class="input" name="lyperson2" value=""/></td>
						<td class="bb">电话3：</td><td><input type="text" class="input" name="lyphone2" value=""/></td>
					</tr>
				</tbody>
	      </table>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label><b>实施信息</b></label>
        </div>
        <div class="field">
          <table class="aa">
		     <tbody>
					<tr>
						<td class="bb">项目经理：</td><td><input type="text" class="input" name="xmjl" value=""/></td>
						<td class="bb">合作单位1：</td><td><input type="text" class="input" name="dw" value=""/></td>
						<td class="bb">联系人1：</td><td><input type="text" class="input" name="lxr" value=""/></td>
						<td class="bb">联系电话1：</td><td><input type="text" class="input" name="lxphone" value=""/></td>
					</tr>
					<tr>
						<td class="bb">合作单位2：</td><td><input type="text" class="input" name="dw1" value=""/></td>
						<td class="bb">联系人2：</td><td><input type="text" class="input" name="lxr1" value=""/></td>
						<td class="bb">联系电话2：</td><td><input type="text" class="input" name="lxphone1" value=""/></td>
						<td class="bb">合作单位3：</td><td><input type="text" class="input" name="dw2" value=""/></td>
					</tr>
					<tr>
						<td class="bb">联系人3：</td><td><input type="text" class="input" name="lxr2" value=""/></td>
						<td class="bb">联系电话3：</td><td><input type="text" class="input" name="lxphone2" value=""/></td>
						<td class="bb">实施状态：</td>
						<td>
							<select name="sszt" class="input w50" style="width: 230px;margin-bottom:-9px;">
					          	<option value="1">实施中</option>
					          	<option value="2">实施完成</option>
					          </select>
						</td>
					</tr>
				</tbody>
	      </table>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label><b>业务信息</b></label>
        </div>
        <div class="field">
          <table class="aa">
		     <tbody>
					<tr>
						<td class="bb">业务员：</td><td><input type="text" class="input" name="salesman" value=""/></td>
						<td class="bb">接洽时间：</td><td><input type="text" class="input" id="contactDate" name="contactDate" value="" autocomplete="off"/></td>
						<td class="bb">接洽状态：</td>
						<td>
							<select name="status" class="input w50" style="width: 230px;margin-bottom:-9px;">
					          	<option value="1">接洽中</option>
					          	<option value="2">合同签订</option>
					          	<option value="3">终止</option>
					          </select>
						</td>
					</tr>
				</tbody>
	      </table>
        </div>
      </div>
      
       <div class="form-group">
        <div class="label">
          <label>上传附件：</label>
        </div>
        <div class="field">
          <table class="table table-hover text-center">
	      	 <tr>
		        <th>附件类型</th>
		        <th>附件</th>
		        <th></th>
		     </tr>							
		     <tbody id="items">
					<tr id="item0">
						<td><input type="text" class="input" name="fileList[0].fileType"></td>
						<td><input type="file" class="input" name="file"></td>
						<td><img src="images/minus.png" style="cursor:pointer;" onclick="minusTR(0)"/></td>
					</tr>
				</tbody>
	      </table>
	      <div style="text-align:center;">
				<img src="images/plus.png" style="cursor:pointer;" onclick="plusTR()"/>
			</div>
        </div>
      </div>
      
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
	    elem: '#contactDate',
	    event: 'focus' 
	});
	
	var num = 0;
	function plusTR(){
		num ++;
		var tr = "<tr id='item"+num+"'><td><input type='text' class='input' name='fileList[" + num + "].fileType'></td><td><input type='file' class='input' name='file' ></td><td><img src='images/minus.png' style='cursor:pointer;' onclick='minusTR("+ num +")'/></td></tr>";
		$("#items").append(tr);
	}
	
	function minusTR(numb){
		$("#item"+ numb).remove(); 
	}
	
	function userSub(){
		var bussName = $("input[name ='bussName']").val();
		
		if(bussName == '') {
			alert("业务名称不可以为空！");
			return ;
		}
		
		if(confirm("确认提交？")) {
			$("#form-article-add").submit();
		}
	}
	function goList(){
		window.location.href="project/business/list";
	}
	</script>
</html>