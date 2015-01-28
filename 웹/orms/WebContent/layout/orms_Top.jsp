<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />
<script type="text/javascript" src="/orms/js/flash.js"></script>
<div id="main_top_div" style="cursor:pointer" onClick="location.href='${cp}/main.do'">
	<img src="${cp }/images/orm_logo.gif" style="margin-right:10px"/>
	<%-- <img src="${cp }/images/orm_title.gif"/> --%>
	<script>

				embedFlashObject("${cp }/images/orm_title.swf", 793, 57, "");

	</script>
</div>