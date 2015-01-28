<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Insert title here</title>
</head>
<body>
	<table>
	<c:forEach var="userInfo" items="${userList}" varStatus="loop">
		<tr>
			<td> ${userInfo.user_id } </td>
			<td> ${userInfo.user_name } </td>
			<td> ${userInfo.user_sex } </td>
			<td> ${userInfo.user_birth_date } </td>
			<td> ${userInfo.user_register_date } </td>
			
			<td><select>
				<option>관리자</option>
				<option>A</option>
				<option>B</option>
				<option>C</option>
				<option>일반</option>
			</select></td>
		</tr>
	</c:forEach>
	</table>	
</body>
</html>
