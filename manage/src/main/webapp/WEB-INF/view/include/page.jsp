<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<tr>
<td id="tdhb">
<div class="pagelist"> 
	<b>总共(${page.totalPage})页</b>
	<c:if test="${page.hasFirstPage}">
		<a href="javascript:void(0);" onclick="invokeAction(1);">第一页</a>
	</c:if>
	<c:if test="${!page.hasFirstPage}"><a href="javascript:void(0);">第一页</a></c:if>
	<c:if test="${page.hasPrevPage}">
		<a href="javascript:void(0);" onclick="invokeAction(${page.currPage-1});">上一页</a>
	</c:if>
	<c:if test="${!page.hasPrevPage}"><a href="javascript:void(0);">上一页</a></c:if>
	<input id="goPage" name="goPage" type="hidden" value="${page.currPage}"/>
	<c:choose>
		<c:when test="${page.totalPage < 5 }"><!-- 总页数不超过5 -->
			<c:forEach begin="1" end="${page.totalPage }" step="1" var="i">
				<span <c:if test="${page.currPage eq i }">class="current"</c:if> onclick="invokeAction(${i});" style="cursor:pointer;">${i}</span>
			</c:forEach>
		</c:when>
		<c:when test="${page.currPage le 3 }">
			<c:forEach begin="1" end="5" step="1" var="i">
				<span <c:if test="${page.currPage eq i }">class="current"</c:if> onclick="invokeAction(${i});" style="cursor:pointer;">${i}</span>
			</c:forEach>
		</c:when>
		<c:when test="${page.currPage ge page.totalPage - 2 }">
			<c:forEach begin="${page.totalPage - 4 }" end="${page.totalPage}" step="1" var="i">
				<span <c:if test="${page.currPage eq i }">class="current"</c:if> onclick="invokeAction(${i});" style="cursor:pointer;">${i}</span>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<c:forEach begin="${page.currPage - 2 }" end="${page.currPage + 2}" step="1" var="i">
				<span <c:if test="${page.currPage eq i }">class="current"</c:if> onclick="invokeAction(${i});" style="cursor:pointer;">${i}</span>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<%-- <span class="current">${page.currPage}</span> --%>
	<c:if test="${page.hasNextPage}">
		<a href="javascript:void(0);" onclick="invokeAction(${page.currPage+1});">下一页 </a>
	</c:if>
	<c:if test="${!page.hasNextPage}"><a href="javascript:void(0);">下一页</a></c:if>
	<c:if test="${page.hasLastPage}">
		<a href="javascript:void(0);" onclick="invokeAction(${page.totalPage});">最末页</a>
	</c:if>
	<c:if test="${!page.hasLastPage}"><a href="javascript:void(0);">最末页</a></c:if>
	</div>
</td>
</tr>
<script type="text/javascript">
	function invokeAction(goPage){
	 	document.getElementById("goPage").value = goPage;
		var formObj = document.forms[0];
		var actionURL = formObj.action;
		formObj.submit();
	}
	
	$(function (){
		var colspan = '${param.colspan}';
		$("#tdhb").attr("colspan", colspan);
		
	});
</script>
