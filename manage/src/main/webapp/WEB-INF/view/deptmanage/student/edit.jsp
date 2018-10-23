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
    <title>修改学生补助</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>
    <link rel="stylesheet" href="layui/css/layui.css"  media="all">
<style>
h1 {text-align: center;margin-bottom: 20px;}
.table1 {width: 1000px;border-collapse: collapse}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 td {padding-right: 6px;line-height: 1;}
.table1 th,.table1 td {border: 1px solid #333;padding: 1px 0 0 0;text-align: center;}
.input{border: 0px;}
</style>
</head>
<body>
	<form action="student/edit" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
     <input type="hidden" name="id" id="stuid" value="${stu.id}">
     <input type="hidden" name="user.id" id="usersid" value="${stu.user.id}">
     <input type="hidden" name="username" value="${stu.user.name}">
     <input type="hidden" name="tutor" id="tutor" value="${stu.tutor}">
		<table border="0" cellspacing="0" cellpadding="8" align="center" class="table1" style="width: 1000px">
		 <div class="form-group" style="margin: 1% 0 0 17%;">
	        <div class="label">
	          <label>支出ff项目：</label>
	        </div>
	        <div class="field">
	          <select name="project.id" class="input w50" style="width: 300px;padding: 7px; border: solid 1px #ddd;border-radius: 3px;" onchange="projectChange()">
	          	<option value="">全部</option>
	          	<c:forEach items="${projectList }" var="project">
	          		<option <c:if test="${stu.project.id == project.id }">selected</c:if> value="${project.id }">${project.projectName }</option>
	          	</c:forEach>
	          </select>
	        </div>
	     </div>
	      <div class="form-group" style="margin: 1% 0 0 17%;">
	        <div class="label">
	          <label>财务编号：</label>
	        </div>
	        <div class="field" id="financialNumber" style="margin-top:7px;">
	         
	        </div>
	     </div>
	     <tr>
      		<th colspan="9"><h2>
      		<div class="layui-inline" style="width:125px;">
		      <div class="layui-input-inline">
		        <input class="layui-input" id="test3" name="bztime" type="text" placeholder="年   月" autocomplete="off" value="<fmt:formatDate value="${stu.bztime }" pattern="yyyy-MM"/>">
		      </div>
	    	 </div>
	    	 学生补助发放明细</h2></th>
      	</tr>
        <tr style="height: 38px;">
          <th style="padding-top: 9px;">部门</th>
          <td style="padding-top: 9px;" colspan="8">${groupname}</td>
        </tr>
        <tr style="height: 38px;">
      		<th style="width:5%;padding-top: 9px;">姓名</th>
      		<th style="width:5%;padding-top: 9px;">类别</th>
      		<th style="width:15%;padding-top: 9px;">身份证号</th>
      		<th style="width:14%;padding-top: 9px;">开户银行</th>
      		<th style="width:15%;padding-top: 9px;">账号</th>
      		<th style="padding-top: 9px;">工作时间(天)</th>
      		<th style="padding-top: 9px;">劳务金额(元)</th>
      		<th style="padding-top: 9px;">其他补助(元)</th>
      		<th style="padding-top: 9px;">小计金额(元)</th>
      	</tr>
       <tbody id="items">
	      	<c:forEach items="${stu.bzlist}" var="bz" varStatus="i">
				<tr class="item${i.index }">
		          <td><input type="hidden" name="bzlist[${i.index }].user.id" value="${bz.user.id }">${bz.user.name}</td>
		         
		          <td>
					<c:if test="${bz.user.education == 1 }">硕士</c:if>
					<c:if test="${bz.user.education == 2 }">博士</c:if>
					<c:if test="${bz.user.education == 3 }">学士</c:if>
				  </td>
		          <td>${bz.user.idCard }</td>
		          <td>${bz.user.bank }</td>
		          <td>${bz.user.cardid }</td>
		          <td>
		           <c:if test="${userid eq '891b0aa0b95647e6ae5087bcdfc38d72' }">
		          		<input type="text" class="input" name="bzlist[${i.index }].ts" style="width:90px;" value="${bz.ts }" onblur="myFunctions()">
		          </c:if>
		          <c:if test="${userid ne '891b0aa0b95647e6ae5087bcdfc38d72' }">
		           		<input type="text" class="input" name="bzlist[${i.index }].ts" style="width:90px;" value="${bz.ts }" readonly>
		          </c:if>
		         
		          </td>
		          <td><input type="text" class="input" name="bzlist[${i.index }].money" id="add1" value="${bz.money }" onblur="myFunction()"></td>
		          <td><input type="text" class="input" name="bzlist[${i.index }].qtmoney" id="add2" value="${bz.qtmoney }" readonly></td>
		          <td><input type="text" class="input" name="bzlist[${i.index }].summoney" id="sum" value="${bz.summoney }" readonly></td>
				</tr>
			</c:forEach>
		</tbody>
		<tr>
			<th colspan="2">合计</th>
			<th></th>
			<th colspan="5"><div id="dx"></div></th>
			<th><input type="text" class="input" name="summoney" id="summoney" value="${stu.summoney }" readonly></th>
		</tr>
      </table>
      <div class="field">
         <button class="button bg-main icon-check-square-o" type="button" id="tj" onClick="userSub();" style="margin-top:9px;margin-left:800px;"> 提交</button>
       </div>
     </form>
<script type="text/javascript">
	$(function(){
		projectChange();
		myFunction();
		myFunctions();
	});
	 laydate.render({
	    elem: '#test3'
	    ,type: 'month'
	    ,done: function(value, date){
	    	var _list = new Array();
			var tr =$('#items').find('tr');
			var tutor = $("#tutor").val();//（老师）
			var stuid = $("#stuid").val();//id为空时是添加
			var len = tr.length;
			for(var i = 0;i < len;i++){
				var userid = tr.eq(i).find('td').eq(0).find("input").val();
				_list[i]=userid;
			}
		    $.post("student/cx",{"stuid":stuid,"tutor":tutor,"year":JSON.stringify(date.year),"month":JSON.stringify(date.month),"date":1,"userids":_list},function(result){
				 if(result!=null&&result!=''){
					 $('#items').find('tr').find("input").attr("disabled",false);
					 $("#tj").attr("disabled",false);
					 for(var i = 0;i < len;i++){
						tr.eq(i).find('td').eq(5).find("input").val(result[i]);
						tr.eq(i).find('td').eq(7).find("input").val(result[i]*8);
					}
				 }else{
				 	alert("本月已申请补助，请勿重复填写！");
				 	$('#items').find('tr').find("input").attr("disabled",true);
				 	$("#tj").attr("disabled",true);
				 }
				 
			});  
		  }
	  });
	
     function myFunction(){
		var sum = 0.0;
		var tr =$('#items').find('tr');
		var len = tr.length;
		for(var i = 0;i < len;i++){
			var one = tr.eq(i).find('td').eq(6).find("input").val();
			var two = tr.eq(i).find('td').eq(7).find("input").val();
			tr.eq(i).find('td').eq(8).find("input").val(one*1+two*1);
			sum+=parseInt(tr.eq(i).find('td').eq(8).find("input").val());
		}
		$("#summoney").val(sum);
		$("#dx").html((sum).numToChinese());
	}
     //改天数   补助改
     function myFunctions(){
 		var sum = 0.0;
 		var tr =$('#items').find('tr');
 		var len = tr.length;
 		for(var i = 0;i < len;i++){
 			var ts = tr.eq(i).find('td').eq(5).find("input").val();
 			tr.eq(i).find('td').eq(7).find("input").val(ts*8);
 		}
 		myFunction();
 	}
	  
	 //把小数前的数分成4位处理，不足位添0，例如：123456 => 0012,3456
    if (!Number.prototype.cutNum) {
        Number.prototype.cutNum = function () { //判断Number对象是否有cutNum方法
            let num = '' + this; //this指需要转换的数，然后由number类型转为string类型
            let len = Math.ceil(num.length/4);
            let arr = [];
            let v_len = num.length;
            while (len > 0){
                let cut_start = v_len -4 > 0 ? v_len-4 : 0;
                let cut_len = v_len -4 > 0 ? 4: v_len;
                let v = num.substr(cut_start,cut_len);
                if(v.length != 4){
                    arr.push('0'.repeat(4 - v.length) + v);
                }else{
                    arr.push(v);
                }
                len--;
                v_len -= 4;
            }
            return arr.length != 1 ? arr.reverse().join(',') : '' + arr;
        }
    }
    if (!Number.prototype.numToChinese) {
        Number.prototype.numToChinese = function () {
            //有小数点的分为两部分：小数前的数firstPart和小数后的数secondPart，小数前的数进行cutNum方法处理
            //如果小数前的数不足4位，添0补位
            let $this = '' + this,
                firstPart = '',
                secondPart = '';
            if(/\./.test($this)){
                let arrPre = $this.split('.');
                firstPart = arrPre[0];
                if(firstPart.length > 12){
                    return '数字不能超过仟亿';
                }
                secondPart = arrPre[1];
                if(secondPart.length > 2){
                    return '小数点后的数字不能超过2位';
                }
            }else{
                firstPart = $this;
            }
            //第一部分：处理小数前的数
            let firstPartArr = [];
            if(firstPart.length > 4){
                firstPartArr = parseInt(firstPart).cutNum().split(','); //firstPart是字符串类型
            }else {
                firstPartArr = firstPartArr.concat('0'.repeat(4-firstPart.length) + firstPart);
            }
            const arrMap = [['0','零'],['1','壹'],['2','贰'],['3','叁'],['4','肆'],
                            ['5','伍'], ['6','陆'],['7','柒'],['8','捌'],['9','玖']],
                unit = ['仟','佰','拾',''];
            let map = new Map(arrMap), //创建Map对象
                splitAddUnit = [], //存放4位分割后的单位
                returnArr = []; //最终返回的值
            if(firstPartArr.length == 3){
                splitAddUnit = ['亿','万'];
            }else if(firstPartArr.length == 2){
                splitAddUnit = ['万'];
            }else{
                splitAddUnit = [''];
            }
            for(let k = 0; k < firstPartArr.length; k++){
                for(let j = 0; j < firstPartArr[k].length; j++){
                    if(firstPartArr[k][j] != 0){
                        //利用Map对象映射相应的值
                        returnArr.push(map.get(firstPartArr[k][j]) + unit[j]);
                    }
                }
                if(splitAddUnit[k]){
                    returnArr.push(splitAddUnit[k]);
                }
            }
            returnArr.push('元');
            //第二部分：处理小数后的数
            if(secondPart){
                if(/^0+$/.test(secondPart)){ //小数后的数全为0时
                    returnArr.push('整');
                }else{
                    const pointAfterUnit = ['角','分'];
                    for(let j = 0; j < secondPart.length; j++){
                        let val = map.get(secondPart[j]) + pointAfterUnit[j];
                        returnArr.push(val);
                    }
                }
            }else{
                returnArr.push('整');
            }
            return returnArr.join('');
        }
    }
    
	//选择项目
	function projectChange(){
		var projectId = $("select[name='project.id']").val();
		
		if(projectId == '') {
		    $("#financialNumber").html('');
		}
		
		$.post("project/view/" + projectId,{},function(result){
			$("#financialNumber").html(result.financialNumber);
		});
	 }
	function userSub(){
	    var projectId = $("select[name ='project.id']").val();
		if(projectId == '') {
			alert("请选择项目！");
			return ;
		}
		if(confirm("确认提交吗？")){
			$("#form-article-add").submit();
		}
	}
	function back (){
		window.location.href="student/list";
	}
	</script>
    <div style="display:none;">
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1274866914'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s19.cnzz.com/stat.php%3Fid%3D1274866914' type='text/javascript'%3E%3C/script%3E"));</script>
	</div>	 
	</body>
</html>
