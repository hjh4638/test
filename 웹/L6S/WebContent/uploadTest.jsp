<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%=request.getSession().getServletContext().getRealPath("") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="uploadJsp.jsp" method="post" enctype="multipart/form-data">
	<input type="file" name="file">
	<input type="text" name="asfasf">
	<input type="submit" value="전송">
</form>

<%
	for(int i=0;i<10;i++){
%>
	<script>alert("test");</script>
<%	
	}

%>
</body>
</html>