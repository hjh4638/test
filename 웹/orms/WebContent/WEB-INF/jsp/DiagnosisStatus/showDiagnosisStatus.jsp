<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<c:set var="uri" value="<%=request.getRequestURL() %>"/>
<script>var firstIn=true;</script>
<jsp:include page="paramDiv.jsp"/>