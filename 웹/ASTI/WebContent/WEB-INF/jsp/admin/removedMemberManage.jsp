<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<table>
	<c:forEach items="${removedUser }" var="user">
		<tr>
			<td>
				<c:out value="${user.user_id }"/>
			</td>
			<td>
				<c:out value="${user.user_name }"/>
			</td>
			<td>
				<c:out value="${user.user_sex }"/>
			</td>
			<td>
				<c:out value="${user.user_birth_date }"/>
			</td>
			<td>
				<c:out value="${user.user_phone_number }"/>
			</td>
		</tr>
	</c:forEach>
</table>