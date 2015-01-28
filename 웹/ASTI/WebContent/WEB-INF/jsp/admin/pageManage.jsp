<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="cp" value="<%=request.getContextPath() %>" />

<script>
	$(function(){
		var code = '${param.page_id}';
		if(code =='D01')
			$('#D01').attr("selected","selected");
		else if(code == 'D02')
			$('#D02').attr("selected","selected");
		else if(code == 'D03')
			$('#D03').attr("selected","selected");
		else if(code == 'D04')
			$('#D04').attr("selected","selected");
		else if(code =='D05')
			$('#D05').attr("selected","selected");
		else if(code == 'D06')
			$('#D06').attr("selected","selected");
		else if(code == 'D07')
			$('#D07').attr("selected","selected");
		else if(code == 'D08')
			$('#D08').attr("selected","selected");
		else if(code =='D09')
			$('#D09').attr("selected","selected");
		else if(code == 'D10')
			$('#D10').attr("selected","selected");
		else if(code == 'D11')
			$('#D11').attr("selected","selected");
		else if(code == 'D12')
			$('#D12').attr("selected","selected");
		else if(code == 'D13')
			$('#D13').attr("selected","selected");
		else if(code == 'D14')
			$('#D14').attr("selected","selected");
		else if(code == 'D15')
			$('#D15').attr("selected","selected");
		else if(code == 'D16')
			$('#D16').attr("selected","selected");
		else if(code == 'D17')
			$('#D17').attr("selected","selected");
		else if(code == 'D18')
			$('#D18').attr("selected","selected");
	});
	function goToPage(page_id){
		$.ajax({
			  url: "${cp}/admin/pageManage.do",
			  data:{page_id:page_id},
			  dataType:"html",
			  cache: false,
			  success: function(data){
				  $("#pageManage").html(data);
			  }
		});
	}
	function addFileButton(){
		$("#fileDiv").append('<p><input type="file" name="pageImage"><p>');
	}
	function deleteFileButton(){
		$("input[name=pageImage]:last").remove();
	}
</script>
<select onchange="goToPage($(this).val())">
	<c:forEach var="page" items="${pageList }">
		<option id="${page.code_id }" value="${page.code_id }"><c:out value="${page.code_name }"/></option>
	</c:forEach> 
</select>

<c:forEach var="page" items="${pageInfo}">
	<p><img style="width:770px;height:553px;" src="<c:url value="/pageImage/${page.page_picture_id}"/>"></p>
</c:forEach>
<c:if test="${pageId ne null}">
	<c:if test="${pageId eq 'D01'}">
		<a href="javascript:addFileButton()"><img src="<c:url value='/images/btn/btn_04.gif'/>"/></a>
		<a href="javascript:deleteFileButton()"><img src="<c:url value='/images/btn/btn_04_0320.gif'/>"/></a>
<!-- 		<input type="button" value="추가" onclick="addFileButton()"> -->
<!-- 		<input type="button" value="삭제" onclick="deleteFileButton()"> -->
	</c:if>
	<form action="<c:url value="/admin/pageImageChange.do"/>" method="post" enctype="multipart/form-data">
		<div id="fileDiv">
			<p><input type="file" name="pageImage"><p>
			<c:if test="${pageId eq 'D01'}">
				<p><input type="file" name="pageImage"><p>
				<p><input type="file" name="pageImage"><p>
				<p><input type="file" name="pageImage"><p>
				<h2>메인페이지는 최소 4개 이상의 이미지가 올라가야합니다.</h2>
			</c:if>
		</div>
		<input type="hidden" name="page_id" value="${pageId}">
		<input type="image" src="<c:url value='/images/btn/btn_06.gif'/>">
	</form>
</c:if>


