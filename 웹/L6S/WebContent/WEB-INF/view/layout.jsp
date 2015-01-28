<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title><tiles:getAsString name="title" /></title>
		
		<!-- jQuery 1.6 Version & Ui-->
		<script type="text/javascript" src="<c:url value='/js/DateUtil.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/Validation.js'/>"></script>  
		<script type="text/javascript" src="<c:url value='/js/jquery.tools.min.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/jquery-1.6.2.min.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/jquery-ui-1.8.16.custom.min.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/jquery.ui.datepicker-ko.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/json.min.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/util/common.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/util/flash.js'/>"></script>
		<script type="text/javascript" src="<c:url value='/js/util/upload.js'/>"></script>
		
		<!-- style -->
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css' />" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/smoothness/jquery-ui-1.8.16.custom.css'/>" />	
	</head>
	<body id="body_wrapper">
		<div id="home_wrapper">
			<a href="<c:url value='/start.do'/>" onfocus="blur();">린6시그마 관리체계</a>
		</div>
		<div id="top_navigation_wrapper">
			<tiles:insertAttribute name="top_navigation"/>
		</div>
		<div id="left_navigation_wrapper">
			<tiles:insertAttribute name="left_navigation"/>
		</div>
		<div id="content_wrapper">
			<tiles:insertAttribute name="belt_navigation"/>
			<tiles:insertAttribute name="content"/>
		</div>
		<div id="foot_wrapper">
			CopyRight ⓒSince 2011.공군 중앙전산소 (최적화모드 : Explorer 6.0이상, 1024*768)
		</div>
	</body>
</html>