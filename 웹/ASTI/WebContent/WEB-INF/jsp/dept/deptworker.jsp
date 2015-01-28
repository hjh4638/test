<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="<c:url value='/js/dept/deptworker.js'/>"></script>
<style>
.workerUnit{
	float: left;
	width: 180px;
	height: 200px;
}
</style>

	
	<table id = "deptWorkerTable" cellspacing="0" cellpadding="0">
		<tr>
			<th>
				성명
			</th>
			<th>
				부서
			</th>
			<th>
				연구/전공분야
			</th>
			<th>
				연락처
			</th>
			<th>
				E-MAIL
			</th>
		</tr>
		<c:forEach var="worker" items="${workerList }">
			<tr onclick="loadWorkerInfomation('${worker.worker_id}')">
				<td>
					<c:out value="${worker.worker_name }"/>
				</td>
				<td>
					<c:out value="${worker.worker_department_name }"/>
				</td>
				<td>
					<c:out value="${worker.worker_major }"/>
				</td>
				<td>
					<c:out value="${worker.worker_phone_number }"/>
				</td>
				<td>
					<c:out value="${worker.worker_email }"/>
				</td>
			</tr>
		</c:forEach>
	</table>
	<jsp:include page="workerInfomation.jsp"/>
