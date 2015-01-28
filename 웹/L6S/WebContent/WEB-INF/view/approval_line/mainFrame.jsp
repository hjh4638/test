<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="<c:url value='/js/jquery-1.5.1.min.js'/>"></script> 
<Script language="javascript" src="${cp}/js/approval_in.js" CHARSET="UTF-8"></Script>
<title>결재자 지정</title>
</head>
	<frameset cols="28%, *" border="1">
		<frame src="${cp }/approval_line/app/treeView.do?startcode=${sosokcode}" noresize>
		<frameset rows="50%, *" border="0"> 
			<frame src="${cp }/approval_line/app/deptMemberList.do?sosokcode=${sosokcode}" name="deptmember" noresize>
			<frame src="${cp }/approval_line/app/selectApprovalMembers.do" name="right" id="right" noresize scrolling=no>
		</frameset>						
	</frameset>

</html>