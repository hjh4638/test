<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<c:if test="${subject_app_size eq null}">
	진행중인 결재가 없습니다.
</c:if>
<c:if test="${subject_app_size >0}">
<h1 class="approval_line_small_title1"></h1>
	<table class="approval_line_table">
		<tr>
			<th>순번</th><th>결재순서</th><th>이름</th><th>직책</th><th>결재자 의견</th><th>결재현황</th>
		</tr>
		
		<c:forEach var="com" items="${subject_app }" varStatus="i">
			<c:if test="${s_app_id eq com.app_id }">	
				<tr>
					<td width="6%">${i.index +1}</td>
					<td width="17%">${com.orderName }</td>
					<td width="15%">${com.app_rank } ${com.app_name }</td>
					<td width="17%">${com.app_ass }</td>
					<td width="35%"><c:out value="${com.app_comment}"/>&nbsp;</td>
					<td width="10%">${com.app_right.approvalState } </td>
				</tr>
			</c:if>
		</c:forEach> 
		<c:if test="${subject_app[0].is_complete eq 1}">
			<tr><td colspan="6">결재가 완료되었습니다.</td></tr>
		</c:if>
	</table>
</c:if>
<c:if test="${step_app_size >0}">
<h2 class="approval_line_small_title2"></h2>
	<table class="approval_line_table">
		<tr>
			<th>순번</th><th>결재순서</th><th>이름</th><th>직책</th><th>결재자 의견</th><th>결재현황</th>
		</tr>
		<c:forEach var="com" items="${step_app }" varStatus="i">
			<c:if test="${
			(com.app_order eq 11 && com.app_seq eq app_seq_map.one) ||
			(com.app_order eq 12 && com.app_seq eq app_seq_map.two) ||
			(com.app_order eq 13 && com.app_seq eq app_seq_map.three) ||
			(com.app_order eq 14 && com.app_seq eq app_seq_map.four) ||
			(com.app_order eq 15 && com.app_seq eq app_seq_map.five)}">
				<tr>
					<td width="6%">${i.index +1}</td>
					<td width="17%">${com.orderName }</td>
					<td width="15%">${com.app_rank } ${com.app_name }</td>
					<td width="17%">${com.app_ass }</td>
					<td width="35%"><c:out value="${com.app_comment}"/>&nbsp;</td>
					<td width="10%">${com.app_right.approvalState}</td>
				</tr>
			</c:if>
		</c:forEach>
		<c:if test="${step_app[0].is_complete eq 1 }"> 
			<tr><td colspan="6">결재가 완료되었습니다.</td></tr>
		</c:if>
	</table>
</c:if>
<c:if test="${end_app_size >0}">
<h2 class="approval_line_small_title3"></h2>
	<table class="approval_line_table">
		<tr>
			<th>순번</th><th>결재순서</th><th>이름</th><th>직책</th><th>결재자 의견</th><th>결재현황</th>
		</tr>
		<c:forEach var="com" items="${end_app }" varStatus="i">
			<c:if test="${end_app_id eq com.app_id }">
				<tr>
					<td width="6%">${i.index +1}</td>
					<td width="17%">${com.orderName }</td>
					<td width="15%">${com.app_rank } ${com.app_name }</td>
					<td width="17%">${com.app_ass }</td>
					<td width="35%"><c:out value="${com.app_comment}"/>&nbsp;</td>
					<td width="10%">${com.app_right.approvalState } </td>
				</tr>
			</c:if>
		</c:forEach> 
		<c:if test="${end_app[0].is_complete eq 1 }"> 
			<tr><td colspan="6">결재가 완료되었습니다.</td></tr>
		</c:if>
	</table>
</c:if>