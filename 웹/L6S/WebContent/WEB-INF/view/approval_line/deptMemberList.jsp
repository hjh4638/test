<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${cp }/css/style1.css" type="text/css">
<script type="text/javascript" src="<c:url value='/js/jquery-1.5.1.min.js'/>"></script> 
<Script language="javascript" src="${cp}/js/approval_in.js" CHARSET="UTF-8"></Script>
<style type="text/css" media="all">
</style>
</head>
<body>
<div>
	<table bordercolor="#dedee0" align="left" class="main_table_small" cellpadding="0" cellspacing="0"  width="380" border="1"  bordercolor="#dedee0" style='padding-top: 0px'> 	
		<thead>
			<tr align="center" height="25px">
				<th>계급 / 이름</th>
				<th>소속</th>
				<th>직책</th>
				<th>결재자</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${empty processLineList}">
			<tr height="25px"><td colspan="5" align="center">해당 부서원이 없습니다.</td></tr>
		</c:if>
		<c:forEach var="line" items="${processLineList}">
			<tr onmouseover="this.className='highlight';" 
			    onmouseout="this.className='delhighlight';"
			    onclick="approval('${line.rankname }', '${line.name}', '${line.sosokname}', '${line.ass }','${line.userid }');"
			    style="cursor:pointer;" 
			    height="25px" align="center">				
				<td title="${line.userid }">${line.rankname } ${line.name }</td>
				<td>${line.sosokname }</td>
				<td>${line.ass }</td>
				<td> 추가 </td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>