<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>


<c:forEach var="d01" items="${d01 }" varStatus="index">
	<c:choose>
		<c:when test="${index.count eq param.index }">
			&nbsp;<img src="<c:url value='/images/main/choice_on.gif'/>">&nbsp;
		</c:when>
		<c:otherwise>
			&nbsp;<img style="cursor: pointer;" onclick="ChoiceImg('${index.count}','${param.index}')" src="<c:url value='/images/main/choice_off.gif'/>">&nbsp;
		</c:otherwise>
	</c:choose>
</c:forEach>
<%-- 		<div style="border:1px solid black;width:10px;float:left;">${index.count }</div> --%>