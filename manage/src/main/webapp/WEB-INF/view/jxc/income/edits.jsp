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
    <title>编辑入库产品</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script src="laydate/laydate.js"></script>  
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span>&nbsp;&nbsp;编辑入库产品</strong></div>
  <div class="body-content">
    <form action="jxc/income/edits" method="post" class="form-x" id="form-article-add" enctype="multipart/form-data">
    <input type="hidden" name="id" value="${detail.id }">
      <div class="form-group">
      <div class="label">
          <label>入库类型：</label>
        </div>
        <div class="field">
          <select name="ly" class="input">
			<option value="1" <c:if test="${detail.ly == 1 }">selected="selected"</c:if>>借用返还</option>
			<option value="2" <c:if test="${detail.ly == 2 }">selected="selected"</c:if>>其他</option>
		 </select>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label>出库编号：</label>
        </div>
        <div class="field">
          <select name="outStore.id" class="input" id="type" onchange="changemodel()">
				<option value="">请选择出库编号</option>
				<c:forEach items="${outList }" var="out">
				    <c:if test="${out.status eq 4 }">  
						<option value="${out.id}" <c:if test="${out.id == detail.outStore.id }">selected="selected"</c:if>>${out.outNo }</option>
					</c:if>
				</c:forEach>
			</select>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>出库单：</label>
        </div>
        <div class="field">
          <table class="table table-hover text-center">
	      	 <tr>
		        <th>产品名称</th>
		        <th>规格/型号</th>
		        <th>数量</th>
		        <th>用途</th>
		        <th>备注</th>
		     </tr>							
		     <tbody id="items">
					<tr>
						<td><div id="name"></div></td>
						<td><div id="model"></div></td>
						<td><div id="amount"></div></td>
						<td><div id="purpose"></div></td>
						<td><div id="bz"></div></td>
					</tr>
				</tbody>
	      </table>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>入库数量：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="amount" name="amount" value="${detail.amount }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>生产厂家：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="manufacturer" name="manufacturer" value="${detail.manufacturer }"/>
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label>备注：</label>
        </div>
        <div class="field">
          <input type="text" class="input" id="remark" name="remark" value="${detail.remark }"/>
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
	changemodel();
		function changemodel() {
		    var outid = $("select[name ='outStore.id']").val();
		  
			if(outid == ''){
				$("#name").html('');
				$("#model").html('');
				$("#amount").html('');
				$("#purpose").html('');
				$("#bz").html('');
			}
		    if(outid != '') {
				$.post("jxc/out/model/"+outid,{},function(data){
					$.each(data, function(index, item) {
						$("#name").html(item.str1);
						$("#model").html(item.str2);
						$("#amount").html(item.str3);
						$("#purpose").html(item.str4);
						$("#bz").html(item.str5);
					});
				});
			}
		}
	
		function userSub(){
			var outStoreid = $("select[name ='outStore.id']").val();
			var amount = $("input[name ='amount']").val();
			
			if(outStoreid == '') {
				alert("请选择出库编号！");
				return ;
			}
			if(amount == '') {
				alert("请输入数量！");
				return ;
			}
			if(isNaN(amount)){
				alert("数量输入错误！");
				return ;
			}
			
			if(confirm("确认提交？")) {
				$("#form-article-add").submit();
			}
		}
		function goList(){
			window.location.href="product/list";
		}
	</script>
</html>