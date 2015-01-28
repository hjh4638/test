<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath()%>"></c:set>
<%String startcode = (String)request.getAttribute("startcode");%>
<%
String treeType = "AVS11C0T";
String dbUser = "A11";
if(startcode==null){
	startcode="A010";
}
if(startcode.length()>4){
	startcode = startcode.substring(0,4);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${cp }/css/style1.css" type="text/css">
<title>조직도</title>
<link rel="stylesheet" href="${cp}/css/jquery-ui-1.8.15.custom.css">
<style type="text/css" media="all">
</style>
<script type="text/javascript" src="${cp }/js/util/flash.js" charset="utf-8">
</script>
</head>
<body>
	<table>
		<tr>
			<table class="main_table_very_small" cellpadding="0" cellspacing="0" width="200">
			<thead>
				<th height="30"> <td class="subtitle" style=" text-align: left; padding-left: 10px;"><b>부대(부서) 선택</b></td> </th>
			</thead>
			</table>
		</tr>
		<tr>
			<td>
			<script>
				embedFlashObject("${cp}/images/approval_flash.swf", 200, 600, "load_url=${cp}/approval_line/app/flashXmlTree.do?startCode=<%= startcode %>|treeType=<%= treeType %>|dbUser=<%= dbUser %>");
<%-- 				embedFlashObject("${cp}/js/util/flashtree.swf", 200, 600, "load_url=${cp}/approval_line/app/flashXmlTree.do?startCode=<%= startcode %>|treeType=<%= treeType %>|dbUser=<%= dbUser %>"); --%>
			</script>
			</td>
		</tr>
	</table>
</body>
</html>