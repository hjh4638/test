<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<c:url value='/js/util/upload.js'/>"></script>
</head>
<body>
	
	
	<form:form commandName="uploadBean" enctype="multipart/form-data">
		<input type="submit"/>
	</form:form>
	
	${fileVoMap }
	
	<script type="text/javascript">
	<!--
		 Embed();
	//-->
	</script>
	
	<a href="javascript:fileUpload();">[전송]</a>
</body>
</html>