<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <c:set var="cp" value="<c:url value=""/>"/> --%>
<c:set var="cp" value="<%=request.getContextPath() %>" />

<!-- 공통 css Include -->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/layout.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/navigation.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/menu.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/administrator.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/assignment.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/smoothness/jquery-ui-1.8.16.custom.css'/>" />
<link rel="stylesheet" href="<c:url value='/css/skin1.css'/>"/> 
 
<!-- jQuery 1.6 Version & Ui-->
<script type="text/javascript" src="<c:url value='/js/jquery-1.5.1.min.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/js/DateUtil.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/Validation.js'/>"></script>  
<script type="text/javascript" src="<c:url value='/js/jquery.tools.min.js'/>"></script> 
<%-- <script type="text/javascript" src="<c:url value='/js/jquery-1.6.2.min.js'/>"></script>  --%>
<script type="text/javascript" src="<c:url value='/js/jquery-ui-1.8.16.custom.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.ui.datepicker-ko.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/json.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/util/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/util/flash.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/util/upload.js'/>"></script>