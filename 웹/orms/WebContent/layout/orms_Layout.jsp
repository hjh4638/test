<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ORM 체계</title>
<tiles:insertAttribute name="include" />
</head>

<body>
<jsp:include page="./orms_Dialog.jsp"></jsp:include>	
<table id="main_layout_table">
	<tr>
		<td colspan="2" id="main_top_layout_td">
			<div id="main_top_layout">
				<tiles:insertAttribute name="top" />
			</div>
		</td>
	</tr>
	<tr>
		<td id="main_menu_layout_td">
			<div id="main_menu_layout">
				<tiles:insertAttribute name="menu" />
			</div>
		</td>
		<td id="main_body_layout_td">
			<div id="main_body_layout">
				<tiles:insertAttribute name="main" />
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2" id="main_footer_layout_td">
			<div id="main_footer_layout">
				<tiles:insertAttribute name="footer" />
			</div>
		</td>
	</tr>
</table>	
</body>
</html>
