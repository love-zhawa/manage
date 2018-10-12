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
    <title>办公室出入库登记</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>
<style>
h1 {text-align: center;margin-bottom: 20px;}
.table1 {width: 1000px;border-collapse: collapse}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 th,.table1 td {border: 1px solid #333;}
.input{border: 0px;}
</style>  
</head>
<h1 class="title">办公室出入库登记</h1>
	<form action="apply/online/storage/add" method="post" class="form-x" id="form-article-add" >
		<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1">
		<tr height="50">
          <th style="width:60px;">标题</th>
          <td style="padding-top:16px;"><input type="text" class="input" id="titleName" name="titleName" value=""/></td>
          <th>出入库日期</th>
          <td><input type="text" class="input" name="changeTime" id="changeTime" value="" autocomplete="off"/></td>
        </tr>
        <tr height="50">
          <th>送货部门</th>
          <td><input type="text" class="input" name="dept" id="dept" value=""/></td>
          <th>库单编号</th>
          <td><input type="text" class="input" name="kdNumber" value=""/></td>
        </tr>
        <tr height="50">
          <th>库单</th>
          <td colspan="3">
			<div class="field">
	          <table class="table table-hover text-center">
		      	 <tr>
			        <th>编号</th>
					<th>名称</th>
					<th>规格</th>
					<th>供货单位</th>
					<th>数量</th>
					<th>单价</th>
					<th>金额</th>
					<th>备注</th>
					<th>操作</th>
			     </tr>
			     <tbody id="items">
						<tr id="item0">
							<td><input type="text" class="input" name="itemList[0].goodsNumber"></td>
							<td><input type="text" class="input" name="itemList[0].goodsName"></td>
							<td><input type="text" class="input" name="itemList[0].specification"></td>
							<td><input type="text" class="input" name="itemList[0].unit"></td>
							<td><input type="text" class="input" name="itemList[0].amount"></td>
							<td><input type="text" class="input" name="itemList[0].signPrice"></td>
							<td><input type="text" class="input" name="itemList[0].price"></td>
							<td><input type="text" class="input" name="itemList[0].remark"></td>
							<td><img src="images/minus.png" style="cursor:pointer;" onclick="minusTR(0)"/></td>
						</tr>
					</tbody>
		      </table>
	        <div style="text-align: center;">
				<img src="images/plus.png" style="cursor:pointer;" onclick="plusTR()"/>
			</div>
			</div>
		</td>
        </tr>
      </table>
      <div class="field">
         <button class="button bg-main icon-check-square-o" type="button" onClick="userSub();" style="margin-top:9px;margin-left:800px;"> 提交</button>
       </div>
     </form>
<script type="text/javascript">
	var num = 0;
	
 	laydate.render({
	    elem: '#changeTime',
	    event: 'focus' 
	});
	function userSub(){
		if(confirm("确认提交吗？")){
			$("#form-article-add").submit();
		}
	}
	
	function plusTR(){
		num ++;
		var tr = "<tr id='item"+num+"'><td><input type='text' class='input' name='itemList[" + num + "].goodsNumber'></td><td><input type='text' class='input' name='itemList[" + num + "].goodsName'></td><td><input type='text' class='input' name='itemList[" + num + "].specification'></td><td><input type='text' class='input' name='itemList[" + num + "].unit'></td><td><input type='text' class='input' name='itemList[" + num + "].amount'></td><td><input type='text' class='input' name='itemList[" + num + "].signPrice'></td><td><input type='text' class='input' name='itemList[" + num + "].price'></td><td><input type='text' class='input' name='itemList[" + num + "].remark'></td><td><img src='images/minus.png' style='cursor:pointer;' onclick='minusTR("+ num +")'/></td></tr>";
		$("#items").append(tr);
	}
	
	function minusTR(numb){
		$("#item"+ numb).remove(); 
	}
	function back (){
		window.location.href="apply/online/storage/enter/list";
	}
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
	</body>
</html>