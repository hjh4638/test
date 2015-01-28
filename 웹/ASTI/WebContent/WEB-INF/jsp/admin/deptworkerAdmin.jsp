<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="<c:url value='/js/dept/deptworker.js'/>"></script>
<c:set var="pagination" value="${astiBoardSearchDTO.astiBoardPaginationDTO }"/>
<script>
	$(function(){
		var code = '${param.code}';
		if(code =='CCC')
			$('#CCC').attr("selected","selected");
		else if(code == 'C00')
			$('#C00').attr("selected","selected");
		else if(code == 'C01')
			$('#C01').attr("selected","selected");
		else if(code == 'C02')
			$('#C02').attr("selected","selected");
	});
	
	function gotoInsert(id){
	var worker_id;
	if(id == null || id == '')
		worker_id ='';
	else
		worker_id = id;
	
		$("#workerAdmin")
		.empty()
		.load("/ASTI/admin/workerRegister.do?worker_id="+worker_id);
				
	}
	function gotoDelete(id){
		var worker_id =id;
    	if(confirm("정말로 삭제하시겠습니까?")){
			$.post("<c:url value="/ajax/workerDelete.do"/>",{worker_id:worker_id},function(isValid){
				if(isValid == "success"){
					location.href="<c:url value='/admin/auth.do?tab=2'/>";
				}else{
					alert("삭제실패");
				}
			});
    	}
    	x
    }
</script>

	부서 : 
	<select onchange="javascript:pageChangeDept('1',$(this).val())">
		<option id="CCC" value="">전체</option>
		<c:forEach var="department" items="${department }">
			<option id="${department.code_id }" value="${department.code_id }"><c:out value="${department.code_name }"/></option>
		</c:forEach>
	</select>
<!-- 	<input type="button" value="연구원입력" onclick="gotoInsert()"> -->
	<a href="javascript:gotoInsert()"><img src="<c:url value='/images/btn/btn_03.gif'/>"/></a>
	<table class="workerTable"> 
		<tr>
			<th>이름</th>
			<th>부서</th>
			<th>연구/전공분야</th>
			<th>연락처</th>
			<th>E-MAIL</th>
			<th></th>
		</tr>
		<c:forEach var="worker" items="${workerList }">
			<tr id="worker${worker.worker_id }">
<%-- 				<td><img width="40" height="50" src="<c:url value="/Temp/${worker.worker_picture_id}"/>" ></td> --%>
				<td><c:out value="${worker.worker_name }"/></td>
				<td><c:out value="${worker.worker_department_name }"/></td>
				<td><c:out value="${worker.worker_major }"/></td>
				<td><c:out value="${worker.worker_phone_number }"/></td>
				<td><c:out value="${worker.worker_email }"/></td>
				<td>
				<a href="javascript:gotoInsert('${worker.worker_id }')">
					<img src="<c:url value='/images/btn/btn_03_0320.gif'/>"/>
				</a>
				<a href="javascript:gotoDelete('${worker.worker_id }')">
					<img src="<c:url value='/images/btn/btn_04_0320.gif'/>"/>
				</a>
<%-- 					<input type="button" value="수정" onclick="gotoInsert(${worker.worker_id })"> --%>
<%-- 					<input type="button" value="삭제" onclick="gotoDelete(${worker.worker_id })"> --%>
				</td>
			</tr>
		</c:forEach>
	</table>

<c:if test="${pagination.beginPage ne 1 }">
	<a href="javascript:pageMoveDept('1','${param.code }')">◁◁
	</a> 
	&nbsp;
	<a href="javascript:pageMoveDept('${pagination.beginPage-1 }','${param.code }')">
	◀
	</a>
</c:if>
<c:forEach var="pageStatus" varStatus="pageCount" begin="${pagination.beginPage }" end="${pagination.endPage }">
	<c:if test="${pagination.lastPage>=pageStatus}">
		<c:choose>
			<c:when test="${pagination.currentPage eq pageStatus }">
				<b>${pageStatus }</b> 
			</c:when>
			<c:otherwise>
				<a href="javascript:pageMoveDept('${pageStatus}','${param.code }')">
					${pageStatus }
				</a> 
			</c:otherwise>
		</c:choose>
		 <c:if test="${!pageCount.last and (pagination.lastPage ne pageStatus)}">|</c:if>
	</c:if>
</c:forEach>
<c:if test="${pagination.lastPage>=pagination.endPage }">
	<a href="javascript:pageMoveDept('${pagination.endPage+1 }','${param.code }')">
	▶
	</a>
	 &nbsp;
	<a href="javascript:pageMoveDept('${pagination.lastPage }','${param.code }')">
	▷▷
	</a>
</c:if>
