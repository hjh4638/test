<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title></title>

<tiles:insertAttribute name="include" />

</head>

<body>
<jsp:include page="./orms_Dialog.jsp"></jsp:include>	
<tiles:insertAttribute name="main" />
</body>
</html>
