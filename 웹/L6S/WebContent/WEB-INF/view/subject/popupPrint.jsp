<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
<script>
	function loadPrint(){
		var table=$(opener.document).find(".print").clone();
		for(var i=0;i<table.length;i++){
			$("#main").append('<table class="assignmentRegister_table">'+$(table[i]).html()+'</table>');
		}
		window.print();
	}
</script>
</head>
<body onload="loadPrint()">
<div style="height:20px;"></div>
<center>
<c:if test="${param.type eq 's' }">
	<h1 class="assignment_detail_title"></h1>
</c:if>
<c:if test="${param.type eq 'd' }">
<h1 class="D_stage">D_stage</h1>
</c:if>
<c:if test="${param.type eq 'm' }">
<h1 class="M_stage">M_stag</h1>
</c:if>
<c:if test="${param.type eq 'a' }">
<h1 class="A_stage">A_stage</h1>
</c:if>
<c:if test="${param.type eq 'i' }">
<h1 class="I_stage">I_stage</h1>
</c:if>
<c:if test="${param.type eq 'c' }">
<h1 class="C_stage">C_stage</h1>
</c:if>
<c:if test="${param.type eq 'e' }">
<h1 class="End_stage">End_stage</h1>
</c:if>

<div id="main"></div>
</center>
</body>
</html>