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


<h1>연구원</h1>
	<table>
		<tr>
			<th>순번</th>
			<th>이름</th>
			<th>부서</th>
			<th>세부사항</th>
		</tr>
		<c:forEach var="worker" items="${workerList }">
			<tr>
				<td>${worker.row_number }</td>
				<td>${worker.worker_name }</td>
				<td>${worker.worker_department_name }</td>
				<td>${worker.worker_detail_info }</td>
			</tr>
		</c:forEach>
	</table>

