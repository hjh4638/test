<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
	<!-- jQuery 1.6 Version & Ui-->
	<script type="text/javascript" src="<c:url value='/js/jquery-1.5.1.min.js'/>"></script> 
	<script type="text/javascript" src="<c:url value='/js/DateUtil.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/Validation.js'/>"></script>  
	<script type="text/javascript" src="<c:url value='/js/jquery.tools.min.js'/>"></script> 
	<script type="text/javascript" src="<c:url value='/js/jquery-ui-1.8.16.custom.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/jquery.ui.datepicker-ko.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/json.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/util/common.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/util/flash.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/util/upload.js'/>"></script>
		
	<!-- style -->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/smoothness/jquery-ui-1.8.16.custom.css'/>" >
<%-- 	<tiles:insertAttribute name="include"/> --%>
<%String browser = request.getHeader("User-Agent");%>
<c:set var="brower" value="<%=browser %>"/>
<script>
$(function(){
	var brower = '${brower}';
	var ie ='Mozilla/4.0';
	if(brower.substring(0, ie.length) == ie)
		$("div#.lsms_work").css("min-height","").css("height","549px");
});
</script>
</head>
<body>

<div class="lsms_layout">

<a href="<c:url value='/main/start.do'/>" onfocus="blur();">
	<div class="lsms_title"></div>
</a>

<div class="top_menu">
	<tiles:insertAttribute name="top_navigation"/>
</div>

<div id="lsms_main" class="lsms_work">
	<tiles:insertAttribute name="stage_template"/>
	<tiles:insertAttribute name="content"/>
</div>

<div class="lsms_foot">
	<tiles:insertAttribute name="foot"/>
</div>

</div>

</body>
</html>